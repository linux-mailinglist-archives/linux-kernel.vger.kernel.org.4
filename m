Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8726AAFC5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCENAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCENAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:00:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9129012F2A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:00:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw28so28010852edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678021201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCq0CnvrYsIMiWt62VoCpfQmqZyRKFVCNg+apqdqte0=;
        b=ReQvG03vS2ZnHS4/Ql+V+luSbXLj92jDZH/kjhK1A+W8hxdidz6+lsZXtH076gnon7
         cUGRcD6tIULchnK5AJlciPVvLjpEqGFtXvsK/1qLP5Hru87LOqmthYGLg2JQQ5UoNVWn
         OEeI/HlOYF+JSTrSXNBjyQdiT0VuMYGT4Z+cosK5XXtlORaFBmePYCx+FFaWZKo/x4WG
         6RoVAg/HxdhEvmKb9cpOzCt5qJfKgm07hDWtmJAG3PRJiDXSObGBhwrmaX+/9EDnQfs5
         NWMnms+PH3/ZKjNxa3PIFB2Ab+qzwLZrzkthop+SwIJSnfDHBue1vxePui6zmS6/FdVw
         WPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCq0CnvrYsIMiWt62VoCpfQmqZyRKFVCNg+apqdqte0=;
        b=q1Y6yTn62fgwkUr96uUX58ODeBb6MsnyVooEpOtO1S0cHpxs3n+aU4VZIorXM4wcud
         ua+lQUpsaH42BFq/NfiYd6Ssq9DQWu2IiU15gk5fuMkt0xZ8AwpfbRqeszNhz/tFn8+f
         6yzFexeln4DJscQtwzRKL3KtSXcezVn6ajduL6n/nZ55DTH1RJpAOx8+ywBXWOWYI3bv
         qGjPqetQwSPFYL3sCpstgIUCCfTs60YQgsdeqmmWacf4qYm2VsT2yMqhoUPlPVScmKxa
         66NhmVkGDvcJ9/tv3UHxSQ3u8jaM9yqhP04UWz56SGAbiYD8+RlIZDyoum5pqB5rXJ7S
         J9lw==
X-Gm-Message-State: AO0yUKV5OOapnKpiOR2dVQMXchXqaRbd5nd25US1nOdlTTcTIgO1POrl
        bdJljzSX9E8oU7XYsfY5QvhUog==
X-Google-Smtp-Source: AK7set/zMWIWpXlRSnQG2tOUnDsvKX/QBMvNpc4TClh/pEA/pcN7ExBzPddLP3KXLi4Yo+xmPdsDIQ==
X-Received: by 2002:aa7:d88c:0:b0:4ab:4c36:463c with SMTP id u12-20020aa7d88c000000b004ab4c36463cmr8019708edq.16.1678021200939;
        Sun, 05 Mar 2023 05:00:00 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906078f00b008ea8effe947sm3193158ejc.225.2023.03.05.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:00:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/11] arm64: dts: qcom: apq8096-db820c: drop SPI label
Date:   Sun,  5 Mar 2023 13:59:48 +0100
Message-Id: <20230305125954.209559-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
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

The SPI controller nodes do not use/allow label property:

  apq8096-db820c.dtb: spi@7575000: Unevaluated properties are not allowed ('label' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index eb18811b2676..842836ed680a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -146,7 +146,6 @@ &blsp1_i2c3 {
 
 &blsp1_spi1 {
 	/* On Low speed expansion */
-	label = "LS-SPI0";
 	status = "okay";
 };
 
@@ -183,7 +182,6 @@ &blsp2_i2c1 {
 
 &blsp2_spi6 {
 	/* On High speed expansion */
-	label = "HS-SPI1";
 	status = "okay";
 };
 
-- 
2.34.1

