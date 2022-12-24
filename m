Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C009655A95
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiLXPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiLXPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:43:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E45D2E8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:42:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bq39so2910422lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysaSn2ynBsG9iGZ/g/I8NJdHeBVgacyPmB6wiSk/yPU=;
        b=o8eHYnYEKtPp1a3dVDvtK+xXcT1LG8+Jm51T4Xm7Kg0b0xjIKAPGSz/Hs04kqJNHzW
         GTB7XYMs+SOO9GemAYdQtwWE2raCo2kMoRsJC0s9pTje0DiDDFe1JR3SixGs+4WnceSh
         5z+FI2oEogM8vx3wxAl+eV9vRyZPXbzl+pqohnzGhRYFi4phRYUqtKIzY9DEZCKQDLjN
         dzZjvrEtAxLpPSLv25Ig0UDcFcHzUzfV+5DN1uQqMkz4DM4GD54C5r93vrhpy8yF4a5O
         DOM66FfNs8MLGNagsM1xaYSvcQoX4UFlpOfy89dDSVKcGFSXITNpcYO7xKspe6wnrllR
         Xtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysaSn2ynBsG9iGZ/g/I8NJdHeBVgacyPmB6wiSk/yPU=;
        b=eRAnE3p0JSkjiZk9qJX6clALoGHNNXkaluVdzowHv1TwayyQlIsq9C5eTqEd3RWG18
         8U6rcaJMhRXbWWbIKdg5VAQk2Wyw89wFU71Y9bBoqDtMmyWnSPqOh5hk0UwbDvOeI7ns
         SIEW6CL+kiRI+NtwRLaVDjSQ5DIYwLNpLWBqTxLV3IB1NjC/rg3CfXb0Y6SObXGbkecm
         IiShyAiwaVhSV1H5hi7953AKkbflU/F4Ss5z1lkR8Oe5LCDme6drLb6kn4qU6BGhq/dX
         PVkKOuqhlEWNamvB18g6COMjSg8e0UiUOenXr3M9AVlKr4jZOmzQz/0T7IEZId8u1gkE
         GQLg==
X-Gm-Message-State: AFqh2kpwn5vSqprNoMUKdh+GNLOAczpeBipu1w2WOKlpsVysesAmhnXG
        sX0YvoKHb4gXmT88v6TE//XHPe1tqGBs15Kv
X-Google-Smtp-Source: AMrXdXturyp6eB5pfcMZNqzEbAP6wVkccGgcQJDfsCkaCZFWZ/EyKqOOlykgdE8Y1htWxkNah5ENbQ==
X-Received: by 2002:ac2:44cb:0:b0:4b6:e64c:aebf with SMTP id d11-20020ac244cb000000b004b6e64caebfmr3575166lfm.51.1671896578199;
        Sat, 24 Dec 2022 07:42:58 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f14-20020ac251ae000000b004b257fef958sm999927lfk.94.2022.12.24.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 07:42:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] arm64: dts: qcom: msm8996: align bus node names with DT schema
Date:   Sat, 24 Dec 2022 16:42:51 +0100
Message-Id: <20221224154255.43499-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and the bindings expect "bus" for
simple-bus nodes:

  msm8996-mtp.dtb: agnoc@0: $nodename:0: 'agnoc@0' does not match '^bus(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c53018ca81d7..cf2f5b74a4c2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1814,7 +1814,7 @@ spmi_bus: spmi@400f000 {
 			#interrupt-cells = <4>;
 		};
 
-		agnoc@0 {
+		bus@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
 			#address-cells = <1>;
-- 
2.34.1

