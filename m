Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2463EB56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLAImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiLAImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:42:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F260C8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:42:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f9so1068138pgf.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sbFnIzF7qvR5A534InqCHDBcQlt3cOWkJpUNrDM5kY=;
        b=XDENRWACJueRJJLfr0sZFDJNEVniluetT+EiqOGJ2elV26Aly+mIXeq2OITr5R9kxX
         axPog3rAomaLwvpSkndt+RwSLx2DEPNBuTXQRA38Q0TNG0wjPk9RLElkHAwIgUPgZ+ad
         hJxEa3TL9a97p3SZ8flTXNyyFpZ+zkV7xN/Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sbFnIzF7qvR5A534InqCHDBcQlt3cOWkJpUNrDM5kY=;
        b=sDcJNb+NkVdl9Fdhrn1pVKGa0UP3GyM5JY8jUuGfuPUiGKWrc2JkQ1jG9NRcYTcDha
         qMt6XuXFCdmX5X+XPg9c3pQ4zuzw9PfdkMSuKAKom78vT//5JWEf6ObdkZsf91pC6pw/
         BdTYiG/kRxQwE3SR3Yp6gxT5jc13WwtDrum/6roqdM7ZoFr+WW6g2bMv3ZUQQaXexXrP
         HZ8spI+CTVBw4Hnrh80Z9R/ych8GpdZ4r6pfMiXOjxEVXqa/dMGTZiMNfXmI6FyWGenW
         9jHKMMK90Y2hwKY9YpC0h5977H5MMgVuDTIXIfc1yNa8mGeuVo35SQdweEdEpEp7q/K8
         Pu0A==
X-Gm-Message-State: ANoB5plBOHkrGDtpCTSMB2MoGGCVPpsU45hTq6lWtfBwGpi4XyIGKwTz
        2PsDS5w8284Sw4b7OPU038XrGg==
X-Google-Smtp-Source: AA0mqf5rTcAjwUigYrgSRA+tffO2tIneJKwa7IosCaE5clajLMjwbQEUOGwXTJG+yg8z36bdvgBRbw==
X-Received: by 2002:a63:f962:0:b0:477:1bb8:bbf4 with SMTP id q34-20020a63f962000000b004771bb8bbf4mr40359999pgk.19.1669884156715;
        Thu, 01 Dec 2022 00:42:36 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2416:fa4e:4eeb:fcde])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902690500b001708c4ebbaesm2932293plk.309.2022.12.01.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:42:36 -0800 (PST)
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
Subject: [PATCH 1/4] arm64: dts: mediatek: mt8183: Fix systimer 13 MHz clock description
Date:   Thu,  1 Dec 2022 16:42:26 +0800
Message-Id: <20221201084229.3464449-2-wenst@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221201084229.3464449-1-wenst@chromium.org>
References: <20221201084229.3464449-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The systimer block derives its 13 MHz clock by dividing the main 26 MHz
oscillator clock by 2 internally, not through the TOPCKGEN clock
controller.

On the MT8183 this divider is set either by power-on-reset or by the
bootloader. The bootloader may then make the divider unconfigurable to,
but can be read out by, the operating system.

Making the systimer block take the 26 MHz clock directly requires
changing the implementations. As an ABI compatible fix, change the
input clock of the systimer block a fixed factor divide-by-2 clock
that takes the 26 MHz oscillator as its input.

Fixes: 5bc8e2875ffb ("arm64: dts: mt8183: add systimer0 device node")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 19ff1babc359..0cbbaebe1213 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -585,6 +585,15 @@ psci {
 		method = "smc";
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
 	clk26m: oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -968,8 +977,7 @@ systimer: timer@10017000 {
 				     "mediatek,mt6765-timer";
 			reg = <0 0x10017000 0 0x1000>;
 			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&topckgen CLK_TOP_CLK13M>;
-			clock-names = "clk13m";
+			clocks = <&clk13m>;
 		};
 
 		iommu: iommu@10205000 {
-- 
2.38.1.584.g0f3c55d4c2-goog

