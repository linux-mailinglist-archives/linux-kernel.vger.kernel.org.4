Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2B6C8C91
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCYIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCYIUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:20:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442F10416;
        Sat, 25 Mar 2023 01:20:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so3869432wrv.1;
        Sat, 25 Mar 2023 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679732429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3af7AQ9wLc3osxXyvBrW7r37wpKHewq77ohhLjiNp5I=;
        b=GZ1zj3fLUmYGbFKegO6Z/96BsbgaT0xaE5+gckU7HaFQbDxJMIFSkRHSnrB9mx2wBK
         4g1bCh6Tzyj1t7Ret28ok7awRe8vNxNBNpgBdzRtey0nyujnXvAi47uFUf0xo4UiYyjv
         2T56JemorZ2bwiOpMwP24BfCKwWpbjug6NZC64K4QbP+cjhO/BJ8TYituLAtrrgBJovq
         cpJLSXZXb0KpLo4seOeAi7vCPqV4PFy+6oIeOWoTYkZ5lZmiXCKYFPu2B7RppBT/qfxH
         HKq2FxkrkUo9MQHTtJwEc9sSK1AIytvPi7V7kR9Ei52lYCCJWCtx6T+GYV2SfC80+MEf
         93IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679732429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3af7AQ9wLc3osxXyvBrW7r37wpKHewq77ohhLjiNp5I=;
        b=PysBXID0z7mZvQsxOjhUN5jfZE8YytYU1lUBYMAj3pAhpPTXfSeJoRBSDbKUYJqglG
         vTVSQB7MwG+LutLDh614WcDWW0QGjBj4ZaK1ZAEsuj+dtJtXs+Nk0Bjb7iaXpXEqAUC2
         /WbeNStNj7QepVQewpfmJQXtA2lLAzn46AkkrI23d6ez8ffiY9mFzggWVdHk7Cgi9cKc
         mEIhfgQ6xfX5Oq2y1l875TEukSBi5XtntpFQEbL4EiNkAvR1BxijMALDmK1a2CTV2/n+
         8WsK5EDsDCHQEJj+/ZK0hvMQkCtsNhq66VSTHIfzc6NZO3OR9CKDueTQ8czZx+H1/xgX
         2PVA==
X-Gm-Message-State: AAQBX9dy7AIG8zDf3a6fesSBC9MpIIM9/DTyEk2If635q9pye0hLmzBM
        oLQTPCAA2eoZ0/++kE3Fe/U=
X-Google-Smtp-Source: AKy350bLGJPGmjTfdtazrsPWVO0wWlxVunsld/1YbgyXqFusaQ02JFkJPR+WAO2w05EfTfvNjI051w==
X-Received: by 2002:adf:e44f:0:b0:2cf:eb86:bd90 with SMTP id t15-20020adfe44f000000b002cfeb86bd90mr4484604wrm.63.1679732429524;
        Sat, 25 Mar 2023 01:20:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm20175918wrs.22.2023.03.25.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:20:29 -0700 (PDT)
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
Subject: [PATCH v3 2/2] ARM: tegra: transformers: bind RT5631 sound nodes
Date:   Sat, 25 Mar 2023 10:20:11 +0200
Message-Id: <20230325082011.6985-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230325082011.6985-1-clamor95@gmail.com>
References: <20230325082011.6985-1-clamor95@gmail.com>
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

