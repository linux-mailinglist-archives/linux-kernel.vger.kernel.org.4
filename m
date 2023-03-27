Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0D6CA88A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjC0PEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjC0PDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:03:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FF3596;
        Mon, 27 Mar 2023 08:03:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so11868704lfu.5;
        Mon, 27 Mar 2023 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679929356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3af7AQ9wLc3osxXyvBrW7r37wpKHewq77ohhLjiNp5I=;
        b=aJAMeUSuyua/Fa1o+yzjjCi4t7zNAxGXPG0mr4ctDoteRlTqAfsvzt1UmCylvScST+
         D53MpZfSCQPDgUc4+h6B7RJD9NS7BV9RdYb6/cn4TGT16+1YttXq8Rye0AiNdP/bI6wF
         sLW+/u9BtWSxrCwrd9nt1QCeK0N5jhH82sQNgvY20RpccuN9HQlRPXikT8jzUa17mYOd
         mw18ksCfHZkzth1pn5CNNsc0+mw12AKyd6tYCn9ddyKIVgT1m53d5eVuSdJW2paltwS0
         Fh1NNRXw8IlOEsmcFE7+n0Lw1IuKRyOIaybwgKVSBOb7K5BThsbAaPL58VQc6NDK1sqB
         mZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3af7AQ9wLc3osxXyvBrW7r37wpKHewq77ohhLjiNp5I=;
        b=iSMijXm7selnhKm6hWZu/w/rqkmV1FpSsGpvP7tSsHxqUCz7ciPxy5rCylW27GniVJ
         lZP+pQYbqhpknw8PHlMWD6+z0skoSdOVp56DExxpbpvHkBfNUpFqF6tT0IpqyO/tgqdV
         sI5PIim+ThCxNanzmAps1ecUbTBx0g1O+YGD4N5MPqDmNmrDJdTZzZOGkNUkPhz8qvhK
         FwypytfGa2U9tgUc+CP4ugswi0l/58fnTvLBGeT+Ci/hYYVr/QYA6ljXjiac3GquzVx7
         NYA1S6T7kiZ4o1211HB0nV3nSnJguW0tIYw3vUPWmHmE5tuTw86GjpY5IkGlCzsuBpAQ
         Y3Qg==
X-Gm-Message-State: AAQBX9ePnVuG3OGmnpN6cgChieXP4kXWxyo5lOUEQt1BKm4vdiNkUkK2
        0muFgeieVl+oJWjfSsAcRDs=
X-Google-Smtp-Source: AKy350YAIa8fmdryQsNcyE9xdIj1Y0024oPSK/j0KzOEf8cX+5Lf79GCDkuFHKNiRZfI46m1NUYpWA==
X-Received: by 2002:a19:a40a:0:b0:4eb:982:adf with SMTP id q10-20020a19a40a000000b004eb09820adfmr1952941lfc.26.1679929356417;
        Mon, 27 Mar 2023 08:02:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id f4-20020a19ae04000000b0049ad2619becsm4706923lfc.131.2023.03.27.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:02:36 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 2/2] ARM: tegra: transformers: bind RT5631 sound nodes
Date:   Mon, 27 Mar 2023 18:02:19 +0300
Message-Id: <20230327150219.13636-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327150219.13636-1-clamor95@gmail.com>
References: <20230327150219.13636-1-clamor95@gmail.com>
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

TF201, TF300TG and TF700T support RT5631 codec.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra30-asus-tf201.dts   | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts  | 17 +++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-asus-tf201.dts b/arch/arm/boot/dts/tegra30-asus-tf201.dts
index 3c2b9e93e028..0406c5a69c12 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf201.dts
@@ -624,4 +624,21 @@ opp-table-emc {
 		/delete-node/ opp-800000000-1300;
 		/delete-node/ opp-900000000-1350;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf201",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Prime TF201 RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Mic Jack",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
index 573deeafb7ba..4861db8e1e59 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
@@ -1084,4 +1084,21 @@ opp-table-actmon {
 		/delete-node/ opp-800000000;
 		/delete-node/ opp-900000000;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf300tg",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Pad TF300TG RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Mic Jack",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
index e7fe8c7a7435..efde7dad718a 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
@@ -820,4 +820,21 @@ vdd_1v2_mipi: regulator-mipi {
 		enable-active-high;
 		vin-supply = <&vdd_3v3_sys>;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf700t",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Infinity TF700T RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Mic Jack",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
-- 
2.37.2

