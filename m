Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8245B9FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiIOQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIOQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:50:54 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290C9E136
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:50:06 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1871841399;
        Thu, 15 Sep 2022 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1663260603; x=1665075004; bh=FkFg8EtCr1O369CBvSqL1CQwl
        CG3BKdMuG2XI5r9JS8=; b=Kxmm8Op1xDnwrVcPZZnih9GDzambZUL+I+yAuaUn0
        U36aDDWvlbbpw2ux3wl32wv3VHcyKlITaGf5qrlh/QC/OVdI006pXiKgqZI7811J
        IEaU4PLymMRNy0mzaSIQvJSwk4dcKHklqGkwypSzy9Mu6oB/6eS3hDX17kypkJbM
        Ak=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V_sxolbgcA_t; Thu, 15 Sep 2022 19:50:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A4C82452C4;
        Thu, 15 Sep 2022 19:49:12 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 15 Sep 2022 19:49:12 +0300
Received: from t14gen1.yadro.com (10.199.21.212) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 15 Sep
 2022 19:49:11 +0300
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Ilya Kuznetsov <ilya@yadro.com>,
        <linux@yadro.com>, Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: [PATCH 2/2] mailbox: Error out early if the mbox driver has failed to submit the message
Date:   Thu, 15 Sep 2022 19:47:30 +0300
Message-ID: <20220915164730.515767-3-e.shatokhin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220915164730.515767-1-e.shatokhin@yadro.com>
References: <20220915164730.515767-1-e.shatokhin@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.21.212]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbox_send_message() places the pointer to the message to the queue
(add_to_rbuf) then calls msg_submit(chan) to submit the first of the
queued messaged to the mailbox. Some of mailbox drivers can return
errors from their .send_data() callbacks, e.g., if the message is
invalid or there is something wrong with the mailbox device.

In this case:
* hrtimer is not started by msg_submit();
* the pointer to that message remains in the queue;
* if mbox_send_message() is called in blocking mode, it will needlessly
wait for tx_tout ms (or for an hour if tx_out is not set), then it will
call tx_tick(chan, -ETIME).

tx_tick() will then try to submit the first message in the queue - the
same message as before. The underlying driver might reject it again.

The problematic message could then remain in the queue forever, which would
prevent the system from sending other, maybe unrelated messages via the
same mailbox channel. Moreover, the caller would be unable to free or reuse
the message structure.

Let us remove the message from the queue and error out from
mbox_send_message() early if sending of the message fails.

As for tx_tick() - not sure, if chan->cl->tx_done() should still be
called if msg_submit(chan) reports an error. For now, tx_tick() will
exit early too.

Signed-off-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
---
 drivers/mailbox/mailbox.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 04db5ef58f93..32d9ba05427e 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -82,10 +82,9 @@ static int msg_submit(struct mbox_chan *chan)
 		chan->cl->tx_prepare(chan->cl, data);
 	/* Try to submit a message to the MBOX controller */
 	err = chan->mbox->ops->send_data(chan, data);
-	if (!err) {
+	chan->msg_count--;
+	if (!err)
 		chan->active_req = data;
-		chan->msg_count--;
-	}
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
 
@@ -102,6 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
 {
 	unsigned long flags;
 	void *mssg;
+	int err;
 
 	spin_lock_irqsave(&chan->lock, flags);
 	mssg = chan->active_req;
@@ -109,9 +109,8 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Submit next message */
-	msg_submit(chan);
-
-	if (!mssg)
+	err = msg_submit(chan);
+	if (!mssg || err)
 		return;
 
 	/* Notify the client */
@@ -276,6 +275,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 	}
 
 	err = msg_submit(chan);
+	if (err)
+		return err;
 
 	if (chan->cl->tx_block) {
 		unsigned long wait;
@@ -293,7 +294,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		}
 	}
 
-	return (err < 0) ? err : t;
+	return t;
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
-- 
2.34.1

