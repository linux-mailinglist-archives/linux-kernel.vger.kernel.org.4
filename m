Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8708B61337C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJaKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJaKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:20:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC7DF8F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:20:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k15so2224171pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bmZ2pYb9pdBaYbjBzroXAssfgCgw6icpxdo/Msq598=;
        b=489qbVO3Y2VoocLP1TrfwItNxUM/uq7K/xmZKibkahS1fi9D4xZTok3cGEYXN1bkW2
         WmqrlfmuObNEJ5xMCUNjFAamXBgV/wwgFA4Ah5LGzXw7P5+LPTIuaQqEp7mg3M1kITNE
         zdvLiP3y2dtFgh3OptkHFhxW/I/OwZ0r9lwdgIiJ92j5oFuLuIafcjyINqoAXHKvq/T5
         uvzitOKX9KXuyGSmAhqoGz6gMyDj2aA06cWd6tlijMIRqSt37NjyoOIv5XeUvnjyaCdS
         MFPIV876LNG/ClU8sX87iQ+h0vd4k7zz1DiS+ezEauZwAvO0sNq5HEypVSeAaMLKr6Ej
         NSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bmZ2pYb9pdBaYbjBzroXAssfgCgw6icpxdo/Msq598=;
        b=oXy69YEVx9Ox+oa/OaGNxL6620RtlIpBbc6KdaZXSOOq7NEmLW3oU4Xu7Bbt3Yt9fr
         NmPi47J8zMNVQUK1btAi4U+ARAHH/IkTOaqF64z+hhPajWAXXo8vAe7y4hfHEupz5tYa
         Jbvic6aFlQtMzi1dCY2bWeeDVcZVK51Xve08DE8TcWdJd/v9SpTxGq38XPfWPKq/bvzp
         BwDIvrYgWjo6sPf9WcyCk0EjonLXXMNs+QXp6Zvgm52g88InRlhApW0eGEgn231XsXml
         AUcqHnkGyU+tadQrgHVnuwdhImJCiYz2wLiizkIaa93PQvPMPd/6bbaOYZtcNJKm1Bed
         O7CQ==
X-Gm-Message-State: ACrzQf2VNcICQ23CBjMvn4R6AMeI2UzWKm3Of3u1rRl15P3gH/4jAip/
        7YI2ZqbsZ7bAcTT9vhzo1QRMLKo6Z8XDMw==
X-Google-Smtp-Source: AMsMyM7cOIuxRw7X4Cf4VCu1A3GaarZ06GwstTdKd5q1ohCrn8RGhFuB+zPQ0SP4+/adehH08yxnqw==
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id w18-20020a631612000000b004614180d88bmr12301738pgl.434.1667211627801;
        Mon, 31 Oct 2022 03:20:27 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b00186881e1feasm4136551plk.112.2022.10.31.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 03:20:27 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v9 4/4] arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi in evoker
Date:   Mon, 31 Oct 2022 18:20:11 +0800
Message-Id: <20221031181735.v9.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031102011.136945-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221031102011.136945-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include sc7280-herobrine-audio-rt5682.dtsi in evoker
as it uses rt5682 codec.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

Changes in v9:
- new patch for evoker include rt5682.dtsi

 .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
index dcdd4eecfe670..d54c07ff35f4f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
@@ -8,8 +8,140 @@
 /dts-v1/;
 
 #include "sc7280-herobrine-evoker.dtsi"
+#include "sc7280-herobrine-audio-rt5682.dtsi"
+
 
 / {
 	model = "Google Evoker";
 	compatible = "google,evoker", "qcom,sc7280";
 };
+
+&sound {
+	model = "sc7280-rt5682-max98360a-3mic";
+
+	audio-routing =
+		"VA DMIC0", "vdd-micb",
+		"VA DMIC1", "vdd-micb",
+		"VA DMIC2", "vdd-micb",
+		"VA DMIC3", "vdd-micb",
+
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+	dai-link@0 {
+		link-name = "MAX98360";
+		reg = <0>;
+
+		cpu {
+			sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+		};
+
+		codec {
+			sound-dai = <&max98360a>;
+		};
+	};
+
+	dai-link@1 {
+		link-name = "DisplayPort";
+		reg = <1>;
+
+		cpu {
+			sound-dai = <&lpass_cpu LPASS_DP_RX>;
+		};
+
+		codec {
+			sound-dai = <&mdss_dp>;
+		};
+	};
+
+	dai-link@2 {
+		link-name = "ALC5682";
+		reg = <1>;
+
+		cpu {
+			sound-dai = <&lpass_cpu MI2S_PRIMARY>;
+		};
+
+		codec {
+			sound-dai = <&alc5682 0 /* aif1 */>;
+		};
+	};
+
+	dai-link@4 {
+		link-name = "DMIC";
+		reg = <4>;
+
+		cpu {
+			sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+		};
+
+		codec {
+			sound-dai = <&lpass_va_macro 0>;
+		};
+	};
+};
+
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
+			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dai-link@0 {
+		reg = <MI2S_PRIMARY>;
+		qcom,playback-sd-lines = <1>;
+		qcom,capture-sd-lines = <0>;
+	};
+
+	dai-link@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+
+	dai-link@5 {
+		reg = <LPASS_DP_RX>;
+	};
+
+	dai-link@25 {
+		reg = <LPASS_CDC_DMA_VA_TX0>;
+	};
+};
+
+&lpass_va_macro {
+	status = "okay";
+	vdd-micb-supply = <&pp1800_l2c>;
+};
+
+/* PINCTRL */
+
+&lpass_dmic01_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic01_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic01_data {
+	bias-pull-down;
+};
+
+&lpass_dmic23_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic23_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic23_data {
+	bias-pull-down;
+};
-- 
2.34.1

