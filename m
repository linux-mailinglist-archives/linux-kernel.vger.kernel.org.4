Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569CE669BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjAMPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjAMPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:16:25 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5293E7BCE9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:07:12 -0800 (PST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72]) by mx-outbound12-28.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Jan 2023 15:07:10 +0000
Received: by mail-pj1-f72.google.com with SMTP id o36-20020a17090a0a2700b00226b4e9895aso10097822pjo.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbRGp4p8llZk1W2l8huKtE8ynztaxnnEWZGQtpnZTOI=;
        b=dGvYv+WYBC50wTVzwAJTgsk5pyoEsceJdZ5OMbvQDoXU4V7Hf4vLyvB7VAezKtAVvp
         g72OaNcztylGRqgPXeq5Rn7UbFMWQnOq3uR8saS0VYfapBZhfCY1RTzU4c/AY69o8yi4
         ryPIITSLRq+At6HIGHBXXp6MnvR12GITn5aro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbRGp4p8llZk1W2l8huKtE8ynztaxnnEWZGQtpnZTOI=;
        b=MQCAJw2PZez6d/UyGY4gBqecDCnjO8fGvkFloQvSyZDC3rFrlf9UU8vclTbaGnPAa6
         NrT5LP4fqTKmSdtg/AVKUgoQZNl1PApOFnaAtmXVPIiVp4o4oM7g9zzasa43GicBauVV
         VWmljoEaQipoibSI0FPF4d5Wwnl8sl1qfEmSqoRkHLJ2nKeeYWixU70qC0uS9sHwwxpV
         p/3rNEz48aBRTSzkzAn2B0VKTDYbbjLzQtQe9s4OVi1gyg0njwm2V7rzFSSv9nTJa7ea
         zYcQ8sY1kQAyezCbtYKoIM8gKrPuKx9QHb3j6g2S8xrW63LXwgvp/NHTUM1dOyBvFrXs
         l2og==
X-Gm-Message-State: AFqh2krz7++5DdWdhUIA9yy4KLDckYjYSyroR8TwR6m8igeCbcEisWM5
        Gacy+8AwyKpUWGb69/PKoEX3n2IpNuBwfYUlCd2C1Tp0BVgBUVtL8KUALnAulYx3yFjODVj+goo
        R/T0usoPJlBKamLJ17LSicInyEXoG9vAjufpM3w/INs8k7CuHtLT5KeprkWNw
X-Received: by 2002:a17:902:bb85:b0:189:8ca1:e641 with SMTP id m5-20020a170902bb8500b001898ca1e641mr80498984pls.60.1673622429055;
        Fri, 13 Jan 2023 07:07:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXscZmErgOwVL6tBvKuitY7Ib1z13zgRMu2ttD4v7LZfAmey7RhM9DZ9ozf9VslikARPV/ITGQ==
X-Received: by 2002:a17:902:bb85:b0:189:8ca1:e641 with SMTP id m5-20020a170902bb8500b001898ca1e641mr80498971pls.60.1673622428746;
        Fri, 13 Jan 2023 07:07:08 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm14325723pla.106.2023.01.13.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:07:08 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 2/2] phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap
Date:   Fri, 13 Jan 2023 20:36:15 +0530
Message-Id: <20230113150615.19375-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230113150615.19375-1-sinthu.raja@ti.com>
References: <20230113150615.19375-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673622429-303100-5446-19125-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.216.72
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245440 [from 
        cloudscan13-144.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The WIZ acts as a wrapper for SerDes and has Lanes 0 and 2 reserved
for USB for type-C lane swap if Lane 1 and Lane 3 are linked to the
USB PHY that is integrated into the SerDes IP. The WIZ control register
has to be configured to support this lane swap feature.

The support for swapping lanes 2 and 3 is missing and therefore
add support to configure the control register to swap between
lanes 2 and 3 if PHY type is USB.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Changes in V4:
============
- Add Review tag.
- Fix checkpatch CHECK errors.
 * Remove unnecessary paranthesis.
 * Avoid logical continuations in multiple lines.

Changes in V3:
=============
Address review comments:
- Update comment to mention the LN23 SWAP along with the LN10

Changes in V2:
=============
Address review comments:
- Update commit description.
- Rename enum variable name from wiz_lane_typec_swap_mode to wiz_typec_master_lane.
- Rename enumerators name specific to list of master lanes used for lane swapping.
- Add inline comments.

 drivers/phy/ti/phy-j721e-wiz.c | 38 +++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index b5c1b82e99a6..1b83c98a78f0 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -58,6 +58,14 @@ enum wiz_lane_standard_mode {
 	LANE_MODE_GEN4,
 };
 
+/*
+ * List of master lanes used for lane swapping
+ */
+enum wiz_typec_master_lane {
+	LANE0 = 0,
+	LANE2 = 2,
+};
+
 enum wiz_refclk_mux_sel {
 	PLL0_REFCLK,
 	PLL1_REFCLK,
@@ -194,6 +202,9 @@ static const struct reg_field p_mac_div_sel1[WIZ_MAX_LANES] = {
 static const struct reg_field typec_ln10_swap =
 					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
 
+static const struct reg_field typec_ln23_swap =
+					REG_FIELD(WIZ_SERDES_TYPEC, 31, 31);
+
 struct wiz_clk_mux {
 	struct clk_hw		hw;
 	struct regmap_field	*field;
@@ -367,6 +378,7 @@ struct wiz {
 	struct regmap_field	*mux_sel_field[WIZ_MUX_NUM_CLOCKS];
 	struct regmap_field	*div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
 	struct regmap_field	*typec_ln10_swap;
+	struct regmap_field	*typec_ln23_swap;
 	struct regmap_field	*sup_legacy_clk_override;
 
 	struct device		*dev;
@@ -676,6 +688,13 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->typec_ln10_swap);
 	}
 
+	wiz->typec_ln23_swap = devm_regmap_field_alloc(dev, regmap,
+						       typec_ln23_swap);
+	if (IS_ERR(wiz->typec_ln23_swap)) {
+		dev_err(dev, "LN23_SWAP reg field init failed\n");
+		return PTR_ERR(wiz->typec_ln23_swap);
+	}
+
 	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap, phy_en_refclk);
 	if (IS_ERR(wiz->phy_en_refclk)) {
 		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
@@ -1246,17 +1265,26 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 			else
 				regmap_field_write(wiz->typec_ln10_swap, 0);
 		} else {
-			/* if no typec-dir gpio was specified and PHY type is
-			 * USB3 with master lane number is '0', set LN10 SWAP
-			 * bit to '1'
+			/* if no typec-dir gpio is specified and PHY type is USB3
+			 * with master lane number is '0' or '2', then set LN10 or
+			 * LN23 SWAP bit to '1' respectively.
 			 */
 			u32 num_lanes = wiz->num_lanes;
 			int i;
 
 			for (i = 0; i < num_lanes; i++) {
-				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3)
-					if (wiz->master_lane_num[i] == 0)
+				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3) {
+					switch (wiz->master_lane_num[i]) {
+					case LANE0:
 						regmap_field_write(wiz->typec_ln10_swap, 1);
+						break;
+					case LANE2:
+						regmap_field_write(wiz->typec_ln23_swap, 1);
+						break;
+					default:
+						break;
+					}
+				}
 			}
 		}
 	}
-- 
2.36.1

