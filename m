Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC4651619
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiLSXAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiLSXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:00:25 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DAB9FC5;
        Mon, 19 Dec 2022 15:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671490824; x=1703026824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YxDkMMxk4hLAAcLgoVzs4Svd1kqGk6cNpGFHgig5IxQ=;
  b=QxqZn8y44kUit8qHxrfMaZPoc8SyeU1dOCsbtp5aFpWIDrXeFUWHfpkw
   4vh/xILOcnP1CkC2seKAZPvo2kUfXf5j5qFnJg9naGuyo2/pqRb7KiEyo
   skS8DJshKsrP2VyUkhUJP01mgxkaSGLh5VVCHjfC3JZMXaVmfhXTD7JYs
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Dec 2022 15:00:24 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 15:00:23 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:23 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 07/28] mailbox: Allow direct registration to a channel
Date:   Mon, 19 Dec 2022 14:58:28 -0800
Message-ID: <20221219225850.2397345-8-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support virtual mailbox controllers and clients which are not platform
devices or come from the devicetree by allowing them to match client to
channel via some other mechanism.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
 drivers/mailbox/omap-mailbox.c | 18 ++-----
 drivers/mailbox/pcc.c          | 18 ++-----
 include/linux/mailbox_client.h |  1 +
 4 files changed, 76 insertions(+), 57 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..adf36c05fa43 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -317,6 +317,71 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 }
 EXPORT_SYMBOL_GPL(mbox_flush);
 
+static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
+{
+	struct device *dev = cl->dev;
+	unsigned long flags;
+	int ret;
+
+	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
+		dev_dbg(dev, "%s: mailbox not free\n", __func__);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->msg_free = 0;
+	chan->msg_count = 0;
+	chan->active_req = NULL;
+	chan->cl = cl;
+	init_completion(&chan->tx_complete);
+
+	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
+		chan->txdone_method = TXDONE_BY_ACK;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	if (chan->mbox->ops->startup) {
+		ret = chan->mbox->ops->startup(chan);
+
+		if (ret) {
+			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
+			mbox_free_channel(chan);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * mbox_bind_client - Request a mailbox channel.
+ * @chan: The mailbox channel to bind the client to.
+ * @cl: Identity of the client requesting the channel.
+ *
+ * The Client specifies its requirements and capabilities while asking for
+ * a mailbox channel. It can't be called from atomic context.
+ * The channel is exclusively allocated and can't be used by another
+ * client before the owner calls mbox_free_channel.
+ * After assignment, any packet received on this channel will be
+ * handed over to the client via the 'rx_callback'.
+ * The framework holds reference to the client, so the mbox_client
+ * structure shouldn't be modified until the mbox_free_channel returns.
+ *
+ * Return: 0 if the channel was assigned to the client successfully.
+ *         <0 for request failure.
+ */
+int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
+{
+	int ret;
+
+	mutex_lock(&con_mutex);
+	ret = __mbox_bind_client(chan, cl);
+	mutex_unlock(&con_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mbox_bind_client);
+
 /**
  * mbox_request_channel - Request a mailbox channel.
  * @cl: Identity of the client requesting the channel.
@@ -340,7 +405,6 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	struct mbox_controller *mbox;
 	struct of_phandle_args spec;
 	struct mbox_chan *chan;
-	unsigned long flags;
 	int ret;
 
 	if (!dev || !dev->of_node) {
@@ -372,33 +436,9 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 		return chan;
 	}
 
-	if (chan->cl || !try_module_get(mbox->dev->driver->owner)) {
-		dev_dbg(dev, "%s: mailbox not free\n", __func__);
-		mutex_unlock(&con_mutex);
-		return ERR_PTR(-EBUSY);
-	}
-
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	init_completion(&chan->tx_complete);
-
-	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
-		chan->txdone_method = TXDONE_BY_ACK;
-
-	spin_unlock_irqrestore(&chan->lock, flags);
-
-	if (chan->mbox->ops->startup) {
-		ret = chan->mbox->ops->startup(chan);
-
-		if (ret) {
-			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
-			mbox_free_channel(chan);
-			chan = ERR_PTR(ret);
-		}
-	}
+	ret = __mbox_bind_client(chan, cl);
+	if (ret)
+		chan = ERR_PTR(ret);
 
 	mutex_unlock(&con_mutex);
 	return chan;
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 098c82d87137..711a56ec8592 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -441,21 +441,9 @@ struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
 	if (!mbox || !mbox->chan)
 		return ERR_PTR(-ENOENT);
 
-	chan = mbox->chan;
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	init_completion(&chan->tx_complete);
-	spin_unlock_irqrestore(&chan->lock, flags);
-
-	ret = chan->mbox->ops->startup(chan);
-	if (ret) {
-		pr_err("Unable to startup the chan (%d)\n", ret);
-		mbox_free_channel(chan);
-		chan = ERR_PTR(ret);
-	}
+	ret = mbox_bind_client(mbox->chan, cl);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return chan;
 }
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3c2bc0ca454c..f655be083369 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -283,7 +283,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan;
 	struct device *dev;
-	unsigned long flags;
+	int rc;
 
 	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);
@@ -296,21 +296,11 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	}
 	dev = chan->mbox->dev;
 
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	init_completion(&chan->tx_complete);
-
-	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
-		chan->txdone_method = TXDONE_BY_ACK;
-
-	spin_unlock_irqrestore(&chan->lock, flags);
+	rc = mbox_bind_client(chan, cl);
+	if (rc)
+		return ERR_PTR(rc);
 
 	if (pchan->plat_irq > 0) {
-		int rc;
-
 		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
 				      MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 65229a45590f..734694912ef7 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -37,6 +37,7 @@ struct mbox_client {
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
 };
 
+int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl);
 struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
-- 
2.25.1

