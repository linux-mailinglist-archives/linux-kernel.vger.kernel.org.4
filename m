Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DB686ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjBAPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjBAPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:51:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8A6812E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:51:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so17734406wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9V6IrRFSec0QSkJNn1rqOWPstzO3hyR9Dg1Y2Z0JCc=;
        b=GEscF2KOEldxLMK5VihbL4pkqm+ni7eyKf4zn4zU1fDiXASsz3nHOwfAD+lif+56D5
         ajYFS3BGNH6hCqufvW8Dq3JFtZuybwCT6zHo9P/7amIaD7QSfft9ncB2OGcgjElU5epv
         zFCFwwshqJORQbWxT8GLthhm0AjIHWMsz7tpViUag7aAmzCH++ywCLw2rK7wre1InmDK
         AHJu32g1GZ+b/BZ8NZA0DIConUJj1S6fDb4RD/W27UnFpFL/w0sRoGAF7MzD+h15ilWN
         a1wlOTP2XLO5TBaHKqXgvnOUYuLBMU4F32iBRzoW1SobI2r5qftAFtD+fH0yYsl3wi3O
         Xi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9V6IrRFSec0QSkJNn1rqOWPstzO3hyR9Dg1Y2Z0JCc=;
        b=csbRTjR7klzS+bbsHyr6D8RUFtgLyEATbc1dUEYixCvKrCgV0YfihwIyjL27HNKcSY
         L6EgeYWY0Ntg4KQH9mG2PUHvfE1UEDuVhfOVA7kZFgD8e9sdcfzHvmyXyAZJi30+V2Ha
         S1kXxiIQIJR9CeS8/Zp/P1+4WXFX4no/5O7kHWMVDw4hbU8RO8my47KE9uYomZsOInk8
         I7w71NSjF+fyrs9TjsjH10yVxyccWvx36eoSDNNHIaxoouUofAqjxq/+fyUVeTAw34j7
         TkczgAYfwk38lWnRnYMOolFv88Tk97Khgf3aumb70ADUCa+QacmJYnYlQct5jvAGZS0b
         wPqA==
X-Gm-Message-State: AO0yUKU3is9si0gdt+GfskqF+taFDGtJngyZ383GzaoneTGWdQY+ik+L
        2rCoKGLCTVMFRcid2c6vSWOGtg==
X-Google-Smtp-Source: AK7set/qlubOHwmey/ay+xN3dB/eddt+pdCm947s4ISWhz2FVzvmzfCgzcfwyXKS9aAYi/Nx6hLtPA==
X-Received: by 2002:a5d:468e:0:b0:242:82a4:2bf4 with SMTP id u14-20020a5d468e000000b0024282a42bf4mr2121876wrq.10.1675266673690;
        Wed, 01 Feb 2023 07:51:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm14816189wrm.43.2023.02.01.07.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:51:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 02/14] ARM: dts: qcom: sdx65: correct TLMM gpio-ranges
Date:   Wed,  1 Feb 2023 16:50:53 +0100
Message-Id: <20230201155105.282708-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 619cafb6d9b3..13f98197141d 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -427,7 +427,7 @@ tlmm: pinctrl@f100000 {
 			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 109>;
+			gpio-ranges = <&tlmm 0 0 108>;
 			interrupt-controller;
 			interrupt-parent = <&intc>;
 			#interrupt-cells = <2>;
-- 
2.34.1

