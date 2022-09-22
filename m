Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB64B5E6C73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiIVT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiIVT5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:57:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3610D0F0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:57:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w8so16417971lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=adnw/70iR35kRw0Wjt+Tvx+wL5mop5CypxFcUPW7oIA=;
        b=BpqxE9ItlwUiXUv8kaKwd5NO9ITWdydQOedR5fOnb32t6UKyJ/S6B4EEfJMTbJ4e6h
         iVwL/D0Y6EX11zpqdKe0OieMXbcEyhNFaXob84KqNuM3YyObsZs91WRGlfxB4EBqSTGY
         edg8yJimYgfM5Pi1AdvUIRwq//mMPNePJ8jv9kbkfA3fmDItbMSswuzoEMDjViBMknSS
         Z/WaQrysyqxnnkvAm5UT0FYL2/0VUKc6G0dfEhKLppgpYcpX/B5NTHRIskm3fOwPnzyO
         vURF11AGKlcjwL9/mD3tPWAplsfAkpStiZXFK+oP45BKnkmI2nEAb8S5nLuK3YkYu9h8
         0sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=adnw/70iR35kRw0Wjt+Tvx+wL5mop5CypxFcUPW7oIA=;
        b=ZkSR4bWtPMNpPhEnSF0SLruaKaQTEIvVC7Ss2pjLUoaeN92BUAhEKrcbFkFP8oyj1Q
         boTTtdt6oqR5OTyA9uOvFo6tabVeAVqxnF8rtHHiRrO4kcdIoofFDBC8sWwOtp2t8boI
         ZztUyhii8wCtYVMNSqZpTOS6rxYZ8bMIe0qASltuVxzZmlwR9x2FfIO3lUBZa+Tf4ScI
         sEtZNf59eF/NWYZWxBs2jb8y1LAI5vP5rnIEHWj+pDib+hPmYcHslf1zm7Sv6XWIyaiG
         zL0w/585PGolQD6V059RZD3/gn8pCuUafSSLa6Cys8Rk1Kn9Wm5zdznBD6hMBRcGuWCA
         JJ/w==
X-Gm-Message-State: ACrzQf3nscIP7bsGyZoICSaQXKNekq9V0H1BhIVdQyjzkngB2ibCg2+o
        Rz+8/TFAhgOzncWko0mS0RADdw==
X-Google-Smtp-Source: AMsMyM7o6+0RwzlMM2SwkWERkarFeg309xO1vAEp9DohhQp6lsYJfOfvl/2lQj5z+TifA9h5hkOmJA==
X-Received: by 2002:a05:6512:3b22:b0:49a:d302:ae04 with SMTP id f34-20020a0565123b2200b0049ad302ae04mr1992785lfv.72.1663876629769;
        Thu, 22 Sep 2022 12:57:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x15-20020a19e00f000000b00498fc3d4d15sm1079375lfg.190.2022.09.22.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:57:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/12] arm64: dts: qcom: sc7280: align LPASS pin configuration with DT schema
Date:   Thu, 22 Sep 2022 21:56:49 +0200
Message-Id: <20220922195651.345369-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects LPASS pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8823b75a6f1b..28e3fb9992d9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2432,82 +2432,82 @@ lpass_tlmm: pinctrl@33c0000 {
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 15>;
 
-			lpass_dmic01_clk: dmic01-clk {
+			lpass_dmic01_clk: dmic01-clk-state {
 				pins = "gpio6";
 				function = "dmic1_clk";
 			};
 
-			lpass_dmic01_clk_sleep: dmic01-clk-sleep {
+			lpass_dmic01_clk_sleep: dmic01-clk-sleep-state {
 				pins = "gpio6";
 				function = "dmic1_clk";
 			};
 
-			lpass_dmic01_data: dmic01-data {
+			lpass_dmic01_data: dmic01-data-state {
 				pins = "gpio7";
 				function = "dmic1_data";
 			};
 
-			lpass_dmic01_data_sleep: dmic01-data-sleep {
+			lpass_dmic01_data_sleep: dmic01-data-sleep-state {
 				pins = "gpio7";
 				function = "dmic1_data";
 			};
 
-			lpass_dmic23_clk: dmic23-clk {
+			lpass_dmic23_clk: dmic23-clk-state {
 				pins = "gpio8";
 				function = "dmic2_clk";
 			};
 
-			lpass_dmic23_clk_sleep: dmic23-clk-sleep {
+			lpass_dmic23_clk_sleep: dmic23-clk-sleep-state {
 				pins = "gpio8";
 				function = "dmic2_clk";
 			};
 
-			lpass_dmic23_data: dmic23-data {
+			lpass_dmic23_data: dmic23-data-state {
 				pins = "gpio9";
 				function = "dmic2_data";
 			};
 
-			lpass_dmic23_data_sleep: dmic23-data-sleep {
+			lpass_dmic23_data_sleep: dmic23-data-sleep-state {
 				pins = "gpio9";
 				function = "dmic2_data";
 			};
 
-			lpass_rx_swr_clk: rx-swr-clk {
+			lpass_rx_swr_clk: rx-swr-clk-state {
 				pins = "gpio3";
 				function = "swr_rx_clk";
 			};
 
-			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep {
+			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep-state {
 				pins = "gpio3";
 				function = "swr_rx_clk";
 			};
 
-			lpass_rx_swr_data: rx-swr-data {
+			lpass_rx_swr_data: rx-swr-data-state {
 				pins = "gpio4", "gpio5";
 				function = "swr_rx_data";
 			};
 
-			lpass_rx_swr_data_sleep: rx-swr-data-sleep {
+			lpass_rx_swr_data_sleep: rx-swr-data-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "swr_rx_data";
 			};
 
-			lpass_tx_swr_clk: tx-swr-clk {
+			lpass_tx_swr_clk: tx-swr-clk-state {
 				pins = "gpio0";
 				function = "swr_tx_clk";
 			};
 
-			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep {
+			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep-state {
 				pins = "gpio0";
 				function = "swr_tx_clk";
 			};
 
-			lpass_tx_swr_data: tx-swr-data {
+			lpass_tx_swr_data: tx-swr-data-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
 			};
 
-			lpass_tx_swr_data_sleep: tx-swr-data-sleep {
+			lpass_tx_swr_data_sleep: tx-swr-data-sleep-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
 			};
-- 
2.34.1

