Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9760305B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiJRP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJRP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:58:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED72A2A96
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:58:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id df9so9559394qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyrr1GKzUYIMpFWVlAheSVsl7aNNeygDeG3I9WF4lxY=;
        b=HEQBGXL7dZIu1ypps03BHEFpnE3PMF6f7sCEGxqrsj4hBZB3QlXL4XXho/NizfuHiq
         iXe14RFrIKecLdMOvjJ1Kp5zat267X23gGqMyhoNICV2vEugbXM+rzWMNyOTIEMA5pf7
         v9E3av2l854Fh2/kmRMmjDBR3jH0hpflHvVT2MnztQuCtEVJaxZZieIzGIi5msk7KJ7U
         99g6pVluhm/Q9Q7xOZxddAaggS7ZN+JL7XsvIIorr21HYo0jNAs39S4Fz8H7KX9g70Cf
         AE5jHXcH8F2eAmX2btUxqSNSs0Ib6YQ4pI7hQyLhl/4mUkgEheByeaWQTDKMXOdBRrKl
         PmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyrr1GKzUYIMpFWVlAheSVsl7aNNeygDeG3I9WF4lxY=;
        b=VozE4PT6abaW4ib9cs8pf0ybglWA4+OmL66mSMRiyP310xaM4c0/2r3kXB5fS8J2/N
         olQfpF1U0WDaCNf2oPt/7joYRhj8/Cn8uG8DWigR1cCTI7oiAowNPrdRsLQtEmHmiNci
         1Oz1MHY0XewmZAtoZTqSJJ7/S7FPIe6XLnGtxQtxxKq5S/y3pjw3TaiIaTnEO7DNV1nH
         ZG7TUyuKtk6e+wbKffDf80RpSpEDMmqeD4Z7ZemMzgt63pBjC5j5s/H+CgFQ1oKdUAx9
         YX0QKuK5oJzqdiNvUKzb7hFxFupnCauWn3u+EvE3PJ8ckKm/mY4wtyDEMgEIaNGaImsR
         x9QA==
X-Gm-Message-State: ACrzQf1NHopxRz+yNLLyUcWrZlnxbqcLax47VvLLU6dXpbELrDgbA6ZQ
        YCD4JTxW+TpCGZvoAWzTeFNfzw==
X-Google-Smtp-Source: AMsMyM7kMnKXk90f9GxW+pS49t8OkZJXmVtkcvIe4Spj10MeHPBJy/kf/L+PLhlAQNMAFho8TVz4bQ==
X-Received: by 2002:a05:6214:240a:b0:4b1:cb3e:d49c with SMTP id fv10-20020a056214240a00b004b1cb3ed49cmr2782692qvb.39.1666108692280;
        Tue, 18 Oct 2022 08:58:12 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id de38-20020a05620a372600b006ce30a5f892sm2721448qkb.102.2022.10.18.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:58:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] arm64: dts: qcom: msm8996-sony-xperia-tone: drop incorrect wlan pin input
Date:   Tue, 18 Oct 2022 11:57:19 -0400
Message-Id: <20221018155721.47140-1-krzysztof.kozlowski@linaro.org>
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

Pin configuration has no "input-high" property, so drop it from node
described as Wifi host wake up pin.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v2:
1. None

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index ca7c8d2e1d3d..93568fb4bc86 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -912,7 +912,6 @@ wl_host_wake: wl-host-wake {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
-		input-high;
 	};
 
 	wl_reg_on: wl-reg-on {
-- 
2.34.1

