Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4FA60B36D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiJXRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiJXREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096A2C653;
        Mon, 24 Oct 2022 08:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBFB7B81031;
        Mon, 24 Oct 2022 15:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43859C433D6;
        Mon, 24 Oct 2022 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625905;
        bh=BTjmI1O7Y0s3CyCTarlAy4q8fd3YY5qQOUFNKk5u7QM=;
        h=From:To:Cc:Subject:Date:From;
        b=pW9+KqGNotlAgjc2vDD76rpSNDPOBOxftgjGAaCVc77nje6eZCrR9Pl18Qv0S/3HL
         xlu+wdKiGxySQyuRvE/8Au+/zIowzwMiB6tRUbikS7AdzUXPQi+jNXW4nVAFQhzpOp
         NPXh5pHtmZOzobG00aY/TDliCe8rijkw0udEwqf/+IX8BfQZPkujtHd9mTbqxI1Kml
         wHjd6ct9gLIguIhAEtASSFArz7Tuo/zYRTWmQs1KrKfccFp3TG54BZhRvVKmMapAvb
         +e0O24sc1BJMGh0K/67Da8VL9wESagvo6FlRNNyvY6cnxqH3atQ52baNg1U//H3KNe
         7SGctLjTBTQNQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/10] ARM: omap2: assorted cleanups
Date:   Mon, 24 Oct 2022 17:38:04 +0200
Message-Id: <20221024153814.254652-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While going through the removal of board files on some other
platforms, I noticed a bit of outdated code on omap2+ that
was left behind after the platform became DT only.

I can put this into the same cleanup tree as the omap1 patches,
or you can merge these into your omap2 tree if there are likely
conflicts with other patches.

Arnd Bergmann (10):
  ARM: omap2: remove unused USB code
  ARM: omap2: remove unused headers
  ARM: omap2: remove unused omap_hwmod_reset.c
  ARM: omap2: simplify clock2xxx header
  ARM: omap2: remove APLL control
  ARM: omap2: smartreflex: remove on_init control
  ARM: omap2: remove unused functions
  ARM: omap2: remove unused declarations
  ARM: omap2: remove unused omap2_pm_init
  ARM: omap2: make functions static

 arch/arm/mach-omap2/Makefile                  |   3 +-
 arch/arm/mach-omap2/board-n8x0.c              |   2 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c       |   1 +
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c  |  14 +-
 arch/arm/mach-omap2/clock.c                   |   2 -
 arch/arm/mach-omap2/clock.h                   |   7 -
 arch/arm/mach-omap2/clock2xxx.h               |  29 --
 arch/arm/mach-omap2/clock3xxx.h               |  21 --
 arch/arm/mach-omap2/clockdomain.c             |  44 +--
 arch/arm/mach-omap2/clockdomain.h             |   4 -
 arch/arm/mach-omap2/cm2xxx.c                  | 101 +-----
 arch/arm/mach-omap2/cm2xxx.h                  |   7 -
 arch/arm/mach-omap2/cm2xxx_3xxx.h             |   5 -
 arch/arm/mach-omap2/common.h                  |  28 --
 arch/arm/mach-omap2/control.c                 |  73 ----
 arch/arm/mach-omap2/control.h                 |   5 -
 arch/arm/mach-omap2/id.c                      |   2 +-
 arch/arm/mach-omap2/id.h                      |   2 -
 arch/arm/mach-omap2/io.c                      |  21 +-
 arch/arm/mach-omap2/omap-secure.c             |   7 +-
 arch/arm/mach-omap2/omap-secure.h             |   3 -
 arch/arm/mach-omap2/omap_device.c             |  74 +----
 arch/arm/mach-omap2/omap_device.h             |  14 -
 arch/arm/mach-omap2/omap_hwmod.c              |  94 +-----
 arch/arm/mach-omap2/omap_hwmod.h              |  21 --
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |   1 -
 .../omap_hwmod_2xxx_3xxx_ipblock_data.c       |   2 +-
 .../omap_hwmod_2xxx_interconnect_data.c       |   1 -
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  12 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   1 -
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |   6 -
 arch/arm/mach-omap2/omap_hwmod_reset.c        |  98 ------
 arch/arm/mach-omap2/omap_opp_data.h           |   5 -
 arch/arm/mach-omap2/omap_phy_internal.c       |  87 -----
 arch/arm/mach-omap2/pm.c                      |   8 +-
 arch/arm/mach-omap2/pm.h                      |  25 --
 arch/arm/mach-omap2/pm24xx.c                  | 312 ------------------
 arch/arm/mach-omap2/powerdomain.c             | 108 +-----
 arch/arm/mach-omap2/powerdomain.h             |   8 -
 arch/arm/mach-omap2/prcm-common.h             |   1 -
 arch/arm/mach-omap2/prcm_mpu44xx.c            |  12 -
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h      |   2 -
 arch/arm/mach-omap2/prm.h                     |   4 -
 arch/arm/mach-omap2/prm2xxx_3xxx.h            |   3 -
 arch/arm/mach-omap2/prm3xxx.c                 |   5 +-
 arch/arm/mach-omap2/prm3xxx.h                 |   2 -
 arch/arm/mach-omap2/prm_common.c              |  55 +--
 arch/arm/mach-omap2/sdrc.c                    |  51 +--
 arch/arm/mach-omap2/sdrc.h                    |   5 -
 arch/arm/mach-omap2/serial.h                  |  66 ----
 arch/arm/mach-omap2/sr_device.c               |  13 -
 arch/arm/mach-omap2/sram.h                    |   4 -
 arch/arm/mach-omap2/usb-tusb6010.c            |   6 +-
 arch/arm/mach-omap2/usb.h                     |  71 ----
 arch/arm/mach-omap2/vc.c                      |  15 -
 arch/arm/mach-omap2/voltage.c                 |   2 +-
 arch/arm/mach-omap2/voltage.h                 |   2 -
 drivers/soc/ti/smartreflex.c                  |   4 -
 include/linux/platform_data/voltage-omap.h    |   1 -
 include/linux/power/smartreflex.h             |   3 -
 include/linux/usb/musb.h                      |   2 -
 61 files changed, 49 insertions(+), 1538 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock3xxx.h
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c
 delete mode 100644 arch/arm/mach-omap2/pm24xx.c
 delete mode 100644 arch/arm/mach-omap2/serial.h
 delete mode 100644 arch/arm/mach-omap2/usb.h

-- 
2.29.2

