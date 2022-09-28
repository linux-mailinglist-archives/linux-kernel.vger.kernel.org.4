Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245875EE00E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiI1PVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiI1PUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:20:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BB57BCF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a8so20850123lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Fxkwow1Xm3fK1Et6nbVH+mRVG5q33XL6HKbPhtZeFeU=;
        b=QDsG7hY/7DZUkGD0YGTss7p+Xl18GN0cleD581EklbcIouPa0r0TkAgn5K9ZVrJITc
         g0rVFZBHbBBLnqWC0IJqcb8ZSDxkMF1/g1Bm2nkrwrTuVNO9hAZ0Wu5TkYPmUU35F3b0
         fTep1WP2xVVMm7KEItmd6+E6v586wx3YjpWBGw8ToWsV1k7uwUtGhW/d49CCir+E3fh/
         1f6Mh3KQokkceYmXX6aJuY3b6OktaLmFXQsxJ5eK+QogciKQTw2UN1jeh6/7k+f1Yx2O
         qZynMwepNFnFOdGbUMtEvgFc96xLoYr3SXKK/GFGyQ611F28dDvjOPNT4p3VQ+Xb8Fbt
         E4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fxkwow1Xm3fK1Et6nbVH+mRVG5q33XL6HKbPhtZeFeU=;
        b=C+5uq2Vz/vLjHViw9uRr74gc087wr2Bl+pwYmT4Hsfymrj+HYmce3ISG4eum+ZOw/z
         sXCiXTLIUeg5XQJF0XZv7BPmQJmCV+tP1A34Qbww9O0jwGCqiPbsg1WQQIK3PHx3qwUD
         X2R2otMklqKK6aTNgrSlqf1P1TiDxyEbFysmZlcKlQiHTAOAbACA1oBSE8efBCPKltXl
         zNEYrSr+advdYr7VqO/I/tS8Noe0uola2Gz8pkTqNmLrSfEC0ZwgdmA2V9zVnX4u6XvT
         F4RqmCYuVEyWOl839KvgvbmGf1xvJ6KbnqnXNzEBh7GwEQsNuWoOjqXL7NC2/jtQUMVe
         RLag==
X-Gm-Message-State: ACrzQf2kqb6VeUb2V4SApr3sIkq7SOzIYjp2Zt8Cjfv+LQHqle04rrn0
        KYIGJMXQMfIO2xJwK6ITzIu87w==
X-Google-Smtp-Source: AMsMyM7MEmEEYjwpUyW2Aqu4/Zc0FmSboH2I7oUiVISmK/R94LcrgrOzhmd4P11ngCZB4ztwJgHsFg==
X-Received: by 2002:a05:6512:1285:b0:499:af40:afaa with SMTP id u5-20020a056512128500b00499af40afaamr13346756lfs.540.1664378439345;
        Wed, 28 Sep 2022 08:20:39 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b00497a41b3a42sm503023lfq.88.2022.09.28.08.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:20:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 06/11] arm64: dts: qcom: msm8996: drop unused slimbus dmas
Date:   Wed, 28 Sep 2022 17:20:22 +0200
Message-Id: <20220928152027.489543-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
References: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings document only two DMA channels.  Linux driver also does not use
remaining rx2/tx2.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2c5908d104f7..8b31f4655cb8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3313,9 +3313,8 @@ slim_msm: slim@91c0000 {
 			compatible = "qcom,slim-ngd-v1.5.0";
 			reg = <0x091c0000 0x2C000>;
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&slimbam 3>, <&slimbam 4>,
-				<&slimbam 5>, <&slimbam 6>;
-			dma-names = "rx", "tx", "tx2", "rx2";
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ngd@1 {
-- 
2.34.1

