Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFAD604AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiJSPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJSPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:10:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB3140E67
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:03:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d18-20020a170902ced200b00180680b8ed1so11858302plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jjeUrnqbhNp6g16FZyggyoCcMU0gxOqp1sDPYM/lLjs=;
        b=I466DihAisJ43CiyCl9Txr4J6tmUK+4Kffzv68FV2YFCjEqBNMPDcpcuSHi0whTLCf
         xhnuMeDaOdHqDF4cXcTspPKG0j4XD40sGfkcAkMNjcPBlKXRGdY5RQciC+mhd/2Iu2Yw
         yuc9nOjcPp8a+62C40n+i2vaAmQztCSPpUDWy+Fir3N3/kRcesPOQZPmwIbYsISmZ7nC
         Yu6ItOpa644BhXEZ0C7hYUQNcitpwkRSjV140VlddREJNqyX0o3widEKrcy3iFZZzxwv
         rTt9mx04aZgG4f8S9Hj9wUS2OGGRyyfxFUsa4PDRjaqk1/vme5VJGOhP1SVcBPyFaIad
         615w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjeUrnqbhNp6g16FZyggyoCcMU0gxOqp1sDPYM/lLjs=;
        b=s/cAjU8pctvrcpSm6bDXlRPpLqDn6jjM6o12fMtbPfXURDKvpFF7OHD/bRhERGd1Gv
         b3TRKEDNBqpfr0fsqpcTtOWe06pPcTVxdNgaZJ91NcjKhwTlvdfHXlgf8/VF/RfwPXi9
         IXjW1i+iXh6j4WyYx+zrD6M9LbggGU8C7QVXnEtN00fybDtlimhtymKXjhd63vw5OxG7
         XVQXGp2BA3kHzKplXMSP56p6dOPuyEFlS5+O639MQgQFWsWQY34GkKSERiF7gASBeKtj
         GErtQ8t8JjqA/GdohUwWlp5BGUACdZUQ0ZAk+HeBNSTjHFmO6fvhYfrenjF+sQeZ/gUH
         TdOA==
X-Gm-Message-State: ACrzQf29KFA2AYx/QyenrUfQxGSOX2tZtsnhIgLDx9SLXeRxMj8QI9GV
        M+hV53HXfGvm95yplyJLZFLzJHw0VMI=
X-Google-Smtp-Source: AMsMyM6pteOsQYBnT17r7bvVUp+6YhBd4RkggukkPWftHlgid6du2KUWvGMkL/OBx05FKGFvHhdFUmnNUo8=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:a42:8a14:f405:2ee1])
 (user=pgonda job=sendgmr) by 2002:a65:5a0b:0:b0:46b:158e:ad7c with SMTP id
 y11-20020a655a0b000000b0046b158ead7cmr7728945pgs.272.1666191824125; Wed, 19
 Oct 2022 08:03:44 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:03:33 -0700
Message-Id: <20221019150333.1047423-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Subject: [PATCH] virt: Prevent AES-GCM IV reuse in SNP guest driver
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASP and an SNP guest use a series of AES-GCM keys called VMPCKs to
communicate securely with each other. The IV to this scheme is a
sequence number that both the ASP and the guest track. Currently this
sequence number in a guest request must exactly match the sequence
number tracked by the ASP. This means that if the guest sees an error
from the host during a request it can only retry that exact request or
disable the VMPCK to prevent an IV reuse. AES-GCM cannot tolerate IV
reuse see:
https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/800-38-series-drafts/gcm/joux_comments.pdf

Fixes: fce96cf044308 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Peter Gonda <pgonda@google.com>
Reported-by: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Marc Orr <marcorr@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org

---
 drivers/virt/coco/sev-guest/sev-guest.c | 45 ++++++++++++++++++-------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..227ae6a10ef2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -67,8 +67,27 @@ static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
 	return true;
 }
 
+/*
+ * If we receive an error from the host or ASP we have two options. We can
+ * either retry the exact same encrypted request or we can discontinue using the
+ * VMPCK.
+ *
+ * This is because in the current encryption scheme GHCB v2 uses AES-GCM to
+ * encrypt the requests. The IV for this scheme is the sequence number. GCM
+ * cannot tolerate IV reuse.
+ *
+ * The ASP FW v1.51 only increments the sequence numbers on a successful
+ * guest<->ASP back and forth and only accepts messages at its exact sequence
+ * number.
+ *
+ * So if we were to reuse the sequence number the encryption scheme is
+ * vulnerable. If we encrypt the sequence number for a fresh IV the ASP will
+ * reject our request.
+ */
 static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
 {
+	dev_alert(snp_dev->dev, "Disabling vmpck_id: %d to prevent IV reuse.\n",
+		  vmpck_id);
 	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
 	snp_dev->vmpck = NULL;
 }
@@ -326,29 +345,29 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (fw_err)
 		*fw_err = err;
 
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_alert(snp_dev->dev,
+			  "Detected error from ASP request. rc: %d, fw_err: %lu\n",
+			  rc, fw_err);
+		goto disable_vmpck;
+	}
 
-	/*
-	 * The verify_and_dec_payload() will fail only if the hypervisor is
-	 * actively modifying the message header or corrupting the encrypted payload.
-	 * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
-	 * the key cannot be used for any communication. The key is disabled to ensure
-	 * that AES-GCM does not use the same IV while encrypting the request payload.
-	 */
 	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
 	if (rc) {
 		dev_alert(snp_dev->dev,
-			  "Detected unexpected decode failure, disabling the vmpck_id %d\n",
-			  vmpck_id);
-		snp_disable_vmpck(snp_dev);
-		return rc;
+			  "Detected unexpected decode failure from ASP. rc: %d\n",
+			  rc);
+		goto disable_vmpck;
 	}
 
 	/* Increment to new message sequence after payload decryption was successful. */
 	snp_inc_msg_seqno(snp_dev);
 
 	return 0;
+
+disable_vmpck:
+	snp_disable_vmpck(snp_dev);
+	return rc;
 }
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
-- 
2.38.0.413.g74048e4d9e-goog

