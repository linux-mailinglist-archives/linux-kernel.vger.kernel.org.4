Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41B26E423B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDQIJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDQIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:09:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A03A99
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:09:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a5so5305645ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718992; x=1684310992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF10OB5S6d78EpPJ2qGhdqhZ1znjtUNINpikwJ8DHFI=;
        b=uI3PRwroiSLQiiSn5k/CvxrE5xshoCGVIt3Gyy2EVATTNdk4ouVHs54+jvl0wynqOQ
         4uKw9QKWZKkU/tXvXJVhR5i1eIdyhN60OPzuQnvZTYU303WwwOFTZF14u3BQTEeG0FWb
         iA5e95ntrlTsbD1xJlbpv3nbfX9Co+1Iry9NQN+utESmG5pnPhLO5lJK0UvFYpzq0pDe
         PBR1XigHuqKSi4252ud34XReCffqnudFEvBbb+gTnYJCayE50xxbNEq9nIE7rcM3tJgN
         9zDGHwT8tWUFidFgnuMrdDI8TpOECGpaGl+cxwMIH7X0NihGntAjEcRxZ+2Ntp6k+BYo
         TJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718992; x=1684310992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF10OB5S6d78EpPJ2qGhdqhZ1znjtUNINpikwJ8DHFI=;
        b=iAx+U9OyNkLvE0qCyAnU72UfpOyaWQNgnjbFjVOUgtjJ6laISqMvsQVT01Ajj0tjJc
         q+X0kFR30+mcqCjO+88onvZhPBObWGpVYZyExYkAZ2BY5Cdji68w2xMhjbY+KjE+Rzom
         xmOT2FiGnZHwLv9WIjYNGOaO7uEaQrcdru/CDXVlOYK4270UZNaR/8+oRfqxFrq/pCOP
         rXuW02MRY7/bKqyWVptlXZATn2skXZ4YEn5Pi6psyRIvy/szTL0dSmBzLjMZP8ltJrk5
         ENdJXX6eYsyCPMLA6j9YmwFfdqY2ClBbzzpBPd97CGO/wdWX0moUywNb9nuYKC6YZDGU
         MxfQ==
X-Gm-Message-State: AAQBX9dJ6R+i0JCdGyeLJriskyzFEJued3G5cUNzY1TOdRS6/CBhooOf
        d5Gfeu4ac7GOkLSmETdXVFZBGg==
X-Google-Smtp-Source: AKy350agwT9WuW+BITUjnPaALRKbriFu6A0yl/usZql7Pj90Ah6fKsLvipXfrNLgWzwY5AOeQOdlZg==
X-Received: by 2002:a17:906:3e1b:b0:94d:69e0:6098 with SMTP id k27-20020a1709063e1b00b0094d69e06098mr7682450eji.45.1681718992511;
        Mon, 17 Apr 2023 01:09:52 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b0094f7da9f1besm988179eju.61.2023.04.17.01.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:09:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8150: add missing qcom,smmu-500 fallback
Date:   Mon, 17 Apr 2023 10:09:37 +0200
Message-Id: <20230417080939.28648-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
References: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6c84bbd103d8 ("dt-bindings: arm-smmu: Add generic
qcom,smmu-500 bindings") the SMMU is supposed to use qcom,smmu-500
compatible fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct compatible and commit msg (Konrad).
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 3846f5e0f656..25085621ef49 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3983,7 +3983,7 @@ spmi_bus: spmi@c440000 {
 		};
 
 		apps_smmu: iommu@15000000 {
-			compatible = "qcom,sm8150-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8150-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.34.1

