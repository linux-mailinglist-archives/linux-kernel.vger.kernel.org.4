Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD06D272F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCaRzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjCaRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:55:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D1711EBD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so14418174wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QkkEgowsBjZnjX/gOtAy8+xgH7LTkosTkX/GzGdyGM=;
        b=XxTBPV4KNcEe0qPmkZRrKyQI5uhQxtQU/7gDyEpIWalnmi94Qk4DmEkGrL9oH39gpH
         942jLhOGte/z6PyFr7pnjP798UhzFFx1gYheTGAzM8cmc/PLEUht2ePK9dUOox+5oJrj
         5JkJKAXYdnzy4G3bu5M508dculDRr34xnOLXJXEcSe0TgUGCBADodzMbwQNswaAmLxi0
         0eLLC/ZmU/FnqIHUmuJSdFvCUsrp8TI0vN9Mw8BVcmQ7A4L0t9py4vQuSOBRLJsnFnw2
         o631GIkfqFXofwlGUffDj3KQ/3My1MbdiqKfKYQYOe1mYA7VU8O/FJQc8nhxjkgOhzvE
         IDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QkkEgowsBjZnjX/gOtAy8+xgH7LTkosTkX/GzGdyGM=;
        b=pzuOmWIOFc598Gqx4XjLpgzRq8c7LW3SwY9eojc8PEINZ5qTDQhVig2a3NNR0g7Jjs
         mGZE6d4WTlFerO8PDhwrfWDSxMcalgbpX5yKisuqreHcWdHGgWlRGz3Hoeg5xK6EJLU1
         iPZAHjgI7YAX5hP6+14MIjndc+GZLnBzb6EEJ8DBKan5i8tj7mo4R9jnGZnK3dWs6kFS
         1BLkcoF0hP89+cMCJnAmP3txMmAne9hcrJTjNf0WmmkWzECRwxE2eyZpVaqvFT0g8Kj0
         n+zm14z2VVf/j+qbDXq3S2ny0wFVMVIf99zNp5R6m5KOKlQ3NULVWIaEjrkfo9t2x5p4
         RHHQ==
X-Gm-Message-State: AAQBX9daRNeeaLkwfjYAXbGeGrJdQFhDTSHmijLf9lQxg3afHD4I0n72
        kL/JT5y0B0ZYtdTX1CST4ycBHw==
X-Google-Smtp-Source: AKy350Z1Zp+HAJjMVsRnd0RSQj/iy8owoVZuBlU/QzAW/hhi49p8EfXc8/Am/kKX+2hEOs8VeQosKQ==
X-Received: by 2002:a1c:ed15:0:b0:3f0:39ab:347c with SMTP id l21-20020a1ced15000000b003f039ab347cmr4719000wmh.23.1680285334697;
        Fri, 31 Mar 2023 10:55:34 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:34 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:54:45 +0200
Subject: [PATCH v4 01/11] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v4-1-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=e/j+wpeA8gY8YWfUFggkrkBUqt/uFn1RH7+Bbqouv28=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6ThWr+36gSjZmFPEG0zdxk33vsAzu6ZhTBFMOW
 4r6UzFmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcekwAKCRArRkmdfjHURcC9D/
 sHF98xyCV9ux8a8j63oXjR4rwT+x72x1oBMjK4zHRXv1kRipKbyGzB0WZ3g4Feusrz6Kwua0SFvejA
 GSQCu+BhEpIDS12gbC9tUY771EKuUla0XJ6WRNVX6Z3iwnbPGJk9QO2Dww0AWgR2/NZIrL+upjRlbD
 imrhhexpY9x0YhszDoZFfEs82J8/sNd/LEsqboduMTiBt75b+PFSGO9W95AhVA9ubB4bOm0MmFWSSn
 kDrZu2Rc1H6KvLHUclS2mq6Z/o6IiLNeIKAj3ZxZpwWlXENq3h78iz2MAl/JCpgxNfJrXJlyv9VN/f
 t669pTa6eWagYP678MPg7/AGKdQlCAosoGPSDUDclVTULmJGDJovpb6ia/7nYDZdSnrtZ13rvF7efE
 BbGY3I2iWvNm/GBxqjYq1qvyv2EenRe4Y/yGOClc6p6oMxkHvQe79/vTr36OEw32wn38zjb6ouJUxa
 SiFNG8V7Y1vu57OpfOKlh0YHW69XdUwvcx7Pb3I6AyTNR/qsq5/gDwWgkQ3leykV5YuyQYh9hDDdy6
 hFQcXdn7TClzRwLcQbAV0fkXnJuElc1Nmpk3lkvTUm6ZKGb3RJdykQ9HV+dYKu9H9KL9Ynk+tCQSRq
 g5XhZ0D1UP3Vp3gdBKFmAinx5yWPez2EfIrcSezJ/QPZgj2Qf/rSB2SI14dQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-wdt

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 55b34461df1b..66cacea8e47f 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -38,6 +38,7 @@ properties:
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
               - mediatek,mt8173-wdt
+              - mediatek,mt8365-wdt
               - mediatek,mt8516-wdt
           - const: mediatek,mt6589-wdt
 

-- 
2.25.1

