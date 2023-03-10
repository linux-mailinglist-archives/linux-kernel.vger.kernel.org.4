Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17976B4A23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjCJPTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjCJPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:18:40 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78372124EAF;
        Fri, 10 Mar 2023 07:09:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i4so3075083ils.1;
        Fri, 10 Mar 2023 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91zNCcK0eMlsZLLSwQnbixSoKrbKhrqTHw8CcP7Hl64=;
        b=zaKryCAmDsAzBhRv0T5CKaTeAnSq5sfwHr0PQpDdS1zeorIpKeKU/Idgg6jkd58DBs
         ft+IUnIsDU72Y1lNAlTgqhFTO63ulenoWmywIpPhKOLsBZpFczXFKhcRROr6ykE+3rWK
         FdjMh9UV4Y6o9iNV7EnNs2LMzEp+gnsJkHwBSJ85GUz7z/eyI3o9n7qjtaB6mYqXMpmQ
         GAolp2fx0/5b0axG+FwiSnpSlmI0ft+YCBNDdUe2/BRFUuihqTvdSnPNYLymDexfx5F4
         Foz7l0+INt59dPh8A4ZGFUySjTyZ38IVhdwxEAgcTRlu7o4qri+6HYfVtzQYz6KhHtND
         tgvQ==
X-Gm-Message-State: AO0yUKWaYEYnEqGDdpkJSOextzvEM6wNII/w+5GamOFflNVMQ5+WzF+C
        SNDblyPQ5nn9wSQLzlrslV8DDTU5EQ==
X-Google-Smtp-Source: AK7set/383iqwmYFM0GwN8AQJI4JEdhGYs3zS6IktE2yuGU2KXhp6x1QK4i8031qSDFNY6w+GPzZXg==
X-Received: by 2002:a05:6870:b016:b0:16d:dbcc:fd7 with SMTP id y22-20020a056870b01600b0016ddbcc0fd7mr16176834oae.14.1678459910405;
        Fri, 10 Mar 2023 06:51:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d4e0c000000b00690df568258sm107669otf.63.2023.03.10.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:51:49 -0800 (PST)
Received: (nullmailer pid 1545900 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Leitner <richard.leitner@skidata.com>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:28 -0600
Message-Id: <20230310144729.1545857-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |  6 +++---
 drivers/usb/chipidea/core.c        |  2 +-
 drivers/usb/dwc2/params.c          |  3 +--
 drivers/usb/host/ehci-ppc-of.c     |  6 +++---
 drivers/usb/host/fsl-mph-dr-of.c   |  7 ++-----
 drivers/usb/misc/usb251xb.c        | 33 ++++++++++++++----------------
 6 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 2eeccf4ec9d6..2855ac303001 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -152,12 +152,12 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 	 * Check the various over current related properties. If over current
 	 * detection is disabled we're not interested in the polarity.
 	 */
-	if (of_find_property(np, "disable-over-current", NULL)) {
+	if (of_property_read_bool(np, "disable-over-current")) {
 		data->disable_oc = 1;
-	} else if (of_find_property(np, "over-current-active-high", NULL)) {
+	} else if (of_property_read_bool(np, "over-current-active-high")) {
 		data->oc_pol_active_low = 0;
 		data->oc_pol_configured = 1;
-	} else if (of_find_property(np, "over-current-active-low", NULL)) {
+	} else if (of_property_read_bool(np, "over-current-active-low")) {
 		data->oc_pol_active_low = 1;
 		data->oc_pol_configured = 1;
 	} else {
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 27c601296130..7ccb223ed53c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -753,7 +753,7 @@ static int ci_get_platdata(struct device *dev,
 		return ret;
 	}
 
-	if (of_find_property(dev->of_node, "non-zero-ttctrl-ttha", NULL))
+	if (of_property_read_bool(dev->of_node, "non-zero-ttctrl-ttha"))
 		platdata->flags |= CI_HDRC_SET_NON_ZERO_TTHA;
 
 	ext_id = ERR_PTR(-ENODEV);
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 9ed9fd956940..21d16533bd2f 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -508,8 +508,7 @@ static void dwc2_get_device_properties(struct dwc2_hsotg *hsotg)
 		of_usb_update_otg_caps(hsotg->dev->of_node, &p->otg_caps);
 	}
 
-	if (of_find_property(hsotg->dev->of_node, "disable-over-current", NULL))
-		p->oc_disable = true;
+	p->oc_disable = of_property_read_bool(hsotg->dev->of_node, "disable-over-current");
 }
 
 static void dwc2_check_param_otg_cap(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index 62a0a193798c..b3aa464e9d2c 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -151,13 +151,13 @@ static int ehci_hcd_ppc_of_probe(struct platform_device *op)
 		of_node_put(np);
 	}
 
-	if (of_get_property(dn, "big-endian", NULL)) {
+	if (of_property_read_bool(dn, "big-endian")) {
 		ehci->big_endian_mmio = 1;
 		ehci->big_endian_desc = 1;
 	}
-	if (of_get_property(dn, "big-endian-regs", NULL))
+	if (of_property_read_bool(dn, "big-endian-regs"))
 		ehci->big_endian_mmio = 1;
-	if (of_get_property(dn, "big-endian-desc", NULL))
+	if (of_property_read_bool(dn, "big-endian-desc"))
 		ehci->big_endian_desc = 1;
 
 	ehci->caps = hcd->regs;
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index cdf71b716c2b..9db909d12354 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -208,11 +208,8 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 
 		pdata->operating_mode = FSL_USB2_MPH_HOST;
 	} else {
-		if (of_get_property(np, "fsl,invert-drvvbus", NULL))
-			pdata->invert_drvvbus = 1;
-
-		if (of_get_property(np, "fsl,invert-pwr-fault", NULL))
-			pdata->invert_pwr_fault = 1;
+		pdata->invert_drvvbus = of_property_read_bool(np, "fsl,invert-drvvbus");
+		pdata->invert_pwr_fault = of_property_read_bool(np, "fsl,invert-pwr-fault");
 
 		/* setup mode selected in the device tree */
 		pdata->operating_mode = dev_data->op_mode;
diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index e3abe67a155d..96f25c1ec113 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -410,10 +410,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 		return -ENODEV;
 	}
 
-	if (of_get_property(np, "skip-config", NULL))
-		hub->skip_config = 1;
-	else
-		hub->skip_config = 0;
+	hub->skip_config = of_property_read_bool(np, "skip-config");
 
 	hub->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(hub->gpio_reset))
@@ -431,40 +428,40 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 		hub->device_id = USB251XB_DEF_DEVICE_ID;
 
 	hub->conf_data1 = USB251XB_DEF_CONFIG_DATA_1;
-	if (of_get_property(np, "self-powered", NULL)) {
+	if (of_property_read_bool(np, "self-powered")) {
 		hub->conf_data1 |= BIT(7);
 
 		/* Configure Over-Current sens when self-powered */
 		hub->conf_data1 &= ~BIT(2);
-		if (of_get_property(np, "ganged-sensing", NULL))
+		if (of_property_read_bool(np, "ganged-sensing"))
 			hub->conf_data1 &= ~BIT(1);
-		else if (of_get_property(np, "individual-sensing", NULL))
+		else if (of_property_read_bool(np, "individual-sensing"))
 			hub->conf_data1 |= BIT(1);
-	} else if (of_get_property(np, "bus-powered", NULL)) {
+	} else if (of_property_read_bool(np, "bus-powered")) {
 		hub->conf_data1 &= ~BIT(7);
 
 		/* Disable Over-Current sense when bus-powered */
 		hub->conf_data1 |= BIT(2);
 	}
 
-	if (of_get_property(np, "disable-hi-speed", NULL))
+	if (of_property_read_bool(np, "disable-hi-speed"))
 		hub->conf_data1 |= BIT(5);
 
-	if (of_get_property(np, "multi-tt", NULL))
+	if (of_property_read_bool(np, "multi-tt"))
 		hub->conf_data1 |= BIT(4);
-	else if (of_get_property(np, "single-tt", NULL))
+	else if (of_property_read_bool(np, "single-tt"))
 		hub->conf_data1 &= ~BIT(4);
 
-	if (of_get_property(np, "disable-eop", NULL))
+	if (of_property_read_bool(np, "disable-eop"))
 		hub->conf_data1 |= BIT(3);
 
-	if (of_get_property(np, "individual-port-switching", NULL))
+	if (of_property_read_bool(np, "individual-port-switching"))
 		hub->conf_data1 |= BIT(0);
-	else if (of_get_property(np, "ganged-port-switching", NULL))
+	else if (of_property_read_bool(np, "ganged-port-switching"))
 		hub->conf_data1 &= ~BIT(0);
 
 	hub->conf_data2 = USB251XB_DEF_CONFIG_DATA_2;
-	if (of_get_property(np, "dynamic-power-switching", NULL))
+	if (of_property_read_bool(np, "dynamic-power-switching"))
 		hub->conf_data2 |= BIT(7);
 
 	if (!of_property_read_u32(np, "oc-delay-us", &property_u32)) {
@@ -487,17 +484,17 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 		}
 	}
 
-	if (of_get_property(np, "compound-device", NULL))
+	if (of_property_read_bool(np, "compound-device"))
 		hub->conf_data2 |= BIT(3);
 
 	hub->conf_data3 = USB251XB_DEF_CONFIG_DATA_3;
-	if (of_get_property(np, "port-mapping-mode", NULL))
+	if (of_property_read_bool(np, "port-mapping-mode"))
 		hub->conf_data3 |= BIT(3);
 
 	if (data->led_support && of_get_property(np, "led-usb-mode", NULL))
 		hub->conf_data3 &= ~BIT(1);
 
-	if (of_get_property(np, "string-support", NULL))
+	if (of_property_read_bool(np, "string-support"))
 		hub->conf_data3 |= BIT(0);
 
 	hub->non_rem_dev = USB251XB_DEF_NON_REMOVABLE_DEVICES;
-- 
2.39.2

