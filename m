Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21B6CC066
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjC1NP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjC1NO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:14:58 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D42B463
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:14:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 12A7C425FF;
        Tue, 28 Mar 2023 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680009287; bh=7+GJvR9Q7iwdn6RqvrNP3aRb/S8micm1/klhGlkjTQs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=hmxYgkrmhKrSMm1gsbnyzuk/Oy5Z9ZH4Yk2doGwr2ElU+dG8ORruuNYMvyZg21x7d
         ZNe0BhG5knyu2NXY6w8YxOuaUsOLx4aPUaskc659yxlOnmdcVh/pxGbhrIdhh7QDv8
         akB+yp2FzyOMUHulOeI+OcUxXBmJcJHEOzCBAcc+wqadjIlNIYabkVZGt35Zd/4wSh
         EKYjVa8+adiglibmgZGRdFrr6HqqiCTEKuNYW+dQ/IRNpD+Cc7m1cc16OljBeDPPT+
         ZDlvaf71ceYRuH1Gu24U8tifqGusHjEbkPzVS024A4nfApJ1d5pEtuaIe461T2ofdE
         Z61s+TVPw0heA==
From:   Hector Martin <marcan@marcan.st>
Date:   Tue, 28 Mar 2023 22:14:16 +0900
Subject: [PATCH 3/5] soc: apple: rtkit: Port to the internal mailbox driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-soc-mailbox-v1-3-3953814532fd@marcan.st>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8077; i=marcan@marcan.st;
 h=from:subject:message-id; bh=7+GJvR9Q7iwdn6RqvrNP3aRb/S8micm1/klhGlkjTQs=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhhSlF1Z6n1/9W5qvvm3p9Rf3MhJuu679rryuvts9e/vJB
 sN1bbmXO0pZGMQ4GGTFFFkaT/Se6vacfk5dNWU6zBxWJpAhDFycAjCRA2sYGTZIV3PsWCXqE7zG
 6n3dye3KFyxbjykqPX1fdWOpYqylayojw9/IUqY7u04c6pilePWw+uejmgr3ky69OBpS/1+S+cE
 De1YA
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

Now that we have a mailbox driver in drivers/soc/apple, port the RTKit
code to it. This mostly just entails replacing calls through the mailbox
subsystem with direct calls into the driver.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/soc/apple/Kconfig          |   2 +-
 drivers/soc/apple/rtkit-internal.h |   8 +--
 drivers/soc/apple/rtkit.c          | 101 ++++++++++---------------------------
 3 files changed, 31 insertions(+), 80 deletions(-)

diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index caa2cf09ff7a..d0e29bbd8c6f 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -33,7 +33,7 @@ config APPLE_MBOX
 
 config APPLE_RTKIT
 	tristate "Apple RTKit co-processor IPC protocol"
-	depends on MAILBOX
+	depends on APPLE_MBOX
 	depends on ARCH_APPLE || COMPILE_TEST
 	default ARCH_APPLE
 	help
diff --git a/drivers/soc/apple/rtkit-internal.h b/drivers/soc/apple/rtkit-internal.h
index 24bd619ec5e4..27c9fa745fd5 100644
--- a/drivers/soc/apple/rtkit-internal.h
+++ b/drivers/soc/apple/rtkit-internal.h
@@ -7,18 +7,17 @@
 #ifndef _APPLE_RTKIT_INTERAL_H
 #define _APPLE_RTKIT_INTERAL_H
 
-#include <linux/apple-mailbox.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/soc/apple/rtkit.h>
 #include <linux/workqueue.h>
+#include "mailbox.h"
 
 #define APPLE_RTKIT_APP_ENDPOINT_START 0x20
 #define APPLE_RTKIT_MAX_ENDPOINTS 0x100
@@ -28,10 +27,7 @@ struct apple_rtkit {
 	const struct apple_rtkit_ops *ops;
 	struct device *dev;
 
-	const char *mbox_name;
-	int mbox_idx;
-	struct mbox_client mbox_cl;
-	struct mbox_chan *mbox_chan;
+	struct apple_mbox *mbox;
 
 	struct completion epmap_completion;
 	struct completion iop_pwr_ack_completion;
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 7c9b9f25bbc1..e6d940292c9f 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -72,11 +72,6 @@ enum {
 #define APPLE_RTKIT_MIN_SUPPORTED_VERSION 11
 #define APPLE_RTKIT_MAX_SUPPORTED_VERSION 12
 
-struct apple_rtkit_msg {
-	struct completion *completion;
-	struct apple_mbox_msg mbox_msg;
-};
-
 struct apple_rtkit_rx_work {
 	struct apple_rtkit *rtk;
 	u8 ep;
@@ -550,12 +545,12 @@ static void apple_rtkit_rx_work(struct work_struct *work)
 	kfree(rtk_work);
 }
 
-static void apple_rtkit_rx(struct mbox_client *cl, void *mssg)
+static void apple_rtkit_rx(struct apple_mbox *mbox, struct apple_mbox_msg msg,
+			   void *cookie)
 {
-	struct apple_rtkit *rtk = container_of(cl, struct apple_rtkit, mbox_cl);
-	struct apple_mbox_msg *msg = mssg;
+	struct apple_rtkit *rtk = cookie;
 	struct apple_rtkit_rx_work *work;
-	u8 ep = msg->msg1;
+	u8 ep = msg.msg1;
 
 	/*
 	 * The message was read from a MMIO FIFO and we have to make
@@ -571,7 +566,7 @@ static void apple_rtkit_rx(struct mbox_client *cl, void *mssg)
 
 	if (ep >= APPLE_RTKIT_APP_ENDPOINT_START &&
 	    rtk->ops->recv_message_early &&
-	    rtk->ops->recv_message_early(rtk->cookie, ep, msg->msg0))
+	    rtk->ops->recv_message_early(rtk->cookie, ep, msg.msg0))
 		return;
 
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
@@ -580,30 +575,18 @@ static void apple_rtkit_rx(struct mbox_client *cl, void *mssg)
 
 	work->rtk = rtk;
 	work->ep = ep;
-	work->msg = msg->msg0;
+	work->msg = msg.msg0;
 	INIT_WORK(&work->work, apple_rtkit_rx_work);
 	queue_work(rtk->wq, &work->work);
 }
 
-static void apple_rtkit_tx_done(struct mbox_client *cl, void *mssg, int r)
-{
-	struct apple_rtkit_msg *msg =
-		container_of(mssg, struct apple_rtkit_msg, mbox_msg);
-
-	if (r == -ETIME)
-		return;
-
-	if (msg->completion)
-		complete(msg->completion);
-	kfree(msg);
-}
-
 int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
 			     struct completion *completion, bool atomic)
 {
-	struct apple_rtkit_msg *msg;
-	int ret;
-	gfp_t flags;
+	struct apple_mbox_msg msg = {
+		.msg0 = message,
+		.msg1 = ep,
+	};
 
 	if (rtk->crashed)
 		return -EINVAL;
@@ -611,19 +594,6 @@ int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
 	    !apple_rtkit_is_running(rtk))
 		return -EINVAL;
 
-	if (atomic)
-		flags = GFP_ATOMIC;
-	else
-		flags = GFP_KERNEL;
-
-	msg = kzalloc(sizeof(*msg), flags);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->mbox_msg.msg0 = message;
-	msg->mbox_msg.msg1 = ep;
-	msg->completion = completion;
-
 	/*
 	 * The message will be sent with a MMIO write. We need the barrier
 	 * here to ensure any previous writes to buffers are visible to the
@@ -631,19 +601,13 @@ int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
 	 */
 	dma_wmb();
 
-	ret = mbox_send_message(rtk->mbox_chan, &msg->mbox_msg);
-	if (ret < 0) {
-		kfree(msg);
-		return ret;
-	}
-
-	return 0;
+	return apple_mbox_send(rtk->mbox, msg, atomic);
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_send_message);
 
 int apple_rtkit_poll(struct apple_rtkit *rtk)
 {
-	return mbox_client_peek_data(rtk->mbox_chan);
+	return apple_mbox_poll(rtk->mbox);
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_poll);
 
@@ -665,20 +629,6 @@ int apple_rtkit_start_ep(struct apple_rtkit *rtk, u8 endpoint)
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_start_ep);
 
-static int apple_rtkit_request_mbox_chan(struct apple_rtkit *rtk)
-{
-	if (rtk->mbox_name)
-		rtk->mbox_chan = mbox_request_channel_byname(&rtk->mbox_cl,
-							     rtk->mbox_name);
-	else
-		rtk->mbox_chan =
-			mbox_request_channel(&rtk->mbox_cl, rtk->mbox_idx);
-
-	if (IS_ERR(rtk->mbox_chan))
-		return PTR_ERR(rtk->mbox_chan);
-	return 0;
-}
-
 struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 					    const char *mbox_name, int mbox_idx,
 					    const struct apple_rtkit_ops *ops)
@@ -704,13 +654,18 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	bitmap_zero(rtk->endpoints, APPLE_RTKIT_MAX_ENDPOINTS);
 	set_bit(APPLE_RTKIT_EP_MGMT, rtk->endpoints);
 
-	rtk->mbox_name = mbox_name;
-	rtk->mbox_idx = mbox_idx;
-	rtk->mbox_cl.dev = dev;
-	rtk->mbox_cl.tx_block = false;
-	rtk->mbox_cl.knows_txdone = false;
-	rtk->mbox_cl.rx_callback = &apple_rtkit_rx;
-	rtk->mbox_cl.tx_done = &apple_rtkit_tx_done;
+	if (mbox_name)
+		rtk->mbox = apple_mbox_get_byname(dev, mbox_name);
+	else
+		rtk->mbox = apple_mbox_get(dev, mbox_idx);
+
+	if (IS_ERR(rtk->mbox)) {
+		ret = PTR_ERR(rtk->mbox);
+		goto free_rtk;
+	}
+
+	rtk->mbox->rx = apple_rtkit_rx;
+	rtk->mbox->cookie = rtk;
 
 	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
@@ -719,7 +674,7 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 		goto free_rtk;
 	}
 
-	ret = apple_rtkit_request_mbox_chan(rtk);
+	ret = apple_mbox_start(rtk->mbox);
 	if (ret)
 		goto destroy_wq;
 
@@ -750,7 +705,7 @@ static int apple_rtkit_wait_for_completion(struct completion *c)
 int apple_rtkit_reinit(struct apple_rtkit *rtk)
 {
 	/* make sure we don't handle any messages while reinitializing */
-	mbox_free_channel(rtk->mbox_chan);
+	apple_mbox_stop(rtk->mbox);
 	flush_workqueue(rtk->wq);
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
@@ -774,7 +729,7 @@ int apple_rtkit_reinit(struct apple_rtkit *rtk)
 	rtk->iop_power_state = APPLE_RTKIT_PWR_STATE_OFF;
 	rtk->ap_power_state = APPLE_RTKIT_PWR_STATE_OFF;
 
-	return apple_rtkit_request_mbox_chan(rtk);
+	return apple_mbox_start(rtk->mbox);
 }
 EXPORT_SYMBOL_GPL(apple_rtkit_reinit);
 
@@ -930,7 +885,7 @@ EXPORT_SYMBOL_GPL(apple_rtkit_wake);
 
 void apple_rtkit_free(struct apple_rtkit *rtk)
 {
-	mbox_free_channel(rtk->mbox_chan);
+	apple_mbox_stop(rtk->mbox);
 	destroy_workqueue(rtk->wq);
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);

-- 
2.40.0

