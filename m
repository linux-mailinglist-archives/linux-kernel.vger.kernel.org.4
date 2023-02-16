Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA077698FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBPJhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBPJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835630B35
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c20so2023871lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4kcTI2putLnbdN9MP2mFPB2+31xxohlAWl8A4kqJzM=;
        b=IWvdWUomqTO8QzgT9/RsA6AztLIRxUOVfgNmvqvN5Gxqy/9cUOZIxx4zOEI1GUMEuO
         V9TAsRuESAn9eSAcdJ2Q3Y3LmKVgHE8dfzqSPMuCxP/X5dVXTxpT/3K4G5ne2L20BOdg
         +Ns/bp3nNMVysizAwePy8SWWIByCVc5VQGg8CAYpY3pYPX0k66HI0RMoIupaYO98vhyF
         UQv0R+0F5TTrERZ+m2rMar8TvjV9kY3VTcqgBRT3yds+E6jk3uqrdTy6JBPMpNEg1k6H
         AheohWlxTzNKMooy9nCo7cHAhRm+3PHCMpalddk4nPGaayP7ES+3UEPmE2SdsVilbLTV
         raJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4kcTI2putLnbdN9MP2mFPB2+31xxohlAWl8A4kqJzM=;
        b=Banl49voEhDIIjXQ+S4MCrU0hDrQcwMa2DVQLsZa0BCmejSEFs6ifSgCECIWYtDrpf
         6HMxDLn/mcZ85adN294RfULuUC8FqtUaoEV1A78Nj2ZafWuaOOFxXPuP2Hf7aPGNPPc9
         glpSxj9/hjvy6kS/qCKOhGYzBFr/EsmXvbF2mOCLY0HCs57qNZDN0fg2CpYNV9eYlRT3
         CGvVfD2hZTEq8UXno2Z0AYdC3uOOf9eyBKeQ5xD4vP8yRc17sV2LUheZAlxPxBTuFkQ1
         Nx+zgLdraKEKUN7MBve3uoB4YHz8VqAt6G8Vt91maSJYaqDNSOQHw+JMWniUBn4Cdahq
         hvUQ==
X-Gm-Message-State: AO0yUKUEJ/lf3X6Z44gWkDW0dXBFb9UrZxprjvytw3c6cvu3yZq3dY4P
        Q/IRX8aB58h1xP4Wh2PwyxX76Q==
X-Google-Smtp-Source: AK7set8LMDSUl/0lfLpNLdxiWXIpZtBeu3tMcI1noiOnxnhVDDzyYiOekOwnbuCrkq4smDZqBa7rOg==
X-Received: by 2002:a05:6512:48f:b0:4ce:88af:473b with SMTP id v15-20020a056512048f00b004ce88af473bmr1118725lfq.54.1676540224493;
        Thu, 16 Feb 2023 01:37:04 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/17] Mass convert GPIO IRQ chips to be immutable
Date:   Thu, 16 Feb 2023 10:37:01 +0100
Message-Id: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD357WMC/0XNQQqDMBCF4avIrDtgprTBXqV0kaSjGdAYMioF8
 e6N3XT5w/t4OygXYYVHs0PhTVTmVMNcGgjRpYFR3rWBWrq2ZG4o07Quzo+MIUpWtHfqiMja3jB
 U5Z0y+uJSiKcbssx/cw5y4V4+v8vn6zi+Vg6p2IIAAAA=
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
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
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

Please test if you have the hardware. The OMAP patch especially,
hi Tony ;)

I don't expect this to be merged to v6.3, but as Bartosz may
feel it is fixes material they are of course fine to trickle
in on a case-by-case basis.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (17):
      gpio: altera: Convert to immutable irq_chip
      gpio: adnp: Convert to immutable irq_chip
      gpio: aspeed: Convert to immutable irq_chip
      gpio: aspeed-sgpio: Convert to immutable irq_chip
      gpio: ath79: Convert to immutable irq_chip
      gpio: cadence: Convert to immutable irq_chip
      gpio: eic_sprd: Convert to immutable irq_chip
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
 drivers/gpio/gpio-aspeed.c       | 44 ++++++++++++++++++---
 drivers/gpio/gpio-ath79.c        |  8 +++-
 drivers/gpio/gpio-cadence.c      | 10 +++--
 drivers/gpio/gpio-eic-sprd.c     | 33 +++++++++++-----
 drivers/gpio/gpio-hisi.c         | 25 +++++++-----
 drivers/gpio/gpio-hlwd.c         | 33 ++++++++++++----
 drivers/gpio/gpio-idt3243x.c     | 11 ++++--
 drivers/gpio/gpio-max732x.c      |  8 +++-
 drivers/gpio/gpio-mlxbf2.c       | 32 ++++++++++++----
 drivers/gpio/gpio-msc313.c       | 26 +++++++++++--
 drivers/gpio/gpio-omap.c         | 83 ++++++++++++++++++++++------------------
 drivers/gpio/gpio-pci-idio-16.c  | 12 ++++--
 drivers/gpio/gpio-pcie-idio-24.c | 12 ++++--
 16 files changed, 297 insertions(+), 118 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230215-immutable-chips-762922277f1e

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

