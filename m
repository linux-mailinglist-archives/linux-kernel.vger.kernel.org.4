Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0F600442
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJPXma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJPXmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D727150;
        Sun, 16 Oct 2022 16:42:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so15964564wrp.10;
        Sun, 16 Oct 2022 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkCe7sPSDik6TqNHygx3u2xLVqvEa5+V8b5EsZsfws4=;
        b=Y3Ze7ElpIWs8oa2OXQ0U5hHbqTe7iv2NUU/HJhcolCUIT5ldNECiF1hWl1IEdSSGR2
         ExWGWD35hyRaRQQC8PQoGjhKeACFSWyhG7zDq8z00kZ0JjiD0boYWhGrHFfu8OBUnRcx
         smFi/7UynZxl2TrXo/sguRN8a+tG67Nvrvdy0KT4ryKU1/o5Z6xyZZlnZK4Ve3FUgI0Y
         v40VtUp92jDE5KpXIWm/CLNRWmyNHexlzWO6jCgz+Y7xnNC40F1lZaR7hdq6St0P+LaH
         8RouuZEpgSAwJ5AFNfWTq/5VztI+oHFfn5tA4wy/hx4HpWUD1gOH037BjV8E6TkOoBxu
         keVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkCe7sPSDik6TqNHygx3u2xLVqvEa5+V8b5EsZsfws4=;
        b=Bqj3hJkEEPtFVB+kzn8eEoOuOSk+O+Xm6MWg0AZuSyj2i5FCov7R1EwLsqLcaimJNy
         G3xSoxcSP/K4fE0TAGlQs83eveseO5DlxNs2qnKCT9+cVBYiJuKXnhtA1yB1mlgyCTI/
         mVw8KVDUoRCXMp3B34IYBRYNE5HW+o+ckFcDdKD6W9Jw5Nbky517x/FJDNhS1YZ3aW3a
         qlhGCyzAdr5uEsO87gI5/iBxBfHyBpnDpay/CWTCVHZa/IGSn5tEonObmSjPceD7bpVE
         VYvWEvHevsTB28d9M/PtOcGL3Ll7cil0m4S4rO8Yuw+6F85kpmewNPq6LiBb8OLtKZW2
         CcOA==
X-Gm-Message-State: ACrzQf0sKcXRHkjjLWtuLcezC/2T3fgH3wRBCDYTe8W+ovjHOfSjC9cH
        VJpUE0J7h5nvhhnu1lG+PhQ=
X-Google-Smtp-Source: AMsMyM6DaG/YKxnIVQ4FPnil+EcHG751UhYdbn/xbmkSKLY/z7D/J9yEfHX73Hea608b2deDhyEOaA==
X-Received: by 2002:a05:6000:2c5:b0:22f:5242:131d with SMTP id o5-20020a05600002c500b0022f5242131dmr4374157wry.228.1665963740536;
        Sun, 16 Oct 2022 16:42:20 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm7138795wrt.42.2022.10.16.16.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:20 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 04/13] dt-bindings: power: axp20x-battery: Add AXP192 compatible
Date:   Mon, 17 Oct 2022 00:43:26 +0100
Message-Id: <20221016234335.904212-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192's battery charger is similar to the others supported by
the axp20x_battery driver.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index e0b95ecbbebd..11f56b07e788 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -20,6 +20,7 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - const: x-powers,axp192-battery-power-supply
       - const: x-powers,axp202-battery-power-supply
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
-- 
2.38.0

