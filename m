Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4373C43F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFWWoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjFWWo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B12736
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D7B61182
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4DBC433C8;
        Fri, 23 Jun 2023 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687560265;
        bh=XqCOUoRP2aujdv2QSKSNLE56ERnjK0/6sbB8vLn8vhE=;
        h=From:To:Cc:Subject:Date:From;
        b=hvpg9c0Rc9J8KG7A4AlnG/gGbcwiDSvBt6Yif/Jsf6RORLzp/B679FIo0BYJgSb89
         s3kfpNAxWdkLPv4z8FEncU/qFFwt/u/GxTVQ0k3hn5JKazAzPTruN23uKI9l/9mGpe
         JhA72kS+WaUR7+IzYQEdyUgPduDd6xNZiu9JuRc7MoVKAOLSgpzOgfayzhnPCRepsZ
         CdmWDbp14eqTXc92boMXtISMsqdQsISIS6R9j3Htb8wMGKP8AJazf3Co3U33QgT/Ig
         DpFBFnCnPOY21EHlADzEfGFYaiOOe+/WYkPwvOFG51KIKOWZtB9On9r66E5HS86Bzm
         QWuItuzn+jy+A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qCpVv-007sPl-2i;
        Fri, 23 Jun 2023 23:44:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Chong Qiao <qiaochong@loongson.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        James Gowans <jgowans@amazon.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Liao Chang <liaochang1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>,
        liuyun <liuyun@loongson.cn>, Marek Vasut <marex@denx.de>,
        Rob Herring <robh@kernel.org>, Rob Landley <rob@landley.net>,
        Shawn Guo <shawnguo@kernel.org>,
        yangqiming <yangqiming@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>,
        zhengyan <zhengyan@asrmicro.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 6.5
Date:   Fri, 23 Jun 2023 23:43:45 +0100
Message-Id: <20230623224345.3577134-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, antonio.borneo@foss.st.com, arnd@arndb.de, zhoubinbin@loongson.cn, qiaochong@loongson.cn, guohanjun@huawei.com, chenhuacai@kernel.org, chenhuacai@loongson.cn, jgowans@amazon.com, lvjianmin@loongson.cn, glaubitz@physik.fu-berlin.de, karahmed@amazon.com, liaochang1@huawei.com, linus.walleij@linaro.org, liupeibao@loongson.cn, liuyun@loongson.cn, marex@denx.de, robh@kernel.org, rob@landley.net, shawnguo@kernel.org, yangqiming@loongson.cn, zhuyinbo@loongson.cn, zouyipeng@huawei.com, chris.zjh@huawei.com, zhengyan@asrmicro.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's the set of irqchip patches for 6.5. The only notable bit
is the workaround for the GICv3 LPIs lacking an active state
and having to be retriggered when firing concurrently on multiple
CPUs. The rest is pretty benign, with mostly a bunch of Loongson
fixes, errata workarounds, and various cleanups.

Please pull,

        M.

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-6.5

for you to fetch changes up to a82f3119d543406ed5b242deabf83cdecb9fe523:

  Merge branch irq/misc-6.5 into irq/irqchip-next (2023-06-21 13:53:41 +0100)

----------------------------------------------------------------
irqchip updates for 6.5

- A number of Loogson/Loogarch fixes

- Allow the core code to retrigger an interrupt that has
  fired while the same interrupt is being handled on another
  CPU, papering over a GICv3 architecture issue

- Work around an integration problem on ASR8601, where the CPU
  numbering isn't representable in the GIC implementation...

- Add some missing interrupt to the STM32 irqchip

- A bunch of warning squashing triggered by W=1 builds

----------------------------------------------------------------
Antonio Borneo (1):
      irqchip/stm32-exti: Fix warning on initialized field overwritten

Arnd Bergmann (6):
      irqdomain: Include internals.h for function prototypes
      irqchip/ftintc010: Mark all function static
      irqchip/mmp: Remove non-DT codepath
      irqchip/clps711x: Remove unused clps711x_intc_init() function
      irqchip/mxs: Include linux/irqchip/mxs.h
      irqchip/gicv3: Add a iort_pmsi_get_dev_id() prototype

Binbin Zhou (2):
      dt-bindings: interrupt-controller: Add Loongson EIOINTC
      irqchip/loongson-eiointc: Add DT init support

James Gowans (3):
      genirq: Expand doc for PENDING and REPLAY flags
      genirq: Allow fasteoi handler to resend interrupts on concurrent handling
      irqchip/gic-v3-its: Enable RESEND_WHEN_IN_PROGRESS for LPIs

Jianmin Lv (3):
      irqchip/loongson-pch-pic: Fix initialization of HT vector register
      irqchip/loongson-liointc: Fix IRQ trigger polarity
      irqchip/loongson-eiointc: Fix irq affinity setting during resume

John Paul Adrian Glaubitz (1):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

Liu Peibao (1):
      irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Marc Zyngier (7):
      irqchip/gic-v3: Improve affinity helper
      Merge branch irq/gic-v3-asr8601 into irq/irqchip-next
      genirq: Use BIT() for the IRQD_* state flags
      Merge branch irq/lpi-resend into irq/irqchip-next
      Merge branch irq/loongarch-fixes-6.5 into irq/irqchip-next
      Revert "irqchip/mxs: Include linux/irqchip/mxs.h"
      Merge branch irq/misc-6.5 into irq/irqchip-next

Marek Vasut (1):
      irqchip/stm32-exti: Add STM32MP15xx IWDG2 EXTI to GIC map

Yinbo Zhu (1):
      irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag

zhengyan (1):
      irqchip/gic-v3: Work around affinity issues on ASR8601

 Documentation/arm64/silicon-errata.rst             |   4 +
 .../interrupt-controller/loongson,eiointc.yaml     |  59 +++++++++
 drivers/irqchip/irq-clps711x.c                     |   7 --
 drivers/irqchip/irq-ftintc010.c                    |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +
 drivers/irqchip/irq-gic-v3.c                       |  45 +++++--
 drivers/irqchip/irq-jcore-aic.c                    |   7 ++
 drivers/irqchip/irq-loongson-eiointc.c             | 135 +++++++++++++++------
 drivers/irqchip/irq-loongson-liointc.c             |  13 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  10 +-
 drivers/irqchip/irq-mmp.c                          | 127 -------------------
 drivers/irqchip/irq-stm32-exti.c                   |  13 ++
 include/linux/acpi_iort.h                          |   3 +-
 include/linux/irq.h                                |  59 +++++----
 include/linux/irqchip/mmp.h                        |  10 --
 kernel/irq/chip.c                                  |  16 ++-
 kernel/irq/debugfs.c                               |   2 +
 kernel/irq/internals.h                             |   7 +-
 kernel/irq/irqdomain.c                             |   2 +
 19 files changed, 296 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
 delete mode 100644 include/linux/irqchip/mmp.h
