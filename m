Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709975B3381
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIIJVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiIIJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:20:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811DB5304
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:20:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q21so1732867lfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ANavTHdhnB5H/zimGyX1UGPrp6R0+SdK4bVct34NTMU=;
        b=fMXCG7jtl9+HMKOdvHXIZP3p2d38seGo+hmg5SmAg4+wTuFdSQrcoVZ9h7awH6V9lc
         VB3MKktw5K+doCBF+JMYN/Qvo7x3nBKVOdzzdlWKVOXEpJU0V1M+Grw6F2mTf4S+ca4r
         VzQyBLQbIeK4vH3VskuNZ5KGFNPmx2HodJ+O4eSCekWeY+ni8pBEwxffxkyl6ZbfwcWY
         e5B+XNz9WLICfU5zFow4tZRzJaDJfs6fwsUBOlLYgxcDKXEPtJDK5I+SHfbBudUOOFXw
         cqgGF/e4uL8Bk4b1+qj4Rucuqk6XVc4+Bz9vvYhSlAj5fVLGueL4VisW48S+aNL5tBCU
         EDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ANavTHdhnB5H/zimGyX1UGPrp6R0+SdK4bVct34NTMU=;
        b=BVAc8mQRi6I94kadfwTM+sUa9sfII9wO97hUOpms5ocoZ1Pi8WhjhFrY9w7RFMaGUO
         oc4NhBpWjFCcVxT06ivd6N5YsQYZ1unlaZpJGc2bcecq9l/+YlBIaLt0Da2t/iFAQ9nS
         rAeVzR5w1xADLN/QLObik4HeQctTlXgkMcZ6NIKldgxRcwVP/DQrfPOR1y+UHAHrf1RA
         Ux5qWNWNeeYCyiwa7dQYwx1NU2JlOmaTdArsk17F4oEaWJRHkgj3ebh/OKW+d8SZQhqA
         Bfw07ZS6cXiRCLSTi+zNf4pI4pujl12xaS3lQuJvLaCdRf32ZZOTlcH956gljVWUCziY
         YGuw==
X-Gm-Message-State: ACgBeo1bJl+dMzZ3RbtfWfbhrgwZQ7AD4+RzaLmG5k89Jd0BAA7BlV1n
        oqWpVfpFol0Nl9bZqtHLf0Yh6g==
X-Google-Smtp-Source: AA6agR7RHROR8x9HmtO/KIYXA7GhEiAvFgE/X5mzLWhLKyq5ahBSlMeP7bRg588iBh06v9manfpNLQ==
X-Received: by 2002:a05:6512:3503:b0:496:517:5802 with SMTP id h3-20020a056512350300b0049605175802mr4054883lfs.83.1662715248054;
        Fri, 09 Sep 2022 02:20:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00498fe38ea0fsm2170lfr.174.2022.09.09.02.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:20:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/15] arm64: dts: qcom: msm8953: add missing TCSR syscon compatible
Date:   Fri,  9 Sep 2022 11:20:26 +0200
Message-Id: <20220909092035.223915-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
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

TCSR syscon node should come with dedicated compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 8416a45ca4fd..ed05897d33f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -722,7 +722,7 @@ tcsr: syscon@1937000 {
 		};
 
 		tcsr_phy_clk_scheme_sel: syscon@193f044 {
-			compatible = "syscon";
+			compatible = "qcom,tcsr-msm8953", "syscon";
 			reg = <0x193f044 0x4>;
 		};
 
-- 
2.34.1

