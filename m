Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C99639CED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK0Ule (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiK0UlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:41:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4ADFC9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:11 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so14532246lfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6gNym63NgF+XTZH1xbf0NrIpXmryBatnYIRGs7yiA8=;
        b=k8oaQKmaomgkAAn4gJZ6oz32ISeg+f7NDfvedrkcJke0EM6slwU20AqrWqz1Qz6RYK
         fIhTcalN17IvM4dsYhOaQ0fpwL9ECK9z/7la/ySHXY4lly8cV6FufBwEBdFmXxWQOtQb
         jPKe1cxmxY0r1cbtc12jE6NlqUOf1avSmAsYJJGWZzltlmoNFVaOJHtUthLVbYGZlMNx
         0pDYFPTG5la8qLXlRG6hTmvbA29MeVOOscMTetTzK0v23Sbc/sQUGGE4sJH4PfFMAfwu
         T2kurnS+tjWiwrgKn034hotN65ap0OkMKQxTzwG1RrmIL2FrLtspFa7gPjmJRE8HfE7Y
         aarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6gNym63NgF+XTZH1xbf0NrIpXmryBatnYIRGs7yiA8=;
        b=hAyb3tIYH4PpZXCeJTh5BswuRrpWW06qcLuc9dYmWvTvC0dnIhnIEswTSmdmttEU2I
         kQEkATU3vdcTQyK4jxBEWelQfx9TAtCqydo5/jsrCvI5OJ7B3ByvnJDylEPgbE00tumk
         yTHmohAeWWIj4xSm6WCiJylU+d46veh5I+zJCW/kyyQ/Ui/0RVvlgkwDtVWj4mesILTq
         kKubkLRrrcqfasL0Lse8GinAQIJDucWw2NpHBAa6L4TRmqDcFRSVLRgYA4IGeolhWsVR
         l55rd+N9pvHxFWymjAKc4BxYB7VMsdJqBTpsrm8qeyylrQm3AdjEc3Alaet7+Rik3ueo
         2AjQ==
X-Gm-Message-State: ANoB5pkMKK91iIGFnqf6tH9PhBrrG1zIzlTYGrDfFUCqxVWlvholIA5O
        h8lytOZDMyIBRzgzcctcxlgGmg==
X-Google-Smtp-Source: AA0mqf7XYe3dUPoZMSEuEg/TAgy3ISspZE7CBYTflFcarO7QXTtqRm76Xx4NbAeRKrEux9dBLHLiEg==
X-Received: by 2002:a19:6a14:0:b0:4b4:e24d:c617 with SMTP id u20-20020a196a14000000b004b4e24dc617mr8650030lfu.61.1669581669649;
        Sun, 27 Nov 2022 12:41:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05651c232700b002773ac59697sm644607ljb.0.2022.11.27.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:41:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, Neil Brown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/6] dt-bindings: leds: ti,tca6507: correct Neil's name
Date:   Sun, 27 Nov 2022 21:40:58 +0100
Message-Id: <20221127204058.57111-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
References: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
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

scripts/get_maintainers.pl is confused when name and family name are
without space:

  $ scripts/get_maintainer.pl -f Documentation/devicetree/bindings/leds/ti,tca6507.yaml
  - NeilBrown <neilb@suse.de> (in file)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/leds/ti,tca6507.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
index 9ce5c0f16e17..f2c4e94b33c3 100644
--- a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
+++ b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TCA6507 LED and GPIO controller
 
 maintainers:
-  - NeilBrown <neilb@suse.de>
+  - Neil Brown <neilb@suse.de>
 
 description:
   The TCA6507 is a programmable LED controller connected via I2C that can drive
-- 
2.34.1

