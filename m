Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AC6DDBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDKNFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjDKNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:05:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80546A4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:04:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so5724672wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681218295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC6gWh/93zTyDqTCTM2LE5tDkTpbOI5ydojvv7gVZxA=;
        b=FFCPUtV2Lhbi5fQvjeIDIR8Qg/uJ/rl9m+UeCwBQTVM4lkw1j9B+ZpUeZ6gDN9B0uS
         5KYFuGOrfu30VupuAu3H3BT4zFFj2fo4YnCOMS94hGmzRtWbUaevbONsQYJhFZ2K4P9X
         L/nKMZc4qzDqDbJSKMCbVwiT74/tyLf1IDhYwNoVGTBX3FfTleMUmDJ+X3a0/Ds+fXw8
         6hXszRubOP119xDL6FbpP8/1iwy5ixar/TfWolzTcqPXDIGuUrUteyXffTqCwC/E32e0
         flTv2fTqn2e4oht+v5shjskCYLvSETVjg+KpbnXDFJtk3DRy0oV4jCvdM/AIo9b0kCt8
         xDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jC6gWh/93zTyDqTCTM2LE5tDkTpbOI5ydojvv7gVZxA=;
        b=qiwJYfuB5pPFPdT+VwIzLbznt4AQNZnIwxAKkia1kBkUUNXN3R/PEjxmbyMcdLNml3
         3dO/e+xt09ak5ZVgjFVWU3U7zNpOntPtZYL3dlOfDhL/ov6jiF78byup9zHVfDCtoY5t
         q3Hys9tK9OuUSYsprER6who8bB26HcG8uuBlzBjtQFpr70ccf16W+NqQcaQL0LtRsRY0
         N4mSIXTVRRvTEthsGTAM0O8jaP7nb++AQfJR83qsIAzkEw1p9iyK7JOfHyE1+WMrC7oh
         FhfiwH3l/btNji5GRAIXbxnF4laPKrbKABgHCBelleIOBnMBTFltTvuh9St/gc2Bv5MJ
         bmCg==
X-Gm-Message-State: AAQBX9eE7NlR93odUXa5TShzI7IA7Bnryzf0ln3bouQ5JNJKEmvVntaS
        TgM08Vy4KDmZh4Aev1zUH250MQ==
X-Google-Smtp-Source: AKy350Z92G2IhtFFM8sPmnrWvnbsC166u3rxSYJBKLJmnUOC9WEFR1kTpLmES+RFg8ATH3kOBYYeCQ==
X-Received: by 2002:a7b:c419:0:b0:3eb:2e32:72c3 with SMTP id k25-20020a7bc419000000b003eb2e3272c3mr10768600wmi.22.1681218294957;
        Tue, 11 Apr 2023 06:04:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id t6-20020a7bc3c6000000b003f04646838esm16921301wmj.39.2023.04.11.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:04:54 -0700 (PDT)
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
Subject: [PATCH v3 5/5] arm64: dts: qcom: sa8775p-ride: enable UFS
Date:   Tue, 11 Apr 2023 15:04:46 +0200
Message-Id: <20230411130446.401440-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411130446.401440-1-brgl@bgdev.pl>
References: <20230411130446.401440-1-brgl@bgdev.pl>
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
2.37.2

