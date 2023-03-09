Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935356B1CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCIHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCIHp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:45:58 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62BBD4634
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:45:56 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r27so1134550lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7u9Q7fUnpppRJq2RShEjTYzc0gmpoEcEwMnKD4I77E=;
        b=ZOGUmF5lPyvnwoaxcsnaV5kFREvx9c67R8Xt2D4aG2OqbpjoSIFIgfjqkeKd2S6usT
         l8DXLzEVqebWIrKLzoDS9E38ZHi4X+ic8s+682m0ifDHn+tHimOpvXVudCZanN7m+C+H
         vBk53hkGLAEoK0bLibgNAgem9FZPvK8njQ1BlmZ8qRGstSAB9t+Hyw/r4nQZlcRpAMjF
         PXeWttVBiHP1Y35YAuxdi7JNtR0VBHVw3F1xrsIYJLgX49CQQGFroE+TpqvMnr+iF4Lz
         i7YmgZn762YP4GfeUrARK5T1rbAouopqXXUl7MA9C9BOjxvIhXvKgBB84+ifrXOof8PX
         XWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7u9Q7fUnpppRJq2RShEjTYzc0gmpoEcEwMnKD4I77E=;
        b=Z4KvLCLz8Xpbbo4eMHcSdaQGw5AKbYMhp4zT9F89xovJnIuBcimMS775tU5KsOUJ8D
         a8x/V3umjh5Oc8bEgBPkrMeQpyvXVpRRSf4IanB3Kr6UrhBq0XYu5+8L9UnS/YEUteU4
         4oqMjbQAwIwrSHrRnnZRIKnZoGD985KlZ0fyYwjoeBMLGfLt9y3Em5YngecG8veva25N
         r1Vxjpkblo4CHfDcS1N0Jn7XpFkEoAZN+3RU0pktc8FgU9ViebyYuNQkWD6GFxPjJ71j
         7opcVBouqFuZWuY/oGSkH+4wqwYGNsNPJAUPb3BXEDYwwu+kbtKIeHCjL7WKjkyjrlLg
         FI3w==
X-Gm-Message-State: AO0yUKW9sAJM3Ll6yGOUa402eabKJj/n9mLCZkJsfPf9Cavl/zHNdQk3
        q9xvy26NiNwg/eK39H5DQJthJQ==
X-Google-Smtp-Source: AK7set+vIUQ72mb6AEMJVO/fxbvWyj70zhw6JKYV9d4wNLZO7GH6w6kig86D2dIVDe9AxryQMSHQBQ==
X-Received: by 2002:ac2:5dfa:0:b0:4b6:e405:1027 with SMTP id z26-20020ac25dfa000000b004b6e4051027mr6046573lfq.14.1678347955140;
        Wed, 08 Mar 2023 23:45:55 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:45:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 00/17] Mass convert GPIO IRQ chips to be immutable
Date:   Thu, 09 Mar 2023 08:45:48 +0100
Message-Id: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2OCWQC/4WOQQ6CMBBFr0K6tqYdBMSV9zAuCp3SSaAlLRIN4
 e4WNsaFcfl/5r0/C4sYCCO7ZAsLOFMk71LIDxlrrXIdctIpMxCQC5AFp2F4TKrpkbeWxsirEmo
 AqCojkSWqURF5E5Rr7cZ1I/kPsx2MAQ0998nbPWVLcfLhtX8wy639PTZLLngh1dkAnFShxbUnp
 4I/+tCxTTbDHwEkgS4bgbkBXdfyS7Cu6xs9SJNyEQEAAA==
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are getting tired of these irq_chips not getting converted
to be immutable, so I just take out the big hammer and fix
some that I deem not too complex as best I can.

I stopped after doing some, I will take another sweep at some
point I guess.

This is v6.4 material.

The last two patches to pci-idio-* (patch 15 and 16) can be
omitted if William's patches to convert this driver to
regmap GPIO are merged first.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Deleted the irq_chip->name assignment in the Aspeed driver
- Fold in a patch from Joel to make aspeed IRQs compulsory
- Link to v2: https://lore.kernel.org/r/20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org

Changes in v2:
- Rebased on v6.3-rc1
- Collected some test and ACK tags
- Link to v1: https://lore.kernel.org/r/20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org

---
Joel Stanley (1):
      gpio: aspeed: Always register the irqchip

Linus Walleij (16):
      gpio: altera: Convert to immutable irq_chip
      gpio: adnp: Convert to immutable irq_chip
      gpio: aspeed: Convert to immutable irq_chip
      gpio: aspeed-sgpio: Convert to immutable irq_chip
      gpio: ath79: Convert to immutable irq_chip
      gpio: cadence: Convert to immutable irq_chip
      gpio: hisi: Convert to immutable irq_chip
      gpio: hlwd: Convert to immutable irq_chip
      gpio: idt3243x: Convert to immutable irq_chip
      gpio: msc313: Convert to immutable irq_chip
      gpio: mlxbf2: Convert to immutable irq_chip
      gpio: max732x: Convert to immutable irq_chip
      gpio: omap: Drop irq_base
      gpio: omap: Convert to immutable irq_chip
      gpio: pci-idio-16: Convert to immutable irq_chip
      gpio: pcie-idio-24: Convert to immutable irq_chip

 drivers/gpio/gpio-adnp.c         |  9 ++++-
 drivers/gpio/gpio-altera.c       | 25 +++++++-----
 drivers/gpio/gpio-aspeed-sgpio.c | 44 +++++++++++++++++----
 drivers/gpio/gpio-aspeed.c       | 82 ++++++++++++++++++++++++++-------------
 drivers/gpio/gpio-ath79.c        |  8 +++-
 drivers/gpio/gpio-cadence.c      | 10 +++--
 drivers/gpio/gpio-hisi.c         | 25 +++++++-----
 drivers/gpio/gpio-hlwd.c         | 33 ++++++++++++----
 drivers/gpio/gpio-idt3243x.c     | 11 ++++--
 drivers/gpio/gpio-max732x.c      |  8 +++-
 drivers/gpio/gpio-mlxbf2.c       | 32 ++++++++++++----
 drivers/gpio/gpio-msc313.c       | 26 +++++++++++--
 drivers/gpio/gpio-omap.c         | 83 ++++++++++++++++++++++------------------
 drivers/gpio/gpio-pci-idio-16.c  | 12 ++++--
 drivers/gpio/gpio-pcie-idio-24.c | 12 ++++--
 15 files changed, 290 insertions(+), 130 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230215-immutable-chips-762922277f1e

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

