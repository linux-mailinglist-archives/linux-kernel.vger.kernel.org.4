Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935DF6229F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKILNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKILNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:13:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996FC2A277
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n12so45637596eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBu0DAqnkYkL46/OegDUIMhoEPze3QFWuGsvoEBwl2o=;
        b=gVtzcJ1byX8sZ9YhGkkBHz4BPLUdhB/GBMuoiJKeMG3vwJnn0sVv9lpDp6qHnhtFwn
         7Pk59pAhnJJTq+tYRRWQ5ChctRlux3yUChdvGcPwwhHVCimfKK/7XnJFuaqp3g048hGe
         7RkOT20iOCiBQa5oIAbpX76l26IfatlYmP0fsESP3KeT3ogJBW3l/4jlKqBRD0QpVtbs
         p7Q7dvXsp46DFfN2fsiWbqt3hpUZ1yrD1EXWKVRIVzTUNrMPL3MnXDfuaZ9hf9Tk3RlD
         Fbugwhrm09Qq6G5JzGX6H+qAy323n1sj7NcWyQDGwRznHy5tfGOLddL6F9gNMKQew0Cz
         x/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBu0DAqnkYkL46/OegDUIMhoEPze3QFWuGsvoEBwl2o=;
        b=d234GkzD/z13ZaNYU9zUjj+e2tirn230O5cSLiJo1g0kjrmhr7KPaUqKSHzwrc6ypW
         1E0tDzWp/3JuXsOTorGe6GbMyuZm66XdntUFvF6fmiR/tvHPJC9JKxeXeASlw8W1MJ8a
         3Fmb6qccfxOC6lafgIPAee4sA0aE/uL9Pir/mrv9RzsEU7Gqe5qPY7cdDT8HA9gbTNIZ
         3DCBKUEH4KvaPBk+71kDn2LNhSyI8sGKdnCfw3Qc9hZ+9ttjV7oVUTIhjhlDLUkFq3Dn
         iUQV0cPaaTnZIbJijok/bHs0xcr86C1dDqWk6iu7azr6Jsq6nL/47VY3dvPt8VsLGeIJ
         ZE7g==
X-Gm-Message-State: ACrzQf3U2E4VNyre45I8v5pZa+VsKfhf5uDrhwfQCqf9oTsKNQkPqEb0
        Ta7fxSso9xwT9jgDBW1YT9bWWA==
X-Google-Smtp-Source: AMsMyM4w7fwX852mFaI/PVuvOoFvMYsBNRUhjoiOvMM3yx/cLRntUQ2JTgNFVwUtnEKMfdSWZ6ac8A==
X-Received: by 2002:a17:906:5a49:b0:7ad:d063:901a with SMTP id my9-20020a1709065a4900b007add063901amr48974054ejc.323.1667992376546;
        Wed, 09 Nov 2022 03:12:56 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:56 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] arm64: dts: qcom: sm6375-pdx225: Configure SMD RPM regulators
Date:   Wed,  9 Nov 2022 12:12:34 +0100
Message-Id: <20221109111236.46003-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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

Configure regulators present on the Xperia 10 IV that are reachable
via SMD RPM.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index d34b4b96e1b9..17094e588a3a 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -95,6 +95,188 @@ &pon_resin {
 	status = "okay";
 };
 
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		pm6125_s5: s5 {
+			regulator-min-microvolt = <382000>;
+			regulator-max-microvolt = <1120000>;
+		};
+
+		pm6125_s6: s6 {
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <1374000>;
+		};
+
+		pm6125_s7: s7 {
+			regulator-min-microvolt = <1574000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		/*
+		 * S8 is VDD_GFX
+		 * L1 is VDD_LPI_CX
+		 */
+
+		pm6125_l2: l2 {
+			regulator-min-microvolt = <1170000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l3: l3 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm6125_l4: l4 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm6125_l5: l5 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3050000>;
+		};
+
+		pm6125_l6: l6 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l7: l7 {
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm6125_l8: l8 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l9: l9 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l10: l10 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l11: l11 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l12: l12 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l13: l13 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l14: l14 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm6125_l15: l15 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm6125_l16: l16 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		/* L17 is VDD_LPI_MX */
+
+		pm6125_l18: l18 {
+			regulator-min-microvolt = <830000>;
+			regulator-max-microvolt = <920000>;
+		};
+
+		pm6125_l19: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l20: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l21: l21 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l22: l22 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm6125_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pmr735a-regulators";
+
+		/*
+		 * S1 is VDD_MX
+		 * S2 is VDD_CX
+		 */
+
+		pmr735a_l1: l1 {
+			regulator-min-microvolt = <570000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pmr735a_l2: l2 {
+			regulator-min-microvolt = <352000>;
+			regulator-max-microvolt = <796000>;
+		};
+
+		pmr735a_l3: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: l4 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pmr735a_l5: l5 {
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+		};
+
+		pmr735a_l6: l6 {
+			regulator-min-microvolt = <504000>;
+			regulator-max-microvolt = <868000>;
+		};
+
+		pmr735a_l7: l7 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.38.1

