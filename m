Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E860F051
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiJ0Gbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiJ0GbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:31:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED401633AA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:31:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5340435pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJD9pg+8d3gbB5bhYEtgXKZfAldyXXkDaqxLrNjRHCg=;
        b=Wc3M/xJxsntnV3zSr730T95omcsJ7gxCjGaRYgqi0yGZMppK6QRd2RruLsgTky4edm
         9s3hAjv7LR1fAFwIoLNU677Zfi3ACcDaTbLfUJ5uqkUlosSLpYgySR57eTf6DCYE3c5G
         xLZAa1miqqkxjTgmZcbKq3CPw8jC+m0m8edrar47c8kJZpZgaVeKpevINh1GYQMZoL+c
         g4kiLZDtHNlT27yXKuI9Ys3eKqcxZUXfQnVKE2FHggb9MOd+Udfe9wE71UucuO1ch3TU
         XqPdEc6PwBnnm8lmebmyq83lM15xZVrvdHPlTMSAqt64QTl+j1Lu7c+CVLf63X+yS36U
         Dipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJD9pg+8d3gbB5bhYEtgXKZfAldyXXkDaqxLrNjRHCg=;
        b=oLnN/eagvbSRuaBMiYLIAPjWoT015XkAFN4HfTBOonGtcEJVex4hWrSY7hyhz6CTuQ
         G947p/pmskvS/QKp16dj8lVWZI7C72AjLHz2gvSjMuaxAWTAUHa32ilB4gGrEssJduFz
         7P+w3Z9VprARTkBd5zXvpR9jEcRtEDdvK03Vp9Vp4bzgFkJ3zYZg1O7+ZekmBuI1APlm
         3ocTzM02JgzsCu8lJkwC7XA/deH2kyABsoU3py++zSv1p6UJSvDeAFveCCQn6lnwUZoE
         /JzZz6hLYrS9JNjnTWGFo+AbwC7EhyBgxZy4k6+yCzy3KN4Ofr+LrlNmItKadJZKMbmf
         0h8Q==
X-Gm-Message-State: ACrzQf1n1a3p1irJC1LZRWomgwPVxeVkjENUJtWZykV86/eIzikxRM6N
        eSw++M2oQgEiKnEEsaHqs5R0sWhtw5fp3uE=
X-Google-Smtp-Source: AMsMyM4Ae7muS29NvHlJAXpdQKUmEBj3L+1jpX7k7qk6MlBh1xSzP7RawSsA8G2OlzK+jmU2WXEDFw==
X-Received: by 2002:a17:902:ef4f:b0:186:6723:8da5 with SMTP id e15-20020a170902ef4f00b0018667238da5mr35911254plx.6.1666852254627;
        Wed, 26 Oct 2022 23:30:54 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.123])
        by smtp.gmail.com with ESMTPSA id i126-20020a626d84000000b00561d79f1064sm446041pfc.57.2022.10.26.23.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:30:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/11] arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC channels
Date:   Thu, 27 Oct 2022 12:00:03 +0530
Message-Id: <20221027063006.9056-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
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

Add VADC channels for measuring the on-chip die temperature and external
crystal osciallator temperature of PMK8280.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 6aa8cf6d9776..9ac5d5c22832 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -173,6 +174,23 @@ &pmk8280_pon_resin {
 	status = "okay";
 };
 
+&pmk8280_vadc {
+	status = "okay";
+
+	pmk8280-die-temp@3 {
+		reg = <PMK8350_ADC7_DIE_TEMP>;
+		label = "pmk8280_die_temp";
+		qcom,pre-scaling = <1 1>;
+	};
+
+	pmk8280-xo-therm@44 {
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		label = "pmk8280_xo_therm";
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.25.1

