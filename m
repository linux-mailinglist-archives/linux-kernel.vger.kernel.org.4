Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B3B64B6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiLMOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiLMOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A420BF9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:08:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 682F261548
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82776C433F0;
        Tue, 13 Dec 2022 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940521;
        bh=ZhS1+Jlq3PtbDqoFD6tZt00rbsFDNMR0cDrwPMM46IU=;
        h=From:To:Cc:Subject:Date:From;
        b=o5JPbh7RIfNUgRAwbMU1AkQ+gPqagF91VvU4yE+e2MCAPxBOXwA/PdyXxq2qtOycq
         svx6xe4s/pD8Dx42oAxi2Rz9GR41biHEuk7wVf5kfBwFg7M5wkaqnJyI1c96z+1f7K
         CdmKZQrlvDWqqcHonGcNqkOYmDlAnEc7X45AejsE/iMtZOyV6UfxMCYEZEkPPyNCpA
         8JKx5Eg2g1FnqyAlHC9joBIm6GRwgeMmTuGK/leaU9Ck2/FwrVG51kLZhYw9LAy+j6
         vrwdGqTV4eWB/4+sXPtEJSfLpdgZCcguFDmHj8ijGKFQcV528i2/7N+lLRW43bNP9E
         tM3ZcuUrF3RzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p55xz-00042J-9t; Tue, 13 Dec 2022 15:09:07 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] irqchip/genirq/msi: Use irq_domain_alloc_irqs()
Date:   Tue, 13 Dec 2022 15:08:42 +0100
Message-Id: <20221213140844.15470-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reworking the irqdomain locking I noticed that we had quite a few
users of the __irq_domain_alloc_irqs() interface which was initially
only intended for some legacy x86 use cases.

This first patch updates the irqchip driver so that the
irq_domain_alloc_irqs() wrapper is instead used consistently.

The second patch adds a matching irq_domain_alloc_irqs_affinity() helper
which can be used when an affinity hint needs to be provided and updates
the sole user.

With this update to gpiolib:

	https://lore.kernel.org/lkml/20221213135227.14398-1-johan+linaro@kernel.org

the only remaining users of the full interface (with preallocated
descriptors) are the two original calls in x86/io_apic and the later
added one for IPI.

Johan


Johan Hovold (2):
  irqchip: Use irq_domain_alloc_irqs()
  genirq/irqdomain/msi: Add irq_domain_alloc_irqs_affinity() wrapper

 drivers/irqchip/irq-apple-aic.c     |  5 ++---
 drivers/irqchip/irq-armada-370-xp.c |  4 ++--
 drivers/irqchip/irq-bcm2836.c       |  6 ++----
 drivers/irqchip/irq-gic-v3.c        |  5 ++---
 drivers/irqchip/irq-gic-v4.c        | 10 ++++------
 drivers/irqchip/irq-gic.c           |  5 ++---
 include/linux/irqdomain.h           | 15 +++++++++++++++
 kernel/irq/msi.c                    |  6 +++---
 8 files changed, 32 insertions(+), 24 deletions(-)

-- 
2.37.4

