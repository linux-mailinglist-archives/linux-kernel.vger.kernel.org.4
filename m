Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9A6A6A09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCAJtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCAJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:49:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87128271B;
        Wed,  1 Mar 2023 01:49:46 -0800 (PST)
Date:   Wed, 01 Mar 2023 09:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677664184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjBYcejPwwKYBVOYzMQ4TIcvZoumdc8c7sD67+6I5es=;
        b=HdmY4pdz68JHFhefmwNe20cjf3+25B0xeG5/Ca0Kq4QEeAeqdhZi4hXrzTGZ6kpbgDj0E6
        X3aKQTG95SyOukBa50ucMVcA1TPuffRNN1nEQ+XnCuWTGz9lwC/+aPK8mtbYUILvdmjrox
        5my3H1hL/XtvJCUv8p/RsNX0AuEGq15JYy+3t1xUpHGcDqGBJr8Z5V3GhLxIEo9pWDJt54
        w/s3xv0EbEvHR/4x3xa3y/taMHRQX4rVQUd8HuMb++GYlXkzt8/hhVzdYxvTjq5YsXz4V7
        7fEToIcGbw2fUXuwGeYPnxpGg87N5hxFBvgpN7TVd676yhOwwseuUDQeNJi4FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677664184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjBYcejPwwKYBVOYzMQ4TIcvZoumdc8c7sD67+6I5es=;
        b=K3w53KBk5fUtxxp4SG1yyrmNuQljW1V5ii6uBFPzpfsl5yv8aRLQkNBHO4BzkLeNPdDqRv
        EyeIe/RCIXNLD1Dg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/sev-guest: Return -EIO if certificate buffer
 is not large enough
Cc:     Larry Dewey <larry.dewey@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee=2E16770?=
 =?utf-8?q?83979=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee=2E167708?=
 =?utf-8?q?3979=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <167766418335.5837.8035431870442051850.tip-bot2@tip-bot2>
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

Commit-ID:     dd093fb08e8f8a958fec4eef36f9f09eac047f60
Gitweb:        https://git.kernel.org/tip/dd093fb08e8f8a958fec4eef36f9f09eac047f60
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 22 Feb 2023 10:39:39 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 01 Mar 2023 10:17:46 +01:00

virt/sev-guest: Return -EIO if certificate buffer is not large enough

Commit

  47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest driver")

changed the behavior associated with the return value when the caller
does not supply a large enough certificate buffer. Prior to the commit a
value of -EIO was returned. Now, 0 is returned.  This breaks the
established ABI with the user.

Change the code to detect the buffer size error and return -EIO.

Fixes: 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest driver")
Reported-by: Larry Dewey <larry.dewey@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Larry Dewey <larry.dewey@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083979.git.thomas.lendacky@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4ec4174..7b4e900 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -377,9 +377,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		snp_dev->input.data_npages = certs_npages;
 	}
 
+	/*
+	 * Increment the message sequence number. There is no harm in doing
+	 * this now because decryption uses the value stored in the response
+	 * structure and any failure will wipe the VMPCK, preventing further
+	 * use anyway.
+	 */
+	snp_inc_msg_seqno(snp_dev);
+
 	if (fw_err)
 		*fw_err = err;
 
+	/*
+	 * If an extended guest request was issued and the supplied certificate
+	 * buffer was not large enough, a standard guest request was issued to
+	 * prevent IV reuse. If the standard request was successful, return -EIO
+	 * back to the caller as would have originally been returned.
+	 */
+	if (!rc && err == SNP_GUEST_REQ_INVALID_LEN)
+		return -EIO;
+
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
@@ -395,9 +412,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 		goto disable_vmpck;
 	}
 
-	/* Increment to new message sequence after payload decryption was successful. */
-	snp_inc_msg_seqno(snp_dev);
-
 	return 0;
 
 disable_vmpck:
