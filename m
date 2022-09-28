Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC0D5EE007
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiI1PU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiI1PUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:20:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274485754D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s10so14715380ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oafNPI2RebJ690RXvFerRH66MRprlkRm3LjfeDmSHqg=;
        b=rx3XgFKIWsg50FkL77Hcvpne1R2s/UIdEdaD1noN+VnzxE0zgLAftUmiY7vM6NXTbv
         rFGcRIu8Z5JCop6SAJhSUm7RAGmtiOohzi0hc2YfgKVVYW4DCEqnie3CsQBYshX6HcBa
         l8hZpn0SXgZK+sWb+BSVUwydd4d0774BodCPHNP33temGZmZ554mt3VyB/y/XFV+1FDF
         naBkXxDbKZaYDQbiSLjbVq55vTTSANswu+FXaG+GdilhoLjQatT9yS06nq6QlfWXRk0H
         5X4QvMXGPrV5QD2UMWyUpHYW7zzhMHngkKNf5H/SYx8+RdOlm/VP80ZcOKbm08zF1BOJ
         iU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oafNPI2RebJ690RXvFerRH66MRprlkRm3LjfeDmSHqg=;
        b=KpVHMSD81yxuKWOFk+j/NOBgHfEAEIdN8R4XjD9PjxHTTStj6BgAh2IEShAWUKVAlv
         /0kHhm72QCWRRXM/INuoHo8ndwrRq9DwR0UpcCdjgJQV+V7eKL4XJKPThOhmfcaRs7tH
         Mv+oczfgegWnOWReZX6/unvgOUu7qK94/ZA2xG4W8SW2hOTqWhpZgprgwhF0a6csrr6v
         7Rz2XFNU1cMc0Z28mEzHltkWR9T7SGH3htxR6a4c09GW8SW9lvlnrIUAVibkxCkCSO7R
         q5NcXtmYDhyT7OekbJNq1OKQXNYzk5HQFWc5sfDrZ58KedPrvnWSSbd1w7VlhI0DxZ/S
         j+PQ==
X-Gm-Message-State: ACrzQf0uXpOoqxuQ/f3g6UIMeNl/NDDhEot0SGQJgHumMy/5USsDJy4T
        A2oSJMl+DLgkOQDWOHAA1l5i0w==
X-Google-Smtp-Source: AMsMyM4V25G2u71JmpUD75q/3Ny+L39I7/Urt1oiXNZiTvVJv/6gYVNpMKAK4bpOTvkCuwOIhRu2Cw==
X-Received: by 2002:a05:651c:1115:b0:26d:a0bd:97af with SMTP id e21-20020a05651c111500b0026da0bd97afmr4547186ljo.261.1664378438143;
        Wed, 28 Sep 2022 08:20:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b00497a41b3a42sm503023lfq.88.2022.09.28.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:20:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v2 05/11] arm64: dts: qcom: sdm845: drop unused slimbus dmas
Date:   Wed, 28 Sep 2022 17:20:21 +0200
Message-Id: <20220928152027.489543-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
References: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
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

Bindings document only two DMA channels.  Linux driver also does not use
remaining rx2/tx2.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2264bba69f84..1213f78a8b7a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3828,9 +3828,8 @@ slim: slim@171c0000 {
 			reg = <0 0x171c0000 0 0x2c000>;
 			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 
-			dmas = <&slimbam 3>, <&slimbam 4>,
-				<&slimbam 5>, <&slimbam 6>;
-			dma-names = "rx", "tx", "tx2", "rx2";
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
 
 			iommus = <&apps_smmu 0x1806 0x0>;
 			#address-cells = <1>;
-- 
2.34.1

