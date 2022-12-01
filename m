Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5C63EB5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLAImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLAImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:42:44 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD72BC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:42:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q1so1055515pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEDSSsGGM8AAJ08Auy3dp0LttRqfjGQgPHRv4DynzpI=;
        b=JHG3IJ5JSznG6iCGYmm3FiA0E7POVkCHlHG7XLvYJlBlS8s4Ba6MxkQ6SeLKll4P9l
         ccNoLbhVbNntAuDvg+izoM0R3lAP89T5vwxqu97HmlQ/7dTSiDe7Um1JCRJCC8bohxjn
         cnEn91GHN9Ac1Iio8VqHyRJc+wFgln0Zwh40M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEDSSsGGM8AAJ08Auy3dp0LttRqfjGQgPHRv4DynzpI=;
        b=xlk/vE80iMc3XScuT+cEPNqbk91MRr/vXNwjlbJz+e0D6pbVGTpa6SZNFsSr4klcbo
         p6nTcmp6uKpp06eZG8qwdORfFD++dyUKsR9pAnh0+yY+SW/b3fKqwgBCL/qFTz//Ba23
         pTh5/JTrUlnmvcAI5vntmRkBCD+XT7kxgCmbfdasZZ55z3CwRh1jsN5VQDveOqFQzxQ+
         EUf4J6jMsxGunthmnKsCnILGPI5SJngPsElp3NoAo/cwqEOIPwS9ueuDYDP9puPIGdaQ
         255ufpI1oXaOxo+RoEInGJdyCCISgo04JJzLT4n/lH840d3uhDpqoWwPdyl1aGXrTKsu
         Fztw==
X-Gm-Message-State: ANoB5pm7DfyAJ4Ti8Z8kIdhbr+Fq3OGwI6213iz6JqWINAqXMsaDXXoh
        KaKuwrHYiC07MJp1ZnFbgZh4iA==
X-Google-Smtp-Source: AA0mqf7FyYTwcmw9tGrsj+b4l/tHPqvoUEIpnviYSG3/NSB7K4eKIhAfRVx7XgZPfbPoxY9gp0nx0g==
X-Received: by 2002:a63:da10:0:b0:477:ccac:6eb5 with SMTP id c16-20020a63da10000000b00477ccac6eb5mr30861853pgh.41.1669884161760;
        Thu, 01 Dec 2022 00:42:41 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2416:fa4e:4eeb:fcde])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902690500b001708c4ebbaesm2932293plk.309.2022.12.01.00.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:42:41 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8195: Fix systimer 13 MHz clock description
Date:   Thu,  1 Dec 2022 16:42:28 +0800
Message-Id: <20221201084229.3464449-4-wenst@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221201084229.3464449-1-wenst@chromium.org>
References: <20221201084229.3464449-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The systimer block derives its 13 MHz clock by dividing the main 26 MHz
oscillator clock by 2 internally, not through the TOPCKGEN clock
controller.

On the MT8195 this divider is set either by power-on-reset or by the
bootloader. The bootloader may then make the divider unconfigurable to,
but can be read out by, the operating system.

Making the systimer block take the 26 MHz clock directly requires
changing the implementations. As an ABI compatible fix, change the
input clock of the systimer block a fixed factor divide-by-2 clock
that takes the 26 MHz oscillator as its input.

Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c48..60e15833956e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -248,6 +248,15 @@ sound: mt8195-sound {
 		status = "disabled";
 	};
 
+	clk13m: fixed-factor-clock-13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "clk13m";
+	};
+
 	clk26m: oscillator-26m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -705,7 +714,7 @@ systimer: timer@10017000 {
 				     "mediatek,mt6765-timer";
 			reg = <0 0x10017000 0 0x1000>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&topckgen CLK_TOP_CLK26M_D2>;
+			clocks = <&clk13m>;
 		};
 
 		pwrap: pwrap@10024000 {
-- 
2.38.1.584.g0f3c55d4c2-goog

