Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE46B21A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCIKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCIKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:38:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4697410A85
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:38:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l25so1375273wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678358281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1bukp9ZasDpBqQmQkWmR1O8qeMiBN3BNf0JM86ADpU=;
        b=AtrkVf1AJ9fU+tdNfw4J6JfsSl9Dyl1HqO2GLW0pSE1YJMH9hmy5twfY2Os8fTqt55
         vccsgXGppd1GEUvQkkfrbippJQuv0Qc18iIISzZvT7YAQyRWuAhOPCYOWQ9skEg7Hxo9
         yxzxXkhjGbDTcbYHPdHTnY05UfyDJr/BktTy99LqLotBCg5VgH03tnTZLpl0y0fMxnL7
         wkRgs9hjyo9NqHg8S+sispVAOG07szsWEeHfz2j2SRPVrTyerOz4duw1n42kxP0kYPpR
         jWNiCQ9pRh0Cvdm/EEaJacJV01z8EbchKUXUkhUA2MUGOgAstq3aBWas4DGqT7EToX4w
         Fodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1bukp9ZasDpBqQmQkWmR1O8qeMiBN3BNf0JM86ADpU=;
        b=F6/SLHIwEHRl6Hj9wZs8jXxunhZLDMf63daUxeScOEU71NNFeQ55mHqv3vOpotQjED
         OqbNpQAmiCAfKxrG2jh4NwRXfKZN5PZ/LmdWk9jpPLDtuFNmYTeDDSJtlv7nB3BctQR3
         3xHW/xZXYH0QvqpxYgFKpbgYJXrjHqlTvZkHfsWMlKvMqy7QpicHhDmxekzci5G8TK4i
         W2DBuoGnkBT7dSuINa3MvS1bvUvu/XbCwVlLvwdUJf6IXSLZfdZakKROZXRwfT+fUaD9
         IMAvKeAqnUGpDbaY/0sGQ5/QVXZaYopIHxWe0OWoZoeMq8zn7Ro0bP1rTFMQcIgYJ75u
         gptg==
X-Gm-Message-State: AO0yUKWEgzuUwQCk29GSAXshD1DvQOga14n1XrEtkddLihAwCYtR+JZD
        UUk0EVqkz3vF8tyjeyLNof2RRA==
X-Google-Smtp-Source: AK7set/vQttsC61gT9nysE1ZMwIeaZBBtaDMepgFuKjtYEqjlV4jcMyeZwX3p2MEJViiVvWpG5faFA==
X-Received: by 2002:a5d:4486:0:b0:2cb:9d29:7242 with SMTP id j6-20020a5d4486000000b002cb9d297242mr14280623wrq.27.1678358280789;
        Thu, 09 Mar 2023 02:38:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f14c:2275:50fc:c056])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm17638119wrd.35.2023.03.09.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:38:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 5/9] arm64: dts: qcom: sa8775p: add the spi16 node
Date:   Thu,  9 Mar 2023 11:37:48 +0100
Message-Id: <20230309103752.173541-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230309103752.173541-1-brgl@bgdev.pl>
References: <20230309103752.173541-1-brgl@bgdev.pl>
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

Add the SPI controller node for the interface exposed on the sa8775p-ride
development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index e7ed309fc04f..d1b2a6d30eae 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -504,6 +504,27 @@ qupv3_id_2: geniqup@8c0000 {
 			#size-cells = <2>;
 			status = "disabled";
 
+			spi16: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00888000 0x0 0x4000>;
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
+						<&aggre2_noc MASTER_QUP_2 QCOM_ICC_TAG_ALWAYS
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c18: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x00890000 0x0 0x4000>;
-- 
2.37.2

