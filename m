Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283CD6994E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBPMxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjBPMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA434108F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so1737022wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIogKRRzvvWwQ7/eHJDt/djGpZ1c7yFgwcrwsrZf458=;
        b=J+wxzzIvy3SLx5uHZeAurDK49xfM4ZMZ71oGA0ct+axdfTCixeDRJ/gJI1ldH0KDb8
         dP1Ab39JNE9oUAYeKONjqtfou+Kfvkl4n44AK2HZRwIqK6SvQLjulxdsf9mR7fEnKeZN
         9I9E3HBvr+frfJrjf6r6nOT3pidTJWGLrjIwqkOCv6gEFUFxKEJktNLktYtdU/0z0xPm
         2+T0DcwafKEyAVjZPsynYuVE+7HRI9Tzo2xJB5CgVdffKNrtBkbPWpRhGagwZeb0UsoC
         77OTS9nRAoKwdmKjLND2D1PlCzrIocoKP4t0l/LnHhw6Sfb3b+BBZOeSvglNMFsRo6/m
         sMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIogKRRzvvWwQ7/eHJDt/djGpZ1c7yFgwcrwsrZf458=;
        b=BEcWJScRjlzZekjb4xhlPkWig5wEKDx9co6mezdJP5V/9OXl+y9QXZUtB0v3chtU6Y
         geRrtsT7qlWzNV1yXJytTefHTKq7lXr9lEELfwQWfh6adi7+AYxU9SESjhdfpzvuEqeX
         txLRnx9yC6DMI3A3U9SpDWAjhN11lgR2lXtScSdkkf9anF+wVOncraRBlSRKCgmi+Ixa
         Eo5UOPcE3A05j3MQonmszG6xJkl6kkAbu1EezjuBqJ7iUf0eOrfGfJ4SfwyxnJ6qraBW
         SfRCjTX2OiohC2Vpv7P/7d4XjbZly8Mjd1QMC8RywxgeZYOE/ft4Vl5XgYv1Q5c2vKMG
         hL4A==
X-Gm-Message-State: AO0yUKUBAv6pIsXFs1WPJZsR2lYu11ywo9gDarEV0GETptWqMBSBBZB0
        8UEHfx6C3UJzd7rASRs/qkmyFw==
X-Google-Smtp-Source: AK7set9wwRxBKGNwYz13e6m5zWdGawEX4n4g+z7sueqXd8C90zP0IAYETEusj8Q/LEYfLP4vjfm9Sw==
X-Received: by 2002:adf:f452:0:b0:2bf:e8f5:fd6e with SMTP id f18-20020adff452000000b002bfe8f5fd6emr4499162wrp.17.1676551983323;
        Thu, 16 Feb 2023 04:53:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 3/9] arm64: dts: qcom: sa8775p: add the i2c18 node
Date:   Thu, 16 Feb 2023 13:52:51 +0100
Message-Id: <20230216125257.112300-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216125257.112300-1-brgl@bgdev.pl>
References: <20230216125257.112300-1-brgl@bgdev.pl>
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

Add a disabled node for the I2C interface that's exposed on the
sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 894c0662afb4..4666e5341922 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -502,6 +502,27 @@ qupv3_id_2: geniqup@8c0000 {
 			clock-names = "m-ahb", "s-ahb";
 			iommus = <&apps_smmu 0x5a3 0x0>;
 			status = "disabled";
+
+			i2c18: i2c@890000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x890000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
+						 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0
+						 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
2.37.2

