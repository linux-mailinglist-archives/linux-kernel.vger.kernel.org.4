Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D956B4806
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjCJO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjCJOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:55:22 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED612E156;
        Fri, 10 Mar 2023 06:50:45 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so3127448otv.0;
        Fri, 10 Mar 2023 06:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W60syQtwwLaj9P+ywSF+QbHoeubN8UmWjHL9quZCQYE=;
        b=gAzTao1URwvJGwBkg52laENNZNisLzuFUPERyrNMtlEDWqSwzv8BtNK54ymL73O1P3
         Mwn//BdnHPt0AwdHb4hpjHm9DgBG6lhgxdxCNxj1CWTrKVTbm2WLoPFpPhJSJpCQTfVg
         liJUF1dp/MMijz7m6Y//lBu45uUtsByr9K6ujJEe037zJhhpUZr5pi0clIip2EN4nJk/
         A4ndlkBv5jARdTSyO/ZrwXART16ubxtMFr5E7kwqFf5hTjjCQjuSJw3/2HFDCdeERe/P
         Wx3xRaE2kSQJs8zGA9D3MvMrxtvtKGI5aWwGwnSPTKwDOY99dZmQ+mOGNiXtWHybK4q4
         1s1w==
X-Gm-Message-State: AO0yUKXZuZY7rN6QHozA45eAb2uZ6hPx4+XKFzQZA9JMcK6twK3OGsvk
        pxTHrnijp0Mdo42YRpnlbw==
X-Google-Smtp-Source: AK7set8tVsqa9HhLKisdw+M9nHnxilhqxXoHkky42GhfVXwc/Oo7Hu2EM+VwC2PJ1F18rc5Oh5fauw==
X-Received: by 2002:a05:6830:920:b0:68b:c60c:de58 with SMTP id v32-20020a056830092000b0068bc60cde58mr16173226ott.7.1678459715123;
        Fri, 10 Mar 2023 06:48:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z27-20020a9d71db000000b00690e6d56670sm129880otj.25.2023.03.10.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:34 -0800 (PST)
Received: (nullmailer pid 1545500 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:25 -0600
Message-Id: <20230310144726.1545453-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/ti/knav_dma.c        | 4 ++--
 drivers/soc/ti/knav_qmss_acc.c   | 2 +-
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 drivers/soc/ti/wkup_m3_ipc.c     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 84afebd355be..0fbc37cd5123 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -666,8 +666,8 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	dma->rx_priority = DMA_PRIO_DEFAULT;
 	dma->tx_priority = DMA_PRIO_DEFAULT;
 
-	dma->enable_all	= (of_get_property(node, "ti,enable-all", NULL) != NULL);
-	dma->loopback	= (of_get_property(node, "ti,loop-back",  NULL) != NULL);
+	dma->enable_all	= of_property_read_bool(node, "ti,enable-all");
+	dma->loopback	= of_property_read_bool(node, "ti,loop-back");
 
 	ret = of_property_read_u32(node, "ti,rx-retry-timeout", &timeout);
 	if (ret < 0) {
diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index fde66e28e046..3d388646ed43 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -521,7 +521,7 @@ int knav_init_acc_range(struct knav_device *kdev,
 
 	info->pdsp = pdsp;
 	channels = range->num_queues;
-	if (of_get_property(node, "multi-queue", NULL)) {
+	if (of_property_read_bool(node, "multi-queue")) {
 		range->flags |= RANGE_MULTI_QUEUE;
 		channels = 1;
 		if (range->queue_base & (32 - 1)) {
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 48de98560093..0f252c2549ba 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1264,7 +1264,7 @@ static int knav_setup_queue_range(struct knav_device *kdev,
 	if (range->num_irqs)
 		range->flags |= RANGE_HAS_IRQ;
 
-	if (of_get_property(node, "qalloc-by-id", NULL))
+	if (of_property_read_bool(node, "qalloc-by-id"))
 		range->flags |= RANGE_RESERVED;
 
 	if (of_property_present(node, "accumulator")) {
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 343c58ed5896..6970478b40f3 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -681,7 +681,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 			dev_warn(dev, "Invalid VTT GPIO(%d) pin\n", temp);
 	}
 
-	if (of_find_property(np, "ti,set-io-isolation", NULL))
+	if (of_property_read_bool(np, "ti,set-io-isolation"))
 		wkup_m3_set_io_isolation(m3_ipc);
 
 	ret = of_property_read_string(np, "firmware-name",
-- 
2.39.2

