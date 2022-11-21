Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15A6631E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKUKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKUKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:25:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DD1C110;
        Mon, 21 Nov 2022 02:25:40 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:25:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669026337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+oVnlIu1lM5ke3fIS0ckQkYs9F1J3bDKitIxtYxMwM=;
        b=NnTpZ1KNNjMDUWrkqcB7mjBPtaW/ABMsC7lcCRpunIiLjbv7O+Jx28mBWBfFZjT9Qe+eAZ
        B8o8Rdl4dQBcb+kloUqkbx8pkNBzusHWk4aOqh8R1Y62ONCKTQeLWa3Gu9qZ+ceAQeJiEt
        8RUq6NhPZAlsd5LLKUMFSIunWcFww0abnqh4X80bWFNilxnRXbwr9XzrOaIgybfQsIWIBi
        3O0TMBpUK9U4VJpuxd1GPGvPEPnymq2xz6gqS3/NwG6AVRuNjP/NUhlkM656JVgPSg4As9
        mkmMcOKxyk6a5DfNgMahW+/bjCmE3g7MlU9KEGeKNtnMimvUm8kOWfsH3nMYog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669026337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+oVnlIu1lM5ke3fIS0ckQkYs9F1J3bDKitIxtYxMwM=;
        b=VjbZuQjXblVvi+BpZur0XfxTYda4v2foKxi+IZWbNEmBIQZ3ICkeHII06t7vZrl0Z/II0c
        Ukav69Q9BLpEk7Dw==
From:   "tip-bot2 for Peter Gonda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/sev-guest: Prevent IV reuse in the SNP guest driver
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221116175558.2373112-1-pgonda@google.com>
References: <20221116175558.2373112-1-pgonda@google.com>
MIME-Version: 1.0
Message-ID: <166902633575.4906.3852391805327097742.tip-bot2@tip-bot2>
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

Commit-ID:     47894e0fa6a56a42be6a47c767e79cce8125489d
Gitweb:        https://git.kernel.org/tip/47894e0fa6a56a42be6a47c767e79cce8125489d
Author:        Peter Gonda <pgonda@google.com>
AuthorDate:    Wed, 16 Nov 2022 09:55:58 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 21 Nov 2022 11:03:40 +01:00

virt/sev-guest: Prevent IV reuse in the SNP guest driver

The AMD Secure Processor (ASP) and an SNP guest use a series of
AES-GCM keys called VMPCKs to communicate securely with each other.
The IV to this scheme is a sequence number that both the ASP and the
guest track.

Currently, this sequence number in a guest request must exactly match
the sequence number tracked by the ASP. This means that if the guest
sees an error from the host during a request it can only retry that
exact request or disable the VMPCK to prevent an IV reuse. AES-GCM
cannot tolerate IV reuse, see: "Authentication Failures in NIST version
of GCM" - Antoine Joux et al.

In order to address this, make handle_guest_request() delete the VMPCK
on any non successful return. To allow userspace querying the cert_data
length make handle_guest_request() save the number of pages required by
the host, then have handle_guest_request() retry the request without
requesting the extended data, then return the number of pages required
back to userspace.

  [ bp: Massage, incorporate Tom's review comments. ]

Fixes: fce96cf044308 ("virt: Add SEV-SNP guest driver")
Reported-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20221116175558.2373112-1-pgonda@google.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 84 ++++++++++++++++++++----
 1 file changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c..1ea6d2e 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -67,8 +67,27 @@ static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
 	return true;
 }
 
+/*
+ * If an error is received from the host or AMD Secure Processor (ASP) there
+ * are two options. Either retry the exact same encrypted request or discontinue
+ * using the VMPCK.
+ *
+ * This is because in the current encryption scheme GHCB v2 uses AES-GCM to
+ * encrypt the requests. The IV for this scheme is the sequence number. GCM
+ * cannot tolerate IV reuse.
+ *
+ * The ASP FW v1.51 only increments the sequence numbers on a successful
+ * guest<->ASP back and forth and only accepts messages at its exact sequence
+ * number.
+ *
+ * So if the sequence number were to be reused the encryption scheme is
+ * vulnerable. If the sequence number were incremented for a fresh IV the ASP
+ * will reject the request.
+ */
 static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
 {
+	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
+		  vmpck_id);
 	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
 	snp_dev->vmpck = NULL;
 }
@@ -321,34 +340,71 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (rc)
 		return rc;
 
-	/* Call firmware to process the request */
+	/*
+	 * Call firmware to process the request. In this function the encrypted
+	 * message enters shared memory with the host. So after this call the
+	 * sequence number must be incremented or the VMPCK must be deleted to
+	 * prevent reuse of the IV.
+	 */
 	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+
+	/*
+	 * If the extended guest request fails due to having too small of a
+	 * certificate data buffer, retry the same guest request without the
+	 * extended data request in order to increment the sequence number
+	 * and thus avoid IV reuse.
+	 */
+	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
+	    err == SNP_GUEST_REQ_INVALID_LEN) {
+		const unsigned int certs_npages = snp_dev->input.data_npages;
+
+		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
+
+		/*
+		 * If this call to the firmware succeeds, the sequence number can
+		 * be incremented allowing for continued use of the VMPCK. If
+		 * there is an error reflected in the return value, this value
+		 * is checked further down and the result will be the deletion
+		 * of the VMPCK and the error code being propagated back to the
+		 * user as an ioctl() return code.
+		 */
+		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+
+		/*
+		 * Override the error to inform callers the given extended
+		 * request buffer size was too small and give the caller the
+		 * required buffer size.
+		 */
+		err = SNP_GUEST_REQ_INVALID_LEN;
+		snp_dev->input.data_npages = certs_npages;
+	}
+
 	if (fw_err)
 		*fw_err = err;
 
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_alert(snp_dev->dev,
+			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
+			  rc, *fw_err);
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
