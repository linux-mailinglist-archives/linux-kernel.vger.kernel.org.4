Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCA606B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJTWvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJTWvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:51:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A522C824
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:51:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bb5so587231qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d0WBFX56sckxA0+6YMdtrdXnrPlYGDpcEgp9mhKEiY=;
        b=vv1bq57sdTPx6QfN0/v613njWm0K6a4DKgxVJja8lkZeMx0Vt6GaA3fNCAXZhUb3t1
         eEF18Re/UO6ytjevHLkxRcYRN4N2x+4LxBacxIHtCKVXpFmj0In0iqLAhVJgxd+TNG3a
         mKhm3J+iuuVi+5N18TN/VNyOCbqsK2CQffu6J552wqzVI7cykT8puGaTyihiZTlKcbPE
         yQhQngULjLo6al0uN+wuqNj6OXJh/fbbygTvqBf/LGJkSs1wZw/YhqaVXrB0LSox3iXk
         mL4VE29knSMaGj8BKjkRN80pYDOBTUpHBqszQC1vDAABlqj3d6zbeP2uUqjmL/ybM7Iv
         066A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d0WBFX56sckxA0+6YMdtrdXnrPlYGDpcEgp9mhKEiY=;
        b=RdefUE9NfWP/LqplOxcT+iHYTB/iCFkVGI3HU6RZ4eOLhv/mMQqCGKs8zBY5g8/vI5
         x1Faj3Qjei/+g7AB6x/9uGNoLzLUEoYY7gNN1sdEFOr9O8kxu+3KoEX8YkP84jMkzw3q
         Xi/rq7uSwyJT6lJe2I2HdzdLxMR9gB62/3mXu/5rXSkQ/5MPtgS8whq1rhpveDzwCFWl
         MdQXeO8lLJJjoMtg5hkXuoWwqddLL1tcCNUOsMKIyG/EEtd4kb6FXUWeTN7X3N6uoBEg
         r/kDclVzZB9JybedIa+MdLrEbvjEpptNOhCkRUbnOv0nXVWUMfEf+W8dl8CoOQvDlKfr
         V8BQ==
X-Gm-Message-State: ACrzQf1ghjtST8jOrE5cRwqi0fHuVwPBKoxek9NnAzCceNN8Mk/LF8se
        mxFsvdai4HTLH/He32ORnZoW/g==
X-Google-Smtp-Source: AMsMyM6DETQrkZmxclQrHqqT2YjHFveSLmkMum6CjJJVGLohI1vRFe6XzwPtawT3Y5T+956fSnxJyA==
X-Received: by 2002:a05:622a:2cf:b0:39c:e120:4acc with SMTP id a15-20020a05622a02cf00b0039ce1204accmr13439784qtx.152.1666306300921;
        Thu, 20 Oct 2022 15:51:40 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0039cc9d24843sm6903479qtb.66.2022.10.20.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:51:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid glitching SPI CS at bootup on trogdor"
Date:   Thu, 20 Oct 2022 18:51:34 -0400
Message-Id: <20221020225135.31750-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e440e30e26dd6b0424002ad0ddcbbcea783efd85 because it
is not a reliable way of fixing SPI CS glitch and it depends on specific
Linux kernel pin controller driver behavior.

This behavior of kernel driver was changed in commit b991f8c3622c
("pinctrl: core: Handling pinmux and pinconf separately") thus
effectively the DTS fix stopped being effective.

Proper solution for the glitching SPI chip select must be implemented in
the drivers, not via ordering of entries in DTS, and is already
introduced in commit d21f4b7ffc22 ("pinctrl: qcom: Avoid glitching lines
when we first mux to output").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

---

Changes since v3:
1. Add tags.
2. Update commig msg - mention pinctrl driver fix for glitch.

Changes since v2:
1. New patch

Not tested on hardware.

Cc: Doug Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 27 +++-----------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 1a1c346d619c..33817358ebb0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -880,17 +880,17 @@ &sdhc_2 {
 };
 
 &spi0 {
-	pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_cs_gpio>;
+	pinctrl-0 = <&qup_spi0_cs_gpio>;
 	cs-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
 };
 
 &spi6 {
-	pinctrl-0 = <&qup_spi6_cs_gpio_init_high>, <&qup_spi6_cs_gpio>;
+	pinctrl-0 = <&qup_spi6_cs_gpio>;
 	cs-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 };
 
 ap_spi_fp: &spi10 {
-	pinctrl-0 = <&qup_spi10_cs_gpio_init_high>, <&qup_spi10_cs_gpio>;
+	pinctrl-0 = <&qup_spi10_cs_gpio>;
 	cs-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 
 	cros_ec_fp: ec@0 {
@@ -1422,27 +1422,6 @@ pinconf {
 		};
 	};
 
-	qup_spi0_cs_gpio_init_high: qup-spi0-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio37";
-			output-high;
-		};
-	};
-
-	qup_spi6_cs_gpio_init_high: qup-spi6-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio62";
-			output-high;
-		};
-	};
-
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio89";
-			output-high;
-		};
-	};
-
 	qup_uart3_sleep: qup-uart3-sleep {
 		pinmux {
 			pins = "gpio38", "gpio39",
-- 
2.34.1

