Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7D70ADEF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjEULtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjEUK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF598E9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 03:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808BD60E74
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 10:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5A7C433D2;
        Sun, 21 May 2023 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664297;
        bh=/6G0R4XqwX0+utiCHqMrQZrwWDY/DWn/StvBRO6Mufs=;
        h=From:To:Cc:Subject:Date:From;
        b=O9kYaJibsH+dk7Jxjy+Jz3gSW3iD9B3NOhQZEH04dm3gUtNgerpqG/TknIVMSJ1tr
         BYYVZSqhe8W7nRsN3J00PqfVbnDgKZSIvxDJRkozqfNmJbNUMyjsTmBjN4ECnfpdMd
         94AN3NWbApZlxP/zDAfJRE7EJ8lAfzdSC1CYW1a1rLg46WMKs4u8OTcr3EVePOkFM7
         WGd1lZZe57LIo3vZPqiRFT356XymjeZDAPdenY5mSdBs3+b3VmUnzVJEjZQCpgu0ag
         5DSIopPBeUwWO6fKI45VlWVZGW57iboQmseDT21SvD6NtSzVTTIxVZQywJk82lOWU+
         4cwQxF0BVXDVQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1q0g8l-00Gpq5-KX;
        Sun, 21 May 2023 11:18:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Julius Werner <jwerner@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 6.4, take #1
Date:   Sun, 21 May 2023 11:18:12 +0100
Message-Id: <20230521101812.2520740-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, dan.carpenter@linaro.org, dianders@chromium.org, jiaxun.yang@flygoat.com, jwerner@chromium.org, wangkefeng.wang@huawei.com, krzysztof.kozlowski@linaro.org, martin.blumenstingl@googlemail.com, fancer.lancer@gmail.com, linux-kernel@vger.kernel.org
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

Here's a handful of irqchip fixes for 6.4. Nothing major, the most
interesting thing being the workaround for a "creative" firmware issue
on some Mediatek-based Chromebooks, resulting in fireworks of the
pseudo-NMI feature is enabled.

Please pull,

	M.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.4-1

for you to fetch changes up to cddb536a73ef2c82ce04059dc61c65e85a355561:

  irqchip/mbigen: Unify the error handling in mbigen_of_create_domain() (2023-05-16 11:19:29 +0100)

----------------------------------------------------------------
irqchip fixes for 6.4, take #1

- MIPS GIC fixes for issues that could result in either
  loss of state in the interrupt controller, or a deadlock

- Workaround for Mediatek Chromebooks that only save/restore
  partial state when turning the GIC redistributors off,
  resulting if fireworks if Linux uses interrupt priorities
  for pseudo-NMIs

- Fix the MBIGEN error handling on init

- Mark meson-gpio OF data structures as __maybe_unused,
  avoiding compilation warnings on non-OF setups

----------------------------------------------------------------
Douglas Anderson (2):
      dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/ broken FW
      irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues

Jiaxun Yang (2):
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable
      irqchip/mips-gic: Use raw spinlock for gic_lock

Kefeng Wang (1):
      irqchip/mbigen: Unify the error handling in mbigen_of_create_domain()

Krzysztof Kozlowski (1):
      irqchip/meson-gpio: Mark OF related data as maybe unused

 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  6 ++++
 drivers/irqchip/irq-gic-common.c                   |  8 ++++--
 drivers/irqchip/irq-gic-common.h                   |  1 +
 drivers/irqchip/irq-gic-v3.c                       | 20 ++++++++++++++
 drivers/irqchip/irq-mbigen.c                       | 31 ++++++++++++---------
 drivers/irqchip/irq-meson-gpio.c                   |  2 +-
 drivers/irqchip/irq-mips-gic.c                     | 32 ++++++++++++----------
 7 files changed, 69 insertions(+), 31 deletions(-)
