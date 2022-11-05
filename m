Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8E61A75A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKEDgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKEDgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:36:35 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C94103F07A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1TEi5
        MrdrPrl+vCS4MMZ/HSJafuRbIvBzswPEFMXVrI=; b=W/9ZkllBwPN8OlaRQ6Swt
        5JlYcwlftTruRsVas/1YRPRKFYkBnXMUJLq7lauPb7t7em3E48chW3Sztr0UQqrs
        NDxopBapS4OGbaSjDsl/cVBO1F3kRdRrqjadrPXBf1tARzlmi36luikFLcteyjKW
        jBX1vUZozhTTholgLf9Dqs=
Received: from m5510.. (unknown [183.192.225.236])
        by smtp12 (Coremail) with SMTP id EMCowACHzOU52mVjRn2lAA--.6785S2;
        Sat, 05 Nov 2022 11:36:26 +0800 (CST)
From:   jqlhn <jqlhn@163.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, jqlhn <jqlhn@163.com>
Subject: [PATCH] drivers:mailbox Using kfifo to store buffered message data
Date:   Sat,  5 Nov 2022 11:36:23 +0800
Message-Id: <20221105033623.259053-1-jqlhn@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACHzOU52mVjRn2lAA--.6785S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1DWr4rtFy5CF1UJrWfGrg_yoW7GF18pF
        WaqFy3JFW8Ja15WF4DK3WrZr12q34kuF98C3sxK3WrZr98Cr93Z3WFy3W0qFWDtF47tFy2
        93Z5Xrs7CF1DKr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEq2NhUUUUU=
X-Originating-IP: [183.192.225.236]
X-CM-SenderInfo: hmtox0i6rwjhhfrp/1tbiGQywolyPfO6VuwABsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current mailbox, a self implemented message array to be used
as message fifo, I am replacing it with kernel kfifo,
in order to make code cleaner.

Signed-off-by: jqlhn <jqlhn@163.com>
---
 drivers/mailbox/mailbox.c          | 33 ++++++++----------------------
 drivers/mailbox/omap-mailbox.c     |  3 +--
 drivers/mailbox/pcc.c              |  3 +--
 include/linux/mailbox_controller.h | 10 ++++-----
 4 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..d738bb472cd0 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -25,59 +25,43 @@ static DEFINE_MUTEX(con_mutex);
 
 static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 {
-	int idx;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
 	/* See if there is any space left */
-	if (chan->msg_count == MBOX_TX_QUEUE_LEN) {
+	if (kfifo_is_full(&chan->msg_fifo)) {
 		spin_unlock_irqrestore(&chan->lock, flags);
 		return -ENOBUFS;
 	}
 
-	idx = chan->msg_free;
-	chan->msg_data[idx] = mssg;
-	chan->msg_count++;
-
-	if (idx == MBOX_TX_QUEUE_LEN - 1)
-		chan->msg_free = 0;
-	else
-		chan->msg_free++;
+	kfifo_put(&chan->msg_fifo, mssg);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	return idx;
+	return 0;
 }
 
 static void msg_submit(struct mbox_chan *chan)
 {
-	unsigned count, idx;
 	unsigned long flags;
 	void *data;
 	int err = -EBUSY;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
+	if (!kfifo_peek(&chan->msg_fifo, &data) || chan->active_req)
 		goto exit;
 
-	count = chan->msg_count;
-	idx = chan->msg_free;
-	if (idx >= count)
-		idx -= count;
-	else
-		idx += MBOX_TX_QUEUE_LEN - count;
-
-	data = chan->msg_data[idx];
-
 	if (chan->cl->tx_prepare)
 		chan->cl->tx_prepare(chan->cl, data);
 	/* Try to submit a message to the MBOX controller */
 	err = chan->mbox->ops->send_data(chan, data);
 	if (!err) {
 		chan->active_req = data;
-		chan->msg_count--;
+		/* Get msg out of fifo */
+		if (!kfifo_get(&chan->msg_fifo, &data))
+			err = -ENODATA;
 	}
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -379,8 +363,7 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	}
 
 	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
+	INIT_KFIFO(chan->msg_fifo);
 	chan->active_req = NULL;
 	chan->cl = cl;
 	init_completion(&chan->tx_complete);
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 098c82d87137..b392f79e77b3 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -443,8 +443,7 @@ struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
 
 	chan = mbox->chan;
 	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
+	INIT_KFIFO(chan->msg_fifo);
 	chan->active_req = NULL;
 	chan->cl = cl;
 	init_completion(&chan->tx_complete);
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3c2bc0ca454c..2359cba8381e 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -297,8 +297,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	dev = chan->mbox->dev;
 
 	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
+	INIT_KFIFO(chan->msg_fifo);
 	chan->active_req = NULL;
 	chan->cl = cl;
 	init_completion(&chan->tx_complete);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f5..b3bec4f33b6d 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -8,6 +8,7 @@
 #include <linux/hrtimer.h>
 #include <linux/device.h>
 #include <linux/completion.h>
+#include <linux/kfifo.h>
 
 struct mbox_chan;
 
@@ -100,7 +101,7 @@ struct mbox_controller {
  * REVISIT: If too many platforms see the "Try increasing MBOX_TX_QUEUE_LEN"
  * print, it needs to be taken from config option or somesuch.
  */
-#define MBOX_TX_QUEUE_LEN	20
+#define MBOX_TX_QUEUE_LEN	32
 
 /**
  * struct mbox_chan - s/w representation of a communication chan
@@ -109,9 +110,7 @@ struct mbox_controller {
  * @cl:			Pointer to the current owner of this channel
  * @tx_complete:	Transmission completion
  * @active_req:		Currently active request hook
- * @msg_count:		No. of mssg currently queued
- * @msg_free:		Index of next available mssg slot
- * @msg_data:		Hook for data packet
+ * @msg_fifo:		Hook for data packet
  * @lock:		Serialise access to the channel
  * @con_priv:		Hook for controller driver to attach private data
  */
@@ -121,8 +120,7 @@ struct mbox_chan {
 	struct mbox_client *cl;
 	struct completion tx_complete;
 	void *active_req;
-	unsigned msg_count, msg_free;
-	void *msg_data[MBOX_TX_QUEUE_LEN];
+	DECLARE_KFIFO(msg_fifo, void*, MBOX_TX_QUEUE_LEN);
 	spinlock_t lock; /* Serialise access to the channel */
 	void *con_priv;
 };
-- 
2.34.1

