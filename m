Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564A16B04CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCHKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCHKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:40:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E929DE33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:40:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so836999wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XIMBXfDU/R4FYmgYxRTe35TNzbPerUdpZusJBGj0r4=;
        b=WPlJXNPq9weQmaEHgmjFJqNEIJhCryuLWGg9i1041Fjka8OA5GMo6pXBj1IJQlSiRL
         AbtBd0QcetWoI9Z+XqSO25tjY3EMAzWnaCfv0dDnCJZ2sb13NGnP7iO0aP1yW27pXs2G
         qfZIi37a1RXG89V9AU3wE1zP9EyIcHFIfqWxe49WgZCufesqr6Rkuso75qSSUTUurvfw
         b2btVOzU0TbmQFGKtRVTpCmFq6nAo+tGGottBBurUXU9BZ84CgZSqQvmu4LCM7neHPO3
         MNNn4qUHS1YoJwJVRDamckpDyQLH4ieTK1HWraR6U0EHHJDwurX6HcdmB9vWuYp63Q5m
         Bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XIMBXfDU/R4FYmgYxRTe35TNzbPerUdpZusJBGj0r4=;
        b=1jYyQHp+/9YuMEtE/uedB5FIPDP9PN+xTt1eqblhxm66Z4ud4qy7kB7krz7Q4C9ubh
         qvrQ5e4l8DlosRp03t0g1/DZeIoguS9aeCLM1ktgx1IxcQxt1b2NWVrTe/Vc8NybU75f
         XJxH95uMUhNgJhAJ5yHykfdjWCXDoPmMbb31fi7uOPyjcbZslGgefVkblFcxlAUOBzij
         fvRzHHFKppZl+ZKMyWypis0zEMYbts+LRujd5VuS3mE5J6j0eMDXkEeTXSxLXKMZ36ks
         e0TCUR3UNt7UvRNda58TP/aoTPqAhPMMw+Kcx0dk1axamifPruHHQy3RtzIzbC7L90ow
         0SHg==
X-Gm-Message-State: AO0yUKVdtGr//8rtNSZNLylCj7jXaR8xOUXOWInmny6zrmWvdrJVk3Ur
        yBJ8lptE8QPwoJJK1Bsgy8flRQ==
X-Google-Smtp-Source: AK7set/bQAmklfNm/duJj4RVLMLptZ+d6QumFEID2d6XQ4+C3YK3EZoh8a94Zl/N3Jhx336CdvE/Rg==
X-Received: by 2002:a05:600c:198e:b0:3eb:36fa:b78d with SMTP id t14-20020a05600c198e00b003eb36fab78dmr15272995wmq.23.1678272019563;
        Wed, 08 Mar 2023 02:40:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2326:fd4c:82e3:7e07])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm20664135wmn.27.2023.03.08.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:40:19 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 6/9] arm64: dts: qcom: sa8775p-ride: enable the SPI node
Date:   Wed,  8 Mar 2023 11:40:06 +0100
Message-Id: <20230308104009.260451-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308104009.260451-1-brgl@bgdev.pl>
References: <20230308104009.260451-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the SPI interface exposed on the sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 5fdce8279537..d01ca3a9ee37 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -14,6 +14,7 @@ / {
 	aliases {
 		serial0 = &uart10;
 		i2c18 = &i2c18;
+		spi16 = &spi16;
 	};
 
 	chosen {
@@ -40,12 +41,25 @@ &sleep_clk {
 	clock-frequency = <32764>;
 };
 
+&spi16 {
+	pinctrl-0 = <&qup_spi16_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &tlmm {
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
 	};
 
+	qup_spi16_default: qup-spi16-state {
+		pins = "gpio86", "gpio87", "gpio88", "gpio89";
+		function = "qup2_se2";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
 	qup_i2c18_default: qup-i2c18-state {
 		pins = "gpio95", "gpio96";
 		function = "qup2_se4";
-- 
2.37.2

