Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16F65FF45F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJNUOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJNUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:14:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00261B871
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:14:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so5196641ybs.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3obta7+4jpsxJjGufR8RmHp+D4xEEYHKC+46IVfYMg=;
        b=mo9CmUUMdRpfCf1BqHvLOZiOPSkOBTRiws9esonvY6HL8h7ba+rKQG2UZQCYwLrxMu
         wK4Qpi6Y5gA2JDxIZ4B4Qm9EtAviDDngaRT/GqIpz+1Uied19OsHI4504VP5ATSm4MKI
         UF8/McecB6Lfa+hyrQ+vJJ1CfjddtfxojbDFTS9F38jtgImsDIxcJHYlcAGmoOhZfEUP
         QYo8mOph/McaR45tulTZyk8YeLAoZwc6UMiDz7Y3CqVTyhskSjmUhTVDU1d7ZlhnEWyQ
         wwd99n1EgQvSlfah1WL/Q3rXRbxZ4cgnk56WvOQnyQEhzg4MShv+iG6IdvddCZ0XgT/b
         tX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3obta7+4jpsxJjGufR8RmHp+D4xEEYHKC+46IVfYMg=;
        b=LX7L7MHcXq5jVbKqaqLfnqus5haNEKNeBPEpGCMdeL1svg0RjOC5a9qU/clLUSW6gj
         /NQOXKxouVmxUgjnPisAXLtL+GDcsk2zHHPh2DHa29PbcpLFY+goFzM6Y1bqaDnzsaUM
         FGecR5vQU6DoVPpDvo07zN77u5jJZz+c7pAl9rSrTq5NrwhTK0xhhy9itiNrVulDV2u7
         VftYkjt9+D3ppdoDDAjaTeVD2/v1/Yb5zd1YaJfYnYJA61SzC3gu8wl2xBF8EDDUjqBH
         IjeJy/AGeyu4yN8Zkwniu6fFqp3+5uhP4X9HaWac0U+taPRrftiTdF8TnjoJblPBpqNf
         9z2Q==
X-Gm-Message-State: ACrzQf0VSd6qFxwElqpuJznZRNEQyFZ66s/nZSaiGKbFPIBk/Sv3kBZ9
        bGXibpwnmZJ5CZITiYg87Q9kZsqtAG9YfA7/R4s=
X-Google-Smtp-Source: AMsMyM7Sxa9uXolZSaNYf6qnyKcfhLQsqFTuuKh9YootYfPXSve/V/uD1ICzJRJvCo7/V9ExOV5N2S/1SHsM4STSfMg=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:2ba5:63af:4077:4515])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:ea97:0:b0:354:d656:7e40 with SMTP
 id t145-20020a0dea97000000b00354d6567e40mr6017256ywe.421.1665778446291; Fri,
 14 Oct 2022 13:14:06 -0700 (PDT)
Date:   Fri, 14 Oct 2022 13:13:50 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665778433; l=3162;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=6WE50nrg4uUCeHIllAF+DlEWwXV19s8fgb2dD/cMHyI=;
 b=X+EmZHmGxUWmuu1FBspMvMc8/hsqTc1LFxbFjYnBl4K/Pm+LC0YjN/wpU3EKSbO+qqKM09KVrLf9
 WOLqxe7LBj4YAj8RIUOWNUH6s9FV/XLS9lqBzPH8q38NJnfgaAPE
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221014201354.3190007-1-ndesaulniers@google.com>
Subject: [PATCH v4 0/4] pass -march= only to compiler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both -march= and -Wa,-march= are specified for assembler or
assembler-with-cpp sources, GCC and Clang will prefer the -Wa,-march=
value but Clang will warn that -march= is unused.

warning: argument unused during compilation: '-march=armv6k'
[-Wunused-command-line-argument]

This is the top group of warnings we observe when using clang to
assemble the kernel via `ARCH=arm make LLVM=1`.

Arnd sent a v2 of my previous patch
https://lore.kernel.org/linux-arm-kernel/20210928154143.2106903-14-arnd@kernel.org/
I added yet a few more instances I found since then. Nathan pointed out
a new one too that I've fixed since v3.

Fixing this will allow us to enable
-Werror=unused-command-line-argument for clang builds.

v3 had an issue wrt. __thumb2__
https://lore.kernel.org/llvm/CAKwvOdmkd2PxvMUZA=A-72eATGDZkqDj--Bv1W+Xt_K_LWdROA@mail.gmail.com/
I've incorporated idea from Nathan and Ard on that.

Nick Desaulniers (4):
  ARM: remove lazy evaluation in Makefile
  ARM: use .arch directives instead of assembler command line flags
  ARM: only use -mtp=cp15 for the compiler
  ARM: pass -march= only to compiler

 arch/arm/Makefile                   | 78 ++++++++++++++++-------------
 arch/arm/boot/compressed/Makefile   |  1 -
 arch/arm/common/Makefile            |  2 -
 arch/arm/common/mcpm_head.S         |  2 +
 arch/arm/common/vlock.S             |  2 +
 arch/arm/kernel/Makefile            |  2 -
 arch/arm/kernel/hyp-stub.S          |  2 +
 arch/arm/kernel/swp_emulate.c       |  1 +
 arch/arm/lib/Makefile               |  4 --
 arch/arm/lib/delay-loop.S           |  4 ++
 arch/arm/mach-at91/Makefile         |  3 --
 arch/arm/mach-at91/pm_suspend.S     |  4 ++
 arch/arm/mach-imx/Makefile          |  3 --
 arch/arm/mach-imx/headsmp.S         |  2 +
 arch/arm/mach-imx/resume-imx6.S     |  2 +
 arch/arm/mach-imx/suspend-imx6.S    |  2 +
 arch/arm/mach-mvebu/Makefile        |  3 --
 arch/arm/mach-mvebu/coherency_ll.S  |  1 +
 arch/arm/mach-mvebu/pmsu.c          |  1 +
 arch/arm/mach-npcm/Makefile         |  2 -
 arch/arm/mach-npcm/headsmp.S        |  2 +
 arch/arm/mach-tegra/Makefile        |  2 -
 arch/arm/mach-tegra/reset-handler.S |  2 +
 arch/arm/mach-tegra/sleep-tegra20.S |  2 +
 arch/arm/mach-tegra/sleep-tegra30.S |  2 +
 arch/arm/mach-tegra/sleep.S         |  2 +
 arch/arm/mm/Makefile                | 15 ------
 arch/arm/mm/abort-ev6.S             |  1 +
 arch/arm/mm/abort-ev7.S             |  1 +
 arch/arm/mm/cache-v6.S              |  2 +
 arch/arm/mm/cache-v7.S              |  2 +
 arch/arm/mm/cache-v7m.S             |  2 +
 arch/arm/mm/copypage-feroceon.c     |  1 +
 arch/arm/mm/proc-v6.S               |  2 +
 arch/arm/mm/proc-v7-2level.S        |  2 +
 arch/arm/mm/proc-v7.S               |  2 +
 arch/arm/mm/tlb-v6.S                |  2 +
 arch/arm/mm/tlb-v7.S                |  2 +
 drivers/memory/Makefile             |  2 -
 drivers/memory/ti-emif-sram-pm.S    |  1 +
 drivers/soc/bcm/brcmstb/pm/Makefile |  1 -
 drivers/soc/bcm/brcmstb/pm/s2-arm.S |  1 +
 42 files changed, 97 insertions(+), 75 deletions(-)

-- 
2.38.0.413.g74048e4d9e-goog

