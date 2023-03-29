Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C46CD5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjC2JFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjC2JEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:04:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7535A1;
        Wed, 29 Mar 2023 02:04:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so60587581eda.0;
        Wed, 29 Mar 2023 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt3pFcNmven8aszzUXY021Or+hkjFjt51HvtYlhXRTU=;
        b=ocCTEOOTta43yM9bjytpG/xXuVfjSG6fLnOBLBSNhz0J8LYV/C50WleDq4MNmn2abF
         JacSQcvcxZsSzGi4Lv9uKW18u58dNuzzSUlTUpZlm18FDci9Xjb5ukdJ+jDpP4CssSxx
         FC9hcsmACfZCLZ1ehi75tEkWT2a/rzFdannZDhDV9Zxb4p9jNA2kAywWRso/3BZh/bPr
         2nLTUgNPR+OUCk0IwbMYnT1cenuq6NuGISu8JMAi8DCp62Mw0wCGM3iknLJ7GnwoW5JZ
         YLxa0H8Et9SUQVJWV9NniCFBK1EJwc+CCf1bVDqscVqt7MVX7OMDZdYPQQX2g5JLE21v
         hWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt3pFcNmven8aszzUXY021Or+hkjFjt51HvtYlhXRTU=;
        b=p/nho7RqG5HgCHfuZ08y7Bi+ub3NOPeGZNGACTm4qDT/ruDvGtbUhsDeafGXN1/uMU
         CP+k72iHqYbCc3IN8qkeGeZU6LSQczJuQjqiCPgUQYz9dDXRcErgItU2mevwbgoAaQBb
         dznJvB6E9m5xxz4vlrfjVClyn6Nqxh9MlITgtKIJwxdsZ0KukTEn7mF6qgZQ3HumfSFy
         2o1FZhF8pobsDYAWWR8r+YRYzxZmmL9PDM3DFNo+X8iA6iMFiSTsc45a5Q8VLEzR8Pb1
         AM1bojuR0PtjR+cyMZmjchbwiAY+a3Nc2um50/wHW6D/Xr/d3NjylI7Jgo4namG6YnGt
         P1LA==
X-Gm-Message-State: AAQBX9fett5AOZlRxdeiO8pe0u9GODVNAw50aqxfWsmUK2kBZ8KWisgs
        ELi5Z7DqCeaKD7iYvm0ew/Q=
X-Google-Smtp-Source: AKy350aBAWqF+LjiRsrY7PmsuATukmUG9f5LmaTxiMQapBXR/uzdxOwKaIJzOBL/TQI5p0ezJ/hhFQ==
X-Received: by 2002:a17:906:a887:b0:939:e7d6:7c52 with SMTP id ha7-20020a170906a88700b00939e7d67c52mr18927345ejb.20.1680080676659;
        Wed, 29 Mar 2023 02:04:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm15437127eje.129.2023.03.29.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:04:36 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: tegra30: peripherals: add 266.5MHz nodes
Date:   Wed, 29 Mar 2023 12:04:03 +0300
Message-Id: <20230329090403.5274-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329090403.5274-1-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LG Optimus Vu (p895) and Optimus 4X HD (p880) have 266.5MHz RAM
clock and require this entry to work with it correctly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
index d100a1a8b705..a2d557155114 100644
--- a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
@@ -210,6 +210,20 @@ opp-204000000-1250 {
 			opp-suspend;
 		};
 
+		opp-266500000-1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <266500000>;
+			opp-supported-hw = <0x0007>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp-266500000-1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <266500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1250>;
+		};
+
 		opp-333500000-1000 {
 			opp-microvolt = <1000000 1000000 1350000>;
 			opp-hz = /bits/ 64 <333500000>;
@@ -424,6 +438,12 @@ opp-204000000 {
 			opp-suspend;
 		};
 
+		opp-266500000 {
+			opp-hz = /bits/ 64 <266500000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <2132000>;
+		};
+
 		opp-333500000 {
 			opp-hz = /bits/ 64 <333500000>;
 			opp-supported-hw = <0x000F>;
-- 
2.37.2

