Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2C6B9237
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjCNL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjCNLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:55:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3482A99;
        Tue, 14 Mar 2023 04:55:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtYr7118828;
        Tue, 14 Mar 2023 06:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678794934;
        bh=c6aDqoAsbT1dBhEldNdWqv8Ad1QA4DE50tP0KhQ3cUs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=S3lpwN3wAtH+EU8Go5ga8V6l61GsmQ/Yxm5FFA3yEKpJvOMcnGuFuqWQ3JNZff1n2
         j0B4OlEsoWj+HeXmo2nY5wIuTiQJPNurlXAq38cs2EuhHoDLGwcF245Vk0yF0yjiDO
         iAVQZR5zXqeTkUWe89jpHxCh52P2oOn9ngPQ4snU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBtYF7003105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:55:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:55:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:55:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtWES111879;
        Tue, 14 Mar 2023 06:55:33 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v7 08/13] media: cadence: csi2rx: Populate subdev devnode
Date:   Tue, 14 Mar 2023 17:25:11 +0530
Message-ID: <20230314115516.667-9-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314115516.667-1-vaishnav.a@ti.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The devnode can be used by media-ctl and other userspace tools to
perform configurations on the subdev. Without it, media-ctl returns
ENOENT when setting format on the sensor subdev.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v5)

Changes in v5:
- Add Laurent's R-by.

Changes in v2:
- New in v2.

 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f8ce9360bfb0..639ade97b998 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -676,6 +676,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);
-- 
2.17.1

