Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282E697706
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBOHFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjBOHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:04:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5663526A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so1192554pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHVr08cnTjJMehZboB/JWbeUqVs1oVn1lVODeozYst8=;
        b=V3YYbHbtCDlii3ENqJOzqAykviuMJyzXsCZAiumNohLKBmLCWs8JPve2pj5RYqASXE
         d2K66/UR3/FzV4CjEV+ms++BDzoJ5tfNe4++iO/zn4oqgwRX0BsXZLTUchoQxUxnG6tw
         /AkJ+JeM3GkkbDyuNN4diG+I5xDDvnoaxN3lQfsf7Uj05ijiYMLv9cDn7QFaAuqWWEvd
         ypTDp5/3WTQXQg8gim3uncHV8yPKsG+Ga4gzYIpIbxbqo8Y/Agxw9MTdvhnvJc9ykW7n
         b+Boe5nWflRdQkHMh+1mqsPHM0lSBbCkpAn1nfyMd+TbAi3ZphtUhaqyaVyevJiYWzSG
         FI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHVr08cnTjJMehZboB/JWbeUqVs1oVn1lVODeozYst8=;
        b=TzspmS54Ga9cigVsrgmipCm5AR96DUNV3I7OF3/4lPN2ipMtU6pOObAoOVbxrdHSaA
         cNTavha0dYhyiocyvXKZNoTJJKemkFgWY8SCyLM95QUxmUxQNhKehWEX89wqr70HjFQX
         D1fv2W8ft4oVqCzibyKUBEn5LppTFYWLlp09lrF2kLDYlGUpmBy8S+FpM1s/L+5zjXDi
         ULk1q8Rll+iFwtnEoLjH6yVxPST08tDFjVwsPGpdO7tAXN/pKyhkv9O3svPFWwpafoE/
         +GhibNHtYQvAWINJnMNvyqPsjJ04mZRLzsJoda6XD8Nmd3weZwOCdmhUOlSkGAWL9Hv5
         SlwA==
X-Gm-Message-State: AO0yUKWmL/D4mVSeauwg73sSd56LnoQUlnPxW5nGkx61KS01cipYFdvT
        jUxMrfXgS5dy+dIfHsMUYJ3+
X-Google-Smtp-Source: AK7set9F00g8NA24XkwVqhsFXZjW6kaf9EYJ0KzZu+qw/r/EktMSJyERqXyL+ge4Bhg7SI6GXsNhCQ==
X-Received: by 2002:a17:903:2344:b0:19a:b801:13e9 with SMTP id c4-20020a170903234400b0019ab80113e9mr1645926plh.19.1676444676086;
        Tue, 14 Feb 2023 23:04:36 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 06/12] arm64: dts: qcom: qdu1000: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:54 +0530
Message-Id: <20230215070400.5901-7-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index f234159d2060..98a859ad5229 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -27,6 +27,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -45,6 +46,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -60,6 +62,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -75,6 +78,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
@@ -1312,6 +1316,7 @@ cpufreq_hw: cpufreq@17d90000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		gem_noc: interconnect@19100000 {
-- 
2.25.1

