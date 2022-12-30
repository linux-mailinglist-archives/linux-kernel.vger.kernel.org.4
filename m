Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8EB659933
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiL3N5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiL3N5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:57:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CC1B9F9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j17so22336460lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/0JIymRfzWnkT5ZkJG8MHW4ZCHhVkLlNKj1eR8OlNg=;
        b=u2bFQ31d/40MfjQoMcTvocQ0k5dw0BSqHiKJ77las+/8Vd0JTKp06Q+qd3BtZ7E6Kw
         vloTsC38MjY335x6Dwhxc75d7P2FcKnEUM2xmLHZKKo36v4ZvjnJwTr/uFbCLeAM5BSf
         v1Tstd2hns4PgIh7n2MRt69zJP7bzeIOrR/pSGAqNgBeLXjsbGulrnVGsmLD/Zn23FSx
         D5Fu8YZVO7QAVywfGZDkwBBkptL5WY22mOFuTD9A5sJVtprKQYPpFNKHTlylDDccmLWB
         1MrblgVtP3ubzdnliVbO1Cs4nrnCH6ca4wvwegBBsQXVrileCmSCsFx1sXnuk34Owsap
         qHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/0JIymRfzWnkT5ZkJG8MHW4ZCHhVkLlNKj1eR8OlNg=;
        b=RldExgbb32luDlZ7s9AVI22htSb1+/COvF2FKT2xl9RKNoVOP4aI0f5IHmKRj2EyY5
         wyhbdzZL8IEbrHaqMRkBGcXblGq4hyg/XxzmwW0Bgqfud1J5FCSs1ciaZthp8U0nMPOK
         QLXxDpksinhl9qWbA7xlKscNifq7qaDNGimPtOwa2h3fGQDuB8EGEzuaX49XttnqZVgX
         jnSEZWw4lolIGolnP7HAoLwK7FEvgdLlAC0V/pBNYPLqJVNxEjyhfBLAtbClBIpLEEUn
         MCLOvHob0Y1L6al0lhsyADtVuM7I6CkudMWpId1GgzeSVYFwXfxufbBbgRYxT0basa6H
         NdOg==
X-Gm-Message-State: AFqh2kpZyvOAQEupZ14opZtBKDQWBFuDzw28WkhF5SL3T+TQ4vcU12zs
        eeluZ3GkPOv7iX7AasYfzjIt8g==
X-Google-Smtp-Source: AMrXdXvkPprzeB1IUzETTdoVkePbL94vuQItUepj8R8qzjGYgzrprUu2+T0fKpJAOkCV285vj8fUEg==
X-Received: by 2002:a19:7414:0:b0:4b4:bea4:15c9 with SMTP id v20-20020a197414000000b004b4bea415c9mr10172789lfe.21.1672408618030;
        Fri, 30 Dec 2022 05:56:58 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm3454787lfs.62.2022.12.30.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:56:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 8/9] arm64: dts: qcom: msm8916-samsung-a2015: correct motor pinctrl node name
Date:   Fri, 30 Dec 2022 14:56:44 +0100
Message-Id: <20221230135645.56401-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typo in motor pinctrl node name:

  msm8916-samsung-a5u-eur.dtb: pinctrl@1000000: 'motor-en-default-stae' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index d600916a0e55..a2ed7bdbf528 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -434,7 +434,7 @@ mdss_sleep: mdss-sleep-state {
 		bias-pull-down;
 	};
 
-	motor_en_default: motor-en-default-stae {
+	motor_en_default: motor-en-default-state {
 		pins = "gpio76";
 		function = "gpio";
 
-- 
2.34.1

