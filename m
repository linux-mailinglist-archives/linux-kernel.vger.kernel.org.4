Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457346AF5E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjCGTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjCGThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7B9E312
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:25:02 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B77D1EC06C1;
        Tue,  7 Mar 2023 20:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678217101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSs80yh0DjTeBBgJyw8SUIiy0yTuPDLDQy0HhlQzc2I=;
        b=CJGDOi/Al5NbWq2cbyNRicnIDTfoE7ymfBPCyg5fRK646hkBAX9tir7f2An4VjwbEQbr3y
        QJwFPTZew9d9tSky7lObNgas1HXchJbCtUfRNSfWsjx3Lvb6DCUtgxocHIEKLC6RgMFzB4
        OpCxX11agZ3mBzIewjFHASVFuR+l8Ys=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH -v3 10/11] virt/coco/sev-guest: Double-buffer messages
Date:   Tue,  7 Mar 2023 20:24:48 +0100
Message-Id: <20230307192449.24732-11-bp@alien8.de>
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

From: Dionna Glaze <dionnaglaze@google.com>

The encryption algorithms read and write directly to shared unencrypted
memory, which may leak information as well as permit the host to tamper
with the message integrity. Instead, copy whole messages in or out as
needed before doing any computation on them.

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230214164638.1189804-3-dionnaglaze@google.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 27 +++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 46f1a8d558b0..0c7b47acba2a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -46,7 +46,15 @@ struct snp_guest_dev {
 
 	void *certs_data;
 	struct snp_guest_crypto *crypto;
+	/* request and response are in unencrypted memory */
 	struct snp_guest_msg *request, *response;
+
+	/*
+	 * Avoid information leakage by double-buffering shared messages
+	 * in fields that are in regular encrypted memory.
+	 */
+	struct snp_guest_msg secret_request, secret_response;
+
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
@@ -266,14 +274,17 @@ static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg *resp = snp_dev->response;
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *resp = &snp_dev->secret_response;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 
 	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
 		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
 
+	/* Copy response from shared memory to encrypted memory. */
+	memcpy(resp, snp_dev->response, sizeof(*resp));
+
 	/* Verify that the sequence counter is incremented by 1 */
 	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
 		return -EBADMSG;
@@ -297,7 +308,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *hdr = &req->hdr;
 
 	memset(req, 0, sizeof(*req));
@@ -417,13 +428,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (!seqno)
 		return -EIO;
 
+	/* Clear shared memory's response for the host to populate. */
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
-	/* Encrypt the userspace provided payload */
+	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
 	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
+	/*
+	 * Write the fully encrypted request to the shared unencrypted
+	 * request page.
+	 */
+	memcpy(snp_dev->request, &snp_dev->secret_request,
+	       sizeof(snp_dev->secret_request));
+
 	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
 	if (rc) {
 		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
-- 
2.35.1

