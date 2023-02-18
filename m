Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFC69BA71
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBROfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBROfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:35:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3DF18170
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:34:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8972DB824B2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 14:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244FFC433D2;
        Sat, 18 Feb 2023 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676730897;
        bh=YPX28jvdpDMYExJBTxTO9Yp3osB/K1wa0lSH2VDMMe8=;
        h=From:To:Cc:Subject:Date:From;
        b=SRpWgN/zaVBOUcc6rh44sxmIyly1vMYUDBpB0+xlPql5tX3/fu375n4YAtAf2YIPN
         9bQkawEr6UKB8hTYrANyEQsNsQ5ykt7KVuF5Mso7cyb6VhmO7xtKpQ4AG9NU7LsMBO
         P6XtStFpiBdddNA81wcV8cFvBGSTvDTUtvA2k7ZJ6UKJwE6LL92KSD5W7uZZ9PfHlA
         saQHyBAIFTbAjzeQ9iHyY1Ex4K3M0ZbBOJVrqgR3APLTeuSXpGbfaLnRzBurWY5/k4
         eWDimcuJDZXlHt6UeLwhQs1RCylmw26POH87Ak2XX8A9fy/4BxXjAdjdF7LN9/8N4p
         IRr2LZn4ZdL5A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pTOIg-00BRKu-Q9;
        Sat, 18 Feb 2023 14:34:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 6.3
Date:   Sat, 18 Feb 2023 14:34:52 +0000
Message-Id: <20230218143452.3817627-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, apatel@ventanamicro.com, dtor@chromium.org, f.fainelli@gmail.com, marcan@marcan.st, hsinyi@chromium.org, chenhuacai@loongson.cn, johan+linaro@kernel.org, jonathanh@nvidia.com, lukas.bulwahn@gmail.com, mark-pk.tsai@mediatek.com, linmq006@gmail.com, philmd@linaro.org, ryan_chen@aspeedtech.com, sfr@canb.auug.org.au, mengyingkun@loongson.cn, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's a small set of irqchip and irqdomain updates. The most
interesting thing is probably the irqdomain locking rework, while the
rest is the usual set of minor updates and fixes (details in the tag).

Please pull,

	M.

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-6.3

for you to fetch changes up to a83bf176fed4ee88dad84d59f77dde153b9a442a:

  Merge branch irq/bcm-l2-fixes into irq/irqchip-next (2023-02-18 14:25:09 +0000)

----------------------------------------------------------------
irqchip updates for 6.3

- New and improved irqdomain locking, closing a number of races that
  became apparent now that we are able to probe drivers in parallel

- A bunch of OF node refcounting bugs have been fixed

- We now have a new IPI mux, lifted from the Apple AIC code and
  made common. It is expected that riscv will eventually benefit
  from it

- Two small fixes for the Broadcom L2 drivers

- Various cleanups and minor bug fixes

----------------------------------------------------------------
Anup Patel (1):
      genirq: Add mechanism to multiplex a single HW IPI

Florian Fainelli (2):
      irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts
      irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts

Huacai Chen (1):
      irqchip/loongson-liointc: Save/restore int_edge/int_pol registers during S3/S4

Johan Hovold (19):
      irqdomain: Fix association race
      irqdomain: Fix disassociation race
      irqdomain: Drop bogus fwspec-mapping error handling
      irqdomain: Look for existing mapping only once
      irqdomain: Refactor __irq_domain_alloc_irqs()
      irqdomain: Fix mapping-creation race
      irqdomain: Drop revmap mutex
      irqdomain: Drop dead domain-name assignment
      irqdomain: Drop leftover brackets
      irqdomain: Clean up irq_domain_push/pop_irq()
      x86/ioapic: Use irq_domain_create_hierarchy()
      x86/uv: Use irq_domain_create_hierarchy()
      irqchip/alpine-msi: Use irq_domain_add_hierarchy()
      irqchip/gic-v2m: Use irq_domain_create_hierarchy()
      irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
      irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
      irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
      irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
      irqdomain: Switch to per-domain locking

Lukas Bulwahn (1):
      irqchip/ls-scfg-msi: Simplify Kconfig dependencies

Marc Zyngier (8):
      irqchip/apple-aic: Move over to core ipi-mux
      genirq/ipi-mux: Use irq_domain_alloc_irqs()
      Merge branch irq/ipi-mux into irq/irqchip-next
      Merge branch irq/refcount into irq/irqchip-next
      Merge branch irq/misc-6.3 into irq/irqchip-next
      irqdomain: Fix domain registration race
      Merge branch irq/irqdomain-locking into irq/irqchip-next
      Merge branch irq/bcm-l2-fixes into irq/irqchip-next

Miaoqian Lin (4):
      irqchip: Fix refcount leak in platform_irqchip_probe
      irqchip/alpine-msi: Fix refcount leak in alpine_msix_init_domains
      irqchip/irq-mvebu-gicp: Fix refcount leak in mvebu_gicp_probe
      irqchip/ti-sci: Fix refcount leak in ti_sci_intr_irq_domain_probe

Ryan Chen (1):
      irqchip/aspeed-scu-ic: Correctly initialise status and enable registers

 arch/x86/kernel/apic/io_apic.c         |   7 +-
 arch/x86/platform/uv/uv_irq.c          |   7 +-
 drivers/irqchip/Kconfig                |   3 +-
 drivers/irqchip/irq-alpine-msi.c       |   9 +-
 drivers/irqchip/irq-apple-aic.c        | 161 +------------
 drivers/irqchip/irq-aspeed-scu-ic.c    |   5 +-
 drivers/irqchip/irq-bcm7120-l2.c       |   3 +-
 drivers/irqchip/irq-brcmstb-l2.c       |   6 +-
 drivers/irqchip/irq-gic-v2m.c          |   5 +-
 drivers/irqchip/irq-gic-v3-its.c       |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c       |   5 +-
 drivers/irqchip/irq-loongson-liointc.c |  13 ++
 drivers/irqchip/irq-loongson-pch-msi.c |   9 +-
 drivers/irqchip/irq-mvebu-gicp.c       |   1 +
 drivers/irqchip/irq-mvebu-odmi.c       |  13 +-
 drivers/irqchip/irq-ti-sci-intr.c      |   1 +
 drivers/irqchip/irqchip.c              |   8 +-
 include/linux/irq.h                    |   3 +
 include/linux/irqdomain.h              |   6 +-
 kernel/irq/Kconfig                     |   5 +
 kernel/irq/Makefile                    |   1 +
 kernel/irq/ipi-mux.c                   | 206 +++++++++++++++++
 kernel/irq/irqdomain.c                 | 408 ++++++++++++++++++++-------------
 23 files changed, 537 insertions(+), 361 deletions(-)
 create mode 100644 kernel/irq/ipi-mux.c
