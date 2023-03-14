Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13F6B9243
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCNL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjCNL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:56:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D3E9FBF7;
        Tue, 14 Mar 2023 04:55:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtW4H118702;
        Tue, 14 Mar 2023 06:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678794932;
        bh=kdF/1Nr7CR+dcXyDeXuh/C6QNDhPFPgYOllESZB4OZ4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DcCSyk8qVBfM9unK0eM0tYrgH88ngjb+uA9q0lTeK8E4fPGdLZC2JwH9jQZloMKjq
         ByWilbPQ5JX5TOFlkOH+1MiQVn2aIMRq36XOI7Bs1egTuBtPXFNaOWG+GSaZhPpLgM
         ipoOMVZkbwhi3eK1nB70CCLuyGWrYVzgMiRTuorg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBtWu4003059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:55:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:55:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:55:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtUTP002389;
        Tue, 14 Mar 2023 06:55:31 -0500
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
Subject: [PATCH v7 07/13] media: cadence: csi2rx: Fix stream data configuration
Date:   Tue, 14 Mar 2023 17:25:10 +0530
Message-ID: <20230314115516.667-8-vaishnav.a@ti.com>
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

Firstly, there is no VC_EN bit present in the STREAM_DATA_CFG register.
Bit 31 is part of the VL_SELECT field. Remove it completely.

Secondly, it makes little sense to enable ith virtual channel for ith
stream. Sure, there might be a use-case that demands it. But there might
also be a use case that demands all streams to use the 0th virtual
channel. Prefer this case over the former because it is less arbitrary
and also makes it very clear what the limitations of the current driver
is instead of giving a false impression that multiple virtual channels
are supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v1)

 drivers/media/platform/cadence/cdns-csi2rx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index e80220840e93..f8ce9360bfb0 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -48,7 +48,6 @@
 #define CSI2RX_STREAM_STATUS_RDY			BIT(31)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
-#define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
 
 #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
@@ -269,8 +268,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		writel(CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT |
-		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
+		/*
+		 * Enable one virtual channel. When multiple virtual channels
+		 * are supported this will have to be changed.
+		 */
+		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,
-- 
2.17.1

