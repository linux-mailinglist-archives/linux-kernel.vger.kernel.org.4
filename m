Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89F8726307
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbjFGOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbjFGOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:39:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0AA1BF8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:39:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso74688095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686148777; x=1688740777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GcYfQXbJmH+P+okZGHVb5WVmSZydMCLOywQQa1xU8c=;
        b=ZPPI2dVEc5hp8ewqPynawtru3GCxCZPf6xGnhu6MHYni8F2Gnrf+crK2MVmQL5sR4U
         Gkp5BCvJ2iFfWv5nWiqNWJ87QDNSIVYF0rEIeA712Bt7v6yoGFlw2xX2DOld4DKhZgNB
         vdlF4k1Xygn3yGKS5XLKjr6FDTPLMYX+wSBMMBAn2NoqJ+lNLo4G5qhiS6aCI0jRU/Fy
         wTenv14TG3XD3Hbxs4m5H0ZmVHZMH76qPGSX4HIegSupRa/nIkoppLdEMs3PJUiSN3CD
         axQXJMeOmz6YlGAwCQA7osO50buxeG7t89cRSi0JFcrILCVD4aO8wyxbJ8awkfDdU2bM
         cCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148777; x=1688740777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GcYfQXbJmH+P+okZGHVb5WVmSZydMCLOywQQa1xU8c=;
        b=Hpe+W3uOUr9FVcqHB0mGugLzXyQt+g8/LAlYsx2NAWipNfI3q/gCem8dzFfmpvz8rm
         npxX0oDtK3mUgqOoy2j5mOynE91/MPCFDUwOxrvdlbPqnL67Kt3fShBfWtE14ZGhIKuw
         Svph6Wb8ML5wZSCRbtYUfQ5yhJn25wPpf9flMvTXc/rL941isr0yXn31qbKKt2EpCl0y
         9ivS3Vi3JKJ4UezVuN4gYbA54l9IMrax4JIRksLbqhiNahWbYWjkzgT0PbFghx9SqdIh
         o0siPSGw5kHA7YFDq6o0kmjcLFKSO5Ho4cUE3aOfKTKuEVh0m6KqEwZfw4mPbuVzcm5c
         S25Q==
X-Gm-Message-State: AC+VfDwiNXLmoGBTEnPwRWH6TfuiadZ0dwSr9oTkcj1ka7X6aq4iyuaY
        vH7k2BqjSMOa4wCSFUnjJ7UFwA==
X-Google-Smtp-Source: ACHHUZ7aQ3eIVra/EYBsnLrW849H9HQ1yWGsVn89GVF+qIOu/DlliUweO7FhT2OLUA1340zXJGbeLA==
X-Received: by 2002:a05:600c:2041:b0:3f7:a80a:c66c with SMTP id p1-20020a05600c204100b003f7a80ac66cmr7534980wmg.0.1686148776871;
        Wed, 07 Jun 2023 07:39:36 -0700 (PDT)
Received: from [127.0.1.1] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003f7ea771b5dsm2380720wmi.1.2023.06.07.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:39:36 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH v5 0/2] Add support for TI TPS65219 PMIC GPIO interface.
Date:   Wed, 07 Jun 2023 16:39:30 +0200
Message-Id: <20230511-tps65219-add-gpio-support-v5-0-ebb94281c854@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKWgGQC/43PTW7EIAwF4KuMWNdTMOSvq96j6gKCM6FqAAETd
 TTK3UtmU7XqIssn2Z+f7yxTcpTZy+nOEq0uu+BraJ5ObJy1vxA4WzNDjpI3QkCJuW1QDKCthUt
 0AfI1xpAKSERjjSKOQ8fqvtGZwCTtx3kX5lLiNeaSSC/Pi86FEle8QbnPxkST+3r0eHuveUphg
 TLX2Z/riEoI2cvu3HcKWwUCPjxp7+nV6NunM4nOY1h2bna5hHR7fLXijh55YEXg0PKJTKtsqwb
 92917rfIwJismhlpXS2V75P9g6jCmKmYa2+quVusQ/2Dbtn0DhnHKXcoBAAA=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686148775; l=3974;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=ayyGJqZuPvp+7hoYN3nxbJTiAaL3qNszicDwYunMJzQ=;
 b=zNK9dWkMh1R0CRGRe3DZW8Cza09Bx1whF0JJpQwy7+9jktk9HM9t3O07bLj3BmmGkwVL/kn3s
 4Ts5+YpqWO8BKsa6BoHUbDSeQfY/0bJbt2N+cejioi5BCNckPaIgn1i
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
- andy.shevchenko review:
	- Use ENOTSUPP instead of EOPNOTSUPP.
        - Nits:
                - Use Datasheet tag in commit message and cover.
		- Indentation, use 80 column width for Kconfig and 100
		  colums for C files.
		- Format comment.
- Link to v4: https://lore.kernel.org/r/20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com

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

Datasheet: https://www.ti.com/lit/ds/symlink/tps65219.pdf
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
 drivers/gpio/Kconfig         |  16 ++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 185 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/tps65219.c       |   2 +-
 5 files changed, 204 insertions(+), 1 deletion(-)
---
base-commit: 8ded96e4d9a6da88bdbad61350cc6147b7c0c00c
change-id: 20230511-tps65219-add-gpio-support-322bdb4e0297

Best regards,
-- 
Jerome Neanne <jneanne@baylibre.com>

