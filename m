Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA26B04C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCHKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCHKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:40:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A59CFC9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:40:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l1so14837455wry.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6crUD0nELm/BVOKaOmrsnATs1eKM4ep25RzmB9fG+c4=;
        b=6BzixgFox6capZv7CQM8jct/uzDTPBatobRgwmWp5D9zZHFsMBsqa8rliMbu5rZl2H
         03J6CdayY1o9YfFwLasMqNBBULVtNW/hN8eG4C6tPuA9dEBr9NNjRvcn+BgKBFUblB74
         6WY+VXb6QB0LcDSkb4/z+tIpQkwBtQjNj/53+FNm9EKzMhot9LKtqvvxP1fGQd2tnAVv
         1bXqMR/ThgMnId4sfDkHJGn4sLALd5E2THYblDLZHuGR6O0npcZm4ifkHTV0xY5Mdkzz
         yn2oUq2sSH0+stRk2PSAThsXZq63Y7brJZog7wrlBWv51BSNdPwz2thx5J7+Hza4Ah+Q
         EphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6crUD0nELm/BVOKaOmrsnATs1eKM4ep25RzmB9fG+c4=;
        b=rOkQwvHkoKQ5xYZv3G8Ca12Ui9dCAbgebAHMyVR6ZMUYDlZUYu8cgeiH97S/HjlQIb
         d6+jE0LudKP2WggxL8u/NewgcM2sP9Wonfgb921SnsfnXVSE01yGBntyipBsTueXTtyl
         CuOBmYBjNT/whRN3+F4aUVN9b41CQwRALM8/9FCfBFuC2+VGO8jICL1zNIz8lhUxnw47
         /E15bxXdIja4iLCTei3lqDCGxrmlAb+EPUzYvlwLGsbC4c7N89Aghg5KWBsKWNU5+3iQ
         n16qcjF0sCROR7w45Pp3i7m+074Yn3+Mk3GVtqswy1DN7p9gYu1SmKMqlJPShbICyKOV
         sfdw==
X-Gm-Message-State: AO0yUKXt09sHusAZIvnyCXQwAvMhSwdxvUmCPJAROkQ2Mgy89PbYW1jy
        Mg7vttEhNzAN374rrNrKEhPhwg==
X-Google-Smtp-Source: AK7set/n2FVksWX9l/ZnXw3LrpxDHYkhQHvlHFYtw1uNqGvwmOVMaS5MgBjjiPP4w7bYpfL/nQqc8A==
X-Received: by 2002:a5d:650d:0:b0:2c5:48bd:d494 with SMTP id x13-20020a5d650d000000b002c548bdd494mr13303404wru.29.1678272015023;
        Wed, 08 Mar 2023 02:40:15 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2326:fd4c:82e3:7e07])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm20664135wmn.27.2023.03.08.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:40:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 1/9] arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
Date:   Wed,  8 Mar 2023 11:40:01 +0100
Message-Id: <20230308104009.260451-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308104009.260451-1-brgl@bgdev.pl>
References: <20230308104009.260451-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the second instance of the QUPv3 engine to the sa8775p.dtsi.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 8e15a24e11dc..5efb3e4f2335 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -491,6 +491,19 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
 			};
 		};
 
+		qupv3_id_2: geniqup@8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x008c0000 0x0 0x6000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			iommus = <&apps_smmu 0x5a3 0x0>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
-- 
2.37.2

