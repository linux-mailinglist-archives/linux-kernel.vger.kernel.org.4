Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5506A341F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBZUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBZUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:54:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4E10AB1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:54:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so18025031eda.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xCc6hdBBOY36yrfSA2b2U559vub69VWaEmSIo4wJJw=;
        b=SMeeXl1uXWvpcsnn6+YTJTplSH7r1sn5v0jQLPV0uuM6eZ8NSBeUCPJct+UDIbDfhE
         hUz9whtZe9H0GWdqkRZmx2lLO80M2ZWam06soXPbvfqNEAKu3NZ7Lf8a/HzlWeqUXFoc
         PTUqnprv3G8kpA+6PG+qBflVBseS6XsKp6Yg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xCc6hdBBOY36yrfSA2b2U559vub69VWaEmSIo4wJJw=;
        b=zqQ8cUmdOURY8L/n1xjjH5Tn7227BjzJOkomqKn9dp+2OXeXuUay0H9nB/XOu6AnRc
         vTz/JwDthrhP9LTLtsKFT1JPRqSK1TV1vzNJFK2atQ5YY1lsuncbMfp/OPo1OP+HlpgT
         jb0e1c9wejzD7Yj4OIZxxQntuULA9/5+hINmWYMyPrlS/C0tYWmtlsGZCOgAOx+x33lc
         lZU+oLR97EB1T8ae5Tw0GI+2/7AJ+Y+kBV0/YXuPOu/Lb1N+U4eexYVPiGJzWfQeLdC5
         9yMalUb6qtfeuCMGT8Siz8846arPWZkTyXpndobLh2TJaRWpSFLSiePPztco1dUpw/tl
         CVOQ==
X-Gm-Message-State: AO0yUKVlUYNyCpBSd6jWwnttRSRZAoi+lJF+TSwabvVV+sHaMnhW6hIR
        rC03/EagAQIbD8bdTPeUH35Nn4a7RSOInTKy+zA=
X-Google-Smtp-Source: AK7set8V6hoMz0ECwaPMOpg+24nD8v3A2PKT8QB9l9btM0fXTE2gC6XCHB9TJ6kADcZOags+3mOjmg==
X-Received: by 2002:a17:906:9991:b0:8b1:7eb1:590e with SMTP id af17-20020a170906999100b008b17eb1590emr32173637ejc.20.1677444841214;
        Sun, 26 Feb 2023 12:54:01 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-22-12.retail.telecomitalia.it. [82.56.22.12])
        by smtp.gmail.com with ESMTPSA id lz15-20020a170906fb0f00b008dffda52d71sm2320013ejb.124.2023.02.26.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 12:54:00 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH] gpio: mxs: use dynamic allocation of base
Date:   Sun, 26 Feb 2023 21:53:57 +0100
Message-Id: <20230226205357.1013504-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
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

Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using static
gpiobase allocation"), one or more warnings are printed during boot on
systems where static allocation of GPIO base is used:

[    0.136834] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.142753] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.148452] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.154341] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.160097] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.

So let's follow the suggestion and use dynamic allocation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpio/gpio-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 7f59e5d936c2..b48a7c1fb7c1 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -330,7 +330,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 
 	port->gc.to_irq = mxs_gpio_to_irq;
 	port->gc.get_direction = mxs_gpio_get_direction;
-	port->gc.base = port->id * 32;
+	port->gc.base = -1;
 
 	err = gpiochip_add_data(&port->gc, port);
 	if (err)
-- 
2.32.0

