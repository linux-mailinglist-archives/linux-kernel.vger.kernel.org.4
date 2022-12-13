Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4D64B574
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiLMMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiLMMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:49:16 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABC1B9F1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:49:14 -0800 (PST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197]) by mx-outbound20-247.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Dec 2022 12:49:12 +0000
Received: by mail-pf1-f197.google.com with SMTP id z13-20020aa79f8d000000b00576b614b7d2so2004027pfr.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJx0rqXAD4/GS75NvFhhlmtznHYCg5Ca/9JyH7cg9Uo=;
        b=kJcvRSdIp5NMz5v1W2KrvA5RQ6yRnVaMEmRm9XeDvp9L9VdtmbkgqW/ajupMeLa5C8
         LYH1eSD2TDLLz7yzclYpZzqrSSJIDUMS6YJ1c9JX2pO9hXEawe8hnibZOn4njwmTYQs0
         PsxVRQq0//XNw635iCjmc9cBeLcyKAdYiG5ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJx0rqXAD4/GS75NvFhhlmtznHYCg5Ca/9JyH7cg9Uo=;
        b=It/lv7oEG2pgssI4bSFZmNQVPjGbt0OPG7fBZsHfv3ZOI5VQjXHzJw36EbUCxLciZb
         mAx7Ss50pup39O8+ivThHqdE1W1grNohI+UOgFKP8Gg/9qsZo55iaDtULXOUylLmq4lV
         QCfh4ntPWHvsjmQIK3mycJvk/oW/A80tmb+GJ5YEVPhj9UJniCTcTu0k6M/ro+e2Jhfu
         5+JzlSG7vvIZGInVuPaW+TrsGcgmOj2GvEibmvH/hu4rGM86uXlg03CJ+3p6aOH3lrq1
         hYgc0dbrwWl3p4mTqOysu3lGyPMafnjhp54y9ktITof85pQQY+pK7Fl2oipPrkNPrZq3
         oVbQ==
X-Gm-Message-State: ANoB5pmcbdrAjeG46TM7bGwFNojCusORPY4WKQ2f3DmgkjXh5ZL1xErP
        PgsQw0GKNvY1Z1vWTEY74VyNiirsVa2c+jAOapXBVWuzkgrOkNasdWOvJYzgGq/Dlfov/Jamu2L
        9+A3zba5urUxo4oUMyFiw2oCZZtEQgb8mvJd+MhSTKk2+fmcZ+bUzkIjIrEV0
X-Received: by 2002:a62:6303:0:b0:578:83f5:554d with SMTP id x3-20020a626303000000b0057883f5554dmr7396315pfb.23.1670935750568;
        Tue, 13 Dec 2022 04:49:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf79NvSLf3fR4k5b2OfX28LbYFMvdBnV3f6QI2mYequV8Z64orw6uQKCILT4aH7NwsrBcXjRnA==
X-Received: by 2002:a62:6303:0:b0:578:83f5:554d with SMTP id x3-20020a626303000000b0057883f5554dmr7396294pfb.23.1670935750251;
        Tue, 13 Dec 2022 04:49:10 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7942f000000b0057622e8e82csm7605485pfo.191.2022.12.13.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:49:09 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 1/2] phy: ti: j721e-wiz: Manage TypeC lane swap if typec-gpio-dir not specified
Date:   Tue, 13 Dec 2022 18:18:53 +0530
Message-Id: <20221213124854.3779-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221213124854.3779-1-sinthu.raja@ti.com>
References: <20221213124854.3779-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1670935751-305367-5380-5821-1
X-BESS-VER: 2019.1_20221212.2317
X-BESS-Apparent-Source-IP: 209.85.210.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244774 [from 
        cloudscan15-235.eu-central-1a.ess.aws.cudaops.com]
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

It's possible that the Type-C plug orientation on the DIR line will be
implemented through hardware design. In that situation, there won't be
an external GPIO line available, but the driver still needs to address
this since the DT won't use the typec-gpio-dir property.

Add code to handle LN10 Type-C swap if typec-gpio-dir property is not
specified in DT.

Remove typec-gpio-dir check to use minimum debounce from Type-C spec if
it is not provided in DT

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 65 +++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 141b51af4427..b17eec632d49 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -375,6 +375,7 @@ struct wiz {
 	struct gpio_desc	*gpio_typec_dir;
 	int			typec_dir_delay;
 	u32 lane_phy_type[WIZ_MAX_LANES];
+	u32 lane_phy_reg[WIZ_MAX_LANES];
 	struct clk		*input_clks[WIZ_MAX_INPUT_CLOCKS];
 	struct clk		*output_clks[WIZ_MAX_OUTPUT_CLOCKS];
 	struct clk_onecell_data	clk_data;
@@ -1231,14 +1232,28 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 	int ret;
 
 	/* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
-	if (id == 0 && wiz->gpio_typec_dir) {
-		if (wiz->typec_dir_delay)
-			msleep_interruptible(wiz->typec_dir_delay);
-
-		if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
-			regmap_field_write(wiz->typec_ln10_swap, 1);
-		else
-			regmap_field_write(wiz->typec_ln10_swap, 0);
+	if (id == 0 && wiz->typec_dir_delay) {
+		msleep_interruptible(wiz->typec_dir_delay);
+
+		if (wiz->gpio_typec_dir) {
+			if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
+				regmap_field_write(wiz->typec_ln10_swap, 1);
+			else
+				regmap_field_write(wiz->typec_ln10_swap, 0);
+		} else {
+			/* if no typec-dir gpio was specified, and USB lines
+			 * are connected to Lane 0 then set LN10 SWAP bit to 1.
+			 */
+			u32 num_lanes = wiz->num_lanes;
+			int i;
+
+			for (i = 0; i < num_lanes; i++) {
+				if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3) \
+						&& wiz->lane_phy_reg[i] == 0) {
+					regmap_field_write(wiz->typec_ln10_swap, 1);
+				}
+			}
+		}
 	}
 
 	if (id == 0) {
@@ -1370,8 +1385,10 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		dev_dbg(dev, "%s: Lanes %u-%u have phy-type %u\n", __func__,
 			reg, reg + num_lanes - 1, phy_type);
 
-		for (i = reg; i < reg + num_lanes; i++)
+		for (i = reg; i < reg + num_lanes; i++) {
+			wiz->lane_phy_reg[i] = reg;
 			wiz->lane_phy_type[i] = phy_type;
+		}
 	}
 
 	return 0;
@@ -1464,24 +1481,22 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_addr_to_resource;
 	}
 
-	if (wiz->gpio_typec_dir) {
-		ret = of_property_read_u32(node, "typec-dir-debounce-ms",
-					   &wiz->typec_dir_delay);
-		if (ret && ret != -EINVAL) {
-			dev_err(dev, "Invalid typec-dir-debounce property\n");
-			goto err_addr_to_resource;
-		}
+	ret = of_property_read_u32(node, "typec-dir-debounce-ms",
+				   &wiz->typec_dir_delay);
+	if (ret && ret != -EINVAL) {
+		dev_err(dev, "Invalid typec-dir-debounce property\n");
+		goto err_addr_to_resource;
+	}
 
-		/* use min. debounce from Type-C spec if not provided in DT  */
-		if (ret == -EINVAL)
-			wiz->typec_dir_delay = WIZ_TYPEC_DIR_DEBOUNCE_MIN;
+	/* use min. debounce from Type-C spec if not provided in DT  */
+	if (ret == -EINVAL)
+		wiz->typec_dir_delay = WIZ_TYPEC_DIR_DEBOUNCE_MIN;
 
-		if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
-		    wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
-			ret = -EINVAL;
-			dev_err(dev, "Invalid typec-dir-debounce property\n");
-			goto err_addr_to_resource;
-		}
+	if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
+	    wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
+		ret = -EINVAL;
+		dev_err(dev, "Invalid typec-dir-debounce property\n");
+		goto err_addr_to_resource;
 	}
 
 	ret = wiz_get_lane_phy_types(dev, wiz);
-- 
2.36.1

