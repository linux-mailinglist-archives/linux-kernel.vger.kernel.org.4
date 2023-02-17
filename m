Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63569AA21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBQLQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBQLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:16:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB776664A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:16:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bx13so755497ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wJq/iqxZ5CY0MZ8/qvZLLKvRq4WEHI7wVVOEpRQbpw=;
        b=MC0poj+iXKkHo+R2YU6rbuzxgf0jQAaVXqzsfYcg40ZF3p+sobPJSFb784cEKAph2V
         omQrmbXAmq+e1xvIDhXtXGahku8AXRkp8Hz9BUHYS5N2NI75Ie5HsrrrN1BrptallZmn
         2TwPVpLlWyflzhC3CIJhIZ1SaXKypl1Zl0Cp2u4JDIn8IGlNRUVSobKIjOAUsFJgLCn8
         HhnKdH+BWhPGRNFicVt4LPpwUvJgaFW9pffXdR9uy10rZ3UDaL1Nto35bJYb/NaH5hcx
         +KiYim1dXAd7QtUADL/nmLwNcpU2tZuRtQJm4+FhOK/8RdcUA45ToDW7owata6sb3Ddb
         /jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wJq/iqxZ5CY0MZ8/qvZLLKvRq4WEHI7wVVOEpRQbpw=;
        b=vUsWLyO7wKXKSYzG7HKcKVNPgw7aMFwHZwi+VcDlgjr9DaCAG9u7/RAvhvdLaSI2NP
         f8l6Crc7ULghz5dYjlq4wXfbaKCEdhVmkq+Q7sYjHZdh0zaVJNe121Qw6Fx3/XjSo/yf
         2DyeqnNJ0S/zRSre0yIW5Bw+O2hU/VMP3u3xUDUmTyvrG3Xd8UuJdmg9RVFulA5UUaIQ
         scDIGk5PYZ/1chcXq3Tjraw+F4SqZh/U7JlJTP5m2xQ4oW44o7IhoPh6P/ubL7cbZ9ck
         14bLzmc5eaPpDEsbw4kbMv3+XtmdI1wMrkHM1v0JiV3GQhu6Gx6BFNkmMxyd0Q24TXUO
         BWHA==
X-Gm-Message-State: AO0yUKUrPpY2QG0xAKNX+LeRrVxSXbCw8u3lbGUpDvAUTydvVxke/4hO
        xNTgCYHU5jW3DRCwMHdAzwlmDw==
X-Google-Smtp-Source: AK7set+MHcEoedvXSDYloedEh6Y9Sy1Tzo13ZFKtLdr645Gc9MRYQ7gRjlpO3L0eUgXSthIRnqVygQ==
X-Received: by 2002:a05:651c:1031:b0:293:4b8d:daeb with SMTP id w17-20020a05651c103100b002934b8ddaebmr66584ljm.34.1676632583401;
        Fri, 17 Feb 2023 03:16:23 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
Date:   Fri, 17 Feb 2023 12:16:10 +0100
Message-Id: <20230217111613.306978-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
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

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb74925313..a8227bb6b336 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2677,7 +2677,8 @@ dma@117f000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x20000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.39.1

