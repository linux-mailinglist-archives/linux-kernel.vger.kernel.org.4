Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C10686ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjBAPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjBAPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:51:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8C75191
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:51:22 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q10so17746780wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFn0z0++9NFRixQfP7nx/jtqdYQ6B+ogjd9YxGTGxb4=;
        b=aFeddXUJelzWwfyWY2hrE4TKzVVDJtTdWNcklqUu5YVuYSvAWhhmQsM/ndKYRHqySm
         9EHHhTyjhNmZDySSBuJy87K2WwgLEQwDqzi4pHdvYfCnhUJ+0rFEqx0KWLEP4ZJztp4e
         goB10sdZWrwlC/x60P3Klw07ej3no0265VMkJQsV60HXC6GdylP+Dcbaj+B+jcCoaHmH
         l5jJFIjYHoP/HQ6gitQRmi8F38K5RzhDjBp52dkJgjIImY2ocIAKMAP3NEhurA2XuzYd
         +jA18fzPVQmhODyDUHhE9qPkgJS7G6bL6p7aKLy4Sm/mGa/lwUdaMAskcfH5j39WhkKq
         KbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFn0z0++9NFRixQfP7nx/jtqdYQ6B+ogjd9YxGTGxb4=;
        b=YwcRsXZL2jSLrjzOF+Hly9SaRfSsPFEPWDFP9I/vR2DpBiPWKZbKj6gZMPgq9JxnuC
         UYbYS8teSjZ0vRcEcE16JxyfY2e7EuIpZLF32+/jH770J+k6zI8ZRxIr3l+6+piv0ZU0
         mXpVds9pWzeC3GzMQeG+FgDIBASLAz+RcSGVvv+9dh0Ikh5pym3qUoO1gK/nJZSkyGGn
         zQQde6YyOFuIfTddOq5hJi/npUPMc62cOm78W2IgTATXxFv6IzYF0/z83gD6pvssz+BL
         qPVr0IsU+p2fIyltR9esbudOnikX4r0jqK2geZOEhwLKD9bTZH3tWvApNc2NMKUxmXRT
         LY3g==
X-Gm-Message-State: AO0yUKV9Fxx7u5jrKGWHsXcFSjJ6Ej63LNMmDHbQsRe5E5ZUkUSUMZ+i
        5fVwKTAuiP+bTfckxEpELGMG/Q==
X-Google-Smtp-Source: AK7set+O3FgHo2qkkNaclOOX6wfEzwk1cME8BsfJkKRoUaHEsmi87pzZhXkbWDDIMYii4PH7JNZSEg==
X-Received: by 2002:a5d:660f:0:b0:2bf:ad43:8f08 with SMTP id n15-20020a5d660f000000b002bfad438f08mr2843436wru.14.1675266681489;
        Wed, 01 Feb 2023 07:51:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm14816189wrm.43.2023.02.01.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:51:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 09/14] arm64: dts: qcom: sm6125: correct TLMM gpio-ranges
Date:   Wed,  1 Feb 2023 16:51:00 +0100
Message-Id: <20230201155105.282708-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 65033227718a..1b7bbef5c575 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -384,7 +384,7 @@ tlmm: pinctrl@500000 {
 			reg-names = "west", "south", "east";
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
-			gpio-ranges = <&tlmm 0 0 134>;
+			gpio-ranges = <&tlmm 0 0 133>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.34.1

