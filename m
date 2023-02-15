Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904676976B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjBOGzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjBOGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:55:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552F34F79
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bt4-20020a17090af00400b002341621377cso1167739pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRK1e1bBAwexX53o+cDSJezWbQwruRqnE48E6Hj9hPo=;
        b=KwsSTjhZm1JZmx1whps8mciiWBJlrx1ezk8vVUWwLb1Vgkis9AhVRIMgb/HeaAZa1Z
         6mPfpPROXrsA2MBvIQ5VL5PCxAxAVA+uwopAYtC/CsYAqeDAfWHcF/nKjcUTwQ5LJ79Q
         /opk4ljz/Nyp1VeKn+DoRS/j5+4meUFAtvfEP9pF8cZYN36ONXQgIUjYhLHhKXXGJlqh
         /EyO0C43sQfS3P2RO2otoft9Gq/63Q+zKgkc66NOHiQEdlkAFXDgGtE1X95vHDQT8H70
         AqJ83KmVryrpHcjbJ6LHrRSD/iy1EHHnac3BogSKuq1bO8HkidlShDnlIRhvnTXpGX5T
         N5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRK1e1bBAwexX53o+cDSJezWbQwruRqnE48E6Hj9hPo=;
        b=6NEHGzyFBwOss/HfaJZbUjTtfIAkvqyIEPOAxpKDvDyiaTyAAUtytZkiZjnL5yV5MX
         awR1u8YvXfiubBxyyeSbBlxZmP4152ZBc0ikvEOmdtq+WKWETHKOHGyTU8SFudQJ1TSI
         z14JSZId/yHZqoKkHfgZz3aXO/wcwlP6T0RZGNCL8sSEOBjPgE8rWVPECklojFbsNsAF
         O6HblVSRvR0zW+TCDs5hoMCpj1n9rmjDb0HFH2fPjtq/2UK7tjSlJRc8spRY5DRD/69M
         d4G9L700Rle5SEE+VuwXEHZSkfM3HTaym5qsVQx6vCYtPY2RMnEjwQOsDSb0phv8+8NY
         cHWQ==
X-Gm-Message-State: AO0yUKWoMjyYU70tKoNpiRQ62hfIFUzOIOrSBcfAnL4amfZOAGmQY21k
        UjuljEr3km22knI1yUgvprnTDWXYlVQJzyY=
X-Google-Smtp-Source: AK7set+SL85AbO3XLXoQVuiD5hrUWrduVA68sdO8o3ZBI8BmvvKZYFznu6DcxlBu1kcE/gjY1Jqxvg==
X-Received: by 2002:a17:902:e80f:b0:196:40ff:97b5 with SMTP id u15-20020a170902e80f00b0019640ff97b5mr1651946plg.40.1676444134842;
        Tue, 14 Feb 2023 22:55:34 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm10276870pls.183.2023.02.14.22.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 22:55:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/12] arm64: dts: qcom: sdm845: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:25:12 +0530
Message-Id: <20230215065520.5535-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215065520.5535-1-manivannan.sadhasivam@linaro.org>
References: <20230215065520.5535-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. But this relationship is not represented in DTS so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..1d5e6ade8ae7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -92,6 +92,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -118,6 +119,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -140,6 +142,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -162,6 +165,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -184,6 +188,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -206,6 +211,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -228,6 +234,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -250,6 +257,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -5232,6 +5240,7 @@ cpufreq_hw: cpufreq@17d43000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		wifi: wifi@18800000 {
-- 
2.25.1

