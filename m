Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14FE7029A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbjEOJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbjEOJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:53:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A810213E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:53:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42711865eso54542255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684144398; x=1686736398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF3XkLBwI40S/PU9ejyV181Dxd0FTXS0tCrPDFNZWw8=;
        b=2koQ2vUev6nnT9WLRCMxh+WRwGFkhcxicv8aXQ5frMIF690ia81CU1JgsTQBSiuQGi
         XYeL3yHaAMgmAz2zijsWoNog6LG3sM7zzhodD+NjfxoA+8R52uURmeb5D9plHHJwJj4D
         33+nTMEPapr8zJ3bgr4P0GyE3grxnR94oz1THlRvpzZ+tpN+mE85j5flqv+QO0HmPLG0
         qL5TS4oBzYYD5/GQvFcoNbyM0Zbf5BpkzaDF0gCqfh8sh2DkWteikYCAMKo0Bq712t/S
         rjrMq6v88TZPrT7/oNifiKiynyEE2maaKer2iL3vHptU3U2IRL1wDDJFDUbEHL+oMULc
         /sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144398; x=1686736398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF3XkLBwI40S/PU9ejyV181Dxd0FTXS0tCrPDFNZWw8=;
        b=ix3z5i5N9+RMteI4bgIuK6sLt0XBiKM0PgRQ7thbaI5Uw/AtXKXuoen/bWY42ZOoGQ
         9L/aHUONPTgX47E5SJmK0Ky+cpBNR4KWeGYDS/XZ/t33ZPrgXXEK45tW+Vxib4TwIR66
         VpQQBTQJ0fZ5nVgbkV1GNwLq5/E8QLJg2z3yQ2ctOiTWcBtlZRCCgbKX0A2X60b9JSyC
         adQsb3YnXZ8Lxej0eT7fPHBge93ebBSGyBlH8F7O/fJsJWM0CfpJtEd6X3EHrYJhyiBM
         477GGypn/iNlTHk4HoFvJjRYN6Uq1mjvb9VkSlpvP8zH8psaTrvM1z1gWyrHNTI1v0iL
         /5JQ==
X-Gm-Message-State: AC+VfDyv0x79aMM6UUTsehOghrnVieXWbtDXqP/QIlCSDAA3f6q4NkNO
        AFWjWnHCAmnnfiYjrSSf45S5Fw==
X-Google-Smtp-Source: ACHHUZ6/EFQHWjmlZKJCfseGGjnzM5u+JTURpLnr9cYBu2urf4sHoKHI0ilYDnqqWOum8LdrphrCmw==
X-Received: by 2002:a5d:6ac5:0:b0:306:3429:1833 with SMTP id u5-20020a5d6ac5000000b0030634291833mr24319445wrw.46.1684144398617;
        Mon, 15 May 2023 02:53:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1388:9f6:c7d9:3b77])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b0030795b2be15sm24228443wrx.103.2023.05.15.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:53:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 3/3] arm64: dts: qcom: sa8775p-ride: enable UFS
Date:   Mon, 15 May 2023 11:53:08 +0200
Message-Id: <20230515095308.183424-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515095308.183424-1-brgl@bgdev.pl>
References: <20230515095308.183424-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the UFS and its PHY on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index f238a02a5448..2bb001a3ea55 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sa8775p.dtsi"
@@ -20,6 +21,7 @@ aliases {
 		serial2 = &uart17;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
+		ufshc1 = &ufs_mem_hc;
 	};
 
 	chosen {
@@ -426,6 +428,23 @@ &uart17 {
 	status = "okay";
 };
 
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l8a>;
+	vcc-max-microamp = <1100000>;
+	vccq-supply = <&vreg_l4c>;
+	vccq-max-microamp = <1200000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
-- 
2.39.2

