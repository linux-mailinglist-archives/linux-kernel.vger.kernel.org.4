Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B1D736853
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjFTJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFTJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:49:42 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F511BF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0lvP6
        UU76dFFHF28ZQO68S90lwikV6LUi3ioLomLC5I=; b=cRUrGDAWFWf/yA5CO82A4
        B+LG+ZYN75msUCGc9UqX//JA8i8ZGH1tQdOEjWNqv8/Nef+56Yksw5VgQsPtCFuM
        u5v7W+nSo9xCjIHPTAZ5iTukG4G/1i6qZ7FOsFEvbFTxR1thcRQLTQVJc/4z6LOG
        /v19UOWYp4OHtmgTXHlI6c=
Received: from openarena.loongson.cn (unknown [114.242.206.180])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wAXg3CldZFkB8yiAQ--.11241S6;
        Tue, 20 Jun 2023 17:47:18 +0800 (CST)
From:   Sui Jingfeng <18949883232@163.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v10 04/11] drm/etnaviv: Add helpers for private data construction and destruction
Date:   Tue, 20 Jun 2023 17:47:09 +0800
Message-Id: <20230620094716.2231414-5-18949883232@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620094716.2231414-1-18949883232@163.com>
References: <20230620094716.2231414-1-18949883232@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXg3CldZFkB8yiAQ--.11241S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyfGFy5WFWrtFyUAF18Zrb_yoWrZFy8pa
        n3AFy0yrWkZF18KasxJr1rXa43C3WxWay09asFgwn0qw4ayr1vgFn5tFyUAF9xJFyrCFsx
        tw1Utr1UXF40krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9VycUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprymkizyyjjits6il2tof0z/xtbBdQeU0VaEE2i9qQAAsK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

There are numerous members in the struct etnaviv_drm_private, which are
shared by all GPU core. This patch introduces two dedicated functions for
the construction and destruction of the instances of this structure.
The goal is to keep its members from leaking to the outside. The code
needed for error handling can also be simplified.

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 73 +++++++++++++++++----------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  1 +
 2 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index cec005035d0e..6a048be02857 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -24,9 +24,47 @@
 #include "etnaviv_perfmon.h"
 
 /*
- * DRM operations:
+ * etnaviv private data construction and destructions:
  */
+static struct etnaviv_drm_private *
+etnaviv_alloc_private(struct device *dev, struct drm_device *drm)
+{
+	struct etnaviv_drm_private *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->drm = drm;
+
+	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
+
+	mutex_init(&priv->gem_lock);
+	INIT_LIST_HEAD(&priv->gem_list);
+	priv->num_gpus = 0;
+	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
+	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(dev);
+	if (IS_ERR(priv->cmdbuf_suballoc)) {
+		kfree(priv);
+		dev_err(dev, "Failed to create cmdbuf suballocator\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return priv;
+}
+
+static void etnaviv_free_private(struct etnaviv_drm_private *priv)
+{
+	if (!priv)
+		return;
+
+	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
+
+	xa_destroy(&priv->active_contexts);
+
+	kfree(priv);
+}
 
 static void load_gpu(struct drm_device *dev)
 {
@@ -511,35 +549,21 @@ static int etnaviv_bind(struct device *dev)
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "failed to allocate private data\n");
-		ret = -ENOMEM;
+	priv = etnaviv_alloc_private(dev, drm);
+	if (IS_ERR(priv)) {
+		ret = PTR_ERR(priv);
 		goto out_put;
 	}
+
 	drm->dev_private = priv;
 
 	dma_set_max_seg_size(dev, SZ_2G);
 
-	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
-
-	mutex_init(&priv->gem_lock);
-	INIT_LIST_HEAD(&priv->gem_list);
-	priv->num_gpus = 0;
-	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-
-	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
-	if (IS_ERR(priv->cmdbuf_suballoc)) {
-		dev_err(drm->dev, "Failed to create cmdbuf suballocator\n");
-		ret = PTR_ERR(priv->cmdbuf_suballoc);
-		goto out_free_priv;
-	}
-
 	dev_set_drvdata(dev, drm);
 
 	ret = component_bind_all(dev, drm);
 	if (ret < 0)
-		goto out_destroy_suballoc;
+		goto out_free_priv;
 
 	load_gpu(drm);
 
@@ -551,10 +575,8 @@ static int etnaviv_bind(struct device *dev)
 
 out_unbind:
 	component_unbind_all(dev, drm);
-out_destroy_suballoc:
-	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 out_free_priv:
-	kfree(priv);
+	etnaviv_free_private(priv);
 out_put:
 	drm_dev_put(drm);
 
@@ -570,12 +592,9 @@ static void etnaviv_unbind(struct device *dev)
 
 	component_unbind_all(dev, drm);
 
-	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
-
-	xa_destroy(&priv->active_contexts);
+	etnaviv_free_private(priv);
 
 	drm->dev_private = NULL;
-	kfree(priv);
 
 	drm_dev_put(drm);
 }
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index b3eb1662e90c..e58f82e698de 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -35,6 +35,7 @@ struct etnaviv_file_private {
 };
 
 struct etnaviv_drm_private {
+	struct drm_device *drm;
 	int num_gpus;
 	struct etnaviv_gpu *gpu[ETNA_MAX_PIPES];
 	gfp_t shm_gfp_mask;
-- 
2.25.1

