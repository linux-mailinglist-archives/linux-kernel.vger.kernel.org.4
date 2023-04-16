Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66E6E39AA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDPPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDPPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:13:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A8B4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:13:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy21so14875364ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681657995; x=1684249995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0FwNqPmFNcBc6gNeUkbk5w2eyQa1n9cXA/EEwQ0eD8=;
        b=mBMBHAEolCyScD19Y3Pl0cKJJWNrWHtvS5fjugImboq/fh51syteJWAxpzdps0i7ot
         LSsUbAmqHe1VEO8ZBZ6Jbcwow1hag+X22Zlz2Wp1SHmox/ul9HQs8VQIH1shKMWI4tHe
         2JVqDZGne9twjY0BybCymcBr+JIDwFOAODAR0uI/fVKUKiiV1kaCko74+ZFr71fLhcJm
         v3sPsvnMFYJgv+I0ny3zq7w0cardBBZeG0g+Upt2HiXl1McF4+LYaqnF7j56695EuZaf
         Rk5r2Y9ks1M2zpnz5nOLWP96OQv6O8xvOhxERtvs2uG2qCLMJDl/rJ4TAY09QzxUidFh
         LPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681657995; x=1684249995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0FwNqPmFNcBc6gNeUkbk5w2eyQa1n9cXA/EEwQ0eD8=;
        b=DUM7+3OJC+K2ZVfk5G91O1hZX5BtKdK6UoXlEhYW13lSS0SZbx6zNFXIXMHQylOFgO
         SPHP6iT6jirXtx0E0/XRQ575H1Sqz2kzQmEXif86H/1tBs9XleieDX6tzgi5OwiMw5F/
         E+3CZNkFpntFAMuQLj7nxlEj+ynJItqHjKI+cbVzj1cj88iS1gLJDE6QI6j5JjxpLqGX
         TQF17mYfFO1OWS+oXl2ekXQ6LGcNuIUqniKP5fkjktXGgYGuhXtU73ilgHpR1NK0bkAJ
         rr1vXv2lLB0kQ8TOwIvhVxslyhuc0U0DBLX0laOQmckE6CJAOEwotBtG5HLirxNuN6TR
         adaQ==
X-Gm-Message-State: AAQBX9fkmrFT121+0ez0WJPp2sIBStJ9gzgZEQbaW6S0fniOFWsDMw/4
        3F+PScs+tpc7KjXOOKjUeE6TQSUrHgLgNfoRZgo=
X-Google-Smtp-Source: AKy350Yv0vwPsZZJ0E6T6BzIIIAg9m/y8/chI/Rdnk8x9vop1eSrsIRGL2+IUNc4ldXX1Wfn9fbcnw==
X-Received: by 2002:a17:906:1317:b0:94a:6f0d:38a4 with SMTP id w23-20020a170906131700b0094a6f0d38a4mr5748778ejb.7.1681657994990;
        Sun, 16 Apr 2023 08:13:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b0094efcc4a076sm3009201eju.164.2023.04.16.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:13:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8150: add missing qcom,smmu-500 fallback
Date:   Sun, 16 Apr 2023 17:13:09 +0200
Message-Id: <20230416151311.346596-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
References: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6c84bbd103d8 ("dt-bindings: arm-smmu: Add generic
qcom,smmu-500 bindings") the SMMU is supposed to use qcom,smmu-500
compatible fallback:

  ['qcom,sm8150-smmu-500', 'qcom,adreno-smmu', 'qcom,smmu-500', 'arm,mmu-500'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 3846f5e0f656..024b3c79ea11 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3983,7 +3983,7 @@ spmi_bus: spmi@c440000 {
 		};
 
 		apps_smmu: iommu@15000000 {
-			compatible = "qcom,sm8150-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.34.1

