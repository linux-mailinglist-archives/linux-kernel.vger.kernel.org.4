Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633D61D8E9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiKEIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKEItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:49:22 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1897522516;
        Sat,  5 Nov 2022 01:49:20 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 5F537604BB;
        Sat,  5 Nov 2022 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667638158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3AIjuOFV7NmJ2TCa+PR6W4BsmI1cN7bR/tG6Mgpyk4=;
        b=juBc8LFU754K6LYQPXPDO3QJpbELE0e2QaSHzMAFWKEfSXkvQNiH1hl281T+cbR7/ej4Qa
        RTiiu0xHY6GJ5BI/UWIiv7pn8ghYqEZhFgkRytRBeCRFB+XRsjluUXizR0K0ziRIB1dEce
        aNXCNqkiFYkrTvTSGmvLtvbZRRJ/zbo=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id A317E10068B;
        Sat,  5 Nov 2022 08:49:17 +0000 (UTC)
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
Subject: [PATCH v1 4/4] pinctrl: mediatek: add pull_type attribute for mediatek MT7986 SoC
Date:   Sat,  5 Nov 2022 09:49:05 +0100
Message-Id: <20221105084905.9596-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221105084905.9596-1-linux@fw-web.de>
References: <20221105084905.9596-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d9ecc7e5-fb35-45d3-9365-e8e061b9cc02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

Commit fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
add SoC specify 'pull_type' attribute for bias configuration.

This patch add pull_type attribute to pinctrl-mt7986.c, and make
bias_set_combo and bias_get_combo available to mediatek MT7986 SoC.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/pinctrl/mediatek/pinctrl-mt7986.c | 56 +++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index d13c59510468..872b1d9b5267 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -407,6 +407,60 @@ static const struct mtk_pin_field_calc mt7986_pin_r1_range[] = {
 	PIN_FIELD_BASE(66, 68, IOCFG_LB_BASE, 0x60, 0x10, 2, 1),
 };
 
+static const unsigned int mt7986_pull_type[] = {
+	MTK_PULL_PUPD_R1R0_TYPE,/*0*/ MTK_PULL_PUPD_R1R0_TYPE,/*1*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*2*/ MTK_PULL_PUPD_R1R0_TYPE,/*3*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*4*/ MTK_PULL_PUPD_R1R0_TYPE,/*4*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*6*/ MTK_PULL_PUPD_R1R0_TYPE,/*5*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*8*/ MTK_PULL_PUPD_R1R0_TYPE,/*9*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*10*/ MTK_PULL_PUPD_R1R0_TYPE,/*11*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*12*/ MTK_PULL_PUPD_R1R0_TYPE,/*13*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*14*/ MTK_PULL_PUPD_R1R0_TYPE,/*14*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*16*/ MTK_PULL_PUPD_R1R0_TYPE,/*15*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*18*/ MTK_PULL_PUPD_R1R0_TYPE,/*19*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*20*/ MTK_PULL_PUPD_R1R0_TYPE,/*21*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*22*/ MTK_PULL_PUPD_R1R0_TYPE,/*23*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*24*/ MTK_PULL_PUPD_R1R0_TYPE,/*24*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*26*/ MTK_PULL_PUPD_R1R0_TYPE,/*25*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*28*/ MTK_PULL_PUPD_R1R0_TYPE,/*29*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*30*/ MTK_PULL_PUPD_R1R0_TYPE,/*31*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*32*/ MTK_PULL_PUPD_R1R0_TYPE,/*33*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*34*/ MTK_PULL_PUPD_R1R0_TYPE,/*34*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*36*/ MTK_PULL_PUPD_R1R0_TYPE,/*35*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*38*/ MTK_PULL_PUPD_R1R0_TYPE,/*39*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*40*/ MTK_PULL_PUPD_R1R0_TYPE,/*41*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*42*/ MTK_PULL_PUPD_R1R0_TYPE,/*43*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*44*/ MTK_PULL_PUPD_R1R0_TYPE,/*44*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*46*/ MTK_PULL_PUPD_R1R0_TYPE,/*45*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*48*/ MTK_PULL_PUPD_R1R0_TYPE,/*49*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*50*/ MTK_PULL_PUPD_R1R0_TYPE,/*51*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*52*/ MTK_PULL_PUPD_R1R0_TYPE,/*53*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*54*/ MTK_PULL_PUPD_R1R0_TYPE,/*54*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*56*/ MTK_PULL_PUPD_R1R0_TYPE,/*55*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*58*/ MTK_PULL_PUPD_R1R0_TYPE,/*59*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*60*/ MTK_PULL_PUPD_R1R0_TYPE,/*61*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*62*/ MTK_PULL_PUPD_R1R0_TYPE,/*63*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*64*/ MTK_PULL_PUPD_R1R0_TYPE,/*64*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*66*/ MTK_PULL_PUPD_R1R0_TYPE,/*65*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*68*/ MTK_PULL_PU_PD_TYPE,/*69*/
+	MTK_PULL_PU_PD_TYPE,/*70*/ MTK_PULL_PU_PD_TYPE,/*71*/
+	MTK_PULL_PU_PD_TYPE,/*72*/ MTK_PULL_PU_PD_TYPE,/*73*/
+	MTK_PULL_PU_PD_TYPE,/*74*/ MTK_PULL_PU_PD_TYPE,/*75*/
+	MTK_PULL_PU_PD_TYPE,/*76*/ MTK_PULL_PU_PD_TYPE,/*77*/
+	MTK_PULL_PU_PD_TYPE,/*78*/ MTK_PULL_PU_PD_TYPE,/*79*/
+	MTK_PULL_PU_PD_TYPE,/*80*/ MTK_PULL_PU_PD_TYPE,/*81*/
+	MTK_PULL_PU_PD_TYPE,/*82*/ MTK_PULL_PU_PD_TYPE,/*83*/
+	MTK_PULL_PU_PD_TYPE,/*84*/ MTK_PULL_PU_PD_TYPE,/*85*/
+	MTK_PULL_PU_PD_TYPE,/*86*/ MTK_PULL_PU_PD_TYPE,/*87*/
+	MTK_PULL_PU_PD_TYPE,/*88*/ MTK_PULL_PU_PD_TYPE,/*89*/
+	MTK_PULL_PU_PD_TYPE,/*90*/ MTK_PULL_PU_PD_TYPE,/*91*/
+	MTK_PULL_PU_PD_TYPE,/*92*/ MTK_PULL_PU_PD_TYPE,/*93*/
+	MTK_PULL_PU_PD_TYPE,/*94*/ MTK_PULL_PU_PD_TYPE,/*95*/
+	MTK_PULL_PU_PD_TYPE,/*96*/ MTK_PULL_PU_PD_TYPE,/*97*/
+	MTK_PULL_PU_PD_TYPE,/*98*/ MTK_PULL_PU_PD_TYPE,/*99*/
+	MTK_PULL_PU_PD_TYPE,/*100*/
+};
+
 static const struct mtk_pin_reg_calc mt7986_reg_cals[] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt7986_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt7986_pin_dir_range),
@@ -866,6 +920,7 @@ static struct mtk_pin_soc mt7986a_data = {
 	.ies_present = false,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.pull_type = mt7986_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
 	.drive_set = mtk_pinconf_drive_set_rev1,
@@ -887,6 +942,7 @@ static struct mtk_pin_soc mt7986b_data = {
 	.ies_present = false,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.pull_type = mt7986_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
 	.drive_set = mtk_pinconf_drive_set_rev1,
-- 
2.34.1

