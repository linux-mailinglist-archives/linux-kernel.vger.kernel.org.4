Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2A6CC064
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjC1NPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjC1NOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:14:50 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D430AD3C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:14:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8F51C424E7;
        Tue, 28 Mar 2023 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680009281; bh=M7BzVw3d+64yIlKTxTOsMPRrEdN40ois41hxCJhxNek=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=yhLrq3a2VSPO6qAAar4w8yMBuoTwqmf6c9lHfCFOeyqPCzzYTVMCCl8kHGb8TpYYf
         5N9ZrFREQYfuxQTLdgj1f7hY+7iFdHUe4KRqmGpQu2RmxPA5ZfPuVs0F4kjPdza5pf
         lm6f4HYnyHTExicoh7tNB1EC/USPBZ+WYDjV5PNPIKKWci504PUx+Aq2YhvlB2HNJ1
         r4rOBRcjtibaU406MtKCBAC5tyqepsgQ8mrilPDJ0RUmJ2G5Pxrmh0IoPXV0+hTStU
         vVRq06BES7HPDwJ6+eNfTcmLVNpterB1yzsxZFodqNsjdjSwfEBFK1kUCXi0ylvmSy
         wBkbnQ/3+pobA==
From:   Hector Martin <marcan@marcan.st>
Date:   Tue, 28 Mar 2023 22:14:14 +0900
Subject: [PATCH 1/5] soc: apple: rtkit: Get rid of
 apple_rtkit_send_message_wait
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-soc-mailbox-v1-1-3953814532fd@marcan.st>
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=marcan@marcan.st;
 h=from:subject:message-id; bh=M7BzVw3d+64yIlKTxTOsMPRrEdN40ois41hxCJhxNek=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhhSlF5arc30WH38iP59FQLWl7b9feMIP52DDW9ULV56O1
 jqQ8kqjo5SFQYyDQVZMkaXxRO+pbs/p59RVU6bDzGFlAhnCwMUpABNJu8DIsK2db2X7ohmdi6+c
 OFY0p+iBxwEmw6S7+/1KZ5z6IV7wq5vhf/J1tqkdvyUiFDmuzgno3RTCvGKa4+Nt927dd/96NWr
 ZVC4A
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is fundamentally broken and has no users. Just remove it.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/soc/apple/rtkit.c       | 32 --------------------------------
 include/linux/soc/apple/rtkit.h | 18 ------------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index d9f19dc99da5..7c9b9f25bbc1 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -641,38 +641,6 @@ int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_send_message);
 
-int apple_rtkit_send_message_wait(struct apple_rtkit *rtk, u8 ep, u64 message,
-				  unsigned long timeout, bool atomic)
-{
-	DECLARE_COMPLETION_ONSTACK(completion);
-	int ret;
-	long t;
-
-	ret = apple_rtkit_send_message(rtk, ep, message, &completion, atomic);
-	if (ret < 0)
-		return ret;
-
-	if (atomic) {
-		ret = mbox_flush(rtk->mbox_chan, timeout);
-		if (ret < 0)
-			return ret;
-
-		if (try_wait_for_completion(&completion))
-			return 0;
-
-		return -ETIME;
-	} else {
-		t = wait_for_completion_interruptible_timeout(
-			&completion, msecs_to_jiffies(timeout));
-		if (t < 0)
-			return t;
-		else if (t == 0)
-			return -ETIME;
-		return 0;
-	}
-}
-EXPORT_SYMBOL_GPL(apple_rtkit_send_message_wait);
-
 int apple_rtkit_poll(struct apple_rtkit *rtk)
 {
 	return mbox_client_peek_data(rtk->mbox_chan);
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index fc456f75c131..8c9ca857ccf6 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -160,24 +160,6 @@ int apple_rtkit_start_ep(struct apple_rtkit *rtk, u8 endpoint);
 int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
 			     struct completion *completion, bool atomic);
 
-/*
- * Send a message to the given endpoint and wait until it has been submitted
- * to the hardware FIFO.
- * Will return zero on success and a negative error code on failure
- * (e.g. -ETIME when the message couldn't be written within the given
- * timeout)
- *
- * @rtk:            RTKit reference
- * @ep:             target endpoint
- * @message:        message to be sent
- * @timeout:        timeout in milliseconds to allow the message transmission
- *                  to be completed
- * @atomic:         if set to true this function can be called from atomic
- *                  context.
- */
-int apple_rtkit_send_message_wait(struct apple_rtkit *rtk, u8 ep, u64 message,
-				  unsigned long timeout, bool atomic);
-
 /*
  * Process incoming messages in atomic context.
  * This only guarantees that messages arrive as far as the recv_message_early

-- 
2.40.0

