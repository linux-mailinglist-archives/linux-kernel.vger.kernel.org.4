Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406AA648E67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLJLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJLdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:33:46 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985641FCED
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:44 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id s25so293979lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRz05yeN/qwQTBz5e4TtGZQYPrI+58FT6y/SfoGhOcI=;
        b=WKFsm+iQRYcy8IU0O5tdPshc/ALdntlsOveHBL5R3cQ5IFiUbysAll/R5E4LZn6yiP
         UIoo5zbYnWLMVTLVKajPlzt87NoX4LY52meVzO4OyZL6rNM2WNcrA4Iq5qgseCa/zaA9
         KRrfOjjEA5F0s0VhuUhmfKiCfkiP6kdlDiLDQxb0ATjY+BAvbGX4oKPe0UxPCfPCV7HD
         CTQCQ4QLyTjiDXJmjRrZUxFnLbXOm/de6YIEGICS33VfzIPY4KtTx0pllsBVO1MnKnPA
         P056Jxvz4FOyjntYixN/wf4D971i2EKsIHW15CkAqxojKS7UjQ2nBzbNTv6Z2FPdxYcw
         to/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRz05yeN/qwQTBz5e4TtGZQYPrI+58FT6y/SfoGhOcI=;
        b=TXJ1xMP6KowWRY8JXj2JoStaZjQnXsP2gl1zxUTNyRrV0ZY2WiVaQPBNg5xIqKWUpd
         mkDbmH81MS9LJNw2PGYjmf39QnmlMO8XksUzOxBouQ504DTEd0BDPzKYNx/v8R1ZITK4
         Q8aD/BuUv34Wnhca6R4hY+Yhs6xuKNgEO/ftly5t1I22jXxJwpwvxDPYbg4+LNLErI43
         4osoMHHI5jys8vf6eGm1qfIv7ugkjTKmFvA9Ygar/J1D2kTKDramYHSNe+uzVcXO5EDW
         UpZdCtJOnStjWedWgQJ4r+YT93Hkrhkg4x1g4GTznzhD9sLr6AflcebJZsm5TRvHULAw
         WcOw==
X-Gm-Message-State: ANoB5plyis9IEZ6oIfK5lolzA779KsJnHgAbuSE7nufLL1RAs0RYlbdA
        FCJPOMsIZCuPBKIUA6kyw54MxSMzyQGUAeHi0sw=
X-Google-Smtp-Source: AA0mqf65nzdmBAIdxQ65zS4pveV0d/c2xKSl/0rtWSo0HucAb9+YTa9kH+OMLjhuF4uoqblzBBqe8g==
X-Received: by 2002:a05:651c:49d:b0:279:dfe9:df87 with SMTP id s29-20020a05651c049d00b00279dfe9df87mr2185668ljc.36.1670672022887;
        Sat, 10 Dec 2022 03:33:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b13-20020a2eb90d000000b00278e9c0d3a2sm571741ljb.33.2022.12.10.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:33:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: drop 0x from unit address
Date:   Sat, 10 Dec 2022 12:33:40 +0100
Message-Id: <20221210113340.63833-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

By coding style, unit address should not start with 0x.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1a257f672887..a63dbd12230f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1636,7 +1636,7 @@ uart7: serial@89c000 {
 			};
 		};
 
-		gpi_dma1: dma-controller@0xa00000 {
+		gpi_dma1: dma-controller@a00000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sdm845-gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
-- 
2.34.1

