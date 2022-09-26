Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2595EAB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiIZPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiIZPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:32:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE25501BC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:19:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D1F7321AA9;
        Mon, 26 Sep 2022 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664201944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2WIgyc8oeY+zl5KU1xJK3+56bjqBOzQeuZ/l6BD6ls=;
        b=qY8RvPXiIpmNppBtHhVvR/lcYb5+KrHTOtwch6dvTPWN8X/VLj6Cw/YIS2IJ+d1ByhjLv6
        J/em/IezcFP+FLxo0JYsBoM3a1BAcvDVDlg27PUngju+UZucwdMDwAW0kSQx57aTdV54Yt
        FjdIzmNYyktbjc3IVUg5Yiuu9DvK60Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BECF139BD;
        Mon, 26 Sep 2022 14:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NfvmINi0MWOZBgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 26 Sep 2022 14:19:04 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] xen/pv: refactor msr access functions to support safe and unsafe accesses
Date:   Mon, 26 Sep 2022 16:18:48 +0200
Message-Id: <20220926141849.21805-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220926141849.21805-1-jgross@suse.com>
References: <20220926141849.21805-1-jgross@suse.com>
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
 arch/x86/xen/enlighten_pv.c | 73 ++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 0ed2e487a693..4e68e047df94 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -916,14 +916,18 @@ static void xen_write_cr4(unsigned long cr4)
 	native_write_cr4(cr4);
 }
 
-static u64 xen_read_msr_safe(unsigned int msr, int *err)
+static u64 xen_do_read_msr(unsigned int msr, int *err)
 {
 	u64 val;
 
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
@@ -932,23 +936,39 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
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
@@ -964,11 +984,28 @@ static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
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

