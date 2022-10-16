Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF4600245
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJPRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJPRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:22:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593F371B2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b25so5451745qkk.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXCX/bvx+GMITxwd1sJyJkSs746MTV1B+EirXA61vBw=;
        b=U/Uog/3oGcNKxEW3ZGHOx7ZGNEgEpVgLbGkK5PfRbiX5qF1LrWDcMaK62Ey3ihB/Jp
         v/fzi6npqnqZtqRvnndpylz7ntQiGtxTI9qvvaQyG7TwWp2PdkWRU8qHkxPPAPoEga7c
         Jvb+b4lhBSEyqn+oehyxiDoAOekP2VIBPrWoeShQmo9PPO+Lm4dj8hr4Iq0IgWMCidTn
         wIW9wLlDpcRwIh7kKsq7ZXySwJ93OMnRZ33jKAdfAQmbN1qeaVimbzxi2DIUtvtyZvXE
         LcwvRV1Z5TRxrwyriSuJPtB8//Q+Z9w+iup3VbMlFWC6ZtMouBb/fe0dNmAztZjWRIvK
         W4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXCX/bvx+GMITxwd1sJyJkSs746MTV1B+EirXA61vBw=;
        b=GHhmizSNG15YnACbTKEdgdYYMY6pVErxVJVk1dlDbNzWPd79HjVdFTEOL8Yhdpsux1
         MlvPj4Qo+E3qdbksw1k2Pd776F9NmqJEWXwJBPJMTha54NpnYQCp1vZBWQyLxnrtj0Am
         0ZfeUhnVwsqk1xSR4zmjw6ZmY9yq+e6FD4UKbBVPMcNB0CEi6qoz3m7dg4Gxq36ZuVfo
         7SADWwwp0iUYIP1TAxYVhIEzSbWM/EeRjKRARNnrg5pKlumAex3WcE8FvH0UULUrRlMB
         pZEeZ2hVvG2Sg7tG/niN4ZXxULIxQo4cXNNjesc46N/9yFzmcPZ82Fm7KJYBNywPgiIR
         U7Ag==
X-Gm-Message-State: ACrzQf1f3iGPhaG1m5Gnunz3sJjXttIgHF1qFF7gQ+Wj/KJbOqTsMIH2
        XvK0MJKefM/kovIudgmkZfDWNQ==
X-Google-Smtp-Source: AMsMyM7BISQHvTRb75ZiRziZVonRMA5Y+vaWTUg9EVFvYFVZk7gtnr2w1/7l0ETlV9k4tEdEnCZcVw==
X-Received: by 2002:ae9:ec07:0:b0:6cf:4190:246 with SMTP id h7-20020ae9ec07000000b006cf41900246mr4953993qkg.760.1665940962485;
        Sun, 16 Oct 2022 10:22:42 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 08/17] arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
Date:   Sun, 16 Oct 2022 13:22:03 -0400
Message-Id: <20221016172212.49105-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

  qcom/sdm845-lg-judyln.dtb: gpios@c000: 'vol-up-active-pins' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 20f275f8694d..1eb423e4be24 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -604,7 +604,7 @@ pinconf {
 };
 
 &pm8998_gpio {
-	vol_up_pin_a: vol-up-active-pins {
+	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
 		input-enable;
-- 
2.34.1

