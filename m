Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1404A6B4754
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjCJOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjCJOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:20 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC3121153;
        Fri, 10 Mar 2023 06:47:35 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id bh20so4393519oib.9;
        Fri, 10 Mar 2023 06:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIz7uldrpE/4a3Yn78TCMTOPk2yNsXBeiewFP++iTtI=;
        b=piCRoVSjF4CJdI61gdGtwXSF21OkABigbQ0znd37VdclwKZuXIZoqcA0QMHAo/JcKD
         Clix07FBd5kIMr2c04xiFDMqtQe5RPoCSPdIAaHeLGPYLMePdbL/nH2XRGKu+gq4Z9gn
         ZwkQnHiKeW0NkpUqQP+6qIF0t7u+A8eaWPv8uXPTLptv01pXP1V8dRWVyGRWKXCgwZ/F
         eSWv/+6IIdOpA97TKGtztv/Lg5xJ4i27lWI0Gq4jZvHiXCIPE1MbXS5E9el6ThSfqOHJ
         Gwv6hxNACUx0cvzUwsE+/FiX2jRDRcNho9qtP+MAIH+WHg3MCosrVvwI847igqqLn1UK
         5F+g==
X-Gm-Message-State: AO0yUKX9DZcPcQgFMvSo8njwuDNkGIdMuBxyUfxhA0a6sxofKozB/Xb/
        YqJZXfGdUBBQ0/x8o/oq4A==
X-Google-Smtp-Source: AK7set/GOJZQNFQdvex7AhT10x8uYUWw1aDar530wB//wxV61PlLIWKRODfn7mKYRTKkWueDppQvnA==
X-Received: by 2002:a05:6808:1d2:b0:384:167d:736b with SMTP id x18-20020a05680801d200b00384167d736bmr10994562oic.15.1678459654281;
        Fri, 10 Mar 2023 06:47:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b005252e5b6604sm834079oos.36.2023.03.10.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:33 -0800 (PST)
Received: (nullmailer pid 1543252 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] media: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:11 -0600
Message-Id: <20230310144711.1543225-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c        | 2 +-
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 +-
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 2 +-
 drivers/media/platform/xilinx/xilinx-vtc.c                  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 969516a940ba..1a2b3214b6f8 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1757,7 +1757,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 	jpeg->vdev->device_caps = V4L2_CAP_STREAMING |
 				  V4L2_CAP_VIDEO_M2M_MPLANE;
 
-	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
+	if (of_property_present(pdev->dev.of_node, "dma-ranges"))
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
 
 	ret = video_register_device(jpeg->vdev, VFL_TYPE_VIDEO, -1);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 174a6eec2f54..d2db8ccaa4c0 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -321,7 +321,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL)) {
+	if (of_property_present(pdev->dev.of_node, "dma-ranges")) {
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
 		if (ret) {
 			mtk_v4l2_err("Failed to set mask");
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 9095186d5495..199042034a3c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -344,7 +344,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_event_workq;
 	}
 
-	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
+	if (of_property_present(pdev->dev.of_node, "dma-ranges"))
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
 
 	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
diff --git a/drivers/media/platform/xilinx/xilinx-vtc.c b/drivers/media/platform/xilinx/xilinx-vtc.c
index 0ae0208d7529..cb4b421a348d 100644
--- a/drivers/media/platform/xilinx/xilinx-vtc.c
+++ b/drivers/media/platform/xilinx/xilinx-vtc.c
@@ -254,7 +254,7 @@ struct xvtc_device *xvtc_of_get(struct device_node *np)
 	struct xvtc_device *found = NULL;
 	struct xvtc_device *xvtc;
 
-	if (!of_find_property(np, "xlnx,vtc", NULL))
+	if (!of_property_present(np, "xlnx,vtc"))
 		return NULL;
 
 	xvtc_node = of_parse_phandle(np, "xlnx,vtc", 0);
-- 
2.39.2

