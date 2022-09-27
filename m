Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61B5ECF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiI0VuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiI0VuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:50:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A539138;
        Tue, 27 Sep 2022 14:49:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j16so17688127lfg.1;
        Tue, 27 Sep 2022 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HJXe3gZv56ziiy/Iqiz+aCPpEAir8UgiNRNBIB+JgvI=;
        b=cmRdgKJaQp8ZP/tz7DiJ7Gd/VX6Uaj4p07f29IRR2mHGRue6ZPV14xb5IvUKyUrFhx
         G1zCmZXcrEppzfeMDdYaKbWEmXA+h/NI2bxu/lbQny4GqX4KUh+Jx/yPzBslBlpFXy06
         54QCzjc/n2edcdRX4g43qJRw+p/K6wD+VTbLUpl97gJbX6qMXklTgaEk9D1GZ1skzyXK
         vXa4gj6MIYaJS0E8IYI2WIL69/UZUTUhc8MuRDKDGl4wrrGwgCc1neZQ6HFNA981VdDl
         Q8g8YniFJjLlZkLLFF3fhjJbjpiRpxXiIp3xtGA32Jj/+J2LWvG0bL86zV/SydqtRAfS
         upDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HJXe3gZv56ziiy/Iqiz+aCPpEAir8UgiNRNBIB+JgvI=;
        b=1iNcF6gOic3LnsLwEAKEoGmcjMOMpWAn4VhKFaqiE0ljhupxfoxAGtltaXJPQ7lvIy
         YSLctU80/YJ/5FHgIBeTK67djiNbqa9O+lrmdCaj81VWpLmOwmYNnRkyeDjzOj3Bf/+V
         j1rxM63yV8JJW6SIfgwb3oZD1sMfps2WLOR/z5f0c32MU6Hj9iOJPnoCfCzaiKCGolXM
         GutzNCpTCfqAUEx/Ur9IAqXmkmjWcZ2eitzcw0t5tJ9SmXWswdhR1lcc93oVJSWccukG
         99OtuMKcRT0Uj+tF3TSJlzprfB21TmAiKV47Ws4YYQIF7t2XByIwUpXvtpU8zv4NV4jZ
         x6pQ==
X-Gm-Message-State: ACrzQf1ugyWEwRGBOBLzEsXNugzu5DfeAc1sr7GkxlPXnlGsPs7C+V8I
        m8gP7jG6/CKKaRNUy/CfNwSciAMb3Etc2w==
X-Google-Smtp-Source: AMsMyM5spy55NXfBUltWrsKggDayo1j/QHeE8Kh5SD1MFscDUOLkIgX2UL6TeNAWXcinoGdXAMDd9Q==
X-Received: by 2002:ac2:5462:0:b0:49d:101:e1ce with SMTP id e2-20020ac25462000000b0049d0101e1cemr11197686lfn.289.1664315392413;
        Tue, 27 Sep 2022 14:49:52 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id u25-20020a2e2e19000000b0025fe7f33bc4sm279901lju.49.2022.09.27.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:49:51 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Date:   Wed, 28 Sep 2022 00:49:37 +0300
Message-Id: <20220927214940.244480-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
References: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
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

The PM8226 provides 8 GPIOs. Add a node to support them.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Rename pm8226 gpio node
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 9b7d9d04ded6..0c10fa16a0f3 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -90,6 +90,16 @@ pm8226_mpps: mpps@a000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8226_gpios: gpio@c000 {
+			compatible = "qcom,pm8226-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8226_gpios 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pm8226_1: pm8226@1 {
-- 
2.34.1

