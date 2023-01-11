Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD216659D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjAKLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjAKLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:15:01 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA43F178A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:14:22 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200]) by mx-outbound45-59.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Jan 2023 11:14:20 +0000
Received: by mail-pl1-f200.google.com with SMTP id y8-20020a170902b48800b00192a600df83so10395823plr.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkPrecdgrR3b0Zn1YRgmmd3I/dP7Z74WRRmS7mk66ds=;
        b=mN/1G5z6IeHzR0ihluySvAN5QNjYJ+qje7EMK6DCW0ewl5L270keiG8IVDtw/FMAdn
         /ImAXFmn0aHVdkqwb+6Ht2TBpKfACvCU2PBY56Ddv+Nx1LlMRAfS9/Oqbl0r24tCUz3k
         BhKEq3YDKT0Mc3h8z3KHCuJST9JwCRezUu3ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkPrecdgrR3b0Zn1YRgmmd3I/dP7Z74WRRmS7mk66ds=;
        b=Fp6pQYC3ACrFCKUs9qL1O/r+HF9H+OR3powZ/pVtfGdNEbCiAftFBeLnpb4+FKfClR
         Q114pUlZakoZU/fVDHd09yZALsirFv35/YdRJIESFDbtKmLWzPlhrb43Mvqhl5FY0xHi
         Bn5W5nNGWThw8W3oGucGa4tCPnMGcWuiiPr+42YRB1hNagwQl1fqPG1tS/doiUrNWjAg
         Xxvuv0NV/K8j0mSXFLj0sQ4hoF46b+Gx9xdqTygxbrs/dJuHm2P6PT0b6m0LcEOzV7kJ
         H4Ffa18E8eOMu1Rs4ieX8HK2q1VL3AsKra6XT45aT6mt63y6IQwkC37DQLAsJkjTwKwJ
         Nu8g==
X-Gm-Message-State: AFqh2kq3qboCgRRHY4VW2ZbaFT6irnI2J8UISbBgaz91jUh81FsvyHga
        iOjDF4CIx/iZ0MfajwN0yGUsIHtFXh/EewSmAPhv01tWyDAYus3BCnfpU+9BY3ViDOyl91Np4i+
        2cjUfHbO04+gRqTf++pQFqe6SSFGovM//wjfBHZTAGg7qnFDD7DFfdqwz3AdV
X-Received: by 2002:a05:6a00:1d03:b0:580:149a:5650 with SMTP id a3-20020a056a001d0300b00580149a5650mr73276192pfx.22.1673435658896;
        Wed, 11 Jan 2023 03:14:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXud9FlZyCl95wBnuTgi/435XVOzxGcFz7TtRPVqAXRv7LSQge9pHXoidmVlz1ItLBaC1vOyvQ==
X-Received: by 2002:a05:6a00:1d03:b0:580:149a:5650 with SMTP id a3-20020a056a001d0300b00580149a5650mr73276181pfx.22.1673435658626;
        Wed, 11 Jan 2023 03:14:18 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b00589ed7ae132sm4235666pfd.13.2023.01.11.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:14:18 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 1/2] phy: ti: j721e-wiz: Manage TypeC lane swap if typec-dir-gpios not specified
Date:   Wed, 11 Jan 2023 16:43:55 +0530
Message-Id: <20230111111356.17392-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230111111356.17392-1-sinthu.raja@ti.com>
References: <20230111111356.17392-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673435659-311579-5583-381-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.200
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245393 [from 
        cloudscan14-111.eu-central-1a.ess.aws.cudaops.com]
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

It's possible that the Type-C plug orientation on the DIR line will be
implemented through hardware design. In that situation, there won't be
an external GPIO line available, but the driver still needs to address
this since the DT won't use the typec-dir-gpios property.

Add code to handle LN10 Type-C swap if typec-dir-gpios property is not
specified in DT.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

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

 drivers/phy/ti/phy-j721e-wiz.c | 39 +++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ddce5ef7711c..571f0ca18874 100644
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
@@ -1234,15 +1235,31 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
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
+				if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3)
+						&& wiz->master_lane_num[i] == 0) {
+					regmap_field_write(wiz->typec_ln10_swap, 1);
+				}
+			}
+		}
 	}
 
 	if (id == 0) {
@@ -1386,8 +1403,10 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
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

