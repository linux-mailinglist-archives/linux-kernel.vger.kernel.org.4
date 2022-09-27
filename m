Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17355ECAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiI0RhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI0RhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:37:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1751D3580
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x29so11759657ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JHCjDmNzA6ce+e/MAOdHluOTeKhVdn9kfCUAVEme8Xs=;
        b=mhk+Uhfib8taALnFf8/xniduw3+f9fqWBosEOvmW0RP+YzzPWX0otS6Xg0zcxsa3PN
         F7otZwy1c4nAy1QSzOuASXh2fasJhsR7wYNO0t/ms1KXERmMeffzVfrHKPWoC2k84qgn
         yX4W6r/U2YS1lnTaJasw59a2L1zA/TvYyr6hObHfQKtnEQWYM7ItNccmi8CfehqTuUzT
         kI0YRRDhelmsJiOW1z0Z1srgQzUsqCpXqlLmvjvNxOxzFek+/HjW4cv/eEWedLUGJrPo
         1aWHCATaljztmHYIsZryuEqc3xXgppF3PPD57TLJoIu83tChvf1hRiITqQHz6leN6ieO
         m27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JHCjDmNzA6ce+e/MAOdHluOTeKhVdn9kfCUAVEme8Xs=;
        b=2SOG9uiHtT9ZShZK6c1mrqVr5Y1bNhW3OAEKPE7w7xNNJi8r9SgVVstzalb8ly4f6y
         Fx4YCIE7F7K/VxA+mf4pGMS6OUDNb3ZMtWtNSkx9tqqywa9vL2QeiySbJgNVwEwshHmt
         fvkye7WufCSOnBEKo4BPtTW1HgjHpZfzr8UTYRYTN1Qt5nqr0dOXaHF4z7EvYH6UJO0m
         ljqoU64e3mX5n252nnqqHgwL8mfDxP8TlBjNFafl+QM/5FuoeBGaJOAsvwruUgyPGLg1
         VGnUgkjVwKCUT7jZzqolRkOcR/9kXrQL9m2x0nNEGKc0iOiyZccj+P9ajJ3MNTApSl8n
         F5Ww==
X-Gm-Message-State: ACrzQf2CIAKtXj0kBmsdVXIlefF6/K7uUw7rnbUVI0sSd5d7yyhERoRA
        XdVkLEEToD07yZR6zWwK5fe9Gw==
X-Google-Smtp-Source: AMsMyM6Qmc8joGC1ysYB2a4vBKpzT8ZoKIWrGsfQyo4vhGORDJ60H2BrBGtdEP2ZO7JQXpFbFAv51w==
X-Received: by 2002:a2e:7217:0:b0:26d:b206:b3fa with SMTP id n23-20020a2e7217000000b0026db206b3famr155058ljc.323.1664300234401;
        Tue, 27 Sep 2022 10:37:14 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:37:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/34] arm64: dts: qcom: ipq6018-cp01-c1: use BLSPI1 pins
Date:   Tue, 27 Sep 2022 19:36:29 +0200
Message-Id: <20220927173702.5200-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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

When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
the device node lacked respective pin configuration assignment.

Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v2:
1. Do not switch to blsp1 (Robert)
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 1ba2eca33c7b..6a716c83e5f1 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -37,6 +37,8 @@ &blsp1_i2c3 {
 
 &blsp1_spi1 {
 	cs-select = <0>;
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	flash@0 {
-- 
2.34.1

