Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43706FF39B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbjEKOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbjEKOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:09:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D8B30D0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:09:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965c3f9af2aso1307197266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683814186; x=1686406186;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuyDnlOYxo/iihv+FkzR/V6NypU3FUK1HIwlYQQjiFA=;
        b=WV28hIevHEo3ZwDgw6pDbONFbRfwzDDWRcZAv12atTzdYG4VhUSkAXRuhmADUABQaQ
         Q3DQAApxjlYwT35fXjaoN5tSE5WsZxI4QTv/Nz38Ng9l8DKXq5YT7ISYwWXP76SnClZH
         us2IFCfAf1mjj/jdPfKS9ZHK6N6AbxhK9zOmAuMZ08scvfCJyJ4LXptry4GfjK6MePyu
         87HTYEouLkVsMOvI1b/UUYM8hplu/lNwwL3YNYmIgevB5Uo3QD1oTQEh8pqwmljdPhu2
         fXwj2nVnu4o7jnFMRlE7MQHqRXhird4kVLl6YzDTSraWOcdVTrqeC9UHU82Xji3WLINU
         RGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814186; x=1686406186;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuyDnlOYxo/iihv+FkzR/V6NypU3FUK1HIwlYQQjiFA=;
        b=hg+87GaSLfzJlbLceQnWoj3whl8kJ8S43MrNWl469I0LzPP/2s94icZuSW2QeJt87g
         d1mVzAjQoPtQjAes4ygD6erxzB4T9zb6sqKEjBvq6toFw5IbjxDVY0uhmpULTkCWQMMk
         AjxbsdKOnJ74c0BrjHAQEYYgRHsPZo4aCdJg2qjWXqYyS6z8yyrnodNKrAb1EBt4d+1q
         Rjr0pp4Y0lrnI3CBjqrpZjB7QhhSYd2kYgENReCWGfCzaES0ecVXVzyPtkVwbYRglaz1
         hCLelJbSTF+N67eCppXrcjfTHhpiX37+jtMcu/xj5nf6mziSET85Mo9HpFTRrsUtFjy5
         2/eQ==
X-Gm-Message-State: AC+VfDx1sVRY756h5CD198Fnjj8GIJJ9ivuiEE3GPaSisXMu7SWqLC8U
        QFs8T7gg7iUXL3fSP5Ccr7saZg==
X-Google-Smtp-Source: ACHHUZ6p282M3/d4Ia8U1W83mgvlYj22N3NEAwi2ZxI3B2vtXVjPE9WM0L4kfOb72diM5xbMkAv/Hg==
X-Received: by 2002:a17:907:3fa5:b0:966:180f:d10c with SMTP id hr37-20020a1709073fa500b00966180fd10cmr19775421ejc.33.1683814186117;
        Thu, 11 May 2023 07:09:46 -0700 (PDT)
Received: from [127.0.1.1] (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id gx1-20020a1709068a4100b00965a0f30fbfsm4057624ejc.186.2023.05.11.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:09:45 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH v2 0/2] Add support for TI TPS65219 PMIC GPIO interface.
Date:   Thu, 11 May 2023 16:09:40 +0200
Message-Id: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACT3XGQC/0WOTQ7CIBBGr2JYOwoDtdaV9zAuoB0txgIZ0GhM7
 y514/Il7/v5iEzsKYvD6iOYnj77GCrgeiX60YYrgR8qC5SoZaMUlJR3DaoO7DDANfkI+ZFS5AI
 a0Q3OkMSuFTXvbCZwbEM/Lg1jKemRcmGy03ayuRBLIxvUi5uYLv71+3E6V75wnKCM1f2vIxql9
 F63m31rcGdAwS2QDYGOzr7v3jFt+jiJef4C1WodctYAAAA=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683814185; l=2580;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=8BsaXhLhKiuRMa3gSnxE5Xb+X8AQ7hver+4gadrzs5I=;
 b=p38uRgJ/bhq6eBnzjcKnFfhtOZlC9rguiKdvXr1dGz995ibKYfcLymqO+mpShgRqofLU+4m+Z
 TKc6XP6OJEKABSi9ltnTzHca3b95ykNeWSejCDBJkZhF1SiQS/l0f1M
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/gpio/Kconfig         |  17 +++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 173 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/tps65219.c       |   2 +-
 5 files changed, 193 insertions(+), 1 deletion(-)
---
base-commit: 1a5304fecee523060f26e2778d9d8e33c0562df3
change-id: 20230511-tps65219-add-gpio-support-322bdb4e0297

Best regards,
-- 
Jerome Neanne <jneanne@baylibre.com>

