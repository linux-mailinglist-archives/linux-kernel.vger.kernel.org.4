Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3241D705D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEQCTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjEQCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:19:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89A3A87
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:18:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so1279941fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684289937; x=1686881937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiwfnxHpTyL1B4ayjglsH0C61007tFWAsNvE7dIFkrY=;
        b=mu6X2ZUoQp+726STqGqjI0ZOiQpGbbIU7rq2AdIvry4lqNAzlMVFVmsEyYmwYITzp5
         A7+LL3MbY6GXK3dQy00cdOUfJAWY4Ow6VX4Yf0RRFRSPnHvYvP0FG6E0FZNhX+HuZQ3d
         goeTIrFpX0S2kYONiaFuqxMPkBIaJH8jHPRQDmTRXiuljr5tKgYCtoLnEKfiNd3es3XC
         jxeYkG8i9MdO9Plrv2p54/ZgSVGcMLW/ApGkgeJDP4HwfRqJnc/ErPHOH8zE/eZs4Hp4
         KK79O0IKAxXyrU2NozVLhlF4jai/eBTASoiqesubrA1SUcbt6IUh99oq6vOPhwD4cBvZ
         v1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684289937; x=1686881937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiwfnxHpTyL1B4ayjglsH0C61007tFWAsNvE7dIFkrY=;
        b=MGVaZHKvC8rZA8Ou/bCrpMz9STPokhh71R09lNloa3AIqk7+KFYM+d9bZKkraRF1YJ
         c6lWWYnfnDZ5qM3wrIZfokXExl1AT0G6ZM7Cu1GkkMfmN3DV8i3Q/sQeBpVuGfwRimDB
         TYgpB2FTHjSAvxqFyaw8yWJJA4ulm8VxkPnDy4abP4U7vh+OZotj8dUIjprVyxoEPQZ/
         9lRGlzfXF/ykqPQPjzlRfOwYWq+led8x8zly4UOdkBlS7lCpIc51Gj7NN6JNKo9ziB4h
         3eSPU7IniE8scTZy2mESPeaUXpzyx96mXTztcNS9T/vpcSh0aCtBTS6ylBhpl+3pmHog
         +rlA==
X-Gm-Message-State: AC+VfDwz2v9//RGyFe4lR2786/BYtz7PshtvIxRSP3F0KENjpDs91CHh
        oh5aIPSkRffiqH3afpeTORgEbA==
X-Google-Smtp-Source: ACHHUZ7D+LOuI/MHSp0j2cZk14xGuFren+3QxYP0Kp6IpsCXfPo+KsUQD4fBUk5Qb5FWBNmZiVW0jQ==
X-Received: by 2002:a2e:90ca:0:b0:2a7:f1e8:b08 with SMTP id o10-20020a2e90ca000000b002a7f1e80b08mr8368282ljg.19.1684289937496;
        Tue, 16 May 2023 19:18:57 -0700 (PDT)
Received: from [10.167.154.1] (public-gprs529629.centertel.pl. [31.61.188.30])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e9656000000b002af01da6c67sm384232ljh.32.2023.05.16.19.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:18:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 04:18:50 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550: Use the correct LLCC
 register scheme
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-kailua-llcc-v1-2-d57bd860c43e@linaro.org>
References: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
In-Reply-To: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684289932; l=1384;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9WupzzHlTXR6Yx1uELACzjwgFEN+yOqghs8q/dMHZUU=;
 b=rFjT625Yg2dYY1oD64UITRGGu/MBYdyR/8rF4bL7kaslFDWb1Tds8XtFi8cYWb3v0dYnaS8oc
 AOCfXsDEx+VCRfOIOvSGgSBuj87pLKKbwZ1dY8CRC0910fhCY8F1KXs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the ABI-breaking (for good reasons) conversion of the LLCC
register description, SM8550 was not taken into account, resulting
in LLCC being broken on any kernel containing the patch referenced
in the fixes tag.

Fix it by describing the regions properly.

Fixes: ee13b5008707 ("qcom: llcc/edac: Fix the base address used for accessing LLCC banks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..70ae7e2e900a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3762,9 +3762,16 @@ gem_noc: interconnect@24100000 {
 
 		system-cache-controller@25000000 {
 			compatible = "qcom,sm8550-llcc";
-			reg = <0 0x25000000 0 0x800000>,
+			reg = <0 0x25000000 0 0x200000>,
+			      <0 0x25200000 0 0x200000>,
+			      <0 0x25400000 0 0x200000>,
+			      <0 0x25600000 0 0x200000>,
 			      <0 0x25800000 0 0x200000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base",
+				    "llcc1_base",
+				    "llcc2_base",
+				    "llcc3_base",
+				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 

-- 
2.40.1

