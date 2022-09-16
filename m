Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695665BA8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiIPIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiIPIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:52:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABDA9274
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF820B8247F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3F1C4347C;
        Fri, 16 Sep 2022 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663318333;
        bh=ORLPPUm7jIn9UYwzTmcaba0vRBvlY+HfDx9nbA/WNDM=;
        h=From:To:Cc:Subject:Date:From;
        b=NuUpZPc9CGfYCBUXG6Gx+Txjv7/oe2sYhpERMldiqz9g+j/To/0Ts11n4wQycLsqf
         f5GHIkdiyCDnl0/J72xZ+GSB6wcPz4bNI7ld7kO15bUC5AMKQnGQfcFB065YU1gpV3
         64tlV9nopEN5n16lB1QwOEVcrJCGJQWHwG8hSx06xETJH+QC2z+u2HJUmnnNRxvVlH
         zTDA1JWBI8WsUUuXoYT26xg/wtVAvSWIw3FzO7XaYrZcREvBkdGIdK+8z8XtbSIIu4
         L3bDAOv9oU/RAZU/58lkd+SZaZZFIBtHKM5N7MVfLDgXUXxJET5JA0q27dc49Kxj2K
         xL5JCjbP2adqA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oZ751-00AZmg-81;
        Fri, 16 Sep 2022 09:52:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 6.0, take #2
Date:   Fri, 16 Sep 2022 09:51:58 +0100
Message-Id: <20220916085158.2592518-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, antonio.borneo@foss.st.com, dan.carpenter@oracle.com, chenhuacai@loongson.cn, lvjianmin@loongson.cn, pierre.gondois@arm.com, linux-kernel@vger.kernel.org
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

Here's a small crop of simple fixes for 6.0, two of them mopping up
the merge of the Loongarch drivers. The rest is a fix for an ITS splat,
and another one to keep the 0-day robot happy.

I expect this is the last set of fixes before 6.1 opens (fingers crossed).

Please pull,

        M.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.0-2

for you to fetch changes up to e7ccba7728cff0e0f1299951571f209fcadcb7b1:

  irqchip/loongson-pch-lpc: Add dependence on LoongArch (2022-09-16 09:25:51 +0100)

----------------------------------------------------------------
irqchip fixes for 6.0, take #2

- A couple of configuration fixes for the recently merged Loongarch drivers

- A fix to avoid dynamic allocation of a cpumask which was causing issues
  with PREEMPT_RT and the GICv3 ITS

- A tightening of an error check in the stm32 exti driver

----------------------------------------------------------------
Antonio Borneo (1):
      irqchip/stm32-exti: Remove check on always false condition

Huacai Chen (1):
      irqchip: Select downstream irqchip drivers for LoongArch CPU

Jianmin Lv (1):
      irqchip/loongson-pch-lpc: Add dependence on LoongArch

Pierre Gondois (1):
      irqchip/gic-v3-its: Remove cpumask_var_t allocation

 drivers/irqchip/Kconfig          |  8 +++++++-
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++------
 drivers/irqchip/irq-stm32-exti.c |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)
