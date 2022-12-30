Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A94659A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiL3PzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiL3PzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:55:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CEC1BEAD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:55:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so32214344lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGfyma8Qn7sSFvu2zSEpMZKY5/A9O53T6J2YqTZdXjc=;
        b=OFnopBeZPQAUbNaRLYVpb7OIMIGUbHsbCDQv1dukARbxv0lwF2fMcinCIPg1rIHLbY
         NTZTfoA/ZCefIue/e5dCz10TeMPxcPglosk4+DzVZiWfOsq7CxTuuPZ5ae3EesO8OXAI
         YsVACSTniFkatgmHIoR6S5oQ1VVz5XUMcnN4a+dtg88N2as97ludx9SYvWC1mUciC9RI
         visOK15+zSj+U7tD4J5/+2Q/ex53tdisF5gvrCSCuBL18vTPOc4kc0SJ4kHfSACcRy8c
         YG7xOu8fynvbJtyfQaJXL79fWmsWIRdMZKqlscul5NmJyDtC8qDtN/XSWA91r/n6jyy3
         Zi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGfyma8Qn7sSFvu2zSEpMZKY5/A9O53T6J2YqTZdXjc=;
        b=VVeVl3ad+ZoQBnPTg7RVceeKLS1j+qXtfIkYyL3IVB+1m+HfoAtTtWj4WEDRUG49Ek
         9TLqKnh6wjRv79fykGZqevBEIC7rRsf/cCpJ1N9mRk9j1i+glSx+ndJaXRm4g4FQ+SiA
         9Dc6lTKmuV0MQ7mz2PXnPXlWdSxsa+S50p63nCtbfBgH+LlX8PF8wsoZr42DwfIz4GXS
         6wiVIml2v3BU3O7VOkaa7vsGcomiFdZbxQOPERiKgQmCU50dH21eS5dNvdMuOeHXJve2
         bRhMb/N4Gah7xun2UCILB9Evsk9TKwLA7OtRrJhY99SFf7OmwkHxt8WujIQedD2YYLUX
         YgIQ==
X-Gm-Message-State: AFqh2kqQlkXTSMuXIBrOuJpmlcUvaHRYsb0BWuF3nL4NmtvrB6ruGDt5
        YjPRgx4keSGsxfYPiQeL4DMDrA==
X-Google-Smtp-Source: AMrXdXvLmPUA4Zd1qNu6Cy/5mT64Qmj3iYHxUKZJgRpzLHWD6hamB78MApyV68kq/q7oikoYxyl1CA==
X-Received: by 2002:a05:6512:1049:b0:4b0:a1e7:915a with SMTP id c9-20020a056512104900b004b0a1e7915amr10290789lfb.49.1672415706422;
        Fri, 30 Dec 2022 07:55:06 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z21-20020a196515000000b004b4bab7d5a9sm3546979lfb.46.2022.12.30.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 07:55:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH] arm64: dts: qcom: sc8280xp: remove GCC from CX power domain
Date:   Fri, 30 Dec 2022 16:55:02 +0100
Message-Id: <20221230155502.115205-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings do not allow power-domain property in GCC clock controller and
documentation does not indicate that GCC is part of VDD_CX.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Maybe the bindings should be fixed? Maybe this was added as workaround?
Anyway looking at documentation I do not see such relation, except
downstream vdd_cx-supply (which is the same as in other SoCs and we do
not represent it in upstream).
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 1d1420c8720c..d14663c9f34c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -799,7 +799,6 @@ gcc: clock-controller@100000 {
 				 <&pcie4_phy>,
 				 <0>,
 				 <0>;
-			power-domains = <&rpmhpd SC8280XP_CX>;
 		};
 
 		ipcc: mailbox@408000 {
-- 
2.34.1

