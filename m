Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED86AA8CD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCDIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjCDIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:43:48 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C716336;
        Sat,  4 Mar 2023 00:43:47 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id by8so4644079ljb.7;
        Sat, 04 Mar 2023 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677919425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syuBBfuFNqUVEt5myTUHBWQU/zXBUecumwT+b6a2b1M=;
        b=e+btXyhqbjOa0x6eHPe5KW5QJ2cuywCOU3Tc2MdVx0PVc8L5mnzddv8lwSroxdM9mH
         ZDvo7KBOu7cKh99s7eHy0ISDkDtCybCl7jvzG3Yii2cCCIXiGgEXU2kiQjC1bmMOuWYx
         hFxbn8AxaBdlZPlJ8+OrtQFJNk/5BtA4VTgMeQ679fn7hM3nmaSegPftXeRqymwoBV9/
         LjRCI1kzJWGTd4mqtwtQY3ckP81JmdnXwWWKI2HguIAU21oZ1Pk2gvpI4eKg9WN2pqM7
         u5ArRmYeqbenkZY1TumiDdO2DeSifog2KOuY/ByZv3x/4lTdR6pbXRnmGp82otP6lIrb
         XSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677919425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syuBBfuFNqUVEt5myTUHBWQU/zXBUecumwT+b6a2b1M=;
        b=a3IxR2RvJ9OQAo/TtnVr51w3UUDd9/aZJ5EtG8MZTVeszMCMT+/Lej7RGYLVl+mSKQ
         YUNHSiEbjWUKHUqH2l4SmkhboSs3GBW7Gnu4V1TfEE8+ZI6mzcGn4iXYKww+RVqsal1n
         lv8vMSxnQmjUo5O5m60U0gmjyLLK20TP+zpCywqxL+3HSKxN3t0UQjrLr8N9RhnkX8VS
         4BPHlo70wLnePjRsnfW/qXRbkn1Q/eqqExhu3peilXbNtcx0VBKwHDw/8KahktM6Lkp8
         Yn5nOQpt1xQq4qOdPY+Nko21HptS3UZ6fG0Qupg7AY8C/cC5H5bnwYaexKLeB2QVvlAo
         PSMQ==
X-Gm-Message-State: AO0yUKU47tnQnKKea4btOBVn99zGcqX2GjbVx+iu2tQzc4YxzEqQGr3Q
        NkHYu8khytg+R6kAggOafaM=
X-Google-Smtp-Source: AK7set9dnpRA1GA84poLDXX/AlDqn51g5tB5Ob33S3w5J4OzPvLSmU0E5pJ2EPFQ6md4S+3D43NptA==
X-Received: by 2002:a2e:b94a:0:b0:293:1565:4353 with SMTP id 10-20020a2eb94a000000b0029315654353mr1335543ljs.10.1677919425459;
        Sat, 04 Mar 2023 00:43:45 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a2ea165000000b00293cc5f83b4sm693575ljl.27.2023.03.04.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 00:43:45 -0800 (PST)
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
Subject: [PATCH v2 5/5] tegra30: peripherals: add 266.5MHz nodes
Date:   Sat,  4 Mar 2023 10:43:19 +0200
Message-Id: <20230304084319.18424-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304084319.18424-1-clamor95@gmail.com>
References: <20230304084319.18424-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may require this entry for proper work.

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

