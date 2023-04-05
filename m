Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB36D7439
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjDEGJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjDEGJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:09:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F049DF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:09:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so138413275ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680674954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s457CUJYeulcw9DiSKcWs4kYJ0VBbhBmodKlU+dm0Dw=;
        b=VHszjhzeAkyOdKPdKprreAYmD17Av0E6PB0RUrmrWMlCBlhqytNrCrR/0fsa2OOdM5
         z8ueBDZLcqtUTnUNuUfsoZ/P2HfyYV+PXFR/jKythuWKE8gbeYAAufxYGT6ZHpw9uf+c
         3QF/ODFOJhfphqMCql0HQs1IY69ABOXfuCw4j4onzrRvgSb0bV+dP1fM5Z1bQVwPV+wo
         Bk9rh0cq9W8wV+A1XuKCqso6qvvvEXsp+kJMOCtodp5s0kz7KBdDidPr5zkqKXdceLp5
         UqWOkZsGohHNw8koy5DIDzcv3ezd8U0cKarPUK1BOdEuSwDPMA25aD2EStmDRbTy/H42
         2MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680674954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s457CUJYeulcw9DiSKcWs4kYJ0VBbhBmodKlU+dm0Dw=;
        b=XrxBjPQJve6V5N0RjEgPkmLPEZu8rkS2rWHHBIh4S81pR+kPSpqF4VR/KCqJrEuL8E
         rp/cYEZvId7S0aJVLj9KJFneJmxuHtND+t7czGiaqgmZwxb8kWfrlyRrm1ZGENxO+rC1
         lvcoz6q6hu43e4rwT0Ru+C1OuN+saF8FjNTMmajYunX9jzvVhNTMXWuffEsgtg/W/0VQ
         QGqOB0ECF3VwdkvSZXG1aAqRVoejpYPw+mCfqTzk8HEWfXOIFKMN+ZXv2i/XuB+Pi2mU
         +jXOta7lZLdy6zQ3XmMRP7Hm1M3EtpX2TT8DR7yUEhvRrlIx16jnWevMbpM9wEVa7J1K
         OIlg==
X-Gm-Message-State: AAQBX9cUGtOt0k1DMHMClUzpzEgbEkUjypIY60W0NV8Ssz5oK4BKr9U9
        ALyriFIIkLYTwGp/cBMJecYQL+UCKuQLayBD1rI=
X-Google-Smtp-Source: AKy350ZNru4UEjGX8NsBR9rOq04ivqA0mNHquECgTls0Si/DlgJS1xXBd3brIA5IO3qia4qMjnRjzQ==
X-Received: by 2002:a17:906:4bd0:b0:933:c474:420b with SMTP id x16-20020a1709064bd000b00933c474420bmr1766764ejv.19.1680674954217;
        Tue, 04 Apr 2023 23:09:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b00882f9130eafsm6784643eju.26.2023.04.04.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:09:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] arm64: dts: qcom: sm8450: simplify interrupts-extended
Date:   Wed,  5 Apr 2023 08:09:06 +0200
Message-Id: <20230405060906.143058-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
References: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parent controller for both interrupts is GIC, so no need for
interrupts-extended.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1dd000748f9e..1dc5d2c49aad 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2298,8 +2298,8 @@ swr0: soundwire-controller@3250000 {
 		swr2: soundwire-controller@33b0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x033b0000 0 0x2000>;
-			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core", "wakeup";
 
 			clocks = <&vamacro>;
-- 
2.34.1

