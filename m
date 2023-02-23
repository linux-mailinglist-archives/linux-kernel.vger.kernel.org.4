Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D686A04EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjBWJd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:33:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDE53EF0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:33:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 596FD337F7;
        Thu, 23 Feb 2023 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjil8ydj+MbGLi24YOvmKTY6GkdCwB8f6NUZv/v3iL0=;
        b=f1lGkoc901x7lIfA6dv5NQpuQXuNT2Y9un8+vttO+jCblw1+Z+0VJz0GmtM8iUuNOWIJel
        zgALYUpQ3GLTcj425d8OzgfSLsqex9QOV+ZRjt7hqepTZeOZ4n5M0z2FX9oxt/xgInoJFz
        dMKS3jUEiMuk6ne8ZFQr4MNruZxSTtM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 110F513928;
        Thu, 23 Feb 2023 09:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a0MDAtsy92OmbAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:33:15 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v3 05/12] x86/xen: set MTRR state when running as Xen PV initial domain
Date:   Thu, 23 Feb 2023 10:32:36 +0100
Message-Id: <20230223093243.1180-6-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-1-jgross@suse.com>
References: <20230223093243.1180-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as Xen PV initial domain (aka dom0), MTRRs are disabled
by the hypervisor, but the system should nevertheless use correct
cache memory types. This has always kind of worked, as disabled MTRRs
resulted in disabled PAT, too, so that the kernel avoided code paths
resulting in inconsistencies. This bypassed all of the sanity checks
the kernel is doing with enabled MTRRs in order to avoid memory
mappings with conflicting memory types.

This has been changed recently, leading to PAT being accepted to be
enabled, while MTRRs stayed disabled. The result is that
mtrr_type_lookup() no longer is accepting all memory type requests,
but started to return WB even if UC- was requested. This led to
driver failures during initialization of some devices.

In reality MTRRs are still in effect, but they are under complete
control of the Xen hypervisor. It is possible, however, to retrieve
the MTRR settings from the hypervisor.

In order to fix those problems, overwrite the MTRR state via
mtrr_overwrite_state() with the MTRR data from the hypervisor, if the
system is running as a Xen dom0.

Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
V3:
- move the call of mtrr_overwrite_state() to xen_pv_init_platform()
---
 arch/x86/xen/enlighten_pv.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index bb59cc6ddb2d..729fb447a5b6 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -68,6 +68,7 @@
 #include <asm/reboot.h>
 #include <asm/hypervisor.h>
 #include <asm/mach_traps.h>
+#include <asm/mtrr.h>
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
@@ -119,6 +120,52 @@ static int __init parse_xen_msr_safe(char *str)
 }
 early_param("xen_msr_safe", parse_xen_msr_safe);
 
+/* Get MTRR settings from Xen and put them into mtrr_state. */
+static void __init xen_set_mtrr_data(void)
+{
+#ifdef CONFIG_MTRR
+	struct xen_platform_op op = {
+		.cmd = XENPF_read_memtype,
+		.interface_version = XENPF_INTERFACE_VERSION,
+	};
+	unsigned int reg;
+	unsigned long mask;
+	uint32_t eax, width;
+	static struct mtrr_var_range var[MTRR_MAX_VAR_RANGES] __initdata;
+
+	/* Get physical address width (only 64-bit cpus supported). */
+	width = 36;
+	eax = cpuid_eax(0x80000000);
+	if ((eax >> 16) == 0x8000 && eax >= 0x80000008) {
+		eax = cpuid_eax(0x80000008);
+		width = eax & 0xff;
+	}
+
+	for (reg = 0; reg < MTRR_MAX_VAR_RANGES; reg++) {
+		op.u.read_memtype.reg = reg;
+		if (HYPERVISOR_platform_op(&op))
+			break;
+
+		/*
+		 * Only called in dom0, which has all RAM PFNs mapped at
+		 * RAM MFNs, and all PCI space etc. is identity mapped.
+		 * This means we can treat MFN == PFN regarding MTTR settings.
+		 */
+		var[reg].base_lo = op.u.read_memtype.type;
+		var[reg].base_lo |= op.u.read_memtype.mfn << PAGE_SHIFT;
+		var[reg].base_hi = op.u.read_memtype.mfn >> (32 - PAGE_SHIFT);
+		mask = ~((op.u.read_memtype.nr_mfns << PAGE_SHIFT) - 1);
+		mask &= (1UL << width) - 1;
+		if (mask)
+			mask |= 1 << 11;
+		var[reg].mask_lo = mask;
+		var[reg].mask_hi = mask >> 32;
+	}
+
+	mtrr_overwrite_state(var, reg, MTRR_TYPE_UNCACHABLE);
+#endif
+}
+
 static void __init xen_pv_init_platform(void)
 {
 	/* PV guests can't operate virtio devices without grants. */
@@ -135,6 +182,9 @@ static void __init xen_pv_init_platform(void)
 
 	/* pvclock is in shared info area */
 	xen_init_time_ops();
+
+	if (xen_initial_domain())
+		xen_set_mtrr_data();
 }
 
 static void __init xen_pv_guest_late_init(void)
-- 
2.35.3

