Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D505B9FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIOQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIOQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:50:46 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E41073330
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:49:57 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 327B241399;
        Thu, 15 Sep 2022 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1663260595; x=1665074996; bh=6UEUP+y+Z7RGWxNREbm/5xo+C
        7aE6gcUmSI1T3jT2l4=; b=pv77DRPjgezXzXD+gD1vfdbrjqaP3r47rCRcHF+sE
        wmqGJn50mDP5QF46C8QamfAQ2gWlTt3QOk1zlHgmw3JYH8rgEWBVVnvWe0IzvZip
        YUhso7c7w5crTtw8/O/GczrUiGVl7xD5+FoFhD2peWEuvl7bZvt14hLIjJy5WPdQ
        hM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4C9GCwduArZf; Thu, 15 Sep 2022 19:49:55 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8B7174525E;
        Thu, 15 Sep 2022 19:48:57 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 15 Sep 2022 19:48:57 +0300
Received: from t14gen1.yadro.com (10.199.21.212) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 15 Sep
 2022 19:48:56 +0300
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Ilya Kuznetsov <ilya@yadro.com>,
        <linux@yadro.com>, Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: [PATCH 1/2] mailbox: Propagate errors from .send_data() callback to mbox_send_message()
Date:   Thu, 15 Sep 2022 19:47:29 +0300
Message-ID: <20220915164730.515767-2-e.shatokhin@yadro.com>
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

msg_submit() calls .send_data() function from the mailbox controller driver
to place the first of the queued messages to the mailbox. Depending on the
actual driver used, this operation could fail.

In this case, if mbox_send_message() is called in blocking mode, it will
always return -ETIME rather than the actual error reported by the
underlying driver. This could be confusing, so let us propagate the
error from msg_submit() to mbox_send_message().

The errors from msg_submit() called in tx_tick() should be handled in a
subsequent patch.

Signed-off-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
---
 drivers/mailbox/mailbox.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..04db5ef58f93 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -50,17 +50,24 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	return idx;
 }
 
-static void msg_submit(struct mbox_chan *chan)
+static int msg_submit(struct mbox_chan *chan)
 {
 	unsigned count, idx;
 	unsigned long flags;
 	void *data;
-	int err = -EBUSY;
+	int err = 0;
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
+	if (!chan->msg_count) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return 0;
+	}
+
+	if (chan->active_req) {
+		err = -EBUSY;
 		goto exit;
+	}
 
 	count = chan->msg_count;
 	idx = chan->msg_free;
@@ -88,6 +95,7 @@ static void msg_submit(struct mbox_chan *chan)
 		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
 		spin_unlock_irqrestore(&chan->mbox->poll_hrt_lock, flags);
 	}
+	return err;
 }
 
 static void tx_tick(struct mbox_chan *chan, int r)
@@ -256,6 +264,7 @@ EXPORT_SYMBOL_GPL(mbox_client_peek_data);
 int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
+	int err;
 
 	if (!chan || !chan->cl)
 		return -EINVAL;
@@ -266,7 +275,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		return t;
 	}
 
-	msg_submit(chan);
+	err = msg_submit(chan);
 
 	if (chan->cl->tx_block) {
 		unsigned long wait;
@@ -284,7 +293,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		}
 	}
 
-	return t;
+	return (err < 0) ? err : t;
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
-- 
2.34.1

