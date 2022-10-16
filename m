Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D560020C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJPRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJPREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:04:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92244CF1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:03:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so5433091qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EE1Ip8I+ofqDBVJqXho2Z/r0isQpGAos6HBYPM6Nis=;
        b=oSXkQ4ocKtjUwfuoC3TaW1or7ZG9tJoQYb0cpxfurpz2vhT4bGJJ2c2KAvjgt//mq4
         jqtcQocVjNpSYZkGAGFMK2DxoyOIWAsBsVPSdeyxS8LgsAqPlm3oa/FXcxThcq9W0ML9
         w3FdQ9JkAIWq8dSkW3mv0VMwK8R8lqx0au5cssh+GdMGdsjo6TXa+YuLNeO3GZEVj32h
         yFiPlN224iyDFC4hx/M3lIE3RSFodWwfW/cII4HA+Ea5M55NhavXA8L8gD3UwRxhfUWJ
         +BxFgZ/q+/VkvCUgHpjWhNrgmtKuw6z1frV/CptxQJun0N9Y07S517j41KnG2ZZxFgtN
         WgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EE1Ip8I+ofqDBVJqXho2Z/r0isQpGAos6HBYPM6Nis=;
        b=CWEPlErVyaF4Krzn49TQhTyENEbkrYT8Gr2keCR05XSc13CZ6I4a1sk88WT4rae6x9
         F6Of18A3RqnXylmHBAKL6nwgmg41ZmFCVc3IfrKwdphYuTrlwGy1wnmaf9dD6Lu/2ANy
         poZi3i92yz5dDd+JyfSgpph/FoQEsmevWP5K/koSxax5VU9P9uKVZCl8LXmvlmFXTSny
         7tATv9ffHksqqV5uayAFtYlH9iruy8ja/+gmZ276WS71rB0t4um0B91bqMkBmIe5ZgmM
         zpH0mgKjzpet2gasmDY/geY2Z3oLCwlHNFE4TFcZI6JZnKgeSp3ymQaFrXOPTRW16n4P
         fRsA==
X-Gm-Message-State: ACrzQf1367KBGQ7VGQS0T6TD3MrzgRDiy0L+4M7op1D1lubE1xG7UY7G
        PnzKsiLMQx8E0pwkpYMQTncQpw==
X-Google-Smtp-Source: AMsMyM5aCIzgtcQ+U4W8M58hhxWtvKj7rNM9hN6uh95vFQS9TfYn/JUr6tOth/n66eQ+51jiDTadjA==
X-Received: by 2002:a05:620a:24c9:b0:6ee:d791:9f84 with SMTP id m9-20020a05620a24c900b006eed7919f84mr5115110qkn.490.1665939778997;
        Sun, 16 Oct 2022 10:02:58 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 34/34] dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example (remaining piece)
Date:   Sun, 16 Oct 2022 13:00:35 -0400
Message-Id: <20221016170035.35014-35-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.  Previous adjustment
missefd one spot.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
index b9ab130cd558..0b251caaebf2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -139,8 +139,8 @@ examples:
         gpio-ranges = <&tlmm 0 0 230>;
 
         gpio-wo-subnode-state {
-                pins = "gpio1";
-                function = "gpio";
+            pins = "gpio1";
+            function = "gpio";
         };
 
         uart-w-subnodes-state {
-- 
2.34.1

