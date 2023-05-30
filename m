Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117C7164D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjE3OtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjE3OtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:49:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CD9D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:49:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso7521258a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685458142; x=1688050142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC1DLYYtBIULk7ShCQFp6sqNI5K0yrBz0U0PM92RpVI=;
        b=cYj/0UdvnrYRxLWE30Pag0dMjBlnkPhq9SfEVLhSh0h7wesZCsN7ZQbFx9LGd0w0o6
         p/1LFcwMRXMEa89KQvnwZokxdlcPl1Q6M5yAc7YujbUYgQ+x1MrzbImjdinSrwy2+AC2
         Odd/VANoBeApcDTBI50o53gAvId28G2cGWCrdZcual2NYoPCgjUgOD3Zi/HCVDNkJF3e
         fC4YwBfzsEOmebe+lJL+K0fUTmIILgzkJdJ+9zQAivS7vBtvmSy5iDWTeVZUT3qxMhsI
         ikFqfe7TYZpvhPUiLdoS3ycpGKRL3nP0wOHGf2c76lHh2YHavqCNPWaeAEPAv4Klr0Nb
         DG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458142; x=1688050142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC1DLYYtBIULk7ShCQFp6sqNI5K0yrBz0U0PM92RpVI=;
        b=MUpkT75IzPvx/b2KdgGU39YyXfbAehb7TDjegrMYLsU0gn07K+juYe1ekvqrYqLNo3
         WzCRgENbTP1Pe3zYWaJpmjsS+7hhoJPf43VzIN9JrHWCoQbYs+h6tCTRxg7W1zvnofa7
         a+GFtdCwmYj/pzznTHuIB3gCUII/bB69kFrhV313FAKw5pwUtSMfqa9yaEPaU2LI5fC8
         nCRSAEf3kmY+zQThTQE2tqqyWRdlCORRs5hw6C7VenHc7otL3dMnvqeWXWuaiifGf2GX
         t88ObWm8TzAHGh4O1spn55KxYF4H29mveXXklUPrDSzUXaWxAo61osxccrTklem6/FcY
         TdeQ==
X-Gm-Message-State: AC+VfDwBcs4p4uxe1BsMmTK2KpbyhNuyRtTAWEtUR3FmLjFYw82B/BYX
        eOrF/OxPFyNI3Yr/imbEroDbMw==
X-Google-Smtp-Source: ACHHUZ5ekV/qA/jutZ5TY0nfdJ3IfVJCe2ml8+qjE57PgMROisWg3g5xJPBlz+bFlKz96buQX6Bymg==
X-Received: by 2002:a17:906:9b88:b0:970:925:6563 with SMTP id dd8-20020a1709069b8800b0097009256563mr2507516ejc.8.1685458142210;
        Tue, 30 May 2023 07:49:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b00514b2717ec6sm631283edt.28.2023.05.30.07.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:49:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 2/7] dt-bindings: pwm: restrict node name suffixes
Date:   Tue, 30 May 2023 16:48:46 +0200
Message-Id: <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the pattern matching node names a bit stricter to improve DTS
consistency.  The pattern is restricted to:
1. Only one unit address or one -N suffix,
2. -N suffixes to decimal numbers.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Tony Lindgren <tony@atomide.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index 3c01f85029e5..abd9fa873354 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -13,7 +13,7 @@ select: false
 
 properties:
   $nodename:
-    pattern: "^pwm(@.*|-[0-9a-f])*$"
+    pattern: "^pwm(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   "#pwm-cells":
     description:
-- 
2.34.1

