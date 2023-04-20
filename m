Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C76E8A78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjDTGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDTGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:36:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D369349C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bc07so606302a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681972574; x=1684564574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4yglOSPzzAHeSTsBLg4Ee200Y5n2ib/pHvnlVkuu8o=;
        b=GKgYqE0Fc+uJ5kRRIqNbc9rVRxh0ybrUbCORXk9+Upqjxd75nmSQC8NG2p9uMjbu2W
         TGRr/fkZoamE/44gxLfsO6dNrxtyibTZ3aFWaDkd4A1yg00wjApbB4XCyPQ7nB/hpWHl
         gqacRrROOD7v3c+bNhcz9zdep5nNLAqW2/xHDs3+lJtVVcVLIKtcxvGWKuEv90q6tG8T
         FVGuFThiraRMgwUjrwNPagcMopMEOlzY07tqdr0O4kRuXOjBfTTr9hEzzItLRn7QIadO
         loK10Hw+DcgVlq1R1xm4S0Kd9o9qvmkRPw5DS2gYn6LPLTtTWTNg+smFTjQycQ0WqAeP
         SO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681972574; x=1684564574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4yglOSPzzAHeSTsBLg4Ee200Y5n2ib/pHvnlVkuu8o=;
        b=WKktuWSQWcac1oe3ugQ0Fe40TfAIULE/q+eZXuV9IUEyEbt/bSJNym3NQh34uRmf4S
         OfOu2MHlQ6IgsAah0v/3yMnIzGAZr4Yw58E+2DERvP3SL+sUIt4NcMCb8UQQBWeg1mkW
         dkfRMxmL+zRlE/1ExVEePv0P/dHMsuEFc9V5/FagN+p4kJfhPcVyA+ULi1zO9zShQkCl
         bpbQdjSKU9n3Ea9tzT40Zwt8ukeD7vlvm3X6PiDMk3mEIY6bNGozNHPm30nm0SgWWKBY
         ScQDiczbFhdivFGM7t8nmBrnSmC4nLcfDnUsc1xGYEQOpOKvHYEDX7sW2w+mdI9OowWj
         OfNw==
X-Gm-Message-State: AAQBX9dhDY9DslpznhqEDU5W9gYDXmr40MS4Yt5+Qv9NC44sf3cQFoJ5
        /M4kXzVRAWnOObNONyI2DCEtCA==
X-Google-Smtp-Source: AKy350bwuDjqv38vYkF8i9BugJ61z75Dyp9Wk+2ngnBHHNe1sdFCU9zikbH5B/r9ROg5GNbmtIlpog==
X-Received: by 2002:a05:6402:74c:b0:506:976e:5242 with SMTP id p12-20020a056402074c00b00506976e5242mr630503edy.25.1681972574318;
        Wed, 19 Apr 2023 23:36:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm395342edx.77.2023.04.19.23.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 23:36:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] arm64: dts: qcom: ipq6018: add unit address to soc node
Date:   Thu, 20 Apr 2023 08:36:04 +0200
Message-Id: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

"soc" node is supposed to have unit address:

  Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 8ec9e282b412..e4267a6ec9a5 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -198,7 +198,7 @@ smem {
 		hwlocks = <&tcsr_mutex 0>;
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0 0 0 0 0x0 0xffffffff>;
-- 
2.34.1

