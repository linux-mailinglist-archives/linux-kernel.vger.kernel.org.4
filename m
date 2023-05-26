Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1536F712914
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbjEZPGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjEZPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:06:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE713D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:06:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-309553c5417so767391f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685113591; x=1687705591;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RX3Q6YeXkmJ37HeLtIKdFn9b2zHc6WYH2gkf9X+5m7I=;
        b=TdolivaKjgNwdAqiffQDUfLmvwGc41ry7WZschgclCq92aezG5MmRiXHO75PsO6GSc
         VI83FsC+jTJVr23U4ikuVWYioTN4Y7XNv4vGSSU7vDhHrR9bac+n2Hj4VIfvQ3JWguya
         XIr76/vJMAlDpJuqspx6Aop+3yEShkWH3mSTqACtG+13CebfQUZ4LLbPcpi7OBLWciqe
         Dqj7UPBMR5yyARp7WPNdCskO6kquJw8LAqc7pAGATon6xsPfXvuirYG3b24FAqoFlH6B
         P39hKe2gDULoLMZ/wIyCOp++/sO7nmkT+3l+GCLsNxZSExjpY6HQv3gWyjHKr5V9RGta
         cFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113591; x=1687705591;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RX3Q6YeXkmJ37HeLtIKdFn9b2zHc6WYH2gkf9X+5m7I=;
        b=bKRQ2Zm1h8xg/QM8CUxVVmV3MNRmuVHeHMqyQ+I9Fv0HvdoA/oMmI+LUVXYxif70Ov
         4+Pw+EpDzlRuJhzOYuvON4De8mC+ajUfDLwLOuQ8ecxg42rWwuhbAOXTmYPki03XqqiJ
         nCPkvRRu534bpB6FsQ62wlJrQ5/1QsQhCjBEsxbOR82GRJsEnS65E5i5584ck6xd9+i6
         2QGOOvuiieyZo2A9XajTl/tpcJvgWD+UER4u2PzuO2V3cYNbTHn43g6V8oOGM23rUWYF
         tizdKCQgUyzaKf+5tMEqNzAYUX0uZfTk/Eyc1SUaFXgqDTN0RjRv86ufZ9ZbxTWbgxa4
         z7QQ==
X-Gm-Message-State: AC+VfDzcuitCV3FFyqGdMmyqNnkoSY/sb4cIYXwViiGij4g9XHHpJQoG
        QVrtaRjY0ucNZ5gKDZQOOw8d4yqCtgWbBd7Lc31zNw==
X-Google-Smtp-Source: ACHHUZ78LOTmoNR7HLuu0djqZ91cbh6iGpgM+pFuLo+3rh4Js7NGnhbE/xa2qYPWV7MzYLwWtxoqUg==
X-Received: by 2002:adf:f34f:0:b0:30a:d9e1:ecf6 with SMTP id e15-20020adff34f000000b0030ad9e1ecf6mr1523039wrp.37.1685113590839;
        Fri, 26 May 2023 08:06:30 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d69d1000000b00304adbeeabbsm5422146wrw.99.2023.05.26.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:06:30 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH v3 0/2] Add support for TI TPS65219 PMIC GPIO interface.
Date:   Fri, 26 May 2023 17:06:02 +0200
Message-Id: <20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrKcGQC/42PQW7DIBBFrxKx7qQwYBx31XtUWYAZx1Q1ICBWo
 8h3D84m6q7LJ/15f/6dFcqeCvs43Fmm1RcfQwP5dmDjbMKFwLvGDDlK3gkBNRXdoRjAOAeX5CO
 Ua0oxV5CI1llFHIeetXtrCoHNJozzbphrTddUaiazvC+mVMpc8Q7lnk2ZJv/7/OPr3HjKcYE6t
 +yrHVEJIU+yP556hVqBgO9AJgT6tOb2422m4xiXXTf7UmO+PVetuEv/M2BF4KD5RFYrp9Vg/nr
 P27Y9AKzZZHAwAQAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685113589; l=3113;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=cJ8O4BUGDUdWCYcYJpyZ1Azp4xYLHSLYCBDChWb7DIQ=;
 b=DSrf5fQA/5Z8zmdTMAZo/SYRW6bOlK6pzIfFJBBXJHv5dSzI+nrINzWi5hHOhIU4eUYs9TIE/
 F9xjUuH9QSBBc4BRou1+KuhSYInZhR/2G64EWwV+La2D6RzBFCYHNai
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

Add support for TI TPS65219 PMIC GPIO interface.

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

Changes in v2:
andy.shevchenko review
- Typo and indentation in commit message.
- Clarify Co-developer role.
- Specify name for module.
- Code simplification for tps65219_gpio_set
- Put test code into #if 0 ... #endif to make it easier to re-use
- Formatting for .driver
- remove dupplicated error management => dead code

Previous version:
v1 - https://lore.kernel.org/all/20230224113837.874264-1-jneanne@baylibre.com/

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
 drivers/gpio/Kconfig         |  17 ++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 183 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/tps65219.c       |   2 +-
 5 files changed, 203 insertions(+), 1 deletion(-)
---
base-commit: 8ded96e4d9a6da88bdbad61350cc6147b7c0c00c
change-id: 20230511-tps65219-add-gpio-support-322bdb4e0297

Best regards,
-- 
Jerome Neanne <jneanne@baylibre.com>

