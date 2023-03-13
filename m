Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFA6B7835
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCMM6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCMM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19D2D7E;
        Mon, 13 Mar 2023 05:58:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQqRKlAUureTp+80aXNMaqlQ6tLwnLDt6ArWqk1UW+E=;
        b=tVgD6myhGhKPiPmhInDx6NIy7FE8aq5MlJYBfKrmkJbWoS/A5t2roZqNBexh1SgeAiqm9W
        8KWkoYJfgva90nPhgkxAJmld2pImxxXBfoaWc7xkcQAAtJtUotgBSkNEySNQsPKK/foNBT
        yC6PmttcxHBS6ydpLl+xxiOjK13JEZL5No46CtbjWEwEO11XrhiAvy8hLfbIXKjkRkyBqV
        06W5lT7X1/dooMxxbVDp2Ppikt4ELCO3veJ9+meoWEck8XiOEbAQeH07oBh7NZfR/kqMNh
        6NBMqSsupi18ND20USO8wD999Mnm97B1qem5leHIzu0M8yRpoPaGXSr8MJyJPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQqRKlAUureTp+80aXNMaqlQ6tLwnLDt6ArWqk1UW+E=;
        b=TDftfrEmIWsGmYtx8q4dA/YKbVB6kRMYMb2iztq6nFMGwviLsaBpwOlTIN4kWxyggAAG8Z
        QPNC4P3Atv7pNICQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Carve out the request issuing
 logic into a helper
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-6-bp@alien8.de>
References: <20230307192449.24732-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167871229033.5837.7773156558096594198.tip-bot2@tip-bot2>
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

Commit-ID:     0fdb6cc7c89cb5e0cbc45dbdbafb8e3fb92ddc95
Gitweb:        https://git.kernel.org/tip/0fdb6cc7c89cb5e0cbc45dbdbafb8e3fb92ddc95
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 07 Mar 2023 09:19:19 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 12:35:02 +01:00

virt/coco/sev-guest: Carve out the request issuing logic into a helper

This makes the code flow a lot easier to follow.

No functional changes.

  [ Tom: touchups. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230307192449.24732-6-bp@alien8.de
---
 drivers/virt/coco/sev-guest/sev-guest.c | 44 ++++++++++++++----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index a51bd4a..07dafe2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -318,27 +318,12 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	return __enc_payload(snp_dev, req, payload, sz);
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
 {
 	unsigned long err, override_err = 0;
 	unsigned int override_npages = 0;
-	u64 seqno;
 	int rc;
 
-	/* Get message sequence and verify that its a non-zero */
-	seqno = snp_get_msg_seqno(snp_dev);
-	if (!seqno)
-		return -EIO;
-
-	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
-
-	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
-	if (rc)
-		return rc;
-
 retry_request:
 	/*
 	 * Call firmware to process the request. In this function the encrypted
@@ -347,7 +332,6 @@ retry_request:
 	 * prevent reuse of the IV.
 	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -401,7 +385,33 @@ retry_request:
 	if (!rc && override_err == SNP_GUEST_REQ_INVALID_LEN)
 		return -EIO;
 
+	return rc;
+}
+
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
+				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz, __u64 *fw_err)
+{
+	u64 seqno;
+	int rc;
+
+	/* Get message sequence and verify that its a non-zero */
+	seqno = snp_get_msg_seqno(snp_dev);
+	if (!seqno)
+		return -EIO;
+
+	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
+
+	/* Encrypt the userspace provided payload */
+	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	if (rc)
+		return rc;
+
+	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
 	if (rc) {
+		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
+			return rc;
+
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
 			  rc, *fw_err);
