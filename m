Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA046994EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBPMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7944617F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d4so1664920wrj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOyfaP0VQoPSZZRozrnt7Rnbt4hWMK3D74BD6fdRa7c=;
        b=4XnN77q3TiQ1taMtkjTpChQxrfvzDqmWliLPFdJNCLzLB6VqwCqlSSbFkwuJIu82/V
         C4qCDiSUAHlf9fBlGvHBkXoc5owwer2wkzXVbe2N/5nTUD6pqeioJB7Jxfv05StIACpw
         8cS6ae5BeJGoY02zllpKToEUD3yVgzbVkFF2Thqv8A0U3BcURbFBzN4aLkDAhXqx2ON5
         QqgELCKImB94ejex0/x4J7folAM5UNl/0RNQ55mj5PfjoHIK0wKUR6WLNyANh+VNM36u
         zs+6sIoS3B9ZqcXPQuvynIaj5pcNbaVZ21fwJ+C3dqgjAthqAn9r5EKgVpnb6/+qyaFd
         nAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOyfaP0VQoPSZZRozrnt7Rnbt4hWMK3D74BD6fdRa7c=;
        b=6d/k+H4/sPV1sDmeY8gQT4yemo9H0YeHD07UE3jPY3lB8b5xD1N+2RT/otu87zcPIG
         y/IV0KKE+AC/fb3WTxFHfe32N4LD/RfwEYpf+mS5ZOvs3ic4FbMXTUlUOQkRI5zuHtkx
         VwVJVlaF1m1APjqGCQD1roc/OnL8Iq9My0zOwWfvczCJCbuxl59I2zoM6XVdOgTQ/bm/
         +rvt4iNHd/LFlDMcfymgzaMcbI7CoKERl5qmtRECRMDqlbKdswRpLCBvDtCTttVZc8Zw
         ojPKmfwea2YqmlTOz1eSP6qm9VgoWUvMnOWdqnAAVKWZxJ2tV36DW69Lypx854x5GWa5
         gdqQ==
X-Gm-Message-State: AO0yUKXDddL8Bsu+FCgveUGnsI/YskbrIZQ0Fi+pNOyhbp42aUIUoJUy
        nNg5GVcyTeIELw/d3qDhyFQTxw==
X-Google-Smtp-Source: AK7set9YMQWnHUBbbfQfcw7q7A8wTJ/SKidpIupgzyqYku5y5w76qNvVYogLjKW1LlcXsf67s8OWvg==
X-Received: by 2002:adf:fdcf:0:b0:2c3:f026:907e with SMTP id i15-20020adffdcf000000b002c3f026907emr4805826wrs.10.1676551985150;
        Thu, 16 Feb 2023 04:53:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 5/9] arm64: dts: qcom: sa8775p: add the spi16 node
Date:   Thu, 16 Feb 2023 13:52:53 +0100
Message-Id: <20230216125257.112300-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216125257.112300-1-brgl@bgdev.pl>
References: <20230216125257.112300-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the SPI controller node for the interface exposed on the sa8775p-ride
development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 4666e5341922..eda5d107961b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -503,6 +503,27 @@ qupv3_id_2: geniqup@8c0000 {
 			iommus = <&apps_smmu 0x5a3 0x0>;
 			status = "disabled";
 
+			spi16: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x888000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
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
+
 			i2c18: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x890000 0x0 0x4000>;
-- 
2.37.2

