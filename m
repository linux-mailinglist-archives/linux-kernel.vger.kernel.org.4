Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDD66AF5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjCGTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjCGThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795F9965A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:24:59 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC8731EC068E;
        Tue,  7 Mar 2023 20:24:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678217097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YVJIIGc1QMZZquSCdhv6upEqgdnIu7WrVxw64prdzU=;
        b=VL0A87YEm5pDLfCdVu5BShpJ9CV+f9BnxCKrHEaMR9lDs4m+nmdNLnUgeI4YvTB/jsfFgZ
        HhgNsnGcmowa4VuC8KxLSEivKeD5kAETSNApHuFro2ZSXEd4lOMu7ZFplf6xovG1SMIxBt
        2scHBfrHOVeT7GAGlRGhyFyLSo4ejvY=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH -v3 03/11] virt/coco/sev-guest: Simplify extended guest request handling
Date:   Tue,  7 Mar 2023 20:24:41 +0100
Message-Id: <20230307192449.24732-4-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307192449.24732-1-bp@alien8.de>
References: <20230307192449.24732-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Return a specific error code - -ENOSPC - to signal the too small cert
data buffer instead of checking exit code and exitinfo2.

While at it, hoist the *fw_err assignment in snp_issue_guest_request()
so that a proper error value is returned to the callers.

  [ Tom: check override_err instead of err. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/sev.c                   | 11 +++---
 drivers/virt/coco/sev-guest/sev-guest.c | 48 +++++++++++++------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c644c34372e8..6a3e1425ba17 100644
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
index ed5d6ae1a144..e61db0b15b7a 100644
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
-- 
2.35.1

