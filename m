Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3707160024F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJPRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJPRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:23:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE8133374
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id hh9so6525695qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvT/AFVSeeIj/3tM0r6mtFFVLLSfMhXJVOyRyP169tg=;
        b=Qp0pv3C9a5b5eDb14EjoD7hKgcCQstjZAN6ordCCl+Ea2cIZcB55Fc1ICU/51c62co
         IEBd/oB8bRNkAmJaSFHAfQVIKEEQtGJGe7SieE6wGT+rbJBmgsA9Tv4RDgwKMuycgpri
         KXlG8+mWGzctOL9t69yNnfBK/vtmddg+yk1VzI33cAJk+sn3P5gKXW5jQp23LJxyfseP
         tsbDzPeFexmok4IFN1aA4VUOh/91YjArU1pcfPSkU96WxFIvu73Q61rwIn1F5j65lgh/
         vq7hiQS+/145/MN3xHR3HfsVLYW9pT3XfXCcUEAIei0VPv222GUhpIvr6NBbcJT/6TUz
         UsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvT/AFVSeeIj/3tM0r6mtFFVLLSfMhXJVOyRyP169tg=;
        b=Gc2QdDmADpUmKQ3cq0VALOASyC31JouMsEZ7EYjWr+1TZnbo4sHEGGoPUpgiEEaGI1
         Qupp8nMTkm73va7WGH5pQLOJdQ5Ejb8I+ajCcYhybEjKiyf+uTFvB1vLOLqFguj7hhK9
         hQPK5F3wUm82iUuBqpM1RW5KlaoPl7KzDbbbnqiVEzQjAH81ILEVh+EGahgwVigFFiZu
         ouyScwQPe4Bh8GNMMfKQqBk2MtBaPo1o49+I3LZ+BY81+QX/vZHlZ/dzaI4GlUFzFLIk
         tmdpw56x8Td8JP6KZvJpm8uHC938zCvER2TkoK63LBrKxAZcZjZEMF2su2yW2ny3TuH6
         VS3w==
X-Gm-Message-State: ACrzQf22ppW57lyIK2ZHkUae9bpzmhWW0SKGJog3CItb8CdEw2DxnKqQ
        iK7DdsKJjHOheuI3wrfLaFnf3Q==
X-Google-Smtp-Source: AMsMyM4mQKBAy9M9CYBBoYoLTWWK7gEgb/xrlDC2Z16WSFfcrbbj61XfDKKQWALw6P3e7omjtbH9cQ==
X-Received: by 2002:a05:622a:392:b0:39c:e5a2:6d18 with SMTP id j18-20020a05622a039200b0039ce5a26d18mr3315184qtx.245.1665940967183;
        Sun, 16 Oct 2022 10:22:47 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 11/17] dt-bindings: pinctrl: qcom,sm8250: add gpio-reserved-ranges and gpio-line-names
Date:   Sun, 16 Oct 2022 13:22:06 -0400
Message-Id: <20221016172212.49105-12-krzysztof.kozlowski@linaro.org>
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

Document common GPIO properties (gpio-reserved-ranges and
gpio-line-names), already used on qrb5165-rb5 board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index c44d02d28bc9..d7d8e5d3b659 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -49,6 +49,13 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 90
+
+  gpio-line-names:
+    maxItems: 180
+
   wakeup-parent: true
 
 #PIN CONFIGURATION NODES
-- 
2.34.1

