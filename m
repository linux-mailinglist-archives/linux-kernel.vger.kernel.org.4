Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F66E8BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjDTHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjDTHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6565059CF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id vc20so4270360ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977060; x=1684569060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFqKpCWwuZDAdPXnzzE7gsC8SfOjkfQgs5s8XBZ8aZk=;
        b=ukQ0Le6TMEKtwl1qb0k1IeiFAR0NkPtd3mYrddufs7v2M5uNHpAbl1167aNvZB6ogh
         qkcck/TwJxS0lhvqLD9xRMFzpp51JJPjmUAU/UYDCaIh6ua3MrcHhJChD4hxMtKusFPh
         tOwd1X5l5EqfG85mZRnwvx367LuDUG4BZOGEWS4udvQVAREfd8HKATkgDUwYyTE/svnU
         Th/ZG3VrDLU8I+vlTdCzn2J2uw5gGIDvoqTwqCgjQujXao+yZVuFh8cAWPC/O3Erd1p5
         PPI69gycuh8ZZu5xJABMoINP9vpUIXCZj6fVoJ5PLH7nGX4YF40ZwOjNT5FnZlp0ON6V
         zCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977060; x=1684569060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFqKpCWwuZDAdPXnzzE7gsC8SfOjkfQgs5s8XBZ8aZk=;
        b=WHDLLqskZbBfcmyQBWsD0R2C1mokAhLIC534Q6H20BGKNRnoi9+Aq9lxa95UBTqQHo
         LFAcVuqOeak04wCDb4VkOYVFmDV++dCDdY70fyOlmSGVgTvf7yKokcd70d4BoQSb+i4F
         F22QCRyFs85KU+4l+4fcyjQyzL/boY0sqKYFs5fYjZvgZ8SedFwFAptnrh1gHH9s58ON
         nSb7wFH3QTFO64Wjtoq3fIqWqwmzAXhgg1V4lVrXyPu5pBUX/20xaUGNqkeWfJH1HEru
         O8Hg7Vsizd0FSq9Rrp1nvm3SeaT7eHmhHrGmckYLxu3FLy59fnHZ652R8z7y6oPLiC9o
         cqcA==
X-Gm-Message-State: AAQBX9ei86KRi9QmH3V68GMDpEScW3xDcQRIVaQJ+fTLmVx5yeupHKuG
        9x+zKp+NuIV9M16kHOg82uQ6b7upn9smINzGd8SBWQ==
X-Google-Smtp-Source: AKy350Y2TcNWboWKh2QDy2Qdikod1p913oFrr5wHNBogRDNZFJOAiFU39DD+VrEDkwxsjp9gf9DMlg==
X-Received: by 2002:a17:906:ce2b:b0:94f:6218:191c with SMTP id sd11-20020a170906ce2b00b0094f6218191cmr689403ejb.18.1681977060507;
        Thu, 20 Apr 2023 00:51:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:51:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/10] ARM: dts: qcom: ipq8064: drop leading 0 from unit-address
Date:   Thu, 20 Apr 2023 09:50:47 +0200
Message-Id: <20230420075053.41976-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
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

Unit-address should not start with 0:

  Warning (simple_bus_reg): /soc/syscon@03000000: simple-bus unit address format error, expected "3000000"

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 621edf508a88..182018d79a7b 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -609,7 +609,7 @@ saw1: regulator@2099000 {
 			regulator;
 		};
 
-		nss_common: syscon@03000000 {
+		nss_common: syscon@3000000 {
 			compatible = "syscon";
 			reg = <0x03000000 0x0000FFFF>;
 		};
-- 
2.34.1

