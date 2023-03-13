Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E06B782F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCMM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCMM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BC210F;
        Mon, 13 Mar 2023 05:58:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OXuAUmjrjcyymnYbM4tpIO1O5BbWJa7T9d0dN9Q/S8=;
        b=w9BRMO6uaS82SrO/CnxYy3U4m74c2NwOlCpXBZyMZ63NKrwWxhmFxfaVZpIw1tAR5i0XO1
        pyvTrV/Dlyof3NhGki7d707griNfcmrqm3Fen2UOiBJWZfzQXHOCBFEba4jRL6pesTz5qx
        wdSjR1cqRhOZ1NeF8VlsTV8CD5Vo564DSWva1ekScy/ibWFpSPtIY24zHiR8J1IRy6cVHD
        mdX0tlQQty2mP4c3jIDw86Fv0TCwrtTrlH7Wiyp6nS+qGQ/t5g+6tKYujK6PX4T8kTM5F0
        x0+RK8XRFaYyVBEG3VZEtFOQIAP//utENcJ8Y+mN2/2gYTYQWugVpe9syHxJWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OXuAUmjrjcyymnYbM4tpIO1O5BbWJa7T9d0dN9Q/S8=;
        b=RryXax9smgw1rCfh09UtjJUslJ3Q/sVCUs9FVmZdRxcc2SJOR7s+gDCdCB9fI5/n3fHvEC
        vkTBvPvf3eqImUDw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Remove the disable_vmpck label
 in handle_guest_request()
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-5-bp@alien8.de>
References: <20230307192449.24732-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167871229056.5837.3427915101817135616.tip-bot2@tip-bot2>
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

Commit-ID:     c5a338274bdb894f088767bea856be344d0ccaef
Gitweb:        https://git.kernel.org/tip/c5a338274bdb894f088767bea856be344d0ccaef
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Feb 2023 11:43:43 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 11:33:41 +01:00

virt/coco/sev-guest: Remove the disable_vmpck label in handle_guest_request()

Call the function directly instead.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230307192449.24732-5-bp@alien8.de
---
 drivers/virt/coco/sev-guest/sev-guest.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index e61db0b..a51bd4a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -405,7 +405,8 @@ retry_request:
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
 			  rc, *fw_err);
-		goto disable_vmpck;
+		snp_disable_vmpck(snp_dev);
+		return rc;
 	}
 
 	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
@@ -413,14 +414,11 @@ retry_request:
 		dev_alert(snp_dev->dev,
 			  "Detected unexpected decode failure from ASP. rc: %d\n",
 			  rc);
-		goto disable_vmpck;
+		snp_disable_vmpck(snp_dev);
+		return rc;
 	}
 
 	return 0;
-
-disable_vmpck:
-	snp_disable_vmpck(snp_dev);
-	return rc;
 }
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
