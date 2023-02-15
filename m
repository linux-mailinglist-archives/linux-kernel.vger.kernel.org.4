Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C2697705
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjBOHFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjBOHFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:05:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEC36445
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso1162970pjn.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtvgID8mNLGj3X1P+nHdIDZyTZvvt/sYgRm2r4KBSpE=;
        b=hrTMbntn1H9DS+R4h9ejPTHiTQ197TAT4KHzEoBErnRQz7aZqXCNIqKgt2GzCThuTx
         sxHoRvF96HHVgBz+cKvvZhGYTpTmzrWGF9YSTAbOj977PHE1MgKPFuzdqFh0BQuuj1sq
         PjGK1JmhzburWZPkGaPdA5suejkLuJPrX9XrivTTknECLZMZd5s6iS8ds9A7oKVg0pnu
         tXF4MSmitXaOIlsfFqbf4Tea1KH/7HQr5y9YZwL3+7EMg5bAsYXdfyAFVVQ2PfKqAwox
         HbAKQDV/lmKrwTbcsXRqNYvPKXHK+63IKK/0VA8DMSCzxAJvJ02tTG0h4JvMrVtdwfK3
         dVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtvgID8mNLGj3X1P+nHdIDZyTZvvt/sYgRm2r4KBSpE=;
        b=0VckYiBtCXY1tbPELoYZ7M/5q+nt7FAp9NBO21FIxCUfLWIdN7ipegdMRWnRuCtMBo
         bF7HCtFnXQt6qzoYlZOtQvBaNMpxgXcEVwBeYtn8ot4epBg/9belfmsKeWgltSUbZl2P
         zekoQ38aFDKVnjEok3IkuuIT2AIX9501215cnM3NfoKE0+uhF/PjmMjHJvn7nsWYVTR2
         ffXr9tWpWLYSOG2RIUQ99In4ebFqvrWN6a+VAWRUDJSJiP35NDyL2XLNWBXF2nSFjXHI
         2KYWkwgdn8tHSeVylxBzR1GJp0zTYBAmAwWbflk/1avcjioIuURGpEmn+kpeIrbPGlsw
         hcwg==
X-Gm-Message-State: AO0yUKXYs/Rd0ZfBEm/StlFGlc54vL3CMSj93sLnuymK96qErm2M9nxn
        JWFHqnAxLehPiqk/OvTDSM7x
X-Google-Smtp-Source: AK7set8exbcoSCRitiD+v2hd06tA5Sfyuj90HWimBLrEl1y/C3mFIU3cBapPvmKQw1iDBNjbyd0hxQ==
X-Received: by 2002:a05:6a20:8f20:b0:c0:be63:75e5 with SMTP id b32-20020a056a208f2000b000c0be6375e5mr1110888pzk.33.1676444679823;
        Tue, 14 Feb 2023 23:04:39 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 07/12] arm64: dts: qcom: sc7180: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:55 +0530
Message-Id: <20230215070400.5901-8-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ebfa21e9ed8a..53f0076f20f6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -76,6 +76,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -103,6 +104,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -126,6 +128,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -149,6 +152,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -172,6 +176,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -195,6 +200,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
@@ -218,6 +224,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
@@ -241,6 +248,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo468";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
@@ -3578,6 +3586,7 @@ cpufreq_hw: cpufreq@18323000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		wifi: wifi@18800000 {
-- 
2.25.1

