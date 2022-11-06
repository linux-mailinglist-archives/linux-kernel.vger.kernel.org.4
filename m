Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F32B61E0BF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKFIB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKFIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:01:36 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4296343;
        Sun,  6 Nov 2022 01:01:33 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 87EBF40665;
        Sun,  6 Nov 2022 08:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667721691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4sTT60tFhvVvkdJlkoRnV4vJdcHfpYoypJr9bb49Ng=;
        b=hWBaVRu5DPLqgR0cLXduTMtEwl6P0F4ywmWuARRqnkx3kzDAGwaN6rcfKqOduQsgWWXluH
        b+LFCerrbOfJ58LpR90Ei/Y2mMpA29/rE8dtTOE4Mi8dGa9IyiZ7rjzdf3ikuLolbBU2gB
        M7//SWaKHOeBXgrG4j+2iDziUyAJlg8=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id D871C3608D6;
        Sun,  6 Nov 2022 08:01:30 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] pinctrl: mediatek: extend pinctrl-moore to support new bias functions
Date:   Sun,  6 Nov 2022 09:01:12 +0100
Message-Id: <20221106080114.7426-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106080114.7426-1-linux@fw-web.de>
References: <20221106080114.7426-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 834ebe36-977f-4cff-aa59-d34b09342e20
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

Commit fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
introduced SoC specify 'pull_type' attribute to mtk_pinconf_bias_set_combo
and mtk_pinconf_bias_get_combo, and make the functions able to support
almost all Mediatek SoCs that use pinctrl-mtk-common-v2.c.

This patch enables pinctrl_moore to support these functions.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c | 49 ++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 526faaebaf77..cdc002d29932 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <dt-bindings/pinctrl/mt65xx.h>
 #include <linux/gpio/driver.h>
 #include "pinctrl-moore.h"
 
@@ -105,7 +106,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
-	int val, val2, err, reg, ret = 1;
+	int val, val2, err, pullup, reg, ret = 1;
 	const struct mtk_pin_desc *desc;
 
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
@@ -114,7 +115,13 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		if (hw->soc->bias_disable_get) {
+		if (hw->soc->bias_get_combo) {
+			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+			if (err)
+				return err;
+			if (ret != MTK_PUPD_SET_R1R0_00 && ret != MTK_DISABLE)
+				return -EINVAL;
+		} else if (hw->soc->bias_disable_get) {
 			err = hw->soc->bias_disable_get(hw, desc, &ret);
 			if (err)
 				return err;
@@ -123,7 +130,15 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (hw->soc->bias_get) {
+		if (hw->soc->bias_get_combo) {
+			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+			if (err)
+				return err;
+			if (ret == MTK_PUPD_SET_R1R0_00 || ret == MTK_DISABLE)
+				return -EINVAL;
+			if (!pullup)
+				return -EINVAL;
+		} else if (hw->soc->bias_get) {
 			err = hw->soc->bias_get(hw, desc, 1, &ret);
 			if (err)
 				return err;
@@ -132,7 +147,15 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_get) {
+		if (hw->soc->bias_get_combo) {
+			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+			if (err)
+				return err;
+			if (ret == MTK_PUPD_SET_R1R0_00 || ret == MTK_DISABLE)
+				return -EINVAL;
+			if (pullup)
+				return -EINVAL;
+		} else if (hw->soc->bias_get) {
 			err = hw->soc->bias_get(hw, desc, 0, &ret);
 			if (err)
 				return err;
@@ -235,7 +258,11 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
-			if (hw->soc->bias_disable_set) {
+			if (hw->soc->bias_set_combo) {
+				err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
+				if (err)
+					return err;
+			} else if (hw->soc->bias_disable_set) {
 				err = hw->soc->bias_disable_set(hw, desc);
 				if (err)
 					return err;
@@ -244,7 +271,11 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			}
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			if (hw->soc->bias_set) {
+			if (hw->soc->bias_set_combo) {
+				err = hw->soc->bias_set_combo(hw, desc, 1, arg);
+				if (err)
+					return err;
+			} else if (hw->soc->bias_set) {
 				err = hw->soc->bias_set(hw, desc, 1);
 				if (err)
 					return err;
@@ -253,7 +284,11 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			}
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			if (hw->soc->bias_set) {
+			if (hw->soc->bias_set_combo) {
+				err = hw->soc->bias_set_combo(hw, desc, 0, arg);
+				if (err)
+					return err;
+			} else if (hw->soc->bias_set) {
 				err = hw->soc->bias_set(hw, desc, 0);
 				if (err)
 					return err;
-- 
2.34.1

