Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA76659D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAKLQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAKLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:15:02 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7124178AB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:14:25 -0800 (PST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198]) by mx-outbound19-234.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Jan 2023 11:14:23 +0000
Received: by mail-pf1-f198.google.com with SMTP id bq10-20020a056a000e0a00b00581221976c0so6787560pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+lvNR7sT5nJHo2oJx3RW/RR3QkiYLJPpOGF0D0gk7M=;
        b=Wnl5gH7YzP3R60QGXUiJ7XpF+uRHfX2RX0pvEgiSLju/RuyQsirbnIfWkAqmjB+qwY
         ifFr77RXR504i/LCSfDFdFMBjW/56AN2sxqHV2juxG5ZpHRUokfAyPeDbVmiX7NSLIBK
         KUAAnP/cdtDZyT2uF5Nm7zT88FcrF5j5VCYJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+lvNR7sT5nJHo2oJx3RW/RR3QkiYLJPpOGF0D0gk7M=;
        b=GdG3WXrMf1oWmLy556gh0AmosyN6YlL4ASUSJniMcbvl+1KgI/99VOqbsLUlg1V1Uc
         4a+GW76kINtpNKvk5ZvEFVxOUK6XyToljVZkMErWbhmNQtyhu/3QdyzFpTsH3TOcSCgy
         7hndqRuAOjsWgPENM2MRajcXNEdgVNtPQmNrhD2N+ARYgTx8e8z95U1Tl766Mu2rnvot
         74tswD8Yr7rjxbCWwPF2Qjav4D+q8F3HCMbEMbQao9AvpW5gs+Gdwhq04nnAe/WxSPDN
         dOwHW2p+KGNHRV1Snj0M8+oFXkpdFs2IdDoV5Xd50QfwxrPbgVyN2a6VxbU/4D+Oikks
         2zgg==
X-Gm-Message-State: AFqh2kplWj+piJ0hTU4XK//03RC2Lvwwi5wiHBDrcm2ZiXq15oNQHdsc
        UffVe4is4bHl4nYX83cWiIUa2BEPXR/ZvmX5+Og+Ai9Cw+lmGnHz/WPsJxnCiJ3MZZnTQ2gdAJX
        mDfir+CUlllREBh5ohop8qyPPNzX42XWJUwGgjKNJo65ZHKQIfytR9qOz7w8A
X-Received: by 2002:a62:b609:0:b0:583:319a:4425 with SMTP id j9-20020a62b609000000b00583319a4425mr19875862pff.29.1673435662041;
        Wed, 11 Jan 2023 03:14:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvLBdwvvsrbXBGXFlMuh0aX1/oWSI/AQgzw7d9Vffxw2ERBrItjmq1m/NVm9puoIw4susynCw==
X-Received: by 2002:a62:b609:0:b0:583:319a:4425 with SMTP id j9-20020a62b609000000b00583319a4425mr19875838pff.29.1673435661721;
        Wed, 11 Jan 2023 03:14:21 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b00589ed7ae132sm4235666pfd.13.2023.01.11.03.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:14:21 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 2/2] phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap
Date:   Wed, 11 Jan 2023 16:43:56 +0530
Message-Id: <20230111111356.17392-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230111111356.17392-1-sinthu.raja@ti.com>
References: <20230111111356.17392-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673435662-305098-5384-441-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.210.198
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245393 [from 
        cloudscan23-191.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
---

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

 drivers/phy/ti/phy-j721e-wiz.c | 39 ++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 571f0ca18874..cd2f2672c098 100644
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
@@ -1246,17 +1265,25 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 			else
 				regmap_field_write(wiz->typec_ln10_swap, 0);
 		} else {
-			/* if no typec-dir gpio was specified and PHY type is
-			 * USB3 with master lane number is '0', set LN10 SWAP
-			 * bit to '1'
+			/* if no typec-dir gpio was specified and PHY type is USB3
+			 * with master lane number is '0' or '2', then set LN10 or
+			 * LN23 SWAP bit to '1' respectively.
 			 */
 			u32 num_lanes = wiz->num_lanes;
 			int i;
 
 			for (i = 0; i < num_lanes; i++) {
-				if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3)
-						&& wiz->master_lane_num[i] == 0) {
-					regmap_field_write(wiz->typec_ln10_swap, 1);
+				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3) {
+					switch (wiz->master_lane_num[i]) {
+					case LANE0:
+						regmap_field_write(wiz->typec_ln10_swap, 1);
+						break;
+					case LANE2:
+						regmap_field_write(wiz->typec_ln23_swap, 1);
+						break;
+					default:
+						break;
+					}
 				}
 			}
 		}
-- 
2.36.1

