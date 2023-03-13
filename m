Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612EC6B783A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCMM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCMM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF6B455;
        Mon, 13 Mar 2023 05:58:16 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klVnixmbKKQXzPOSoXudW5Vityk7cxQ7t6Ur6l65nwg=;
        b=TXUVF1CzACRczBIjFrWMaBwKS4Cl3ODfddQYqIZfZoCwxnClw/gkkN7kRq6NCQh2J+BhkC
        0XZWXrEwfjn8xRttWtxP0/JU/PLQ7ybKmeZGsaequl1NyVy4pJQwY/ToPQ6H69h+tD/YnZ
        BkG6fnrUrOafqR3qpFsgMTC0JOctrzCtmab1t4GR12Le1MGd4/T4lDtn2ooZ3ttCG2F7ST
        fMyAn8tOM68StY4Nute22m7GG2Z6pWfwaYwI8bQPQwgdaVbuDydo/THpa7OMfPIzboKnMo
        8RuEq9ZU4QlAWf6lqmTAeZ3rTZqeUeBwgpJyr8h80Knc403Ew/4VwD6NF2GSpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klVnixmbKKQXzPOSoXudW5Vityk7cxQ7t6Ur6l65nwg=;
        b=nDbehQCsodhDqfS/nqYgLzW5ijVBuS5emBNI7ot+YbNqu5PoqIK7xJBVlSJqYVUc3ZmpCy
        3WjmqJJi/TPp6GDA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Simplify extended guest
 request handling
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-4-bp@alien8.de>
References: <20230307192449.24732-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167871229078.5837.2530695833715446239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     970ab823743fb54b42002ec76c51481f67436444
Gitweb:        https://git.kernel.org/tip/970ab823743fb54b42002ec76c51481f67436444
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Feb 2023 11:39:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 11:27:10 +01:00

virt/coco/sev-guest: Simplify extended guest request handling

Return a specific error code - -ENOSPC - to signal the too small cert
data buffer instead of checking exit code and exitinfo2.

While at it, hoist the *fw_err assignment in snp_issue_guest_request()
so that a proper error value is returned to the callers.

  [ Tom: check override_err instead of err. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230307192449.24732-4-bp@alien8.de
---
 arch/x86/kernel/sev.c                   | 11 +++---
 drivers/virt/coco/sev-guest/sev-guest.c | 48 +++++++++++++-----------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c644c34..6a3e142 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2209,15 +2209,16 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned 
 	if (ret)
 		goto e_put;
 
+	*fw_err = ghcb->save.sw_exit_info_2;
 	if (ghcb->save.sw_exit_info_2) {
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
+		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN) {
 			input->data_npages = ghcb_get_rbx(ghcb);
-
-		*fw_err = ghcb->save.sw_exit_info_2;
-
-		ret = -EIO;
+			ret = -ENOSPC;
+		} else {
+			ret = -EIO;
+		}
 	}
 
 e_put:
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index ed5d6ae..e61db0b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -322,7 +322,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
 {
-	unsigned long err;
+	unsigned long err, override_err = 0;
+	unsigned int override_npages = 0;
 	u64 seqno;
 	int rc;
 
@@ -338,6 +339,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
+retry_request:
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -346,17 +348,24 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
 
-	/*
-	 * If the extended guest request fails due to having too small of a
-	 * certificate data buffer, retry the same guest request without the
-	 * extended data request in order to increment the sequence number
-	 * and thus avoid IV reuse.
-	 */
-	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
-	    err == SNP_GUEST_REQ_INVALID_LEN) {
-		const unsigned int certs_npages = snp_dev->input.data_npages;
+	switch (rc) {
+	case -ENOSPC:
+		/*
+		 * If the extended guest request fails due to having too
+		 * small of a certificate data buffer, retry the same
+		 * guest request without the extended data request in
+		 * order to increment the sequence number and thus avoid
+		 * IV reuse.
+		 */
+		override_npages = snp_dev->input.data_npages;
+		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
-		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+		/*
+		 * Override the error to inform callers the given extended
+		 * request buffer size was too small and give the caller the
+		 * required buffer size.
+		 */
+		override_err	= SNP_GUEST_REQ_INVALID_LEN;
 
 		/*
 		 * If this call to the firmware succeeds, the sequence number can
@@ -366,15 +375,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		 * of the VMPCK and the error code being propagated back to the
 		 * user as an ioctl() return code.
 		 */
-		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-
-		/*
-		 * Override the error to inform callers the given extended
-		 * request buffer size was too small and give the caller the
-		 * required buffer size.
-		 */
-		err = SNP_GUEST_REQ_INVALID_LEN;
-		snp_dev->input.data_npages = certs_npages;
+		goto retry_request;
 	}
 
 	/*
@@ -386,7 +387,10 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	snp_inc_msg_seqno(snp_dev);
 
 	if (fw_err)
-		*fw_err = err;
+		*fw_err = override_err ?: err;
+
+	if (override_npages)
+		snp_dev->input.data_npages = override_npages;
 
 	/*
 	 * If an extended guest request was issued and the supplied certificate
@@ -394,7 +398,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	 * prevent IV reuse. If the standard request was successful, return -EIO
 	 * back to the caller as would have originally been returned.
 	 */
-	if (!rc && err == SNP_GUEST_REQ_INVALID_LEN)
+	if (!rc && override_err == SNP_GUEST_REQ_INVALID_LEN)
 		return -EIO;
 
 	if (rc) {
