Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49952735601
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFSLkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFSLkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:40:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D24DA;
        Mon, 19 Jun 2023 04:40:24 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63044800;
        Mon, 19 Jun 2023 13:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174788;
        bh=ePaFmnJIjLj6Wcp4D35xX6T00j1OOYbTHpoDKYhKFWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJhUCY1uT0st0ET+at5x9QVc4ZcSOeyjce1XtmRBcJbWsn5FhAXNtzkLPNZcVuWmt
         L3wUKXIzjPesMyEIzYO6p2xiXdp6Adc98c7Bs6dGHNvZHCyb5Pr+PMcQwDE6BnvPKp
         0pH3Dxr/uEUv4Nfm1/xOdjgPoy5leYPyIr1jhSJo=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Jai Luthra <j-luthra@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 2/4] media: ti: cal: Fix cal_camerarx_create() error handling
Date:   Mon, 19 Jun 2023 14:40:05 +0300
Message-Id: <20230619114007.297393-3-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619114007.297393-1-tomi.valkeinen@ideasonboard.com>
References: <20230619114007.297393-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't do a proper job at freeing resources in cal_camerarx_create's
error paths.

Fix these, and also switch the phy allcation from kzalloc to
devm_kzalloc to simplify the code further.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/ti/cal/cal-camerarx.c | 23 +++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/ti/cal/cal-camerarx.c b/drivers/media/platform/ti/cal/cal-camerarx.c
index 267089b0fea0..97208d542f9e 100644
--- a/drivers/media/platform/ti/cal/cal-camerarx.c
+++ b/drivers/media/platform/ti/cal/cal-camerarx.c
@@ -864,7 +864,7 @@ struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
 	unsigned int i;
 	int ret;
 
-	phy = kzalloc(sizeof(*phy), GFP_KERNEL);
+	phy = devm_kzalloc(cal->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return ERR_PTR(-ENOMEM);
 
@@ -882,7 +882,7 @@ struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
 	if (IS_ERR(phy->base)) {
 		cal_err(cal, "failed to ioremap\n");
 		ret = PTR_ERR(phy->base);
-		goto error;
+		goto err_destroy_mutex;
 	}
 
 	cal_dbg(1, cal, "ioresource %s at %pa - %pa\n",
@@ -890,11 +890,11 @@ struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
 
 	ret = cal_camerarx_regmap_init(cal, phy);
 	if (ret)
-		goto error;
+		goto err_destroy_mutex;
 
 	ret = cal_camerarx_parse_dt(phy);
 	if (ret)
-		goto error;
+		goto err_destroy_mutex;
 
 	/* Initialize the V4L2 subdev and media entity. */
 	sd = &phy->subdev;
@@ -911,21 +911,25 @@ struct cal_camerarx *cal_camerarx_create(struct cal_dev *cal,
 	ret = media_entity_pads_init(&sd->entity, ARRAY_SIZE(phy->pads),
 				     phy->pads);
 	if (ret)
-		goto error;
+		goto err_node_put;
 
 	ret = cal_camerarx_sd_init_cfg(sd, NULL);
 	if (ret)
-		goto error;
+		goto err_entity_cleanup;
 
 	ret = v4l2_device_register_subdev(&cal->v4l2_dev, sd);
 	if (ret)
-		goto error;
+		goto err_entity_cleanup;
 
 	return phy;
 
-error:
+err_entity_cleanup:
 	media_entity_cleanup(&phy->subdev.entity);
-	kfree(phy);
+err_node_put:
+	of_node_put(phy->source_ep_node);
+	of_node_put(phy->source_node);
+err_destroy_mutex:
+	mutex_destroy(&phy->mutex);
 	return ERR_PTR(ret);
 }
 
@@ -939,5 +943,4 @@ void cal_camerarx_destroy(struct cal_camerarx *phy)
 	of_node_put(phy->source_ep_node);
 	of_node_put(phy->source_node);
 	mutex_destroy(&phy->mutex);
-	kfree(phy);
 }
-- 
2.34.1

