Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8066E4F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjDQRjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDQRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:39:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E38B45B;
        Mon, 17 Apr 2023 10:39:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m39-20020a05600c3b2700b003f170e75bd3so1732792wms.1;
        Mon, 17 Apr 2023 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753154; x=1684345154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo8M7dptfnnU8j8sIZf6ijHu+Q3xkPlAvSopMzRPSeI=;
        b=dxFQjXSqWSI4OK3YlKmd4NDmF/m8JF1EDA4I4yjdo0xcBTHYlHxRiOAOCVO0JbO5LJ
         EMBzj/9m3bpsfhJbd9KzFtKtN5vssL9xugmL50GBR8rS6lS5kV8wy6TEJ2oM5/uFZQo3
         eVj8V8YoU9tgYURwoBZ5mwJDBs3nvhR76e1mkMj0vCjI5iJX1nqjgYG1F7SE7LWRhQuj
         DzNpLa9MjC9IlmvUtV5di/4MyrIRBLXL1fGNPKg2gsfDy755YmhOcM4EcmEG3R+V7B0s
         /c3+5BKwrFdvGA60lwCzK8wrzKBpV1/iIoukolc6R3cUuGrBh9nMiMzVnyF7Tg20wx5q
         lZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753154; x=1684345154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo8M7dptfnnU8j8sIZf6ijHu+Q3xkPlAvSopMzRPSeI=;
        b=f61CrgdCc8+R/RAcTkz0MSKLmidMJdmH4bio8h5MoCH71HahwEiNmWPhH40krwk2lN
         VarL3l1bZvx9ED+Zxwkv0XVMFjGfUU4WxryuWBvzv5uiewO7X99qDZJOl4PQz3fyaCYR
         XsIi+9D5ErpNMTVbejhmL5qkQ6MXnSRo9BIW15utFNhBesHZh4zRxIFCw8azApRuHfHn
         DfrKOrda+HrcscH4sPJRH08wXqx+QGZh7hz319Qdn1dngCN0okp8BlYOjBv0ZF+v2hAZ
         gSvAhcHfWbJUoGtIwtuBRfP7Nmk2yWL81U71ScOJdgCYcdAr/AelT6sPGOZofyRT3dLY
         kr6A==
X-Gm-Message-State: AAQBX9fZpT4GitqJRiYQ7eXRifb9wrQjAaArVajncn+z3X8aPl5oxS59
        k9yJKCbdshzp4wpznd+/K6Hs26z4TdyI/Q==
X-Google-Smtp-Source: AKy350Z/R7Edry6qOXn5LKcogwRMGp4EGe+XGM1A+KKlUhlTpgn4eAwnm+s947vhwm74FR4LqtNFog==
X-Received: by 2002:a1c:f617:0:b0:3ed:a80e:6dfa with SMTP id w23-20020a1cf617000000b003eda80e6dfamr10949474wmc.40.1681753154125;
        Mon, 17 Apr 2023 10:39:14 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (35.145.195.178.dynamic.wline.res.cust.swisscom.ch. [178.195.145.35])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm2478211wmb.7.2023.04.17.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:39:13 -0700 (PDT)
From:   Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 4/4] arm64: dts: colibri-imx8x: delete adc1 and dsp
Date:   Mon, 17 Apr 2023 19:38:30 +0200
Message-Id: <20230417173830.19401-5-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
References: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8, i.MX8X, i.MX8XP and i.MX8XL SOC device trees are all based on
imx8-ss-*.dtsi files. For i.MX8X and i.MX8XP these device trees
should be updated with some peripherals removed or updated, similar
to i.MX8XL (imx8dxl-ss-*.dtsi files). However, it looks like only
i.MX8 and i.MX8XL are up to date, but for i.MX8X and i.MX8XP some
of the peripherals got inherited from imx8-ss-*.dtsi files, but in
reality they are not present on SOC.
As a result, during resource partition ownership check U-Boot receives
messages from SCU firmware about these resources not owned by boot
partition. In reality, these resources are not owned by anyone, as
they simply does not exist, but are defined in Linux device tree.
This change removes those peripherals, which are listed during
U-Boot resource partition ownership check as warnings:

  ## Flattened Device Tree blob at 9d400000
     Booting using the fdt blob at 0x9d400000
     Loading Device Tree to 00000000fd652000, end 00000000fd67efff ... OK
  Disable clock-controller@59580000 rsrc 512 not owned
  Disable clock-controller@5ac90000 rsrc 102 not owned

  Starting kernel ...

Fixes: ba5a5615d54f ("arm64: dts: freescale: add initial support for colibri imx8x")

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index b0d6f632622c..49d105eb4769 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -769,3 +769,10 @@ pinctrl_wifi: wifigrp {
 		fsl,pins = <IMX8QXP_SCU_BOOT_MODE3_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20>;
 	};
 };
+
+/* Delete peripherals which are not present on SOC, but are defined in imx8-ss-*.dtsi */
+
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &dsp;
+/delete-node/ &dsp_lpcg;
-- 
2.34.1

