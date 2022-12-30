Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09CC659917
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiL3N5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiL3N45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:56:57 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08389A46A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p36so31809060lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZA5k5Um4QC/Gu6DGvK7WlL+xj8bUXjpr8IzDN/ZjXGg=;
        b=AgQoDwE8bEf90Yvuyo11KZfRK9WErnd9GYYHLFCa4+YP7WHojgPnaZn22Ce9v1IVRn
         kARxgJuqV+qypQ3EUHW+pbcfTYRlGtI4NRsnPEk2wXFdpb0lZJOs99pYeYYFZ8ex/fhc
         SEX5yK4h52g81fuHm4T1mhxs8k3f0wVjc/Hg1g9tMcmqUazng5rCpcRiFNG9rGv4DzDA
         QnyhUu924cQp16dAMUr6s5M9FutV8BU+xxchx1osvVlG65VUwGZzD6efUT/ACJmQPeZt
         vZdOEPwaMMsTi5TFgdTtEy5BR4OQUqTO42MyNg3GC4fRAVuuMmYVpm0axv/zCGXGS9QS
         Bt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZA5k5Um4QC/Gu6DGvK7WlL+xj8bUXjpr8IzDN/ZjXGg=;
        b=SD814ROUb9CHYQa8QUTzMCxg38ju99graHBDJ4NZZLq8K1m1pRDGUcSchGncCJXvEY
         hz6SFeYENbkoJ0rI9806ylz2YelaVZj0ahzoZBAXh2KbT2mebMDOctC/ZIgY8MzYsKWu
         6Z6PqMOUHIFZ9lMm03HIn8yNwg2k1GS9Q3vbn5WssdsokAs8iErJyH45KTVV4+i6mW6V
         j6R2BGj06TfY/sVOmGZTA6R87AoOqV8QFIGQUMpQbYTt+XyfxutWEl4hBuf6joAfo8Ep
         ai9oprQZIE0EhHQKG3/ebZByN6nf81FWIXlQ9MWJZv5a0jBKDaNJ3VZfnRtStOOj+TMg
         +/DQ==
X-Gm-Message-State: AFqh2krGVyllP0JXLmt3ef8frDYx7Uhh29src5ySWCX62qz4+drq6g59
        I8CBCIDIfzfAmZGVQlokLOZekw==
X-Google-Smtp-Source: AMrXdXs3b/uH5YdoAg91RJwml6Oqtz6T3gUdSvXHyM0KJdwIHnSqY4yXZM6NXOtH9CHHfSJbxCJNfA==
X-Received: by 2002:a05:6512:2527:b0:4b5:8504:7072 with SMTP id be39-20020a056512252700b004b585047072mr9217541lfb.14.1672408608381;
        Fri, 30 Dec 2022 05:56:48 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm3454787lfs.62.2022.12.30.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:56:47 -0800 (PST)
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
Subject: [PATCH 1/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: correct pins pattern
Date:   Fri, 30 Dec 2022 14:56:37 +0100
Message-Id: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

SC8280XP LPASS LPI pin controller has GPIO 0-18:

  sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
    'pins' is a required property
    'function' is a required property
    'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
    'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
    'gpio2' does not match '^gpio([0-1]|1[0-8])$'

Fixes: 958bb025f5b3 ("dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi pinctrl bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
index 7d2589387e1a..309d3dd9013b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -65,7 +65,7 @@ $defs:
           List of gpio pins affected by the properties specified in this
           subnode.
         items:
-          pattern: "^gpio([0-1]|1[0-8])$"
+          pattern: "^gpio([0-9]|1[0-8])$"
 
       function:
         enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
-- 
2.34.1

