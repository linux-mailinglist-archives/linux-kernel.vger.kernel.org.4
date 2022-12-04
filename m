Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E11641C28
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLDJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLDJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:44:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C158186C5
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:44:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so14188842lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3HomfrFO7xrccw3wI23gM/KzW1+sQcHf2I8oAsV4RXw=;
        b=SKqzIr8KsMkO+CAmLfFp5pRbO+C6Gj2T8N1vYgvSuiXbxvVcj/umaZgBJaky9Q5DZU
         fMpW9dlDIj7KC34SEM9vj6JKhPRwL1QGFlFr0WnSxuqelxvMb3LhEOEBlahB9e0q9n4e
         MAe82H6sKIwRNo8Uz4rusEH1tLHcmuM4faLmnka66QunAeJq/GHT37ntnsNTgQqeQ1A7
         v73pntyJpzSxi+kGLU5QKmrCLeLOAzOdSk9L/cGdjU8Xk7NwOCCVJhqSCkwuX0p5x83f
         0Ik7TL5t2PAgsuWP8wT1qcokP4q/ZCF8H553hYlS98mKyo6jNEbilqRjndx55Kbzqedl
         RKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HomfrFO7xrccw3wI23gM/KzW1+sQcHf2I8oAsV4RXw=;
        b=Dwsw4NuRNFfhdMvdbBszP82+hGc6oopH7BH7m89H4gCJyQ7s52a3bPWXDsk9AI3G7n
         Jp5e7xgWW1DqZ5cZOixYHohjZRvsNZws9JbXJ8+7rjaCeYTY4vZMt2cV2ABRFoMKAiiw
         ebmWcnxfFK5d5VNteu+dd/99I6cr/KswIqqtf77V4JVZqcnQgJyZxGcqzWPkbBdH22a2
         dn8TQogYSXN/8To6onjXfv5/8QBxEqBuNgY2BIQarqyvASXr7dCQhQkv0kJEKE3vQdwp
         dVjPhNOQPQdhexm8UXOa+GBVAvwCAcOHhxgRvJMkD8BXm1aL8a+UZi+A1KEpxaihdD2m
         n56Q==
X-Gm-Message-State: ANoB5pkcw+TdecTmUqiFfa/p0fxGQCNkOSZ8QX5848A50aZ23AePmp2j
        LI7n+At04JmlnYKiiJDGK16OpQ==
X-Google-Smtp-Source: AA0mqf7vkCSWy0BKQH0xuK5+sTe1C11QhekXE+IFDwwBFVjZPU5V30kk311AWrs43FJrQc4nt6YMgQ==
X-Received: by 2002:ac2:5981:0:b0:4b5:6990:3c94 with SMTP id w1-20020ac25981000000b004b569903c94mr912599lfn.27.1670147081717;
        Sun, 04 Dec 2022 01:44:41 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o10-20020a056512052a00b004b07cdef19csm1711593lfc.138.2022.12.04.01.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:44:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] arm64: dts: qcom: sm8450: align MMC node names with dtschema
Date:   Sun,  4 Dec 2022 10:44:33 +0100
Message-Id: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
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

The bindings expect "mmc" for MMC/SDHCI nodes:

  qcom/sm8450-sony-xperia-nagara-pdx223.dtb: sdhci@8804000: $nodename:0: 'sdhci@8804000' does not match '^mmc(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index f20db5456765..e0d30dadbf8b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3354,7 +3354,7 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
 
-- 
2.34.1

