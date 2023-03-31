Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8217D6D2908
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjCaUAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjCaT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:59:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865791DFA5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v1so23578836wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680292776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T51w85qNGZ/wH1d68t5C4IE+YzS6I1k1IrcXjbzYMqE=;
        b=z59upxBH9VlBuY/hlmuYlAIN3ukfPRl0X+jMR2BPQpQBHGAsW5XK2K7cZBSo/eJUvx
         2vGjfZIYqN2LSuH/EbBbldGuJwdS4xX62ZKcEY8MNEJ57AP79h3LohWWRJuANyzxFmFf
         Dkgz3ew+pKfAQSda32nF1Qw0hgM6L6Iwoo1fEODS0e+BRMEw5eRr8/XWFbQXD2OsO5B5
         p05iCaavhDNJrqbMv/vPl0FXniYxI/pXMEqyhX0B6VqQseipt8Hgy9pBqiYzjb0sHGvv
         1mYIz7m1/2nUBiyEgQw5I+Q/WDw0D1AnxXMxrJ5QEYpxfpyKywcmMqGGP8MLZkXNtS8O
         tkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T51w85qNGZ/wH1d68t5C4IE+YzS6I1k1IrcXjbzYMqE=;
        b=Cjs6Xzue0ZLz+dMH57W5ePpJKRmlewilLzZ2utPBbaKRty3PWNfoMtFrsilXwxA08S
         Dand7vSYLUAR/Ovseck73Vu5MW7psn7EzrN6+Xh0qZ/lLzMhGR39g5NAuksMdbWjC1jj
         EagfHzyHcfdB7kGl3TW2RZ954no/fzcKsZ+XRmKUIBfuTOj/tr6x+ezpciLqGF+Q4LmH
         MXWbbQqOT1rW/T6JZ1WYDzH0jkXts088hy9p0ceFltVE87wVmY29n2JyQE+eXarlMbrZ
         g/kHsapeIcWSqoMwtKiec/COi8Hihli4kxjPjcA5vUdm6EL2MylnJw78hBjLNQ7SKpXV
         ciEQ==
X-Gm-Message-State: AAQBX9eFjm0BHan0zgFea6Sn4LIjGOL4xAIC/HB10FxNVOv2wivtJyut
        F1YUg37G58l0DPVs1dK75pzbfw==
X-Google-Smtp-Source: AKy350Zhy7Qpe3qgnCTosWHd18eYouna/DwThhMA1L/29rY6f8iHBVUSHTCA4Krfzcgilg01o61tBQ==
X-Received: by 2002:a5d:4a51:0:b0:2d3:33d4:1cfb with SMTP id v17-20020a5d4a51000000b002d333d41cfbmr21995080wrs.36.1680292776104;
        Fri, 31 Mar 2023 12:59:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1dc:d1f:e44f:2a1d])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b002cff0e213ddsm2990286wrt.14.2023.03.31.12.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:59:35 -0700 (PDT)
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
Subject: [PATCH 5/5] arm64: dts: qcom: sa8775p-ride: enable UFS
Date:   Fri, 31 Mar 2023 21:59:20 +0200
Message-Id: <20230331195920.582620-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230331195920.582620-1-brgl@bgdev.pl>
References: <20230331195920.582620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the UFS and its PHY on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index fdd229d232d1..e921093a9f08 100644
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
2.37.2

