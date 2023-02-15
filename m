Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C892B6976CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjBOG5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjBOG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:56:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD3F3525F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:56:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so1069913pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hWzwrq3hV8TOIaiR9k+5O0t1qbVTCRxBbpH8HHjlnE=;
        b=W73Vup5l/4wmUFILlnyK+/L/Wr2iRFEBesUg2thm7OrkLy0vgdp5c8DjXJsV+4p53t
         xmLK+cAIGCwz4XhR1HcSmz4UJEmWURJTdX8TFR6c2ajIOdXbqNZuO2vgEs9qqMaGJtmH
         zMcUiQ9rbGaxyvSnOlO0KN0PwxWnYnu79J49eaEu8ziVzzB1LhTXqiPXTCzgVG+nAER9
         nZLqQ6eEFJOfh+g3iq/3W8cQW2j8fsZIKHId9sYsimOsD4QMBQCtOAcj62gvKYp3Ku8X
         udHcu0S80nqUVZ5iTT6YCTxSxGyeTv6eaW9UmjDTWAv5lF3BqJVNCjUTvvetTxcCGGvq
         f4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hWzwrq3hV8TOIaiR9k+5O0t1qbVTCRxBbpH8HHjlnE=;
        b=BqGeNoV6Z/TfFNy8BV7re4oPaBptOe8hGdoCp1MX/iu08eFG0AjD0XinnMfUolEl/n
         eWfhpEzLyhfqpCdtWIgk+APCbFkc7QdmrJx87M9rGqetzy+wuMDNRuA8qWD68woz2lAJ
         /DKC1jVckl2PKuc2AXooKR1+iFx4LNKU3jr9Ad7+iiuEdB7yEDbC5kQiE6SMW7nG5YKx
         Uj4X4PGIoTLoaCtpgmD0oblajZIbdBsGxL9250GV1Wg8AYdrjxEB2F5/HNlWFZC8w+vZ
         AGczjtWWXoa8k6xWNdjaI9HnFtX81DUrdBmm/5rUGSEOJUypO8wQe1ErVOCyy2rC17pR
         h3Kg==
X-Gm-Message-State: AO0yUKV7ssD6DO9W86GbO63jJWWJkWpJrOdlppXkAWyUN2Kn5JuL5atR
        AmnJzcJd7I33VqMyIHHx7Xpc
X-Google-Smtp-Source: AK7set98tbJrd+LprEx5pqji2QGDLjt7orjF6PtffR0wVCzF7mUDefaqcMsGkR6c6p6/PdhJntBbvQ==
X-Received: by 2002:a17:903:1110:b0:196:8d48:8744 with SMTP id n16-20020a170903111000b001968d488744mr1405591plh.40.1676444161988;
        Tue, 14 Feb 2023 22:56:01 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b001933b4b1a49sm10276870pls.183.2023.02.14.22.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 22:56:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/12] arm64: dts: qcom: sm8150: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:25:19 +0530
Message-Id: <20230215065520.5535-9-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index fd20096cfc6e..693d023d2629 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -48,6 +48,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -74,6 +75,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -97,6 +99,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -119,6 +122,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -141,6 +145,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
@@ -163,6 +168,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
@@ -185,6 +191,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
@@ -207,6 +214,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <421>;
@@ -4273,6 +4281,7 @@ cpufreq_hw: cpufreq@18323000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		lmh_cluster1: lmh@18350800 {
-- 
2.25.1

