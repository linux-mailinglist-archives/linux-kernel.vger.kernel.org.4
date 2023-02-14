Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927DD696A41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjBNQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjBNQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AD83E4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ec8c88d75so139470927b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0nfdnvfldsrO3Wlbi7UXxbxGh5v/Cc3vMzKji0VJCw=;
        b=WBceX564EWms8L5oRwFo5LqR4t0pF7MQ1SN05LYidS09ZBWhB1oM/T2CpKL25862NX
         X6KUSF1RvcvkVsqnto+XKdP/3EInT0Y7ReNwzpqOIN0Uni33pIw95AFs6yXSBfETo4Iu
         v6rB1dtqqHuLFqrCBe626m8fUBt8u3lhffJaxAH2FN2JWGXldf3rHOts6+ngQXm18W0H
         gA2M8EH/FRHWQNDsids5N0OZNJ6WI6fzvaKB25/gb7kOFiCyGIJ9hM7JrSUpGfiibp4n
         +hXrRtjEdWdA1SFYFDihgThU7Don6bky/waq5m8tDNU9F/QjdMDfdmvChL4w9BS7B/3j
         5POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0nfdnvfldsrO3Wlbi7UXxbxGh5v/Cc3vMzKji0VJCw=;
        b=dgD6SdrgW4QhOHLdUHOyYSAv73cDUFtSD+pMmQ1Hr2FmgCj+SSOsKOz+yonmM45siL
         uTw6HH7o+ogvJ5qnZacVeDMEucoxOBGyYyjAiLWlpJX1NHrOakYDCw0HJF4ttkrC15kI
         H+d1JiLucG6P6XtXetuWXn5fP0dGh1oiniG2clrc5GPTrYy61VlHHwJOjPoPgQ5vdROC
         a+rQvwbtfpG+BRt5fIpQSMZH2x1fpVZ1LMKM37W6XuuTOPwECMa3h3AcYb4D+oCVwQVR
         o/w/mhEssyeGZ199qZek9VjGPFpVh8HJ6LAQk2/NPaATgONjXLdC1l89KxdwlpYniTr3
         gviQ==
X-Gm-Message-State: AO0yUKXUszwqVnn9gdXKCi4k2JPCxWizgUWzkiqmmopRUQeGZsOtjzFt
        +62+8HjjfysYI9xIfvM/uJfBJOYMCe0SXhYdVC1itdc/4gfdqhVKa+WsOr9ciRHdly0+R5hWoYl
        j/4hvbPAi/DjLd4VDi5B9hxq2oKwVxdaq2riHx2CB8R+/kMFFtJUQkzHBSU6JRJmCf6oihDM1s5
        XDHWqr650=
X-Google-Smtp-Source: AK7set9U2gh1E4Zu3sxIanWgg2VqTuBpapDNzMznUIzHuOOEowrzNDDxq8w3+Dnl27mY4U0RliJWWMNgjm7ejB9HOw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a81:9c08:0:b0:4ff:95a:1aa with SMTP id
 m8-20020a819c08000000b004ff095a01aamr369220ywa.364.1676393329914; Tue, 14 Feb
 2023 08:48:49 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:46:36 +0000
In-Reply-To: <20230214164638.1189804-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230214164638.1189804-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
Message-ID: <20230214164638.1189804-3-dionnaglaze@google.com>
Subject: [PATCH v15 2/4] virt/coco/sev-guest: Double-buffer messages
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The encryption algorithms read and write directly to shared unencrypted
memory, which may leak information as well as permit the host to tamper
with the message integrity. Instead copy whole messages in or out as
needed before doing any computation on them.

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michael Sterritt <sterritt@google.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index dc75f11c086e..9f6c5ca40d3b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -45,7 +45,13 @@ struct snp_guest_dev {
 
 	void *certs_data;
 	struct snp_guest_crypto *crypto;
+	/* request and response are in unencrypted memory */
 	struct snp_guest_msg *request, *response;
+	/*
+	 * Avoid information leakage by double-buffering shared messages
+	 * in fields that are in regular encrypted memory.
+	 */
+	struct snp_guest_msg secret_request, secret_response;
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
@@ -265,14 +271,17 @@ static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
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
@@ -296,7 +305,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *hdr = &req->hdr;
 
 	memset(req, 0, sizeof(*req));
@@ -336,13 +345,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
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
 retry:
 	/*
 	 * Call firmware to process the request. In this function the encrypted
-- 
2.39.1.637.g21b0678d19-goog

