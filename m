Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA05F787E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJGNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJGM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF1318B38;
        Fri,  7 Oct 2022 05:59:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u10so7206718wrq.2;
        Fri, 07 Oct 2022 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVLrACcSKUPhaj5dkzpeft8dc3na+SzUoUyCH0CxQdc=;
        b=DyWFQsu7X3KCZe7cMwk7WfNuPX+E6P4ASu1VzPNNmhee/7D0jcse1/z8KqM/eThL32
         x7YhJ3rWXGy/Zz4Y7Gb4ZsDLTyK+8JUVL28uDjBzqS+axCNJmKnD8PTId3Ydbc4rNmjl
         uuwmT2tQ2woLJtAQpACaMr+cMgcLNBCZ3SwARjA2HsXWGOThUfV34kai+F4PljJ3XxLd
         0BnfegdCnrVBJVUmdU6KzNa3MjKZXtsJhOifMoAFhFv52dukVxu/hwu1tYsXxRVi/Ail
         NpB44KgwNCxHPc4dS7ob4IFkLB/Tnznoob/hSDQImfoQG7OxizdKhfciFumeBLkmUUrW
         pWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVLrACcSKUPhaj5dkzpeft8dc3na+SzUoUyCH0CxQdc=;
        b=unBnrVeld4yoGt3rSWgtu6GOo5NPZ2IlOXt5snbZQvfue9b+UdCP0ZpakSP5FnIFSr
         CCIJvlpET/D9LQg749K42JnAW1bjMZluzAmabLB2jcyhpzftZfl2VR0tHInPhCyrhBOu
         +nTJgSpuW2z8bn3DRj81GbMEzzsBMiMNCOkAJFHcANcBNnyRnuih5iBNLbpXptTjot5A
         q3LPCv/II8iM2UcfK/NRO2u1GMp/5Q21XZfik2U8bQw5BeT+QG+zwDU0JNX5v38Bs0Fh
         HrxmkyMUZmgaUoRibJB2Y4mlNwslKuxyMiVJADM3gTErT7En8C1SBnGoKG+HOnyegWGF
         SeXw==
X-Gm-Message-State: ACrzQf2AyEAq1182PyFu2L7w51lzI4mGN6ycxB/RwtKfHyf+mafHHVx8
        SmwEqZdSLB4JaQ6YTV7f4Lc=
X-Google-Smtp-Source: AMsMyM4UqKaqiRWCIrUoQV9U1D8DCBnEWwXVW8JC5m1oy3ts9Y/S2543eendEL5h/L/kDtbdhy4EJw==
X-Received: by 2002:adf:ec03:0:b0:22e:4d3:bb37 with SMTP id x3-20020adfec03000000b0022e04d3bb37mr3123892wrn.665.1665147587543;
        Fri, 07 Oct 2022 05:59:47 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:47 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] arm64: dts: mediatek: mt6797: Make pin configuration nodes follow DT bindings
Date:   Fri,  7 Oct 2022 15:59:01 +0300
Message-Id: <20221007125904.55371-8-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add -pins suffix to pin configuration nodes to follow DT bindings
and pass dtbs_check.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 15616231022a..0c2b477184ae 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -135,70 +135,70 @@ pio: pinctrl@10005000 {
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		uart0_pins_a: uart0 {
+		uart0_pins_a: uart0-pins {
 			pins0 {
 				pinmux = <MT6797_GPIO234__FUNC_UTXD0>,
 					 <MT6797_GPIO235__FUNC_URXD0>;
 			};
 		};
 
-		uart1_pins_a: uart1 {
+		uart1_pins_a: uart1-pins {
 			pins1 {
 				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
 					 <MT6797_GPIO233__FUNC_UTXD1>;
 			};
 		};
 
-		i2c0_pins_a: i2c0 {
+		i2c0_pins_a: i2c0-pins {
 			pins0 {
 				pinmux = <MT6797_GPIO37__FUNC_SCL0_0>,
 					 <MT6797_GPIO38__FUNC_SDA0_0>;
 			};
 		};
 
-		i2c1_pins_a: i2c1 {
+		i2c1_pins_a: i2c1-pins {
 			pins1 {
 				pinmux = <MT6797_GPIO55__FUNC_SCL1_0>,
 					 <MT6797_GPIO56__FUNC_SDA1_0>;
 			};
 		};
 
-		i2c2_pins_a: i2c2 {
+		i2c2_pins_a: i2c2-pins {
 			pins2 {
 				pinmux = <MT6797_GPIO96__FUNC_SCL2_0>,
 					 <MT6797_GPIO95__FUNC_SDA2_0>;
 			};
 		};
 
-		i2c3_pins_a: i2c3 {
+		i2c3_pins_a: i2c3-pins {
 			pins3 {
 				pinmux = <MT6797_GPIO75__FUNC_SDA3_0>,
 					 <MT6797_GPIO74__FUNC_SCL3_0>;
 			};
 		};
 
-		i2c4_pins_a: i2c4 {
+		i2c4_pins_a: i2c4-pins {
 			pins4 {
 				pinmux = <MT6797_GPIO238__FUNC_SDA4_0>,
 					 <MT6797_GPIO239__FUNC_SCL4_0>;
 			};
 		};
 
-		i2c5_pins_a: i2c5 {
+		i2c5_pins_a: i2c5-pins {
 			pins5 {
 				pinmux = <MT6797_GPIO240__FUNC_SDA5_0>,
 					 <MT6797_GPIO241__FUNC_SCL5_0>;
 			};
 		};
 
-		i2c6_pins_a: i2c6 {
+		i2c6_pins_a: i2c6-pins {
 			pins6 {
 				pinmux = <MT6797_GPIO152__FUNC_SDA6_0>,
 					 <MT6797_GPIO151__FUNC_SCL6_0>;
 			};
 		};
 
-		i2c7_pins_a: i2c7 {
+		i2c7_pins_a: i2c7-pins {
 			pins7 {
 				pinmux = <MT6797_GPIO154__FUNC_SDA7_0>,
 					 <MT6797_GPIO153__FUNC_SCL7_0>;
-- 
2.38.0

