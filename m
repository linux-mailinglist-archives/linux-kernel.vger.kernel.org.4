Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC372AE65
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFJT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFJT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:26:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F8270B;
        Sat, 10 Jun 2023 12:26:48 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77ac2eb07a3so136549039f.2;
        Sat, 10 Jun 2023 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686425208; x=1689017208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uulmumzfWaS24fz5Ie5uKr4WLizl9rXMt6vNsDfz7EE=;
        b=NkCihISg1izjma7B9HurTiLq7P7gp9GGFnDWcvjaNEEtCBfgyDhZ/crYtCCj9nLlL+
         HbArPZE4MeUZCFbtWk7URZW9QqHqmFIJhd06hhmSwXpbz0qBD8DRnb2UxWZ6yXfqlwCL
         VmWVJadvtw1y/nNjSieHnxxGI0wk/gWxnofV8SFSI6Clf2t4G9YQKg/25zUmj198AedN
         fJc2knC7+yD3Y7BtK8f25WTA833N4GaSoEASuys5/+unzdikNSk3FrK4Kv7PILEAEbIl
         TdL3tisQDARSz7h/hoaAfvNFICNDz+cSDwKBniNHN6nh3cTVDMxi5ncMia7ePlh3Usbf
         dg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686425208; x=1689017208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uulmumzfWaS24fz5Ie5uKr4WLizl9rXMt6vNsDfz7EE=;
        b=jJiECQb/jEE27tM/5AIm6z7MqJqrGC1qC+m8y0Q5CbsMqGkL2HWwCPmMQAMHpADBOT
         UNeoQoBGUsb0jzNvAmLn/AUqs76YtU6Lx2xQloXdOCsmLlPror0kv12/KFVJhVC4xydI
         OeQWTHnpSrMtZuH33jcKSA0RBdaCO7iRbVFIHd1L0W37YWbInG2rw16LcA/X9ogaPEkD
         5QsvLJvSqBLCmX8XDf0fKwaZ0aj1i5okNxBYbxBhtBZiXggwsQVGVtmUfH1O0dp+sz78
         abIbGqvnn6fjbA8jNBY7KbznwV5+6QP/iNS6nE/xjBaXyb8Je8Ajtrm0RzcUSCVujIBI
         REoQ==
X-Gm-Message-State: AC+VfDyxb+QlzjZhy1dMTIOqWeX5Le6J30QsJkAQlyz1MozUhmnwNxJ6
        O+2RDU8zogZwH3jUA5j8cyY=
X-Google-Smtp-Source: ACHHUZ7dOegi1CyLXwE+fNfCBgKzEimNbC2ZRaMPl9cs4O1phmtsCEWw1yfK9fhSuAMHL54v4Wg3eQ==
X-Received: by 2002:a05:6602:2759:b0:76c:6674:243b with SMTP id b25-20020a056602275900b0076c6674243bmr4348868ioe.15.1686425207639;
        Sat, 10 Jun 2023 12:26:47 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:7d74:3e3b:c016:e413])
        by smtp.gmail.com with ESMTPSA id a24-20020a6b6618000000b00752f62cd3bdsm1963834ioc.12.2023.06.10.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:26:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] arm64: dts: imx8mm-beacon: Change camera I2C address
Date:   Sat, 10 Jun 2023 14:26:35 -0500
Message-Id: <20230610192637.263600-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610192637.263600-1-aford173@gmail.com>
References: <20230610192637.263600-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI to HDMI bridge uses the address currently assigned to
the camera, so change the camera address to the alternative
address of 0x10 in preparation to enable the bridge.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index bc531175ff76..d5c6fc68d656 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -141,11 +141,11 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
-	camera@3c {
+	camera@10 {
 		compatible = "ovti,ov5640";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ov5640>;
-		reg = <0x3c>;
+		reg = <0x10>;
 		clocks = <&clk IMX8MM_CLK_CLKO1>;
 		clock-names = "xclk";
 		assigned-clocks = <&clk IMX8MM_CLK_CLKO1>;
-- 
2.39.2

