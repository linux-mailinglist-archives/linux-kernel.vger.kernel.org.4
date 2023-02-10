Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AFA692552
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjBJSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjBJSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:25:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4263582;
        Fri, 10 Feb 2023 10:25:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so18340305ejb.0;
        Fri, 10 Feb 2023 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyBzoWonyroiVWOV9YyUOPxjVW7NIqHXUCfTqPDs494=;
        b=ebLy1htRwAGPgbF4vheWwt/5UYmixRi8gd57rvXUC7dUEqTvLJgMh3/BgPbUsv5XlY
         pmQ5wje3aKntpnAOSHtpUDeHVJsgmwHPtJzIUVFn4F5+t3wM2EIlqRH5QljT/bGupf1p
         YE/Jt3Q5CEeXA89z+ybYm0JqLb/L6qgFrY5rUD2vORu6X9rLrt4sfUCOcDP5lOEwPCSh
         Buvpt2eYPkxkPpDFn6abMQI42nxoXYz0SgnBqSQk5Dj/hQ4rTwXWz0RuBhaD8tWfU39V
         wf0o/hZzd1G6rfpYWdFoAhzSHF5/oMnwT9RU22FPp2/Gqv4iQjarvFf/EVDiJhOLv/6S
         /F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyBzoWonyroiVWOV9YyUOPxjVW7NIqHXUCfTqPDs494=;
        b=eIIUJQEdwQhN4csdvtjr8aD7PR+mD1tjyz0bIZOBRte+SDnnv/A78KnozhoCoYrnjG
         C+mNOyl7Ud3ajy1LHRbl18Ra/akCOQnF/Q8PDEYg/WrItBOubRQwTPdYMTJPbPOHiNXH
         znlvCU+E1J6UZbIQxH65cd73RdoUpnYFXud7JlCcRgnjTlZcn3zLcMikWyay4vrkK+kA
         ceUtUEM8QNwOPmRqnj60nh5am/Yh8O5AqDsoDnJAWUAlUONUJXP2LWK5xS1kzS/LU4T2
         9CH7MnP2b8KsE7PNdbnvPhbSMwhJYWA5a0pKujhDRIZKtWHCq9RCyyjVBZdka/g50GXb
         o3ew==
X-Gm-Message-State: AO0yUKVYtmk8HEJfH5ew0ZnZ9SK/r21MQ9FciD2KPzSdqC/qHeMUlzWV
        F3Ik5yApK1xzU14/CQKG+Ok=
X-Google-Smtp-Source: AK7set9xA/Pdz2Tf7LtUnn5pvUgmMkZJr4RCfb4ZnexC6hSS+IRoYOLRpI/4WFVbv7fJ1z1XAThcng==
X-Received: by 2002:a17:906:7952:b0:884:b467:ae4a with SMTP id l18-20020a170906795200b00884b467ae4amr20535503ejo.64.1676053524019;
        Fri, 10 Feb 2023 10:25:24 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906024400b008aef19f678asm2708966ejl.165.2023.02.10.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:25:23 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: [PATCH v3 5/5] arm: dts: mt7623: add port@5 as CPU port
Date:   Fri, 10 Feb 2023 21:25:05 +0300
Message-Id: <20230210182505.24597-6-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210182505.24597-1-arinc.unal@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

On the MT7623AI SoC and Bananapi BPI-R2, port 5 of the MT7530 switch is
connected to the second MAC of the SoC as a CPU port. Add the port and set
up the second MAC on the bindings.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623a.dtsi                | 24 +++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 24 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index 2a50b5c0c933..bcf909d58a1c 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -28,6 +28,17 @@ fixed-link {
 	};
 };
 
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
+	};
+};
+
 &eth {
 	status = "okay";
 	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
@@ -79,6 +90,19 @@ port@4 {
 					label = "swp4";
 				};
 
+				port@5 {
+					reg = <5>;
+					label = "cpu";
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index dc9b4f99eb8b..642b1c0a96ba 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -182,6 +182,17 @@ fixed-link {
 	};
 };
 
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
+	};
+};
+
 &eth {
 	status = "okay";
 
@@ -225,6 +236,19 @@ port@4 {
 					label = "lan3";
 				};
 
+				port@5 {
+					reg = <5>;
+					label = "cpu";
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";
-- 
2.37.2

