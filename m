Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B69713929
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE1LXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjE1LXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:23:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A093B8;
        Sun, 28 May 2023 04:23:10 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33b4b70693eso4126215ab.1;
        Sun, 28 May 2023 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685272989; x=1687864989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOnckt3TDA0cJhfLkMg+Ow7ExAuQl0k8N7Xk1jU8+tk=;
        b=EhcvTs2XdJPtaGPgFhLx2frzEfGElw/s/i4x1WmO6JFNiJdEkHUmX4VtC3RXuXiSgv
         lDTz8TqFVCJQh+UPePWXCY1fdKxngzg/tvS2ahUqRgJI1EfqMM48LgkKV7naFMUw89jh
         MnF2/Xuiw0Vy7WPdo2ao2xoDj0QgQh3KTEbpPfLJa/RPbAS3Z2+EOff2KB4W9sYYYOFP
         XPFsbJKWCEVI4dbfzlvOHuEXWSG2Amr0sRR+3lxS7TEH8bR7BDMwi+gb3ZZnhdx25LYi
         cx++gK/h41NYhbQKPwfJ628nMaBngnDyRARAZyXrrE/d2uqIH9Sc0tSforYXRcvegOXy
         62aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685272989; x=1687864989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOnckt3TDA0cJhfLkMg+Ow7ExAuQl0k8N7Xk1jU8+tk=;
        b=cTIPvufalWxd/zcQxUFBPNDLP5m80V+FVQHfaGP3nF4KHVOKmA0n8DEULngzawQmw2
         nXoZ59S9dRRJBqn1/ShGswI7oIt8odqRO0NOOIWPE0q40LTXg/OknG4Rp52MY6JXFgHw
         +83b6SKqOz62MzCAU+twHvl05U4aL28ZES6O2RKmqV4n8L2S/J1VbPRbVKY7WOk4bzrm
         slP/WAXUO5SYU9XmCQdiTJN48Gs9AzSVnL/L1UMZceWzoO4qBGOjiaW3N5PGBCGGHT38
         ASVtOmIpIJRelIbdqPrbpHhEJrxUN7IgneNM1LOz61mFqZjtLkS73hwOiNJ72rJsmMX/
         l41g==
X-Gm-Message-State: AC+VfDw9buZSYdnTO4XRlZd1aew1WVyr88h2DkM096jcT6xIwi01MfmN
        aRlx0ngVONRypJT9lwTs10Y=
X-Google-Smtp-Source: ACHHUZ4t6+r6sJOXXmfo1iv9eFOsmMbJvKUtnhH7T1HqGVKvPE+EJyIKaTPtJIR6HZREN7O2TzwsHg==
X-Received: by 2002:a05:6e02:5c2:b0:338:9bf3:467e with SMTP id l2-20020a056e0205c200b003389bf3467emr4902824ils.22.1685272989283;
        Sun, 28 May 2023 04:23:09 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2abe:81ec:481:190b])
        by smtp.gmail.com with ESMTPSA id n40-20020a027168000000b004178754b24bsm2305814jaf.166.2023.05.28.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 04:23:08 -0700 (PDT)
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
Subject: [PATCH V2 2/2] arm64: dts: imx8mn-beacon: Fix SPI CS pinmux
Date:   Sun, 28 May 2023 06:22:54 -0500
Message-Id: <20230528112254.2634028-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230528112254.2634028-1-aford173@gmail.com>
References: <20230528112254.2634028-1-aford173@gmail.com>
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

The final production baseboard had a different chip select than
earlier prototype boards.  When the newer board was released,
the SPI stopped working because the wrong pin was used in the device
tree and conflicted with the UART RTS. Fix the pinmux for
production boards.

Fixes: 36ca3c8ccb53 ("arm64: dts: imx: Add Beacon i.MX8M Nano development kit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 038ef8a3e604..16761975f56e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -104,7 +104,7 @@ simple-audio-card,codec {
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
@@ -273,7 +273,7 @@ pinctrl_espi2: espi2grp {
 			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
 			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
 			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x41
 		>;
 	};
 
-- 
2.39.2

