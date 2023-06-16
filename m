Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830E67338BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbjFPTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjFPTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:02:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8352D5F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:02:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-519274f7b05so1377440a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686942148; x=1689534148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARSSXq/AxdbZBW4rlafZx7CGwmXZf89mlbDFWw/BMlo=;
        b=F5axYCF0BT0337i8VMINw4zYhGLesqhRqj7XdyQzF3EvQAuu+cHS9pOTJ3PwCD1LQb
         gGMd59ieS9srLsphHMiYUESL2TLp66tsOM5YiZo5lZZUa3MBhLn5p+h9+n1hHLtIv9Y+
         vpbxeJ12RLiO/Aq9ytObigCTkbe3VUOn4sHUpk5jdeyE9LqkDZCllP/BDxgxWJblnkhf
         W5qjQrrx+FEEnp3bACoGtjhnF3SdRy4rzhnNOEXT3Rg5Dz5Md98DBJQCzAX18wzdifE+
         eg3kVCbleTxBgZ1fHzC/TXFg0JEPOyL0tD6Ql2vlExbh45U8Vmoheh2Rz3+2NY9CyI1y
         aO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686942148; x=1689534148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARSSXq/AxdbZBW4rlafZx7CGwmXZf89mlbDFWw/BMlo=;
        b=GKfGWKoUQ4JyM3nGy5aEHjnXq0Dr9cggChg6e+BOCHhez9eqLOG6u1W4SwS+1dFM6j
         D6I4YkpI5KgS3UXPFyMSFY/FSDaHwe5CUQHtzHbGW7a2Ca8bAdkHBN+Zvp0QCacCbWn9
         N7U9UMU+oE1V75scuUyr1K5w22W62ohbgyl4+ik2IwqjCAnTBfdFRtQJuMZWdn2Nt+2Y
         cNS5SSrPsUmR37NOP1/7smWRq6RZij7Mn7S5NmlxWqkk7AMeKYQ7CYrYoyLY6M4akfGj
         E4307XKVoRV3kDKl/yB0p1kZYwRPAv0SUjem0pRVJxDr6Uc3s1aOBDNx+Xd/3v68LpsP
         N8/Q==
X-Gm-Message-State: AC+VfDwKqsnCULcogLVtFlZGTZFZjxtyd1C7kyAtixyDfalIn1W14V3d
        NkyZp+DwRs3LmVaZTwzfO37kmQ==
X-Google-Smtp-Source: ACHHUZ40N6jyKBfx92i22LHfl3FhhUiSPnPU5/4z2Z21/iP4QXkf+pgEo4pSW4nkTCn06k+KNAQQ8Q==
X-Received: by 2002:a17:907:a03:b0:982:2278:bcef with SMTP id bb3-20020a1709070a0300b009822278bcefmr2932160ejc.60.1686942147912;
        Fri, 16 Jun 2023 12:02:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709060e4200b00982362776cbsm5637880eji.118.2023.06.16.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 12:02:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sm8350-hdk: include PMK8350
Date:   Fri, 16 Jun 2023 21:02:20 +0200
Message-Id: <20230616190222.2251186-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDK8350 comes with PMK8350 PMIC, so include relevant DTSI.  This also
allows to use reboot reason.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index d33338e9a95f..de67438b3a97 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8350.dtsi"
+#include "pmk8350.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SM8350 HDK";
-- 
2.34.1

