Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117766E4FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDQSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDQSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:04:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0FBB81
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754645; x=1713290645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3HuikI716f2ys2CohTnjAOi+mGw2PSL74PJSePfvn8A=;
  b=0SMi9TqYOEijHumuQEKdUQNeXJIx1608hAc5+l/HhkQXwthrkWExKmkF
   0A1ff4Y7+oMXpo8Wmo+FLBPNxTYBTk5h1ybMQTMJgdN/8CgtSl624mPpT
   FbjXkzl5/8n+vfNQAO1OOH30VUkPgHADo8BOLhFI2UZoUtu/o6W3ekrNp
   oYrdadTo2iYHdpRDcX2rnc/l3sUS+Yx/pW+PakOIRcc8SLus2h2I+wD4i
   MP1YSFzm5vGuZcm0DJC6dm3XN6/iUKKJ7Jej/2N+LVHpOnuC1JGGI1bOr
   7LyLP2SEDIH5Ocs2NB8g5FjtU6+vC+WA45Rby/CT18ry6G5YE5MUJYD6o
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="147469789"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:04:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:56 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:54 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] phy: sparx5-serdes: add skip_cmu_cfg check when configuring lanes
Date:   Mon, 17 Apr 2023 20:03:35 +0200
Message-ID: <20230417180335.2787494-8-daniel.machon@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417180335.2787494-1-daniel.machon@microchip.com>
References: <20230417180335.2787494-1-daniel.machon@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for skip_cmu_cfg when configuring the serdes lane.  All
individual serdeses are reset upon first configuration. Resetting the
serdes involves reconfiguring it with preset values. The serdesmode is
required to determine the clock-providing CMU, therefore make sure the
serdes is not reconfigured if the serdesmode is not set.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index eb9352d1de7e..01bd5ea620c5 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -1646,6 +1646,10 @@ static int sparx5_sd10g28_apply_params(struct sparx5_serdes_macro *macro,
 	u32 value, cmu_idx;
 	int err;
 
+	/* Do not configure serdes if CMU is not to be configured too */
+	if (params->skip_cmu_cfg)
+		return 0;
+
 	cmu_idx = sparx5_serdes_cmu_get(params->cmu_sel, lane_index);
 	err = sparx5_cmu_cfg(priv, cmu_idx);
 	if (err)
@@ -2111,6 +2115,7 @@ static int sparx5_sd10g28_config(struct sparx5_serdes_macro *macro, bool reset)
 		.rxinvert = 1,
 		.txswing = 240,
 		.reg_rst = reset,
+		.skip_cmu_cfg = reset,
 	};
 	int err;
 
-- 
2.34.1

