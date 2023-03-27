Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E586CAF77
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjC0UKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjC0UKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:10:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D282C1FCF;
        Mon, 27 Mar 2023 13:09:59 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679947794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9H/qKMnGLaC7iNgrO0+y8zuktVY7zzlf1BdX6chGocI=;
        b=hMr+fsq//f8UPsunLkwwXmQTv0/JZVQFiVNVhZeD9G096bfDSuWGb+nYQjZqfrIUmV+PL6
        6/VW2NS4Vw3740PzbYiglzw0ySmbF9/LsEbgLxSoTzOG+9Jd/HoVoFuMJWjcrQFac4ggoW
        iY5RtzrL2PoZqtwX3CaxaKIgDAWiQR/FDNYMEEw6UidIhlBNnmF2BTUM4IjT76cotzp2RL
        cVhXysY/Fb5nkJQQI+dWcG1Qz1AA4JtRyk7OS40BZOlaLvbh3l+Xf88nuP6HyGi6A1LGyC
        uwWh9OxdXM1NrxZxgTGgnXknMGrZkVRwmF5fksNvvDwUtfFU9dKkRjOchINpYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679947794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9H/qKMnGLaC7iNgrO0+y8zuktVY7zzlf1BdX6chGocI=;
        b=sYtT3f8lhBFQlKexabZvSX4pRlmTG6JaMHTe1bO/e8EBJbF0fFGscWXJkBtBeErw4dFVFL
        WsQFoK0UU+heXnCQ==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/ioremap: Add hypervisor callback for private MMIO
 mapping in coco VM
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1678329614-3482-2-git-send-email-mikelley@microsoft.com>
References: <1678329614-3482-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <167994779371.5837.9395971676724373412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     88e378d400fa0544d51cf62037e7774d8a4b4379
Gitweb:        https://git.kernel.org/tip/88e378d400fa0544d51cf62037e7774d8a4b4379
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Wed, 08 Mar 2023 18:40:02 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 26 Mar 2023 23:42:40 +02:00

x86/ioremap: Add hypervisor callback for private MMIO mapping in coco VM

Current code always maps MMIO devices as shared (decrypted) in a
confidential computing VM. But Hyper-V guest VMs on AMD SEV-SNP with vTOM
use a paravisor running in VMPL0 to emulate some devices, such as the
IO-APIC and TPM. In such a case, the device must be accessed as private
(encrypted) because the paravisor emulates the device at an address below
vTOM, where all accesses are encrypted.

Add a new hypervisor callback to determine if an MMIO address should
be mapped private. The callback allows hypervisor-specific code to handle
any quirks, the use of a paravisor, etc. in determining whether a mapping
must be private. If the callback is not used by a hypervisor, default
to returning "false", which is consistent with normal coco VM behavior.

Use this callback as another special case to check for when doing
ioremap().  Just checking the starting address is sufficient as an
ioremap range must be all private or all shared.

Also make the callback in early boot IO-APIC mapping code that uses the
fixmap.

  [ bp: Touchups. ]

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/1678329614-3482-2-git-send-email-mikelley@microsoft.com
---
 arch/x86/include/asm/x86_init.h |  4 ++++
 arch/x86/kernel/apic/io_apic.c  | 10 ++++++++--
 arch/x86/kernel/x86_init.c      |  2 ++
 arch/x86/mm/ioremap.c           |  5 +++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c1c8c58..acc20ae 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -259,11 +259,15 @@ struct x86_legacy_features {
  *				VMMCALL under SEV-ES.  Needs to return 'false'
  *				if the checks fail.  Called from the #VC
  *				exception handler.
+ * @is_private_mmio:		For CoCo VMs, must map MMIO address as private.
+ *				Used when device is emulated by a paravisor
+ *				layer in the VM context.
  */
 struct x86_hyper_runtime {
 	void (*pin_vcpu)(int cpu);
 	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
+	bool (*is_private_mmio)(u64 addr);
 };
 
 /**
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1f83b05..146671d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -66,6 +66,7 @@
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
 #include <asm/pgtable.h>
+#include <asm/x86_init.h>
 
 #define	for_each_ioapic(idx)		\
 	for ((idx) = 0; (idx) < nr_ioapics; (idx)++)
@@ -2680,10 +2681,15 @@ static void io_apic_set_fixmap(enum fixed_addresses idx, phys_addr_t phys)
 	pgprot_t flags = FIXMAP_PAGE_NOCACHE;
 
 	/*
-	 * Ensure fixmaps for IOAPIC MMIO respect memory encryption pgprot
+	 * Ensure fixmaps for IO-APIC MMIO respect memory encryption pgprot
 	 * bits, just like normal ioremap():
 	 */
-	flags = pgprot_decrypted(flags);
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		if (x86_platform.hyper.is_private_mmio(phys))
+			flags = pgprot_encrypted(flags);
+		else
+			flags = pgprot_decrypted(flags);
+	}
 
 	__set_fixmap(idx, phys, flags);
 }
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ef80d36..95be383 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -134,6 +134,7 @@ static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
@@ -149,6 +150,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.realmode_reserve		= reserve_real_mode,
 	.realmode_init			= init_real_mode,
 	.hyper.pin_vcpu			= x86_op_int_noop,
+	.hyper.is_private_mmio		= is_private_mmio_noop,
 
 	.guest = {
 		.enc_status_change_prepare = enc_status_change_prepare_noop,
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 6453fba..aa7d279 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -116,6 +116,11 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
+	if (x86_platform.hyper.is_private_mmio(addr)) {
+		desc->flags |= IORES_MAP_ENCRYPTED;
+		return;
+	}
+
 	if (!IS_ENABLED(CONFIG_EFI))
 		return;
 
