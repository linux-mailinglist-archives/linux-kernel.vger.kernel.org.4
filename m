Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38535F3EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJDIog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJDIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:44:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8884D81D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:44:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E8B41F8FC;
        Tue,  4 Oct 2022 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664873065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rg7G2sE/xwQjZFXkh5AfLZ6BOzaSFVCwXC3avs7dOhM=;
        b=A+NxQexafoTYnVQ/mf4TVXN0GkLKIg2mP5sKyx1Gz2V3ktHdatz1HlJqgWcQIRhl5hOeoT
        3Q0+qKFhx2Ufd9teMM1JVfivPQD8aszyNe/LecnT3KZRw2nHdoey3kERS7LrsUGl99ZLcS
        S5gceBOro6LRxBH1JdWTsKpWGfKCeuU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17BC0139D2;
        Tue,  4 Oct 2022 08:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1/l0BGnyO2O4VwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:44:25 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 2/3] xen/pv: refactor msr access functions to support safe and unsafe accesses
Date:   Tue,  4 Oct 2022 10:43:34 +0200
Message-Id: <20221004084335.2838-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004084335.2838-1-jgross@suse.com>
References: <20221004084335.2838-1-jgross@suse.com>
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

Refactor and rename xen_read_msr_safe() and xen_write_msr_safe() to
support both cases of MSR accesses, safe ones and potentially GP-fault
generating ones.

This will prepare to no longer swallow GPs silently in xen_read_msr()
and xen_write_msr().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- init val in xen_do_read_msr() to 0 (Jan Beulich)
---
 arch/x86/xen/enlighten_pv.c | 75 +++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 9b1a58dda935..d5b0844a1b7c 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -917,14 +917,18 @@ static void xen_write_cr4(unsigned long cr4)
 	native_write_cr4(cr4);
 }
 
-static u64 xen_read_msr_safe(unsigned int msr, int *err)
+static u64 xen_do_read_msr(unsigned int msr, int *err)
 {
-	u64 val;
+	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
 
 	if (pmu_msr_read(msr, &val, err))
 		return val;
 
-	val = native_read_msr_safe(msr, err);
+	if (err)
+		val = native_read_msr_safe(msr, err);
+	else
+		val = native_read_msr(msr);
+
 	switch (msr) {
 	case MSR_IA32_APICBASE:
 		val &= ~X2APIC_ENABLE;
@@ -933,23 +937,39 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
 	return val;
 }
 
-static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
+static void set_seg(unsigned int which, unsigned int low, unsigned int high,
+		    int *err)
 {
-	int ret;
-	unsigned int which;
-	u64 base;
+	u64 base = ((u64)high << 32) | low;
+
+	if (HYPERVISOR_set_segment_base(which, base) == 0)
+		return;
 
-	ret = 0;
+	if (err)
+		*err = -EIO;
+	else
+		WARN(1, "Xen set_segment_base(%u, %llx) failed\n", which, base);
+}
 
+/*
+ * Support write_msr_safe() and write_msr() semantics.
+ * With err == NULL write_msr() semantics are selected.
+ * Supplying an err pointer requires err to be pre-initialized with 0.
+ */
+static void xen_do_write_msr(unsigned int msr, unsigned int low,
+			     unsigned int high, int *err)
+{
 	switch (msr) {
-	case MSR_FS_BASE:		which = SEGBASE_FS; goto set;
-	case MSR_KERNEL_GS_BASE:	which = SEGBASE_GS_USER; goto set;
-	case MSR_GS_BASE:		which = SEGBASE_GS_KERNEL; goto set;
-
-	set:
-		base = ((u64)high << 32) | low;
-		if (HYPERVISOR_set_segment_base(which, base) != 0)
-			ret = -EIO;
+	case MSR_FS_BASE:
+		set_seg(SEGBASE_FS, low, high, err);
+		break;
+
+	case MSR_KERNEL_GS_BASE:
+		set_seg(SEGBASE_GS_USER, low, high, err);
+		break;
+
+	case MSR_GS_BASE:
+		set_seg(SEGBASE_GS_KERNEL, low, high, err);
 		break;
 
 	case MSR_STAR:
@@ -965,11 +985,28 @@ static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
 		break;
 
 	default:
-		if (!pmu_msr_write(msr, low, high, &ret))
-			ret = native_write_msr_safe(msr, low, high);
+		if (!pmu_msr_write(msr, low, high, err)) {
+			if (err)
+				*err = native_write_msr_safe(msr, low, high);
+			else
+				native_write_msr(msr, low, high);
+		}
 	}
+}
+
+static u64 xen_read_msr_safe(unsigned int msr, int *err)
+{
+	return xen_do_read_msr(msr, err);
+}
+
+static int xen_write_msr_safe(unsigned int msr, unsigned int low,
+			      unsigned int high)
+{
+	int err = 0;
+
+	xen_do_write_msr(msr, low, high, &err);
 
-	return ret;
+	return err;
 }
 
 static u64 xen_read_msr(unsigned int msr)
-- 
2.35.3

