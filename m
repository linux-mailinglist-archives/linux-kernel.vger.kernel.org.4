Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F7675659
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjATOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjATOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:09:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5754BCE0D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:09:24 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2630F1EC04DA;
        Fri, 20 Jan 2023 15:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674223763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T9GRsQGZ43CT2aqK7qLXQdn6CnxRG6pQmvT40OS61uc=;
        b=d3/Fcwt+ABUTPnNylyYX9vTlA4X5d/CcnsQlBDIUvR1cWzma866EXDwzBwQhjuiNhhuoNz
        9I5Z0Vf75NtSi8jxC96rNh7P1mTw7LtUa7bDrkanWPjMAqCaTsZsCs2rzXqLurFHr107DK
        WTgqk3qfX+rxGc+v+bp/a7mDoRmHYiQ=
Date:   Fri, 20 Jan 2023 15:09:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v11 2/7] x86/sev: Change snp_guest_issue_request's fw_err
Message-ID: <Y8qgjgPCmnPR4tQL@zn.tnic>
References: <20230111194001.1947849-1-dionnaglaze@google.com>
 <20230111194001.1947849-3-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230111194001.1947849-3-dionnaglaze@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 07:39:56PM +0000, Dionna Glaze wrote:
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's unsigned long*. A temporary
> typedef is introduced for the err argument so it can be changed in a
> later patch more cleanly.

Why?

Why not make it a u64 directly and be done with it?

---

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..61b0bfc7f131 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -216,8 +216,7 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
-static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  unsigned long *fw_err)
+static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..70b4cbd33c45 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,7 @@
 #include <linux/efi.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/psp-sev.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2175,7 +2176,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2186,9 +2187,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	if (!fw_err)
+	if (!exitinfo2)
 		return -EINVAL;
 
+	*exitinfo2 = SEV_RET_NO_FW_CALL;
+
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
 	 * a per-CPU GHCB.
@@ -2212,14 +2215,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 	if (ret)
 		goto e_put;
 
+	*exitinfo2 = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
 		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
 			input->data_npages = ghcb_get_rbx(ghcb);
 
-		*fw_err = ghcb->save.sw_exit_info_2;
-
 		ret = -EIO;
 	}
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174e05a3..e15d94785761 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -322,8 +322,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
-	u64 seqno;
+	u64 seqno, err;
 	int rc;
 
 	/* Get message sequence and verify that its a non-zero */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
