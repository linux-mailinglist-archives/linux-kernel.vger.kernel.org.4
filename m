Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEA64B573
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiLMMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiLMMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:49:18 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D21BEA9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:49:17 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound46-236.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Dec 2022 12:49:15 +0000
Received: by mail-pl1-f199.google.com with SMTP id b17-20020a170903229100b00189da3b178bso12987564plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4XCC2SNWD3YZuAByZlmhT1HNH2lwLYNZczilwjwoq8=;
        b=ntUrA3y4KwnbuSPFOpGeXbFZS994aN7CbbPZvsvQY3PU9CtDofaTWlURW3hJYm4piF
         A66eOcFeGRqyEFm8dIVPjXxBamT5ucn0otb8CI1bLk5XJz9moaDp5oEgpEV2JTV+QcpM
         X40o4VrWxhPAf+u0Rfru6DLlA8tcnZbaACL1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4XCC2SNWD3YZuAByZlmhT1HNH2lwLYNZczilwjwoq8=;
        b=GMr8mNPbh+MM4O0PHAtLpgUI2dL0fhXgZBmNfmp3SDJ7t2YeKhzWrMrqlAvNvwZlFJ
         tGdp64s6IaZjkDmzXasOR/ETTRsqlh2w3m+dh7trfaGNfYIbwjeUpFZR/cEHsEF69Uey
         klw2M4Jq2MbuGnajjKO4pwEi3Sh8o9v+liYCXvgQDB+3PDtXPVr8ZegZ4LazyegFJG+9
         vlJc0b/TV+IqivsG9rsYUMj1zBxQUtpr9D9uhWgFRnSog2Az/324QXobIzw2Gao1UaRV
         +MKDy9md7wbGjlPNCVmf7Ir2SZ2YrGOSVXEsncSyfw7XoZQ9Is7t3mjRPz9+c9q8zNzV
         olMw==
X-Gm-Message-State: ANoB5pl4toIS8U51YAcQ/nvCjJEgT3FKA0VUniCQwKuucW8mVxtOrPoS
        iflhdn8hJEEXyCaqESyxJZNlqM4RRAE0Zgai/ee49NAzAE+h+PwI86cyqYl4GnPRSJ/0nafFObl
        ym2sAxZ3cyFEMNvMK94VuS7iyAOJuJ23Q6EdiKic2LnRYVT/qk7cqnSUxBojf
X-Received: by 2002:aa7:8250:0:b0:572:75f0:8010 with SMTP id e16-20020aa78250000000b0057275f08010mr18208292pfn.14.1670935753754;
        Tue, 13 Dec 2022 04:49:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5N/tf/eQTEMT+wfQQLT9zHuYzXU6hPK99CRRxu4RbFzyftkLwlvTX28bUzYdHPhFSp+h5E/g==
X-Received: by 2002:aa7:8250:0:b0:572:75f0:8010 with SMTP id e16-20020aa78250000000b0057275f08010mr18208275pfn.14.1670935753461;
        Tue, 13 Dec 2022 04:49:13 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7942f000000b0057622e8e82csm7605485pfo.191.2022.12.13.04.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:49:12 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 2/2] phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap
Date:   Tue, 13 Dec 2022 18:18:54 +0530
Message-Id: <20221213124854.3779-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221213124854.3779-1-sinthu.raja@ti.com>
References: <20221213124854.3779-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1670935754-312012-5635-5406-1
X-BESS-VER: 2019.1_20221212.2317
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244774 [from 
        cloudscan15-174.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
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

Serdes wiz supports both LN23 and LN10 Type-C swap. Add support to
configure LN23 bit to swap between lane2 or lane3 if required.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index b17eec632d49..0091892af0b0 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -58,6 +58,11 @@ enum wiz_lane_standard_mode {
 	LANE_MODE_GEN4,
 };
 
+enum wiz_lane_typec_swap_mode {
+	LANE10_SWAP = 0,
+	LANE23_SWAP = 2,
+};
+
 enum wiz_refclk_mux_sel {
 	PLL0_REFCLK,
 	PLL1_REFCLK,
@@ -194,6 +199,9 @@ static const struct reg_field p_mac_div_sel1[WIZ_MAX_LANES] = {
 static const struct reg_field typec_ln10_swap =
 					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
 
+static const struct reg_field typec_ln23_swap =
+					REG_FIELD(WIZ_SERDES_TYPEC, 31, 31);
+
 struct wiz_clk_mux {
 	struct clk_hw		hw;
 	struct regmap_field	*field;
@@ -366,6 +374,7 @@ struct wiz {
 	struct regmap_field	*mux_sel_field[WIZ_MUX_NUM_CLOCKS];
 	struct regmap_field	*div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
 	struct regmap_field	*typec_ln10_swap;
+	struct regmap_field	*typec_ln23_swap;
 	struct regmap_field	*sup_legacy_clk_override;
 
 	struct device		*dev;
@@ -675,6 +684,13 @@ static int wiz_regfield_init(struct wiz *wiz)
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
@@ -1242,15 +1258,24 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 				regmap_field_write(wiz->typec_ln10_swap, 0);
 		} else {
 			/* if no typec-dir gpio was specified, and USB lines
-			 * are connected to Lane 0 then set LN10 SWAP bit to 1.
+			 * are connected to SWAP lanes '0' or '2' then set LN10 SWAP
+			 * or LN23 bit to 1 respectively.
 			 */
 			u32 num_lanes = wiz->num_lanes;
 			int i;
 
 			for (i = 0; i < num_lanes; i++) {
-				if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3) \
-						&& wiz->lane_phy_reg[i] == 0) {
-					regmap_field_write(wiz->typec_ln10_swap, 1);
+				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3) {
+					switch (wiz->lane_phy_reg[i]) {
+					case LANE10_SWAP:
+						regmap_field_write(wiz->typec_ln10_swap, 1);
+						break;
+					case LANE23_SWAP:
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

