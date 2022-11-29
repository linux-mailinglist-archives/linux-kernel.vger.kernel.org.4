Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13B63B7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiK2CeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiK2CeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:34:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED2421AF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:34:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s12so17962573edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=770v95sUrIlvtNLFG2ZFJPK2miGjPEzCsACcRdRH3P0=;
        b=KtIorSIdh3d3uWlsZA1SrhGsQlbfGeLfo+VHQYFWQtkxRniNSTYERELjM3I5xCQPES
         iW1aMNWCA9wC7C4/aaVQa1DNgKcQlD0kCogEmpTnekZQiNNzVXywkUMmwJMXV0124wTT
         VgIr5sURQfKCiUWg8xMSU0fSEODUS2kcAv9kRtnb9l1e7VpAUXIMggTPsR0gGavSYVYf
         HqrY+qMUOQrxu0XjRe7Wfr0gZbyPsUhV1JpPtywD4DPBiIRVzADw4dzQ0nrS+5Ig4HrG
         hZ5ltam91ISEz7Ri66w20yPQLBDRWqJmKpiEJuMtkP2obRkKfBAZCudmfLLTnn4gm0SG
         HfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=770v95sUrIlvtNLFG2ZFJPK2miGjPEzCsACcRdRH3P0=;
        b=wyf0C2FhzKggFMAsP2079Nk8HuIgqsNVsmoCCIvVJctY28aubvU3nF09R6netceSPD
         3G2yj++JsA7hCvy2OTZvQzDOTkp9bc327bbEfY6KDNdCinT+DQvIZ9qSvXydxJ2iZ5A6
         s+ypy2d6TP4EPMAzr7rgUkU8ZA/jXku2kDUuGCELS57JEiG9mUQdojuoUUgH6dNZtn8n
         ZII7ie7Iy3B40fOZEeQafk55DYYplIrr1JZAh4ZKh0yVBxyuu7OMRz5c1HInzSCe+MR7
         Bneq3DEJwgWl6xvLFIoWEKh9LkewpYB4aRIpZ46oQv/wuRvAWvzd6aPVtT/uCAIED3Dx
         ymKQ==
X-Gm-Message-State: ANoB5pn/5Q5Iy6q2WZ7ssIqv9plh2/BAhf6mSmIV9oQvimzfDrAmZBG1
        RrW/FBuustNWZhqBYzmzlNeayQ==
X-Google-Smtp-Source: AA0mqf50ZSA74qR3XCOCM6LUBeSegCpn3qM55F0v3CAeeDj/+bX11XGwWL8FKbwRauaJFIssCHLC4g==
X-Received: by 2002:a05:6402:5483:b0:468:d5a9:cb4b with SMTP id fg3-20020a056402548300b00468d5a9cb4bmr35890314edb.409.1669689245330;
        Mon, 28 Nov 2022 18:34:05 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d744000000b004615f7495e0sm5733817eds.8.2022.11.28.18.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 18:34:05 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: [PATCH v3 2/7] pinctrl: stm32: Remove check for pins-are-numbered
Date:   Tue, 29 Nov 2022 03:33:56 +0100
Message-Id: <20221129023401.278780-3-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129023401.278780-1-bero@baylibre.com>
References: <20221129023401.278780-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the check for the unnecessary pins-are-numbered
DeviceTree property

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index cc9472b284047..1cddca506ad7e 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1499,11 +1499,6 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	if (!match_data)
 		return -EINVAL;
 
-	if (!device_property_present(dev, "pins-are-numbered")) {
-		dev_err(dev, "only support pins-are-numbered format\n");
-		return -EINVAL;
-	}
-
 	pctl = devm_kzalloc(dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
 		return -ENOMEM;
-- 
2.38.1

