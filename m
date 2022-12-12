Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284964A0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiLLNdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiLLNdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:33:12 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207813E18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:33:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so18553021lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyGn1DzomgI5Qa0YLeZd0l0VrjDz/wGrgsCv02M2m/0=;
        b=KNptsQKiTTUk1mjZAHJjNeIxZQCeUuWUbucs9gQItJcdV3N9enEiocO0rNn4Usu2mz
         0aJR/cS5idITBFj1MB4jMYVuFjV/K3878mcRirnVJeQQhKE9fjY95Rjdr//RmXgR47yr
         OA18f59QFhcgOxDTSazABL9x73rXezn4f2+4ykyMd+BtTW+1qmk7MH1aolq3yQ7AvEm6
         EAnoVdrz/IOsREc84ml+p2eHMnilusYxt22reLdribGERNbNVB69H/GMoLI4PFIhrf2h
         FCtzGLM4fhwTme6chod+8amR4Opi8te0JcwvXALgyGakUMB5+DZWsmWIdP3951orDxYA
         svtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyGn1DzomgI5Qa0YLeZd0l0VrjDz/wGrgsCv02M2m/0=;
        b=aYZSvfi6oh7dFvdrLgIWRUCtiMUDlp0FRY2CqXbZsccXMPZ9+Cbx2pBpKKl/cfN+Pb
         fU5MujzlNukl13WZLbWT2w3KWOfS8pGfDyhqL6YnfDY8ehyCECRWni8cBZ/fxjqUgE2S
         Nnij7D1cME8g/c3LvbOuZRncRs/2AchQ4TphK4bU/jJLTor9IMH/T8YNRd5PzVUZisSl
         ouWb4C4lqqghgjQibbyrm18do26rPC+e4dei03ZVYEHFz1AeBmr4+t9yBJG45TApg7Vi
         Fn3/dqxY0oPmQnZ1fj07qggT3GRL4x2tDZuWjtfxTnjy5ZlxKI5qalN3SSt2AYPYlg3q
         Fa1w==
X-Gm-Message-State: ANoB5plqoFmgZ+fs/55LTIjvpKb2aQPQStNJE8R++B/wh8zdYtVWdoxZ
        60TRNwbthdhgYfV/tC0oG2uH5w==
X-Google-Smtp-Source: AA0mqf7nadPTddEwlQiqnOUzYpE1/ZfAgUC5Apodg0MFD1otIMRJrb+q9pXarRdD8BMjPTBtfb8ikQ==
X-Received: by 2002:ac2:5dc5:0:b0:4b5:a5c7:3282 with SMTP id x5-20020ac25dc5000000b004b5a5c73282mr4295787lfq.61.1670851988257;
        Mon, 12 Dec 2022 05:33:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a194f52000000b0049478cc4eb9sm1624435lfk.230.2022.12.12.05.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:33:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sc7280: correct SPMI bus address cells
Date:   Mon, 12 Dec 2022 14:33:00 +0100
Message-Id: <20221212133303.39610-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
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

The SPMI bus uses two address cells and zero size cells (secoond reg
entry - SPMI_USID - is not the size):

  spmi@c440000: #address-cells:0:0: 2 was expected

Fixes: 14abf8dfe364 ("arm64: dts: qcom: sc7280: Add SPMI PMIC arbiter device for SC7280")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 448879d3d5cd..7c24c2129800 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4286,8 +4286,8 @@ spmi_bus: spmi@c440000 {
 			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
 		};
-- 
2.34.1

