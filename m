Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A06B47E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjCJOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjCJOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:54:08 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9E20568;
        Fri, 10 Mar 2023 06:49:59 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id bg11so4402221oib.5;
        Fri, 10 Mar 2023 06:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwhYtKzDnXEsLBl9Tm3BqnXbNzyUsQ3KuTYFbJoohGM=;
        b=Y+Bo8TYkfnbYROW59aHEiy7Loa7w9Lyr2OAeBGvM7lJF5afIzUtUSZvGwtKD+hjuTY
         ZQ2roLOk2gO/0hn0+oULU6rCw3HO/fXBA1R7QRfiLyUVdlzQsIFC8thLGNXzrLPLC45q
         eDNdwIhZQOmE4FJzD9KIlb5JNtARl4EXUKOBiAlPXL/FibOYKPT9JIX9kcVZfNfYUaTQ
         ruUVb8Fa5MKHd+67psArxoKOKjUlAqEtKzM5I++WX6AwFJ/KmzWu/+ui9REkpLFtTu4K
         n5fbPGCBt435CK1dfVWFxpBTXQFem2xsrgF6sbUXZidpCralIoJoO6AKas776SdKJjiJ
         1yZQ==
X-Gm-Message-State: AO0yUKVRlAfqWW5rXrIewugzAK/HbX5+6HUaJmc7z0zlEQvQUrm7JrbQ
        cH4aCOxznbwBrmvYMWCyPg==
X-Google-Smtp-Source: AK7set/2Hv/GHCQ4CWKw9+OchH8gffT8eqBP4iLmC17qsMPdXt7UFyt1xWM3HZum7IWwuaM8TqbJlg==
X-Received: by 2002:a05:6808:1d7:b0:383:ef56:a34c with SMTP id x23-20020a05680801d700b00383ef56a34cmr1364469oic.2.1678459722220;
        Fri, 10 Mar 2023 06:48:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y129-20020acae187000000b0038476262f65sm967331oig.33.2023.03.10.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:41 -0800 (PST)
Received: (nullmailer pid 1544713 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] pinctrl: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:20 -0600
Message-Id: <20230310144721.1544669-1-robh@kernel.org>
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
 drivers/pinctrl/mediatek/pinctrl-moore.c |  2 +-
 drivers/pinctrl/pinctrl-single.c         |  4 ++--
 drivers/pinctrl/pinctrl-stmfx.c          |  2 +-
 drivers/pinctrl/renesas/pinctrl.c        |  4 ++--
 drivers/pinctrl/stm32/pinctrl-stm32.c    |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c    | 20 ++++++++++----------
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 007b98ce5631..8649a2f9d324 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -586,7 +586,7 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
 	 * Documentation/devicetree/bindings/gpio/gpio.txt on how to
 	 * bind pinctrl and gpio drivers via the "gpio-ranges" property.
 	 */
-	if (!of_find_property(hw->dev->of_node, "gpio-ranges", NULL)) {
+	if (!of_property_present(hw->dev->of_node, "gpio-ranges")) {
 		ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
 					     chip->ngpio);
 		if (ret < 0) {
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 190923757cda..0dabbcf68b9f 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -939,11 +939,11 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 
 	/* cacluate how much properties are supported in current node */
 	for (i = 0; i < ARRAY_SIZE(prop2); i++) {
-		if (of_find_property(np, prop2[i].name, NULL))
+		if (of_property_present(np, prop2[i].name))
 			nconfs++;
 	}
 	for (i = 0; i < ARRAY_SIZE(prop4); i++) {
-		if (of_find_property(np, prop4[i].name, NULL))
+		if (of_property_present(np, prop4[i].name))
 			nconfs++;
 	}
 	if (!nconfs)
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 1181c4b506b1..3c031692e44d 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -632,7 +632,7 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 	pctl->dev = &pdev->dev;
 	pctl->stmfx = stmfx;
 
-	if (!of_find_property(np, "gpio-ranges", NULL)) {
+	if (!of_property_present(np, "gpio-ranges")) {
 		dev_err(pctl->dev, "missing required gpio-ranges property\n");
 		return -EINVAL;
 	}
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
index b74147800319..5c71e168b370 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -125,8 +125,8 @@ static int sh_pfc_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	 * inside a subnode nor across subnodes.
 	 */
 	if (!pmx->func_prop_name) {
-		if (of_find_property(np, "groups", NULL) ||
-		    of_find_property(np, "pins", NULL)) {
+		if (of_property_present(np, "groups")||
+		    of_property_present(np, "pins")) {
 			pmx->func_prop_name = "function";
 			pmx->groups_prop_name = "groups";
 			pmx->pins_prop_name = "pins";
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index cb33a23ab0c1..66a25becd8f5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1374,7 +1374,7 @@ static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pde
 	struct device_node *parent;
 	struct irq_domain *domain;
 
-	if (!of_find_property(np, "interrupt-parent", NULL))
+	if (!of_property_present(np, "interrupt-parent"))
 		return NULL;
 
 	parent = of_irq_find_parent(np);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f35179eceb4e..1dc1882cbdd7 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -224,16 +224,16 @@ static int sunxi_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 
 static bool sunxi_pctrl_has_bias_prop(struct device_node *node)
 {
-	return of_find_property(node, "bias-pull-up", NULL) ||
-		of_find_property(node, "bias-pull-down", NULL) ||
-		of_find_property(node, "bias-disable", NULL) ||
-		of_find_property(node, "allwinner,pull", NULL);
+	return of_property_present(node, "bias-pull-up") ||
+		of_property_present(node, "bias-pull-down") ||
+		of_property_present(node, "bias-disable") ||
+		of_property_present(node, "allwinner,pull");
 }
 
 static bool sunxi_pctrl_has_drive_prop(struct device_node *node)
 {
-	return of_find_property(node, "drive-strength", NULL) ||
-		of_find_property(node, "allwinner,drive", NULL);
+	return of_property_present(node, "drive-strength") ||
+		of_property_present(node, "allwinner,drive");
 }
 
 static int sunxi_pctrl_parse_bias_prop(struct device_node *node)
@@ -241,13 +241,13 @@ static int sunxi_pctrl_parse_bias_prop(struct device_node *node)
 	u32 val;
 
 	/* Try the new style binding */
-	if (of_find_property(node, "bias-pull-up", NULL))
+	if (of_property_present(node, "bias-pull-up"))
 		return PIN_CONFIG_BIAS_PULL_UP;
 
-	if (of_find_property(node, "bias-pull-down", NULL))
+	if (of_property_present(node, "bias-pull-down"))
 		return PIN_CONFIG_BIAS_PULL_DOWN;
 
-	if (of_find_property(node, "bias-disable", NULL))
+	if (of_property_present(node, "bias-disable"))
 		return PIN_CONFIG_BIAS_DISABLE;
 
 	/* And fall back to the old binding */
@@ -1424,7 +1424,7 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 		return 0;
 
 	/* If we don't have any setup, bail out */
-	if (!of_find_property(node, "input-debounce", NULL))
+	if (!of_property_present(node, "input-debounce"))
 		return 0;
 
 	losc = devm_clk_get(pctl->dev, "losc");
-- 
2.39.2

