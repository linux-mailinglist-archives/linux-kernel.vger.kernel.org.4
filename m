Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDA7157CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjE3IAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE3IA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:00:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EF1F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:00:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so27579325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685433624; x=1688025624;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bw+5vrlh0KQEe/ZrC9Pnuz5iO47khIwJxUk/pu1gpew=;
        b=ibetnfGa8zwbkn/x1gxPY8DvlS1I3oy9L0hEzldvnZQfuPCq8VupX5M8Oh4JwI+N6G
         PKnq46TGaLsGxijSv/v/7yGW73SYCN/3C2LqjVVzFk3QFeYXBE/+SMpF1F9yib6KRKZg
         dw8BEOrDmnZ6EVkqerqJ4ctQIi3aQ4NcODtsZZNJS/FPWFuMd8cxzvn3VivknkwRNT8H
         kL2qwjXXqCrpCM2aCNjyiJgHHnxx2HtRO56T08v+aUeh1oLObuLaJk36NK8oS7SzPti7
         3LpXlNRZsXeJAOfWOOIDDt2eAj+q07KfnDOJiPxgj4N7TDW81/97qfqfRzA6r5BQ8WYD
         lb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433624; x=1688025624;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw+5vrlh0KQEe/ZrC9Pnuz5iO47khIwJxUk/pu1gpew=;
        b=JVJi/AX0NlWkuAyP3Vz0wrpVlO1iiF+3z6NwNnE4bWnL4R2ejygldL4ji/l2YAQwSQ
         UAMZ4sJxHmWQtS050kxJZXuBRqWxqmT9TU187HU4R8Gh7zt3z7AA7lHpxQEUv96tUGwS
         qt50ceJwZqmKW2/Gm5OSEq0fN6lGOt1fRYDVZmhedGRG+hB37bsN8d1Pft3ojejNFHmr
         /9aU7xPW2hEipdklz43DpAw7v85wg/0btxxme6TFv9Au1Pd7nqPzEAPgu/caFWszNfao
         5I6mP7w0eAS60IUVYVKhqicQO74OKAihbU/LyQXfr9QweJzo5IXLuwFlP/FTxEx8q+L2
         Qr8A==
X-Gm-Message-State: AC+VfDzYUh6wGNvne7HEydQB0GLHIwDhJxhetpNN/xi1eC0D2NmQ52wi
        NbBWsgLIlcjO8joNJNjniiCotWdVL/K2OfJHmO+02g==
X-Google-Smtp-Source: ACHHUZ66WyhozjmS8SuHV4WWbgDfZBfLjKrJUYKJliPrYZCbi0ZUu5y02AZ0hWXhH82JdhKKhy6qnw==
X-Received: by 2002:a05:600c:2055:b0:3f6:1c0:aa7a with SMTP id p21-20020a05600c205500b003f601c0aa7amr819793wmg.29.1685433623796;
        Tue, 30 May 2023 01:00:23 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f6050d35c9sm16409978wmc.20.2023.05.30.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:00:23 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH v4 0/2] Add support for TI TPS65219 PMIC GPIO interface.
Date:   Tue, 30 May 2023 09:59:58 +0200
Message-Id: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6sdWQC/42Py27DIBBFfyVi3UlhwK+s+h9VFmDGMVUNCIiVK
 PK/F2dTtassr3TnzLkPlik5yux0eLBEq8su+BrU24GNs/YXAmdrZshR8kYIKDG3DYoBtLVwiS5
 AvsYYUgGJaKxRxHHoWL03OhOYpP0474S5lHiNuSTSy/uic6HEFW9Q7t2YaHK3p8fnueYphQXKX
 Lu/3xGVELKX3bHvFLYKBHx50t7Th9H3b2cSHcew7LjZ5RLS/blqxR36yoAVgUPLJzKtsq0a9F/
 u7rXKl2GywsRQdbVUtkf+D7Zt2w8fJUuGfQEAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685433622; l=3607;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=75fLodblHGAK8az+b3sKgWwZ6ptLjqBbZzqy8WiflR4=;
 b=+vetZhSC7TkflGwLDOj2AYFcBRUnPgVLW2aniFawu05B2Prd09qxSBUyqq64Iq6eJ/EXV25hQ
 t99OUQ4h6xjDIgPq8fBGtVMi2wXEDzOYF788K6F+Yylm6HTBxsBdaDJ
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
- andy.shevchenko review:
	- Nits:
		- move blank line before link in this cover.
		- Kconfig indentation.
		- Formatting: Comments; indentation; line length 100.
		- Do not split string literals.
	- Add var *dev = gpio->tps->dev and replace to get shorter blocks.
	- Evaluate GPIO0 MULTI_DEVICE_ENABLE only once.
	- Explicit include of bits.h
Change to CONFIG_DEBUG_GPIO: debug options from Kconfig for GPIO only.

- Link to v3: https://lore.kernel.org/r/20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com
GPIO interface consist in 3 pins:
Two GPIOS are output only: GPO1, GPO2.

GPIO0 is used for multi device support:
- The input-functionality is only used in multi-PMIC configuration
- In single-PMIC, it can be used as an output

The configuration is static and flashed in NVM in factory.
Description tps65219.pdf chapter 7.3.13

Linux must not change MULTI_DEVICE_ENABLE bit at run time.

This was done for test purpose only to check input/output
correct behavior on EVM board (no access to different NVM config).

Tested on k3-am62x-lp-sk board. This board MULTI_DEVICE_ENABLE=0

Despite the register bits are out of order,
driver is remapping in natural order:
GPIO0 is gpiochip line 0
GPO1/2 are gpiochip line 1/2

Initial version by Jon Cormier on TI Mainline.
Ported upstream by Jerome Neanne

PMIC datasheet:

Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
Changes in v3:
- Linus Walleij Review:
	- put test code under IS_ENABLED(DEBUG)
- Bartosz Golaszewski Review:
	- nits: alphabetical ordering for includes, newline after
	  return, 
	- Add error message on regmap_update_bits failure.
	- Change variable name in: tps65219_template_chip so that it's
	  clear that gpio_chip get's a copy of this template structure.

- Link to v2: https://lore.kernel.org/r/20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com
Changes in v2:
andy.shevchenko review:
	- Typo and indentation in commit message.
	- Clarify Co-developer role.
	- Specify name for module.
	- Code simplification for tps65219_gpio_set
	- Put test code into #if 0 ... #endif to make it easier to re-use
	- Formatting for .driver
	- remove dupplicated error management => dead code

- Link to v1: https://lore.kernel.org/all/20230224113837.874264-1-jneanne@baylibre.com/

Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

Jerome Neanne (2):
  gpio: tps65219: add GPIO support for TPS65219 PMIC
  mfd: tps65219: Add gpio cell instance

 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |  13 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 167 +++++++++++++++++++++++++++++++++++
 drivers/mfd/tps65219.c       |   7 +-
 5 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-tps65219.c

--
2.34.1

---
Jerome Neanne (2):
      gpio: tps65219: add GPIO support for TPS65219 PMIC
      mfd: tps65219: Add gpio cell instance

 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |  15 ++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 181 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/tps65219.c       |   2 +-
 5 files changed, 199 insertions(+), 1 deletion(-)
---
base-commit: 8ded96e4d9a6da88bdbad61350cc6147b7c0c00c
change-id: 20230511-tps65219-add-gpio-support-322bdb4e0297

Best regards,
-- 
Jerome Neanne <jneanne@baylibre.com>

