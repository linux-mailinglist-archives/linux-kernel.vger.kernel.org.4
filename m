Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE8669BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjAMPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAMPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:16:20 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7B40C2C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:07:08 -0800 (PST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200]) by mx-outbound12-28.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Jan 2023 15:07:06 +0000
Received: by mail-pf1-f200.google.com with SMTP id 74-20020a62184d000000b0058b9f769609so3164513pfy.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+NSHccOtsCvHIJa85NeQChFC1UztUbiKQ4lP4DgpYE=;
        b=W9+BtAl08PRQpEb9/gbIViu7QsPYIAff+i6FpkK4mdaCYS6DY0+6/aufc6tFCweI2o
         9P1DKxBQCY5CluMNnBoYx55P+Sa+okGBGBsDdaqJod/93s66g0BvXZHdH4HHkXIrIntF
         ght67/8qciMtcCtM5OUjR7QDf0AOo+hbFd8Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+NSHccOtsCvHIJa85NeQChFC1UztUbiKQ4lP4DgpYE=;
        b=YwZBNTEWKUVrpUlZB3/Igag3koeXSJlj16CN0yQFdlvKrQgBLxXjCXUIHxpmZThJVn
         s1nQ80INBc5/MOn1eQAtnOZZGSZo9UcdaZydKmBYwNjElMu7i7tdPtpLA3gB76EXwcyD
         qwBAQXfW3DYucGtUAi/5M71T0CbCjL67RcRWz+zq60gRcYtJUWsOyDRZ5s9RTV0aXwCY
         RTiRYfWsbAIQo5Q8Dc0VjhRV90qrkTbUg/S+4A1CF5jV56Ge4HCkiPzmChBFWbaxdTmN
         UIP0zCHKJcIs62H99G5LriZ82/vz3dNYVeZuwGBycmhnwM9FSo8bFDXktA0IS0rUjPRG
         Laag==
X-Gm-Message-State: AFqh2krBjwk1ggAB7lQPufyYvGZHz2YkAG68EISroS4AldWCiFV9nNED
        ZTaO+LxnBYtwGGvQMoxiqDRK6sts0T/Wdw3qvJlJ/3dLurax7cpGNbggTGRX0/NvIxFHuV+xB4A
        KX0gNHfUhbORF2kTaSJ89urXtTw6e1cRuLOmWwQP+rslQMx4eUk61l6dSLi/f
X-Received: by 2002:a17:903:2447:b0:191:1a7c:ef9f with SMTP id l7-20020a170903244700b001911a7cef9fmr114145362pls.1.1673622425263;
        Fri, 13 Jan 2023 07:07:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXusrPlnaK+wmzYGKRbXYOFMSqbu96oB8HP0e7TOKd6vguQ6K8ok85JPWB7jm/g9wf1EWy8T0A==
X-Received: by 2002:a17:903:2447:b0:191:1a7c:ef9f with SMTP id l7-20020a170903244700b001911a7cef9fmr114145330pls.1.1673622424972;
        Fri, 13 Jan 2023 07:07:04 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm14325723pla.106.2023.01.13.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:07:04 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 1/2] phy: ti: j721e-wiz: Manage TypeC lane swap if typec-dir-gpios not specified
Date:   Fri, 13 Jan 2023 20:36:14 +0530
Message-Id: <20230113150615.19375-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230113150615.19375-1-sinthu.raja@ti.com>
References: <20230113150615.19375-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673622425-303100-5447-19117-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.210.200
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245440 [from 
        cloudscan20-233.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
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

It's possible that the Type-C plug orientation on the DIR line will be
implemented through hardware design. In that situation, there won't be
an external GPIO line available, but the driver still needs to address
this since the DT won't use the typec-dir-gpios property.

Add code to handle LN10 Type-C swap if typec-dir-gpios property is not
specified in DT.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

No changes in V4.

Changes in V3:
=============
- Added Reviewed-by tag.

Changes in V2:
=============
Address review comments:
- Update commit description as per review comments.
- Restore code to check only debounce delay only if typec-dir-gpios property is specified in DT.
- Rename lane_phy_reg variable as master_lane_num.
- Update inline comments.

 drivers/phy/ti/phy-j721e-wiz.c | 38 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ddce5ef7711c..b5c1b82e99a6 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -376,6 +376,7 @@ struct wiz {
 	struct gpio_desc	*gpio_typec_dir;
 	int			typec_dir_delay;
 	u32 lane_phy_type[WIZ_MAX_LANES];
+	u32 master_lane_num[WIZ_MAX_LANES];
 	struct clk		*input_clks[WIZ_MAX_INPUT_CLOCKS];
 	struct clk		*output_clks[WIZ_MAX_OUTPUT_CLOCKS];
 	struct clk_onecell_data	clk_data;
@@ -1234,15 +1235,30 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 	struct wiz *wiz = dev_get_drvdata(dev);
 	int ret;
 
-	/* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
-	if (id == 0 && wiz->gpio_typec_dir) {
-		if (wiz->typec_dir_delay)
-			msleep_interruptible(wiz->typec_dir_delay);
-
-		if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
-			regmap_field_write(wiz->typec_ln10_swap, 1);
-		else
-			regmap_field_write(wiz->typec_ln10_swap, 0);
+	if (id == 0) {
+		/* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
+		if (wiz->gpio_typec_dir) {
+			if (wiz->typec_dir_delay)
+				msleep_interruptible(wiz->typec_dir_delay);
+
+			if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
+				regmap_field_write(wiz->typec_ln10_swap, 1);
+			else
+				regmap_field_write(wiz->typec_ln10_swap, 0);
+		} else {
+			/* if no typec-dir gpio was specified and PHY type is
+			 * USB3 with master lane number is '0', set LN10 SWAP
+			 * bit to '1'
+			 */
+			u32 num_lanes = wiz->num_lanes;
+			int i;
+
+			for (i = 0; i < num_lanes; i++) {
+				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3)
+					if (wiz->master_lane_num[i] == 0)
+						regmap_field_write(wiz->typec_ln10_swap, 1);
+			}
+		}
 	}
 
 	if (id == 0) {
@@ -1386,8 +1402,10 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		dev_dbg(dev, "%s: Lanes %u-%u have phy-type %u\n", __func__,
 			reg, reg + num_lanes - 1, phy_type);
 
-		for (i = reg; i < reg + num_lanes; i++)
+		for (i = reg; i < reg + num_lanes; i++) {
+			wiz->master_lane_num[i] = reg;
 			wiz->lane_phy_type[i] = phy_type;
+		}
 	}
 
 	return 0;
-- 
2.36.1

