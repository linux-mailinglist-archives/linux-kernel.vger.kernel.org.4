Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82EF697718
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjBOHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjBOHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:05:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A62B0A3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so1060889pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZHWlB7pux//lNkbt9HTSOdwlznBfF1lihCKM77AJKM=;
        b=nkKnTlEN5hcZ4qLo/YVL8/tFoNmLwWE2LIP2yZmru0bRdRIBlvpEDcmvaZZqZLIk2C
         qC7/LXyBNy41py2CtwcD3TmLQyhODdIR6WuaazQzIMwH1TEvY8Dc1RH6SJ2+uOJI6I1N
         aJ1D9WoAW8UHXdla7Vg/GkJS8+YzCckv+vvickNSYx0PNXvG6/C2j2vjuMWFKVmP1WTl
         Ox8mEEi4eJNJJo+CUUEyoQgLjQrI+FrinnklniWx/Kx4MWK1je7LvqwqbzNWc09BSllh
         MtXOmMX2hyX+EnjsfASE7daCFg6fzpRu5yDqzt4jtoQsFspYN5gEGfYlpKzFdwgWIeay
         VXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZHWlB7pux//lNkbt9HTSOdwlznBfF1lihCKM77AJKM=;
        b=jpwG4tfQjDFnsQuItf32bCcBBUmgd53OcBO665shsnhPibFnYE2jDLT5ZBieDSjssq
         zDeHGsk8fbCcBj5LsiikHT4Hq2GrzJ0uloRNIYBObnx0kGQJSPKQyypIf1Gv+fY2rv5J
         3MAb2nZ9M4EbWV54HcJbSPDNGxohx1PhorQSf984oQ8IetEmiQlsEI1Voidm6l59QZeQ
         DwAga1l4fyFrDFWStDn6ACRFXPDlD3gOR8aZJA6CxyFTdg9d5we61+mKj9T3qGXPmyak
         B9/jt0jJZl8qRJRQlJNvs4NPSCcNh3Ab8uvCC16ME4yGbjZTkzDWd1wCUpqOMdIhRWvP
         9WaA==
X-Gm-Message-State: AO0yUKWmAosDXFdDJEpuzIWqZsCxyZQbmwdDieGv0nKDDhmhDPp1BzEp
        UWcSoOw/rfCdm5ZObtI5OcWG
X-Google-Smtp-Source: AK7set/ZVmlUnW3doNVCk/iZmewAyeWi13ySBwi6xF3aCncg/p8Ni9tgLZjV4Ii+EBKbfJdp7UBYAA==
X-Received: by 2002:a05:6a20:1f22:b0:be:b49e:a634 with SMTP id dn34-20020a056a201f2200b000beb49ea634mr728348pzb.23.1676444695405;
        Tue, 14 Feb 2023 23:04:55 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 11/12] arm64: dts: qcom: sm6375: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:59 +0530
Message-Id: <20230215070400.5901-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
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

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. But this relationship is not represented in DTS so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 31b88c738510..58d3b4785401 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -39,6 +39,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -58,6 +59,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -74,6 +76,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -90,6 +93,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -106,6 +110,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -122,6 +127,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -139,6 +145,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -155,6 +162,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo660";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -1383,6 +1391,7 @@ cpufreq_hw: cpufreq@fd91000 {
 				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 	};
 
-- 
2.25.1

