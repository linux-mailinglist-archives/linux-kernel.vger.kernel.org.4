Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C806965A464
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiLaNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiLaM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD10DF2F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so35148575lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oblM6MazKj47KI6mVE2SFSZqU9kEVRoASZWd8seUR0E=;
        b=Qk5YLsv2goGn/Zoh05L6/1JkbVwvBzlBMRl2Xyr0QiPns/w4UYVkSD6DeBZoO+3vMR
         1Q+82FTpegCjrQocgcqqJcU7JseYjaa2AydT0xdOXqxo8FX3LwURudOEKlqj0fUh5ZrA
         udehi7oeqKnnDLE7FdxGYTaybz0QHlEGyQizqlsbOZGX0IUoWqoMw1faL4Er6/fX7CXP
         W2Ws0e4sWVgAk/lP56Jb5f1WOlfRMLHzd65Lw0C+1Sl9iuXcu/wrdYy7REtcetW+Mij1
         caMr9sY6LRZiMILD4w2gy5NIHkwx7JA59tYdS/pm2DeVqrKhp4CR5julTnglGlI15bnz
         Gnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oblM6MazKj47KI6mVE2SFSZqU9kEVRoASZWd8seUR0E=;
        b=GGKAO3op6Ck6CBELNijMQgAdurxlts7/06w1lOTmFvaMl79GgbioeLeDBUafmadf8I
         Xb9JCHD0s/v0vGMtGSgehXpZCxo63CtJ3chOE3qPVGw+pDlgfDiPEEv2p2afu25yPh+3
         b3D8rMPWch7aIwtrSpEXd7Qmz0yYFvlc693QjHYI7yxmLdWoQLt1cxF7IegoHb0auh7u
         Ru9gi29J60C8S90bN8/yn1dhgeA0klVfM/WUvn1YMwk2mRfqSJQW50gxGMDiFRcZ0/AF
         j5YrGnodIk55a0d75x7DinpFJfpjC9JUXphCo7YeduYAmWeXSoIjsCCJDtAnk+5haJVc
         WRLQ==
X-Gm-Message-State: AFqh2kpOagYiUrw8lEqb3LyYTsKZk/1QyMXdB+sLMjldERcpPXaZw37f
        JXVuMO1kbCeRiKiVBdLWshm91w==
X-Google-Smtp-Source: AMrXdXv8P/6MxWmfRxmn0ieCJEwmdm+DEQ88NSSgvXF32gdICRchtzV62q3xLnDQ5iu24dflrJq4YA==
X-Received: by 2002:ac2:599d:0:b0:4b5:8bbb:51e5 with SMTP id w29-20020ac2599d000000b004b58bbb51e5mr9321576lfn.32.1672491573890;
        Sat, 31 Dec 2022 04:59:33 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] arm64: dts: qcom: sm8350: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:05 +0100
Message-Id: <20221231125911.437599-13-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 067613ca9c03..5f191ebbf724 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1598,9 +1598,9 @@ ipa: ipa@1e40000 {
 
 			iommus = <&apps_smmu 0x5c0 0x0>,
 				 <&apps_smmu 0x5c2 0x0>;
-			reg = <0 0x1e40000 0 0x8000>,
-			      <0 0x1e50000 0 0x4b20>,
-			      <0 0x1e04000 0 0x23000>;
+			reg = <0 0x01e40000 0 0x8000>,
+			      <0 0x01e50000 0 0x4b20>,
+			      <0 0x01e04000 0 0x23000>;
 			reg-names = "ipa-reg",
 				    "ipa-shared",
 				    "gsi";
@@ -1731,11 +1731,11 @@ sram@c3f0000 {
 
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x0 0xc440000 0x0 0x1100>,
-			      <0x0 0xc600000 0x0 0x2000000>,
-			      <0x0 0xe600000 0x0 0x100000>,
-			      <0x0 0xe700000 0x0 0xa0000>,
-			      <0x0 0xc40a000 0x0 0x26000>;
+			reg = <0x0 0x0c440000 0x0 0x1100>,
+			      <0x0 0x0c600000 0x0 0x2000000>,
+			      <0x0 0x0e600000 0x0 0x100000>,
+			      <0x0 0x0e700000 0x0 0xa0000>,
+			      <0x0 0x0c40a000 0x0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.0

