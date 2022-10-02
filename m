Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A115F233E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJBM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJBM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECB39B8C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 05:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7344460DFC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 12:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CC8C433D6;
        Sun,  2 Oct 2022 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664715359;
        bh=+/ybN/q4QXSiKxPv/Q+F/K5FhbvuD82/yXUxtmf5JeI=;
        h=From:To:Cc:Subject:Date:From;
        b=JG6kgaLMlMkJfBjCfbiYwl1mWueZkjFXh+aCKcby2p3GlGA55YGkUJXnfWl5TK4V1
         t9hyaQJ+kZsvK+qz5JmXK36NPqJ5ZMNTsoLe9N08l8HDht6Q36bVN28EuB0YwCOmfk
         QWKjoxD1Oi3u4gJABLiduewMihKaT47WxMC6M9msjGI0+INZrz7yMUaTgWzIieqCsW
         snAyhavpuMPXKkotey/8uz7XrEYHQDdFiXt60JHk1/ZiXU8ooIoJHMbUMVGubfR0Kk
         LqxjfQGOZXWLRIAf0cLbt6FxPtlgtRzyDuuRsejtvoMKe6p79ONjXtYKAPf5fQC/kK
         SKxRfF70phdGA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oeyVh-00E9TC-Hr;
        Sun, 02 Oct 2022 13:55:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Apurva Nandan <a-nandan@ti.com>, Frank Li <Frank.Li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Rob Herring <robh@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 6.1
Date:   Sun,  2 Oct 2022 13:55:54 +0100
Message-Id: <20221002125554.3902840-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, a-nandan@ti.com, Frank.Li@nxp.com, geert+renesas@glider.be, chenhuacai@loongson.cn, robh@kernel.org, sander@svanheule.net, yangtiezhu@loongson.cn, daizhiyuan@phytium.com.cn, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of irqchip updates for 6.1. The good news is that it
probably is the smallest in a long while, and nobody is going
to complain about that!

The only thing of interest is the FSL MU driver that can provide
platform MSI support when the SoC is used as a an endpoint.
The rest is a boring set of updates (DT churn, driver rework as
a consequence of DT churn, and spelling fixes...)

Please pull,

	M.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-6.1

for you to fetch changes up to 732d69c80cb04a587d9ec2935bcb63989e66eb92:

  Merge branch irq/misc-6.1 into irq/irqchip-next (2022-09-29 17:21:16 +0100)

----------------------------------------------------------------
irqchip updates for 6.1

- A new driver for the FSL MU widget that provides platform MSI

- An update for the Realtek RTL irqchip to use a DT binding that
  actually describes the hardware

- A handful of DT updates, as well as minor code and spelling fixes

----------------------------------------------------------------
Apurva Nandan (2):
      dt-bindings: irqchip: ti,sci-inta: Fix warning for missing #interrupt-cells
      dt-bindings: interrupt-controller: ti,sci-intr: Fix missing reg property in the binding

Frank Li (4):
      platform-msi: Export symbol platform_msi_create_irq_domain()
      irqchip: Allow extra fields to be passed to IRQCHIP_PLATFORM_DRIVER_END
      irqchip: Add IMX MU MSI controller driver
      dt-bindings: irqchip: Describe the IMX MU block as a MSI controller

Geert Uytterhoeven (1):
      dt-bindings: irqchip: renesas,irqc: Add r8a779g0 support

Huacai Chen (1):
      irqchip: Make irqchip_init() usable on pure ACPI systems

Marc Zyngier (3):
      Merge branch irq/fsl-mu-msi into irq/irqchip-next
      Merge branch irq/rtl-imap-deprecation into irq/irqchip-next
      Merge branch irq/misc-6.1 into irq/irqchip-next

Sander Vanheule (3):
      irqchip/realtek-rtl: use irq_domain_add_linear()
      dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
      irqchip/realtek-rtl: use parent interrupts

Zhiyuan Dai (1):
      irqchip/gic-v3: Fix typo in comment

 .../bindings/interrupt-controller/fsl,mu-msi.yaml  |  99 +++++
 .../interrupt-controller/realtek,rtl-intc.yaml     |  60 ++-
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   3 +
 .../bindings/interrupt-controller/ti,sci-intr.yaml |   3 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/irqchip/Kconfig                            |  16 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-imx-mu-msi.c                   | 453 +++++++++++++++++++++
 drivers/irqchip/irq-realtek-rtl.c                  | 134 +++---
 include/linux/irqchip.h                            |   4 +-
 include/linux/of_irq.h                             |   6 +-
 13 files changed, 690 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
 create mode 100644 drivers/irqchip/irq-imx-mu-msi.c
