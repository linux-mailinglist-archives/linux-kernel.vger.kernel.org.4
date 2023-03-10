Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDF6B47BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjCJOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjCJOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:53:20 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBF12B026;
        Fri, 10 Mar 2023 06:49:22 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id bg11so4401311oib.5;
        Fri, 10 Mar 2023 06:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCm7q3U60/6KX9NcfTGr2pgCK75ismvU0cilf2FoiGw=;
        b=BgrvSnFROC0ijHIi650QY2Fx+hT4+KyHeonVoBY+ygi5mmTSabAya8yv4za8rvKvXC
         YJDhs8e1Jhld1LWTbQKG9JlSCCit85cejfKKj0/SCbIQt/tebepplnfHo/zXhrBbEwIQ
         4EYTxXcaW39k9JHo19R7hzBQ9sYva0OH7s/T6dHQrzflNTCVn7q5ABrSIccfgLFJPKcq
         c0R0VVD98IhuB6+aX0qEEWI244MQ7qXkZhoimM5XlvtPYcMIVmnUodn8lmNxW0WUq5WG
         k851etgYLHdXYKkWGsXclytNuz+FdhEkkhhNElZgLAQrjj7LY8epFBSmnSPWT/9V0XdZ
         hNoA==
X-Gm-Message-State: AO0yUKWu80XvnxL6A/3D/OcoDgpFGqXDvuZZosKW8F37P3zcoUsPAgXT
        eNbYET2qA8PzyAFzkkvTJg==
X-Google-Smtp-Source: AK7set+/P06XaRp7GkTwg3tc6gShVPdQ5zxSFTjc+shqKUaog2xzKowKu9ROn/VBl+65mw2D8Tw0Yw==
X-Received: by 2002:a05:6808:86:b0:384:67e1:ca00 with SMTP id s6-20020a056808008600b0038467e1ca00mr9966724oic.48.1678459700609;
        Fri, 10 Mar 2023 06:48:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u26-20020a9d4d9a000000b00686a19ffef1sm92062otk.80.2023.03.10.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:20 -0800 (PST)
Received: (nullmailer pid 1545813 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH] usb: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:27 -0600
Message-Id: <20230310144728.1545786-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/gadget/udc/snps_udc_plat.c | 2 +-
 drivers/usb/host/fsl-mph-dr-of.c       | 4 ++--
 drivers/usb/musb/omap2430.c            | 2 +-
 drivers/usb/phy/phy-mxs-usb.c          | 2 +-
 drivers/usb/phy/phy-tegra-usb.c        | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 8bbb89c80348..0d3e705655b9 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -158,7 +158,7 @@ static int udc_plat_probe(struct platform_device *pdev)
 	}
 
 	/* Register for extcon if supported */
-	if (of_get_property(dev->of_node, "extcon", NULL)) {
+	if (of_property_present(dev->of_node, "extcon")) {
 		udc->edev = extcon_get_edev_by_phandle(dev, 0);
 		if (IS_ERR(udc->edev)) {
 			if (PTR_ERR(udc->edev) == -EPROBE_DEFER)
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 46c6a152b865..cdf71b716c2b 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -200,10 +200,10 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 	dev_data = get_dr_mode_data(np);
 
 	if (of_device_is_compatible(np, "fsl-usb2-mph")) {
-		if (of_get_property(np, "port0", NULL))
+		if (of_property_present(np, "port0"))
 			pdata->port_enables |= FSL_USB2_PORT0_ENABLED;
 
-		if (of_get_property(np, "port1", NULL))
+		if (of_property_present(np, "port1"))
 			pdata->port_enables |= FSL_USB2_PORT1_ENABLED;
 
 		pdata->operating_mode = FSL_USB2_MPH_HOST;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 44a21ec865fb..7f305b352591 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -334,7 +334,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	 * Legacy SoCs using omap_device get confused if node is moved
 	 * because of interconnect properties mixed into the node.
 	 */
-	if (of_get_property(np, "ti,hwmods", NULL)) {
+	if (of_property_present(np, "ti,hwmods")) {
 		dev_warn(&pdev->dev, "please update to probe with ti-sysc\n");
 		populate_irqs = true;
 	} else {
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index d2836ef5d15c..0a8e3fd699ca 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -733,7 +733,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Some SoCs don't have anatop registers */
-	if (of_get_property(np, "fsl,anatop", NULL)) {
+	if (of_property_present(np, "fsl,anatop")) {
 		mxs_phy->regmap_anatop = syscon_regmap_lookup_by_phandle
 			(np, "fsl,anatop");
 		if (IS_ERR(mxs_phy->regmap_anatop)) {
diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index f0240107edb1..4d207ce3ddf2 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1375,7 +1375,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	tegra_phy->is_legacy_phy =
 		of_property_read_bool(np, "nvidia,has-legacy-mode");
 
-	if (of_find_property(np, "dr_mode", NULL))
+	if (of_property_present(np, "dr_mode"))
 		tegra_phy->mode = usb_get_dr_mode(&pdev->dev);
 	else
 		tegra_phy->mode = USB_DR_MODE_HOST;
-- 
2.39.2

