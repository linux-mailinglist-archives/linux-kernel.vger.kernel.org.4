Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341116372B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKXHMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKXHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:12:13 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D0CEBB5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:16:18 -0800 (PST)
X-QQ-mid: bizesmtpipv603t1669273772t53h
Received: from localhost ( [255.97.187.15])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Nov 2022 15:09:31 +0800 (CST)
X-QQ-SSF: 01400000002000506000B00A0000000
X-QQ-FEAT: lO87fmWkX3EhOYKGIcNAVg2np+9aHKZcDBznuwONjf3kOrIu+wm+usOljGs2Q
        22k5qNe3UdSqeq6C6EraOV0yrMYFk1S3ilUPTlct8i/aQw6HWNCUQV1N1U2KcaCRceEwZWT
        5V+fFOaoEryPhzPDmuKP28ZU27MQcre7PD6gpFsIyjlbVxvPjFPsw7ckP6EtTJBAkJy4SSL
        Z35IXadyJ+59gpGmTFXAigG+H6f24ykRIjCejTQZuZdcEqVnRT0tTN7E+ykBePhEHKqXSeR
        XO6YyyKfGR6iP9Q36+LOiFY13nJ1VKJ/0KbikJCSdRkDLxbQ39VEIRzZWUFMr2LXQNggfV9
        5/f4B0xVZNKxHCn5qV9k9c7IwBlP+QOdTygl6+7xAU0oT3ixCIBnPidVwP3iw==
X-QQ-GoodBg: 2
Date:   Thu, 24 Nov 2022 15:09:31 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm_scpi: modify to support acpi
Message-ID: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm_scpi: modify to support acpi

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/firmware/arm_scpi.c       | 188 +++++++++++++++++++++---------
 drivers/mailbox/phytium_mailbox.c |  44 +++++++
 2 files changed, 180 insertions(+), 52 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 435d0e2658a4..e2e90dcc38bd 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/spinlock.h>
+#include <linux/acpi.h>
 
 #define CMD_ID_MASK		GENMASK(6, 0)
 #define CMD_TOKEN_ID_MASK	GENMASK(15, 8)
@@ -907,6 +908,8 @@ static const struct of_device_id shmem_of_match[] __maybe_unused = {
 	{ }
 };
 
+extern struct mbox_chan *phytium_mbox_request_channel(struct mbox_client *cl);
+
 static int scpi_probe(struct platform_device *pdev)
 {
 	int count, idx, ret;
@@ -914,18 +917,30 @@ static int scpi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct scpi_drvinfo *scpi_drvinfo;
+	const struct acpi_device_id *match;
 
 	scpi_drvinfo = devm_kzalloc(dev, sizeof(*scpi_drvinfo), GFP_KERNEL);
 	if (!scpi_drvinfo)
 		return -ENOMEM;
 
-	if (of_match_device(legacy_scpi_of_match, &pdev->dev))
-		scpi_drvinfo->is_legacy = true;
+	/* Wang Honghui modified to support acpi */
+	if (dev->of_node) {
+		if (of_match_device(legacy_scpi_of_match, &pdev->dev))
+			scpi_drvinfo->is_legacy = true;
 
-	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
-	if (count < 0) {
-		dev_err(dev, "no mboxes property in '%pOF'\n", np);
-		return -ENODEV;
+		count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
+		if (count < 0) {
+			dev_err(dev, "no mboxes property in '%pOF'\n", np);
+			return -ENODEV;
+		}
+	} else {
+		match = acpi_match_device(dev->driver->acpi_match_table, dev);
+                if (!match) {
+                        dev_err(dev, "scpi: Error ACPI match data is missing\n");
+                        return -ENODEV;
+                }
+
+                count = 1;
 	}
 
 	scpi_drvinfo->channels =
@@ -937,55 +952,116 @@ static int scpi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for (; scpi_drvinfo->num_chans < count; scpi_drvinfo->num_chans++) {
-		resource_size_t size;
-		int idx = scpi_drvinfo->num_chans;
-		struct scpi_chan *pchan = scpi_drvinfo->channels + idx;
-		struct mbox_client *cl = &pchan->cl;
-		struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
-
-		if (!of_match_node(shmem_of_match, shmem))
-			return -ENXIO;
+	/* Wang Honghui modified to support acpi */
+	if (dev->of_node) {
+		for (; scpi_drvinfo->num_chans < count; scpi_drvinfo->num_chans++) {
+			resource_size_t size;
+			int idx = scpi_drvinfo->num_chans;
+			struct scpi_chan *pchan = scpi_drvinfo->channels + idx;
+			struct mbox_client *cl = &pchan->cl;
+			struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
+	
+			if (!of_match_node(shmem_of_match, shmem))
+				return -ENXIO;
+	
+			ret = of_address_to_resource(shmem, 0, &res);
+			of_node_put(shmem);
+			if (ret) {
+				dev_err(dev, "failed to get SCPI payload mem resource\n");
+				return ret;
+			}
 
-		ret = of_address_to_resource(shmem, 0, &res);
-		of_node_put(shmem);
-		if (ret) {
-			dev_err(dev, "failed to get SCPI payload mem resource\n");
+			size = resource_size(&res);
+			pchan->rx_payload = devm_ioremap(dev, res.start, size);
+			if (!pchan->rx_payload) {
+				dev_err(dev, "failed to ioremap SCPI payload\n");
+				return -EADDRNOTAVAIL;
+			}
+			pchan->tx_payload = pchan->rx_payload + (size >> 1);
+
+			cl->dev = dev;
+			cl->rx_callback = scpi_handle_remote_msg;
+			cl->tx_prepare = scpi_tx_prepare;
+			cl->tx_block = true;
+			cl->tx_tout = 20;
+			cl->knows_txdone = false; /* controller can't ack */
+
+			INIT_LIST_HEAD(&pchan->rx_pending);
+			INIT_LIST_HEAD(&pchan->xfers_list);
+			spin_lock_init(&pchan->rx_lock);
+			mutex_init(&pchan->xfers_lock);
+	
+			ret = scpi_alloc_xfer_list(dev, pchan);
+			if (!ret) {
+				pchan->chan = mbox_request_channel(cl, idx);
+				if (!IS_ERR(pchan->chan))
+					continue;
+				ret = PTR_ERR(pchan->chan);
+				if (ret != -EPROBE_DEFER)
+					dev_err(dev, "failed to get channel%d err %d\n",
+						idx, ret);
+			}
 			return ret;
 		}
-
-		size = resource_size(&res);
-		pchan->rx_payload = devm_ioremap(dev, res.start, size);
-		if (!pchan->rx_payload) {
-			dev_err(dev, "failed to ioremap SCPI payload\n");
-			return -EADDRNOTAVAIL;
-		}
-		pchan->tx_payload = pchan->rx_payload + (size >> 1);
-
-		cl->dev = dev;
-		cl->rx_callback = scpi_handle_remote_msg;
-		cl->tx_prepare = scpi_tx_prepare;
-		cl->tx_block = true;
-		cl->tx_tout = 20;
-		cl->knows_txdone = false; /* controller can't ack */
-
-		INIT_LIST_HEAD(&pchan->rx_pending);
-		INIT_LIST_HEAD(&pchan->xfers_list);
-		spin_lock_init(&pchan->rx_lock);
-		mutex_init(&pchan->xfers_lock);
-
-		ret = scpi_alloc_xfer_list(dev, pchan);
-		if (!ret) {
-			pchan->chan = mbox_request_channel(cl, idx);
-			if (!IS_ERR(pchan->chan))
-				continue;
-			ret = PTR_ERR(pchan->chan);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to get channel%d err %d\n",
-					idx, ret);
-		}
-		return ret;
-	}
+	} else {
+		for (; scpi_info->num_chans < count; scpi_info->num_chans++) {
+                        u32 size;
+                        u32 addr;
+                        int idx = scpi_info->num_chans;
+                        struct scpi_chan *pchan = scpi_info->channels + idx;
+                        struct mbox_client *cl = &pchan->cl;
+                        struct fwnode_handle *fn;
+
+                        fn = dev_fwnode(&(pdev->dev));
+                        ret = fwnode_property_read_u32(fn, "shmem_start",  &addr);
+                        if (ret < 0) {
+                                dev_err(dev, "failed to get SCPI payload mem resource\n");
+                                return ret;
+                        }
+
+                        ret = fwnode_property_read_u32(fn, "shmem_size",  &size);
+                        if (ret < 0) {
+                                dev_err(dev, "failed to ioremap SCPI payload\n");
+                                return -EADDRNOTAVAIL;
+                        }
+
+                        pchan->rx_payload = devm_ioremap(dev, (resource_size_t)addr, (resource_size_t)size);
+
+                        if (!pchan->rx_payload) {
+                                dev_err(dev, "failed to ioremap SCPI payload\n");
+                                return -EADDRNOTAVAIL;
+                        }
+                        pchan->tx_payload = pchan->rx_payload + (size >> 1);
+
+                        cl->dev = dev;
+                        cl->rx_callback = scpi_handle_remote_msg;
+                        cl->tx_prepare = scpi_tx_prepare;
+                        cl->tx_block = true;
+                        cl->tx_tout = 20;
+                        cl->knows_txdone = false; /* controller can't ack */
+
+                        INIT_LIST_HEAD(&pchan->rx_pending);
+                        INIT_LIST_HEAD(&pchan->xfers_list);
+                        spin_lock_init(&pchan->rx_lock);
+                        mutex_init(&pchan->xfers_lock);
+
+                        ret = scpi_alloc_xfer_list(dev, pchan);
+
+                        if (!ret) {
+                                pchan->chan = phytium_mbox_request_channel(cl);
+
+                                if (!IS_ERR(pchan->chan))
+                                        continue;
+
+                                ret = PTR_ERR(pchan->chan);
+                                if (ret != -EPROBE_DEFER)
+                                        dev_err(dev, "failed to get channel%d err %d\n",
+                                                idx, ret);
+                        }
+
+                        return ret;
+                }
+        }
 
 	scpi_drvinfo->commands = scpi_std_commands;
 
@@ -1044,11 +1120,19 @@ static const struct of_device_id scpi_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, scpi_of_match);
 
+/* Wang Honghui add to support Phytium FT2000/4 CPU for acpi */
+static const struct acpi_device_id scpi_acpi_match[] = {
+        { "PHYT0008", 0 },
+        { }
+};
+MODULE_DEVICE_TABLE(acpi, scpi_acpi_match);
+
 static struct platform_driver scpi_driver = {
 	.driver = {
 		.name = "scpi_protocol",
 		.of_match_table = scpi_of_match,
 		.dev_groups = versions_groups,
+		.acpi_match_table = ACPI_PTR(scpi_acpi_match),
 	},
 	.probe = scpi_probe,
 	.remove = scpi_remove,
diff --git a/drivers/mailbox/phytium_mailbox.c b/drivers/mailbox/phytium_mailbox.c
index c797d4b4769f..e5ee3d4e7d5f 100644
--- a/drivers/mailbox/phytium_mailbox.c
+++ b/drivers/mailbox/phytium_mailbox.c
@@ -23,6 +23,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+/* Wang Honghui add */
+#include <linux/mailbox_client.h>
+#include "mailbox.h"
+
 #define INTR_STAT	0x0
 #define INTR_SET	0x8
 #define INTR_CLR	0x10
@@ -31,6 +35,9 @@
 
 #define NR_CHANS	1
 
+/* Wang Honghui add */
+static struct mbox_chan *phytium_mbox_chan;
+
 struct phytium_mbox_link {
 	unsigned irq;
 	void __iomem *tx_reg;
@@ -183,6 +190,43 @@ static int phytium_mbox_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+** Wang Honghui add for scpi to request mbox chan
+*/
+struct mbox_chan *phytium_mbox_request_channel(struct mbox_client *cl)
+{
+        struct device *dev = cl->dev;
+        struct mbox_chan *chan = phytium_mbox_chan;
+        unsigned long flags;
+        int ret;
+    
+        if(!chan)    
+                return ERR_PTR(-EPROBE_DEFER);
+    
+        spin_lock_irqsave(&chan->lock, flags);
+        chan->msg_free = 0;
+        chan->msg_count = 0;
+        chan->active_req = NULL;
+        chan->cl = cl; 
+        init_completion(&chan->tx_complete);
+    
+        if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
+                chan->txdone_method = TXDONE_BY_ACK;
+
+        spin_unlock_irqrestore(&chan->lock, flags);
+    
+        if (chan->mbox->ops->startup) {
+                ret = chan->mbox->ops->startup(chan);
+
+                if (ret) {
+    
+                        dev_err(dev, "Unable to startup the chan (%d)\n", ret);
+                        chan = ERR_PTR(ret);
+                }
+        }
+        return chan;
+}
+
 static struct platform_driver phytium_mbox_driver = {
 	.probe = phytium_mbox_probe,
 	.remove = phytium_mbox_remove,
-- 
2.34.1

