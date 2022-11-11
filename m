Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02BD625998
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiKKLjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiKKLjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:39:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77488D18C;
        Fri, 11 Nov 2022 03:37:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k8so6141856wrh.1;
        Fri, 11 Nov 2022 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcYkB/mxztaLgFeEdGXiapfCgu8NPHMQKOD54+dU1Xg=;
        b=Ynrf4dU5EOo5yHCKTcZ3ChryXeMxonMaIZ96DCkpPoDic+1exkeZWdnFCtr1JclsZE
         RmQ2zSjtW/yPIFCuTmvH3lBv3XHwZkT3hds4aiiYsbz8Kivx9QddzOgBgsZBws2JhXbu
         UI3F5uBkSurqh4pmGlEyqCTvVeZ2P/Kije5JtyBqL0IQujI/SetdLHRQga0Hr19zQ/Av
         CODd0CIyAIK4ekmBQtxRhwSgS+vLGXLMV8TGGDNPJiF7ae5IyDl2zLP6StJcCyqQN59J
         XijfvMnvKjWMqxO1aV8224i24H/PhsEkB2/WIP8WaxpM+v1jpfd5FiBmpEdJqBsV7PnV
         dOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcYkB/mxztaLgFeEdGXiapfCgu8NPHMQKOD54+dU1Xg=;
        b=Tx9qYJC9rLV/eW5O2OgudPAjLJLvKkgkO4KB9Cd9ZnmpAHioCZYlyS8lf/Y7Fw/dEf
         I9bwe2SN2y3sfV9iE5IS9h8ZpJXNp3dkhn/QxnIA2M//W+j92RMVKDBBV7pTshekhlHs
         IN+sX1K6/y7AEy0aX4FaxNFT8DmtA3bxghToMZcnh41HakcUON0iIih/k1PQF9+Yjnis
         d0eIm29aIRXigDm3dF4JncIDRlTJLSIqCSPYevNfMSZEWm8s2vd/KiLgbDn6CTeXuN70
         2hFunaIAwe8SHfQxXowzJitKuZOhm+s8bK/8j/sDNguMMwcgeoiJWo/NSPQJ2WKVHBrP
         mPQw==
X-Gm-Message-State: ANoB5pmvc7BhI17MgEnAP24Kw7XEOh4ku2r/w49nRLKXihcUwMdYfX74
        zjRLMtaU/A0Ew+lEy/nsUzbCSLvwcEw=
X-Google-Smtp-Source: AA0mqf5KjyuueErqc2vgVBh9hgG0yWx3HILirKu4yTe7CZaYDlcu+VL/edTiEV1O3l2naXzULa/hqQ==
X-Received: by 2002:adf:e546:0:b0:236:7083:21d5 with SMTP id z6-20020adfe546000000b00236708321d5mr932526wrm.126.1668166656750;
        Fri, 11 Nov 2022 03:37:36 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e12-20020adffd0c000000b00236576c8eddsm1728349wrr.12.2022.11.11.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:37:36 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Date:   Fri, 11 Nov 2022 12:37:32 +0100
Message-Id: <20221111113732.461881-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The OF node store in chip->fwnode is used to explicitly override the FW
node for a GPIO chip. For chips that use the default FW node (i.e. that
of their parent device), this will be NULL and cause the chip not to be
fully registered.

Instead, use the GPIO device's FW node, which is set to either the node
of the parent device or the explicit override in chip->fwnode.

Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4be3c21aa718..55c3712592db 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1067,7 +1067,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	struct device_node *np;
 	int ret;
 
-	np = to_of_node(chip->fwnode);
+	np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
 	if (!np)
 		return 0;
 
-- 
2.38.1

