Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299105FC821
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJLPQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJLPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:16:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249F303C9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g11so5714491qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izSN7xRQqssnM767hbIgGLtwY0E8L+UfBxDaexTRlTs=;
        b=M6wQigtVJrVPC9MwqwM9yRS8mMnzbDo6SepkFNF7b3AsYFewTcyUeL3vcV4h+D+WpM
         pLguOZaXQsbK6Z3z1g4PoKakPvUekqRZW/Aed7X2BddyI3OnNFQC2C4jZTtrduwAxRL8
         18lYklKksityuqtq3tayqZoN3deGG/Rs5lARuQ8wLNpqi1rKhqU+NFCYmj6xRSAhbGA7
         JU1234EIygn3hHBiz1aZw69wp93zU3ad5rt4WsxUyDy7os+Arjh8HdsqSldJEJ5whTfJ
         v08dZ1v2nL2WCJ99Ml6LTrOVVZqiZDUxkbQrcwidd79EGs+XjVJsioSDEP6tnmggJvqY
         ZozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izSN7xRQqssnM767hbIgGLtwY0E8L+UfBxDaexTRlTs=;
        b=ogncJlSfBcMgzlbrUmWezmrzId6Xq5lH7cXnvM5rZD1tqrDpqwU09k+F2O9XNtx06L
         r5rz7P52WJOTT+Pc3g6onz2jAgj1qwouCURCKM05ER9/8mXmqCxau5wNn5xZsqa6ZK4H
         FIV17oHKBHfKnmmgw+g1unA2UU0tNbYFUfYsdTTCZdEJtp+ZfNiFcA3XAKcjvG4lCrPt
         Z0Fu4e3Eb9agbHromYdY8b2AM6P83nwCHIe9HhVm95mvMcFyWVEyFtFoxm2Abw1z5Mya
         Z0P2ysV+IVuRfTNyW0CJ0rqdDr+EJrcpSJAaATC0pKm1rzTp9xvJxG+BAgR5kB4Via3g
         OA1g==
X-Gm-Message-State: ACrzQf3dPHkPRCtOiybzwNGMx9KiU36rJaME+TtUPVo4KIXrtBaDCkBq
        Y57Yi/ABvp8WdYnHbZkPMCWIFon4L80n6Q==
X-Google-Smtp-Source: AMsMyM7jBS8OcjxwxEwcD4uNNieiG8sP6kVEP5POfNJ+BoROi19TVVYwpicNF8ld4KbkfuPlccRzOw==
X-Received: by 2002:a05:622a:1788:b0:35c:bf57:caa7 with SMTP id s8-20020a05622a178800b0035cbf57caa7mr23920283qtk.470.1665587779925;
        Wed, 12 Oct 2022 08:16:19 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a454200b006af0ce13499sm16671612qkp.115.2022.10.12.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:16:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] arm64: dts: qcom: msm8998: add gpio-ranges to TLMM
Date:   Wed, 12 Oct 2022 11:14:13 -0400
Message-Id: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Qualcomm pinctrl bindings and drivers expect gpio-ranges property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f05f16ac5cc1..2c4acf227253 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1056,6 +1056,7 @@ tlmm: pinctrl@3400000 {
 			compatible = "qcom,msm8998-pinctrl";
 			reg = <0x03400000 0xc00000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&tlmm 0 0 150>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-- 
2.34.1

