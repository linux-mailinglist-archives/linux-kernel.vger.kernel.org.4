Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7A65FBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjAFHSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjAFHSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:18:03 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6536ECB6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:18:01 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198]) by mx-outbound18-167.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 06 Jan 2023 07:17:58 +0000
Received: by mail-pg1-f198.google.com with SMTP id r22-20020a63ce56000000b00478f1cfb0fbso631830pgi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 23:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U47qPxunUiTYhLuKKBP4Q4lX+fiKt2gn1uBtduLzsvA=;
        b=GjJuhDTRGHhbmnpexrgqtbJUTieXEiVEAhKVYwuRFPtlXPrcbQ5o66CRB6552XxIkL
         sd6H27FBFowXmlrr1bF6xAU3wVZfTQ0XZvS1UNR0MMmoNzb/ZtHvNz63j1ZcOzTuTTmX
         1wcc1flX7dhxfdUx+Jvw97jyzY0i4XHpq1S8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U47qPxunUiTYhLuKKBP4Q4lX+fiKt2gn1uBtduLzsvA=;
        b=kLnAO6ROd0YRAq5DPAiaGrWxj+YsRGiYbZXoHkjyr3o+ExTpnoZJsQoxg6uA2XFFCY
         ptluiYLuFMNKDKC2tGRODvIevQZKvqHt9Z3LD1JPBl+UKNGkhcJIXVUEHEPeShUrkznF
         V/0sEthdyrrV45PnkjN07t3HraVhHrCEMcB2ajb4/vzuAI8EI8UT64QxDNUb7WYKU2l6
         uO1of99EPoCkAPodIRF5txPxc6RoSVv4XQ/lTFAaHBwHyr++4AESI9RKQu0qlprdS0qT
         rEG/tqA0I5n+8Ev5nEeAg/NNJVigW91N7wf29fUAYylkqkxAT3hkfTU/AkJUhILLwwBl
         yb7w==
X-Gm-Message-State: AFqh2kq+j3Pk1dhfvNdwIgY/bqmzLYWYbvPDzzh/Dds5PhMCBf932BwI
        5HpoQj7nT4LEn/2ghNtura3yK26HWABMGNmZnTBA/GV1+4EZXESPmodcKTadEKK+nGZ8p7Pktn3
        uSazIFpmke4wNPf7Oq9GMq4R6uNxaTRWcAsc1kc8GWNEOniFR0xGrs+OzJEJQ
X-Received: by 2002:a17:902:e384:b0:191:162f:dbe3 with SMTP id g4-20020a170902e38400b00191162fdbe3mr50417517ple.2.1672989477733;
        Thu, 05 Jan 2023 23:17:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvseIPSgj6pQELFrqFNoBhzUv9Hdfnib8K4c07guejAQIRkRqWMDgy6UVT19I+2en07RTrrAQ==
X-Received: by 2002:a17:902:e384:b0:191:162f:dbe3 with SMTP id g4-20020a170902e38400b00191162fdbe3mr50417497ple.2.1672989477389;
        Thu, 05 Jan 2023 23:17:57 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b00189348ab156sm138845plk.283.2023.01.05.23.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:17:56 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 2/2] phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap
Date:   Fri,  6 Jan 2023 12:47:14 +0530
Message-Id: <20230106071714.30562-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230106071714.30562-1-sinthu.raja@ti.com>
References: <20230106071714.30562-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1672989478-304775-5385-49264-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.215.198
X-BESS-Outbound-Spam-Score: 0.90
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245283 [from 
        cloudscan17-25.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.90 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_SA085b
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

Changes in V2:
=============
Address review comments:
- Update commit description.
- Rename enum variable name from wiz_lane_typec_swap_mode to wiz_typec_master_lane.
- Rename enumerators name specific to list of master lanes used for lane swapping.
- Add inline comments.

V1: https://lore.kernel.org/lkml/20221213124854.3779-2-sinthu.raja@ti.com/T/#m5e2d1a15d647f5df9dd28ed2dedc4b0812d6466f

 drivers/phy/ti/phy-j721e-wiz.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 571f0ca18874..815e8124b94a 100644
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
@@ -1254,9 +1273,17 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
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

