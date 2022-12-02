Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFE16409A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiLBP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiLBP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:57:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC4193F7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:57:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id be13so8040571lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YbiQi8bpVzcfCjoZJyL06JibybCKaHt7b1twZeD9Ow=;
        b=iq4Yg0chddeZ/+a+TH7hdmk7jz4NC3LXdjGWASg5iv2ySSOkMQmsCxRscSlOAVzGlM
         i6FACaaNxNSr37RCfDGqXPWAHFEe6ju4svzxl9w6Ghbgxx4OfyIxxz+/4ALfmRdhDVS+
         zF+YigAQ4EpPxwe0nNc5c5rLzAN/ZfUU2hwgpJFnFL5sGIpZU1Ygh5RgigUP6NZ5JNhS
         oA2cuYsIMnckPURgKRBd6ywMeqNuL0GaKKAJBaLYs8AL4ERjM1LR/LCrCEyl0peee/jy
         1J1Js760+8ekAw/oQ8vgnlwZ7ENAS1vAc9LeuCCbLnsHrZ8WKb8ilJchKUapiChVaTn0
         UeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YbiQi8bpVzcfCjoZJyL06JibybCKaHt7b1twZeD9Ow=;
        b=OvByPPs6XRuDILc+0hGPbm5HgnAuXcqPwJdV44cjlTgCaqPuIwfJ4sTP3c7q7y4Nu2
         Ky06cC7kVly0rtqWb3j0JPofN30gpAhk7E3/vzZGyq5QKiBQPTbxuT7wQpidOtQbw8+6
         6ahEMXEBFka+l05PkwnbIuRrAETmNj0IcYghy7Sr9FoqjglTXoxePtg6DsYFsm9RX5vJ
         Td25HXFiyawGIkQKBxu93IMlJbpJGmYlkMu16BwfDxZXg36AJxF//FY1pd4F8B19oPyA
         650QoKauvp7SISmg7YLjzoSXMfQSGM0JLS/ooTjQBd7tugMqhDmmx/Rt4zMT8d0t87lZ
         Ogsw==
X-Gm-Message-State: ANoB5pmuRmtCDEEqdMdneGFbjmqzgj0z8OgnawfFGOniFay15Rm8XNpv
        sEyBvjV/jUghV/p+yb9MXJPb4Q==
X-Google-Smtp-Source: AA0mqf7s3RliaLsyzAtkDaMbZCuLfy4R1OzeVMS8XQ6V3f3kYsxxyIFggzAuQUFFvANvd4fYvEvpoA==
X-Received: by 2002:a05:6512:2203:b0:4aa:83e6:53e8 with SMTP id h3-20020a056512220300b004aa83e653e8mr14950951lfu.606.1669996666905;
        Fri, 02 Dec 2022 07:57:46 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25e99000000b004b4e6dab30esm1049133lfq.222.2022.12.02.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:57:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845: do not customize SPI0 pin drive/bias
Date:   Fri,  2 Dec 2022 16:57:38 +0100
Message-Id: <20221202155738.383301-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
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

Each board should define pin drive/bias for used busses.  All boards
using SPI0 (db845c and cheza) already do it, so drop the bias/drive
strength from SoC DTSI.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Doug Anderson <dianders@chromium.org>

Changes since v2:
1. New patch.
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e6019009533e..1a7999843dd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2785,8 +2785,6 @@ qup_i2c15_default: qup-i2c15-default-state {
 			qup_spi0_default: qup-spi0-default-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "qup0";
-				drive-strength = <6>;
-				bias-disable;
 			};
 
 			qup_spi1_default: qup-spi1-default-state {
-- 
2.34.1

