Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5732265EDA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAENrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAENqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:46:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862EB392DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E3FB81AD0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C90C433EF;
        Thu,  5 Jan 2023 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926406;
        bh=QW95drhjEd2B7cLTxK2XfcE251o5ge5KKlLQKFVGxDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCQrJtEe4v3sXLjiU0mo0kDQgGCWYeHNJ8xP3wS27irk6KDHLy0rtO/4bFdG+Nraw
         +uc1JsdrLOZIGbQ/fJGTvrvdoj6RDi5KpkPDbt/vvrcZNnSsKf9AQ56jCtifTSkfKf
         sg2R2vSxI8t8vBZD5baHkEQI97wXhDhu/vlqbWB1uzhJp8CaVFPqjJJ46+0FN4Ghm3
         fMn7Gqk0eaNS3XZ9u9Z2xIazFpyaXxYP8RGmjLCoZBL4gyW89jYkYFIa/u9jXaA/ml
         5nQkRepNzzvYNkwiYHg3FdMkk4xxm+ex8sEoFHY/0oPdB9/raQogpPrUx2cZArYCUh
         0Q2ajYYeQ/sHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ales Bardorfer <ales@i-tech.si>,
        Ales Snuparek <snuparek@atlas.cz>,
        Alex Osborne <ato@meshy.org>,
        Alex Osborne <bobofdoom@gmail.com>,
        Dirk Opfer <dirk@opfer-online.de>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Ian Molton <spyro@f2s.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Petchkovsky <mkpetch@internode.on.net>,
        Nick Bane <nick@cecomputing.co.uk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Sergey Lapin <slapin@ossfans.org>,
        Tomas Cech <sleep_walker@suse.cz>
Subject: [PATCH 01/27] ARM: pxa: remove unused board files
Date:   Thu,  5 Jan 2023 14:45:56 +0100
Message-Id: <20230105134622.254560-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The majority of all pxa board files has not been touched in a long time,
and no users have spoken up in favor of keeping them around. This leaves
only support for the platforms that were already converted to DT, as
well as the gumstix and spitz/akita/borzoi machines that work in qemu
and can still be converted to DT later.

Cc: Ales Bardorfer <ales@i-tech.si>
Cc: Ales Snuparek <snuparek@atlas.cz>
Cc: Alex Osborne <ato@meshy.org>
Cc: Alex Osborne <bobofdoom@gmail.com>
Cc: Dirk Opfer <dirk@opfer-online.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Ian Molton <spyro@f2s.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Michael Petchkovsky <mkpetch@internode.on.net>
Cc: Nick Bane <nick@cecomputing.co.uk>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Sergey Lapin <slapin@ossfans.org>
Cc: Tomas Cech <sleep_walker@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                  |   99 --
 arch/arm/configs/cm_x300_defconfig           |  163 ---
 arch/arm/configs/colibri_pxa270_defconfig    |  157 ---
 arch/arm/configs/colibri_pxa300_defconfig    |   60 -
 arch/arm/configs/corgi_defconfig             |  247 ----
 arch/arm/configs/eseries_pxa_defconfig       |   97 --
 arch/arm/configs/ezx_defconfig               |  389 ------
 arch/arm/configs/h5000_defconfig             |   74 --
 arch/arm/configs/lpd270_defconfig            |   58 -
 arch/arm/configs/lubbock_defconfig           |   53 -
 arch/arm/configs/magician_defconfig          |  151 ---
 arch/arm/configs/mainstone_defconfig         |   51 -
 arch/arm/configs/palmz72_defconfig           |   75 --
 arch/arm/configs/pcm027_defconfig            |   90 --
 arch/arm/configs/pxa255-idp_defconfig        |   55 -
 arch/arm/configs/pxa_defconfig               |    3 -
 arch/arm/configs/trizeps4_defconfig          |  207 ---
 arch/arm/configs/viper_defconfig             |  160 ---
 arch/arm/configs/xcep_defconfig              |   90 --
 arch/arm/configs/zeus_defconfig              |  173 ---
 arch/arm/mach-pxa/Kconfig                    |  583 +-------
 arch/arm/mach-pxa/Makefile                   |   58 -
 arch/arm/mach-pxa/balloon3-pcmcia.c          |  137 --
 arch/arm/mach-pxa/balloon3.c                 |  821 ------------
 arch/arm/mach-pxa/balloon3.h                 |  181 ---
 arch/arm/mach-pxa/capc7117.c                 |  159 ---
 arch/arm/mach-pxa/cm-x300.c                  |  883 ------------
 arch/arm/mach-pxa/colibri-evalboard.c        |  138 --
 arch/arm/mach-pxa/colibri-pcmcia.c           |  165 ---
 arch/arm/mach-pxa/colibri-pxa270-income.c    |  236 ----
 arch/arm/mach-pxa/colibri-pxa270.c           |  330 -----
 arch/arm/mach-pxa/colibri-pxa300.c           |  193 ---
 arch/arm/mach-pxa/colibri-pxa320.c           |  264 ----
 arch/arm/mach-pxa/colibri-pxa3xx.c           |  147 --
 arch/arm/mach-pxa/colibri.h                  |   70 -
 arch/arm/mach-pxa/corgi.c                    |  826 ------------
 arch/arm/mach-pxa/corgi.h                    |  110 --
 arch/arm/mach-pxa/corgi_pm.c                 |  221 ---
 arch/arm/mach-pxa/csb701.c                   |   67 -
 arch/arm/mach-pxa/csb726.c                   |  291 ----
 arch/arm/mach-pxa/csb726.h                   |   24 -
 arch/arm/mach-pxa/e740-pcmcia.c              |  127 --
 arch/arm/mach-pxa/eseries-gpio.h             |   63 -
 arch/arm/mach-pxa/eseries-irq.h              |   24 -
 arch/arm/mach-pxa/eseries.c                  | 1001 --------------
 arch/arm/mach-pxa/ezx.c                      | 1254 ------------------
 arch/arm/mach-pxa/h5000.c                    |  210 ---
 arch/arm/mach-pxa/h5000.h                    |  109 --
 arch/arm/mach-pxa/himalaya.c                 |  166 ---
 arch/arm/mach-pxa/hx4700-pcmcia.c            |  118 --
 arch/arm/mach-pxa/hx4700.c                   |  942 -------------
 arch/arm/mach-pxa/hx4700.h                   |  129 --
 arch/arm/mach-pxa/icontrol.c                 |  218 ---
 arch/arm/mach-pxa/idp.c                      |  285 ----
 arch/arm/mach-pxa/idp.h                      |  195 ---
 arch/arm/mach-pxa/littleton.c                |  462 -------
 arch/arm/mach-pxa/littleton.h                |   14 -
 arch/arm/mach-pxa/lpd270.c                   |  518 --------
 arch/arm/mach-pxa/lpd270.h                   |   40 -
 arch/arm/mach-pxa/lubbock.c                  |  649 ---------
 arch/arm/mach-pxa/lubbock.h                  |   47 -
 arch/arm/mach-pxa/magician.c                 | 1112 ----------------
 arch/arm/mach-pxa/magician.h                 |  125 --
 arch/arm/mach-pxa/mainstone.c                |  738 -----------
 arch/arm/mach-pxa/mainstone.h                |  140 --
 arch/arm/mach-pxa/mfp-pxa320.h               |  458 -------
 arch/arm/mach-pxa/mioa701.c                  |  784 -----------
 arch/arm/mach-pxa/mioa701.h                  |   76 --
 arch/arm/mach-pxa/mioa701_bootresume.S       |   38 -
 arch/arm/mach-pxa/mp900.c                    |  101 --
 arch/arm/mach-pxa/mxm8x10.c                  |  477 -------
 arch/arm/mach-pxa/mxm8x10.h                  |   22 -
 arch/arm/mach-pxa/palm27x.c                  |  473 -------
 arch/arm/mach-pxa/palm27x.h                  |   77 --
 arch/arm/mach-pxa/palmld-pcmcia.c            |  111 --
 arch/arm/mach-pxa/palmld.c                   |  392 ------
 arch/arm/mach-pxa/palmld.h                   |  107 --
 arch/arm/mach-pxa/palmt5.c                   |  234 ----
 arch/arm/mach-pxa/palmt5.h                   |   82 --
 arch/arm/mach-pxa/palmtc-pcmcia.c            |  162 ---
 arch/arm/mach-pxa/palmtc.c                   |  539 --------
 arch/arm/mach-pxa/palmtc.h                   |   84 --
 arch/arm/mach-pxa/palmte2.c                  |  383 ------
 arch/arm/mach-pxa/palmte2.h                  |   64 -
 arch/arm/mach-pxa/palmtreo.c                 |  548 --------
 arch/arm/mach-pxa/palmtreo.h                 |   64 -
 arch/arm/mach-pxa/palmtx-pcmcia.c            |  111 --
 arch/arm/mach-pxa/palmtx.c                   |  390 ------
 arch/arm/mach-pxa/palmtx.h                   |  110 --
 arch/arm/mach-pxa/palmz72.c                  |  319 -----
 arch/arm/mach-pxa/palmz72.h                  |   80 --
 arch/arm/mach-pxa/pcm027.c                   |  266 ----
 arch/arm/mach-pxa/pcm027.h                   |   73 -
 arch/arm/mach-pxa/pcm990-baseboard.c         |  408 ------
 arch/arm/mach-pxa/pcm990_baseboard.h         |  199 ---
 arch/arm/mach-pxa/poodle.c                   |  484 -------
 arch/arm/mach-pxa/poodle.h                   |   92 --
 arch/arm/mach-pxa/pxa320.c                   |   88 --
 arch/arm/mach-pxa/pxa320.h                   |    9 -
 arch/arm/mach-pxa/pxa930.c                   |  217 ---
 arch/arm/mach-pxa/pxa930.h                   |    8 -
 arch/arm/mach-pxa/pxa_cplds_irqs.c           |  200 ---
 arch/arm/mach-pxa/regs-uart.h                |  146 --
 arch/arm/mach-pxa/saar.c                     |  604 ---------
 arch/arm/mach-pxa/sharpsl_pm.c               |    4 -
 arch/arm/mach-pxa/tavorevb.c                 |  506 -------
 arch/arm/mach-pxa/tosa-bt.c                  |  134 --
 arch/arm/mach-pxa/tosa.c                     |  946 -------------
 arch/arm/mach-pxa/tosa.h                     |  165 ---
 arch/arm/mach-pxa/tosa_bt.h                  |   18 -
 arch/arm/mach-pxa/trizeps4-pcmcia.c          |  200 ---
 arch/arm/mach-pxa/trizeps4.c                 |  575 --------
 arch/arm/mach-pxa/trizeps4.h                 |  166 ---
 arch/arm/mach-pxa/viper-pcmcia.c             |  180 ---
 arch/arm/mach-pxa/viper-pcmcia.h             |   12 -
 arch/arm/mach-pxa/viper.c                    | 1034 ---------------
 arch/arm/mach-pxa/viper.h                    |   91 --
 arch/arm/mach-pxa/vpac270-pcmcia.c           |  137 --
 arch/arm/mach-pxa/vpac270.c                  |  736 ----------
 arch/arm/mach-pxa/vpac270.h                  |   38 -
 arch/arm/mach-pxa/xcep.c                     |  190 ---
 arch/arm/mach-pxa/z2.c                       |  781 -----------
 arch/arm/mach-pxa/z2.h                       |   37 -
 arch/arm/mach-pxa/zeus.c                     |  974 --------------
 arch/arm/mach-pxa/zeus.h                     |   82 --
 arch/arm/mach-pxa/zylonite.c                 |  495 -------
 arch/arm/mach-pxa/zylonite.h                 |   45 -
 arch/arm/mach-pxa/zylonite_pxa300.c          |  281 ----
 arch/arm/mach-pxa/zylonite_pxa320.c          |  213 ---
 drivers/input/touchscreen/mainstone-wm97xx.c |   10 -
 drivers/pcmcia/pxa2xx_base.c                 |    8 +-
 drivers/pcmcia/sa1111_generic.c              |    4 -
 drivers/power/supply/ds2760_battery.c        |    8 -
 drivers/usb/gadget/udc/pxa25x_udc.c          |   62 -
 drivers/video/backlight/locomolcd.c          |   10 -
 135 files changed, 2 insertions(+), 34262 deletions(-)
 delete mode 100644 arch/arm/configs/cm_x300_defconfig
 delete mode 100644 arch/arm/configs/colibri_pxa270_defconfig
 delete mode 100644 arch/arm/configs/colibri_pxa300_defconfig
 delete mode 100644 arch/arm/configs/corgi_defconfig
 delete mode 100644 arch/arm/configs/eseries_pxa_defconfig
 delete mode 100644 arch/arm/configs/ezx_defconfig
 delete mode 100644 arch/arm/configs/h5000_defconfig
 delete mode 100644 arch/arm/configs/lpd270_defconfig
 delete mode 100644 arch/arm/configs/lubbock_defconfig
 delete mode 100644 arch/arm/configs/magician_defconfig
 delete mode 100644 arch/arm/configs/mainstone_defconfig
 delete mode 100644 arch/arm/configs/palmz72_defconfig
 delete mode 100644 arch/arm/configs/pcm027_defconfig
 delete mode 100644 arch/arm/configs/pxa255-idp_defconfig
 delete mode 100644 arch/arm/configs/trizeps4_defconfig
 delete mode 100644 arch/arm/configs/viper_defconfig
 delete mode 100644 arch/arm/configs/xcep_defconfig
 delete mode 100644 arch/arm/configs/zeus_defconfig
 delete mode 100644 arch/arm/mach-pxa/balloon3-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/balloon3.c
 delete mode 100644 arch/arm/mach-pxa/balloon3.h
 delete mode 100644 arch/arm/mach-pxa/capc7117.c
 delete mode 100644 arch/arm/mach-pxa/cm-x300.c
 delete mode 100644 arch/arm/mach-pxa/colibri-evalboard.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa270-income.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa270.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa300.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa320.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/colibri.h
 delete mode 100644 arch/arm/mach-pxa/corgi.c
 delete mode 100644 arch/arm/mach-pxa/corgi.h
 delete mode 100644 arch/arm/mach-pxa/corgi_pm.c
 delete mode 100644 arch/arm/mach-pxa/csb701.c
 delete mode 100644 arch/arm/mach-pxa/csb726.c
 delete mode 100644 arch/arm/mach-pxa/csb726.h
 delete mode 100644 arch/arm/mach-pxa/e740-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/eseries-gpio.h
 delete mode 100644 arch/arm/mach-pxa/eseries-irq.h
 delete mode 100644 arch/arm/mach-pxa/eseries.c
 delete mode 100644 arch/arm/mach-pxa/ezx.c
 delete mode 100644 arch/arm/mach-pxa/h5000.c
 delete mode 100644 arch/arm/mach-pxa/h5000.h
 delete mode 100644 arch/arm/mach-pxa/himalaya.c
 delete mode 100644 arch/arm/mach-pxa/hx4700-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/hx4700.c
 delete mode 100644 arch/arm/mach-pxa/hx4700.h
 delete mode 100644 arch/arm/mach-pxa/icontrol.c
 delete mode 100644 arch/arm/mach-pxa/idp.c
 delete mode 100644 arch/arm/mach-pxa/idp.h
 delete mode 100644 arch/arm/mach-pxa/littleton.c
 delete mode 100644 arch/arm/mach-pxa/littleton.h
 delete mode 100644 arch/arm/mach-pxa/lpd270.c
 delete mode 100644 arch/arm/mach-pxa/lpd270.h
 delete mode 100644 arch/arm/mach-pxa/lubbock.c
 delete mode 100644 arch/arm/mach-pxa/lubbock.h
 delete mode 100644 arch/arm/mach-pxa/magician.c
 delete mode 100644 arch/arm/mach-pxa/magician.h
 delete mode 100644 arch/arm/mach-pxa/mainstone.c
 delete mode 100644 arch/arm/mach-pxa/mainstone.h
 delete mode 100644 arch/arm/mach-pxa/mfp-pxa320.h
 delete mode 100644 arch/arm/mach-pxa/mioa701.c
 delete mode 100644 arch/arm/mach-pxa/mioa701.h
 delete mode 100644 arch/arm/mach-pxa/mioa701_bootresume.S
 delete mode 100644 arch/arm/mach-pxa/mp900.c
 delete mode 100644 arch/arm/mach-pxa/mxm8x10.c
 delete mode 100644 arch/arm/mach-pxa/mxm8x10.h
 delete mode 100644 arch/arm/mach-pxa/palm27x.c
 delete mode 100644 arch/arm/mach-pxa/palm27x.h
 delete mode 100644 arch/arm/mach-pxa/palmld-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/palmld.c
 delete mode 100644 arch/arm/mach-pxa/palmld.h
 delete mode 100644 arch/arm/mach-pxa/palmt5.c
 delete mode 100644 arch/arm/mach-pxa/palmt5.h
 delete mode 100644 arch/arm/mach-pxa/palmtc-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/palmtc.c
 delete mode 100644 arch/arm/mach-pxa/palmtc.h
 delete mode 100644 arch/arm/mach-pxa/palmte2.c
 delete mode 100644 arch/arm/mach-pxa/palmte2.h
 delete mode 100644 arch/arm/mach-pxa/palmtreo.c
 delete mode 100644 arch/arm/mach-pxa/palmtreo.h
 delete mode 100644 arch/arm/mach-pxa/palmtx-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/palmtx.c
 delete mode 100644 arch/arm/mach-pxa/palmtx.h
 delete mode 100644 arch/arm/mach-pxa/palmz72.c
 delete mode 100644 arch/arm/mach-pxa/palmz72.h
 delete mode 100644 arch/arm/mach-pxa/pcm027.c
 delete mode 100644 arch/arm/mach-pxa/pcm027.h
 delete mode 100644 arch/arm/mach-pxa/pcm990-baseboard.c
 delete mode 100644 arch/arm/mach-pxa/pcm990_baseboard.h
 delete mode 100644 arch/arm/mach-pxa/poodle.c
 delete mode 100644 arch/arm/mach-pxa/poodle.h
 delete mode 100644 arch/arm/mach-pxa/pxa320.c
 delete mode 100644 arch/arm/mach-pxa/pxa320.h
 delete mode 100644 arch/arm/mach-pxa/pxa930.c
 delete mode 100644 arch/arm/mach-pxa/pxa930.h
 delete mode 100644 arch/arm/mach-pxa/pxa_cplds_irqs.c
 delete mode 100644 arch/arm/mach-pxa/regs-uart.h
 delete mode 100644 arch/arm/mach-pxa/saar.c
 delete mode 100644 arch/arm/mach-pxa/tavorevb.c
 delete mode 100644 arch/arm/mach-pxa/tosa-bt.c
 delete mode 100644 arch/arm/mach-pxa/tosa.c
 delete mode 100644 arch/arm/mach-pxa/tosa.h
 delete mode 100644 arch/arm/mach-pxa/tosa_bt.h
 delete mode 100644 arch/arm/mach-pxa/trizeps4-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/trizeps4.c
 delete mode 100644 arch/arm/mach-pxa/trizeps4.h
 delete mode 100644 arch/arm/mach-pxa/viper-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/viper-pcmcia.h
 delete mode 100644 arch/arm/mach-pxa/viper.c
 delete mode 100644 arch/arm/mach-pxa/viper.h
 delete mode 100644 arch/arm/mach-pxa/vpac270-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/vpac270.c
 delete mode 100644 arch/arm/mach-pxa/vpac270.h
 delete mode 100644 arch/arm/mach-pxa/xcep.c
 delete mode 100644 arch/arm/mach-pxa/z2.c
 delete mode 100644 arch/arm/mach-pxa/z2.h
 delete mode 100644 arch/arm/mach-pxa/zeus.c
 delete mode 100644 arch/arm/mach-pxa/zeus.h
 delete mode 100644 arch/arm/mach-pxa/zylonite.c
 delete mode 100644 arch/arm/mach-pxa/zylonite.h
 delete mode 100644 arch/arm/mach-pxa/zylonite_pxa300.c
 delete mode 100644 arch/arm/mach-pxa/zylonite_pxa320.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cc5017a3d90d..abdab4212c92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2114,10 +2114,6 @@ F:	tools/perf/arch/arm/util/pmu.c
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
-ARM/CORGI MACHINE SUPPORT
-M:	Richard Purdie <rpurdie@rpsys.net>
-S:	Maintained
-
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linus.walleij@linaro.org>
@@ -2157,12 +2153,6 @@ F:	include/dt-bindings/bus/moxtet.h
 F:	include/linux/armada-37xx-rwtm-mailbox.h
 F:	include/linux/moxtet.h
 
-ARM/EZX SMARTPHONES (A780, A910, A1200, E680, ROKR E2 and ROKR E6)
-M:	Robert Jarzmik <robert.jarzmik@free.fr>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-pxa/ezx.c
-
 ARM/FARADAY FA526 PORT
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2212,25 +2202,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
 F:	arch/arm/boot/dts/vf*
 F:	arch/arm/mach-imx/*vf610*
 
-ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/GUMSTIX MACHINE SUPPORT
 M:	Steve Sakoman <sakoman@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
-ARM/H4700 (HP IPAQ HX4700) MACHINE SUPPORT
-M:	Philipp Zabel <philipp.zabel@gmail.com>
-M:	Paul Parsons <lost.distance@yahoo.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-pxa/hx4700.c
-F:	arch/arm/mach-pxa/include/mach/hx4700.h
-F:	sound/soc/pxa/hx4700.c
-
 ARM/HISILICON SOC SUPPORT
 M:	Wei Xu <xuwei5@hisilicon.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2273,12 +2249,6 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/omap3-igep*
 
-ARM/INCOME PXA270 SUPPORT
-M:	Marek Vasut <marek.vasut@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-pxa/colibri-pxa270-income.c
-
 ARM/INTEL IXP4XX ARM ARCHITECTURE
 M:	Linus Walleij <linusw@kernel.org>
 M:	Imre Kaloz <kaloz@openwrt.org>
@@ -2311,22 +2281,12 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
-ARM/IP FABRICS DOUBLE ESPRESSO MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/LG1K ARCHITECTURE
 M:	Chanho Min <chanho.min@lge.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/lg/
 
-ARM/LOGICPD PXA270 MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/LPC18XX ARCHITECTURE
 M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2353,10 +2313,6 @@ F:	drivers/usb/host/ohci-nxp.c
 F:	drivers/watchdog/pnx4008_wdt.c
 N:	lpc32xx
 
-ARM/MAGICIAN MACHINE SUPPORT
-M:	Philipp Zabel <philipp.zabel@gmail.com>
-S:	Maintained
-
 ARM/Marvell Dove/MV78xx0/Orion SOC support
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
@@ -2485,12 +2441,6 @@ F:	arch/arm/boot/dts/milbeaut*
 F:	arch/arm/mach-milbeaut/
 N:	milbeaut
 
-ARM/MIOA701 MACHINE SUPPORT
-M:	Robert Jarzmik <robert.jarzmik@free.fr>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-pxa/mioa701.c
-
 ARM/MStar/Sigmastar Armv7 SoC support
 M:	Daniel Palmer <daniel@thingy.jp>
 M:	Romain Perier <romain.perier@gmail.com>
@@ -2511,10 +2461,6 @@ F:	drivers/watchdog/msc313e_wdt.c
 F:	include/dt-bindings/clock/mstar-*
 F:	include/dt-bindings/gpio/msc313-gpio.h
 
-ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
-M:	Michael Petchkovsky <mkpetch@internode.on.net>
-S:	Maintained
-
 ARM/NOMADIK/Ux500 ARCHITECTURES
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2600,32 +2546,6 @@ F:	arch/arm/mach-oxnas/
 F:	drivers/power/reset/oxnas-restart.c
 N:	oxnas
 
-ARM/PALM TREO SUPPORT
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Orphan
-F:	arch/arm/mach-pxa/palmtreo.*
-
-ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
-M:	Marek Vasut <marek.vasut@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-W:	http://hackndev.com
-F:	arch/arm/mach-pxa/include/mach/palmld.h
-F:	arch/arm/mach-pxa/include/mach/palmtc.h
-F:	arch/arm/mach-pxa/include/mach/palmtx.h
-F:	arch/arm/mach-pxa/palmld.c
-F:	arch/arm/mach-pxa/palmt5.*
-F:	arch/arm/mach-pxa/palmtc.c
-F:	arch/arm/mach-pxa/palmte2.*
-F:	arch/arm/mach-pxa/palmtx.c
-
-ARM/PALMZ72 SUPPORT
-M:	Sergey Lapin <slapin@ossfans.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-W:	http://hackndev.com
-F:	arch/arm/mach-pxa/palmz72.*
-
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
 M:	Bjorn Andersson <andersson@kernel.org>
@@ -2999,11 +2919,6 @@ F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
 F:	include/dt-bindings/pinctrl/k3.h
 
-ARM/TOSA MACHINE SUPPORT
-M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
-M:	Dirk Opfer <dirk@opfer-online.de>
-S:	Maintained
-
 ARM/TOSHIBA VISCONTI ARCHITECTURE
 M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -3073,13 +2988,6 @@ S:	Maintained
 W:	http://www.armlinux.org.uk/
 F:	arch/arm/vfp/
 
-ARM/VOIPAC PXA270 SUPPORT
-M:	Marek Vasut <marek.vasut@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-pxa/include/mach/vpac270.h
-F:	arch/arm/mach-pxa/vpac270.c
-
 ARM/VT8500 ARM ARCHITECTURE
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Orphan
@@ -3097,13 +3005,6 @@ F:	drivers/video/fbdev/vt8500lcdfb.*
 F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
 
-ARM/ZIPIT Z2 SUPPORT
-M:	Marek Vasut <marek.vasut@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-pxa/include/mach/z2.h
-F:	arch/arm/mach-pxa/z2.c
-
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
deleted file mode 100644
index 95144e380b4b..000000000000
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
deleted file mode 100644
index 8357d721c69c..000000000000
diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
deleted file mode 100644
index 42adfefdb6dc..000000000000
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
deleted file mode 100644
index df84640f4f57..000000000000
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
deleted file mode 100644
index b4c2e6457e04..000000000000
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
deleted file mode 100644
index ef7b0a0aee3a..000000000000
diff --git a/arch/arm/configs/h5000_defconfig b/arch/arm/configs/h5000_defconfig
deleted file mode 100644
index d01f1a6bd04d..000000000000
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
deleted file mode 100644
index b0c21a99a0a8..000000000000
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
deleted file mode 100644
index 4fc744c96196..000000000000
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
deleted file mode 100644
index 5a8776f6aba3..000000000000
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
deleted file mode 100644
index 096cd7bc667a..000000000000
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
deleted file mode 100644
index a9a808bc2f70..000000000000
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
deleted file mode 100644
index a392312a13ce..000000000000
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
deleted file mode 100644
index ae0444949a87..000000000000
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 0a0f12df40b5..74c7145c79ea 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -19,7 +19,6 @@ CONFIG_ARCH_GUMSTIX=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
-CONFIG_PXA_SYSTEMS_CPLDS=y
 CONFIG_AEABI=y
 CONFIG_ARCH_FORCE_MAX_ORDER=9
 CONFIG_CMDLINE="root=/dev/ram0 ro"
@@ -397,9 +396,7 @@ CONFIG_FB_VIRTUAL=m
 CONFIG_FB_SIMPLE=y
 CONFIG_LCD_CORGI=m
 CONFIG_LCD_PLATFORM=m
-CONFIG_LCD_TOSA=m
 CONFIG_BACKLIGHT_PWM=m
-CONFIG_BACKLIGHT_TOSA=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
deleted file mode 100644
index 009abe1e49ef..000000000000
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
deleted file mode 100644
index 02f9849893b2..000000000000
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
deleted file mode 100644
index 6bd9f71b71fc..000000000000
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
deleted file mode 100644
index c4535315e216..000000000000
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index b90d98bae68d..1d2eba70c18c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -16,10 +16,6 @@ menuconfig ARCH_PXA
 
 if ARCH_PXA
 
-menu "Intel PXA2xx/PXA3xx Implementations"
-
-comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
-
 config MACH_PXA25X_DT
 	bool "Support PXA25x platforms from device tree"
 	select PINCTRL
@@ -56,115 +52,7 @@ config MACH_PXA3XX_DT
 
 if ATAGS
 
-config ARCH_LUBBOCK
-	bool "Intel DBPXA250 Development Platform (aka Lubbock)"
-	depends on UNUSED_BOARD_FILES
-	select GPIO_REG
-	select PXA25x
-	select SA1111
-
-config MACH_MAINSTONE
-	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
-	depends on UNUSED_BOARD_FILES
-	select GPIO_REG
-	select PXA27x
-
-config MACH_ZYLONITE
-	bool
-	select PXA3xx
-
-config MACH_ZYLONITE300
-	bool "PXA3xx Development Platform (aka Zylonite) PXA300/310"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA300
-	select CPU_PXA310
-	select MACH_ZYLONITE
-
-config MACH_ZYLONITE320
-	bool "PXA3xx Development Platform (aka Zylonite) PXA320"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA320
-	select MACH_ZYLONITE
-
-config MACH_LITTLETON
-	bool "PXA3xx Form Factor Platform (aka Littleton)"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA300
-	select CPU_PXA310
-	select PXA3xx
-
-config MACH_TAVOREVB
-	bool "PXA930 Evaluation Board (aka TavorEVB)"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA930
-	select CPU_PXA935
-	select PXA3xx
-	select FB
-	select FB_PXA
-
-config MACH_SAAR
-	bool "PXA930 Handheld Platform (aka SAAR)"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA930
-	select CPU_PXA935
-	select PXA3xx
-	select FB
-	select FB_PXA
-
-comment "Third Party Dev Platforms (sorted by vendor name)"
-
-config ARCH_PXA_IDP
-	bool "Accelent Xscale IDP"
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-
-config ARCH_VIPER
-	bool "Arcom/Eurotech VIPER SBC"
-	depends on UNUSED_BOARD_FILES
-	select ARCOM_PCMCIA
-	select I2C_GPIO if I2C=y
-	select ISA
-	select PXA25x
-
-config MACH_ARCOM_ZEUS
-	bool "Arcom/Eurotech ZEUS SBC"
-	depends on UNUSED_BOARD_FILES
-	select ARCOM_PCMCIA
-	select ISA
-	select PXA27x
-
-config MACH_BALLOON3
-	bool "Balloon 3 board"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-
-config MACH_CSB726
-	bool "Enable Cogent CSB726 System On a Module"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on a Cogent
-	  CSB726 System On Module.
-
-config CSB726_CSB701
-	bool "Enable support for CSB701 baseboard"
-	depends on UNUSED_BOARD_FILES
-	depends on MACH_CSB726
-
-config MACH_CM_X300
-	bool "CompuLab CM-X300 modules"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA300
-	select CPU_PXA310
-	select PXA3xx
-
-config MACH_CAPC7117
-	bool "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA320
-	select PXA3xx
+comment "Legacy board files"
 
 config ARCH_GUMSTIX
 	bool "Gumstix XScale 255 boards"
@@ -185,307 +73,6 @@ config GUMSTIX_AM300EPD
 
 endchoice
 
-config MACH_XCEP
-	bool "Iskratel Electronics XCEP"
-	depends on UNUSED_BOARD_FILES
-	select MTD
-	select MTD_CFI
-	select MTD_CFI_INTELEXT
-	select MTD_PHYSMAP
-	select PXA25x
-	help
-	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
-	  Tuned for usage in Libera instruments for particle accelerators.
-
-config TRIZEPS_PXA
-	bool "PXA based Keith und Koep Trizeps DIMM-Modules"
-	depends on UNUSED_BOARD_FILES
-
-config MACH_TRIZEPS4
-	bool "Keith und Koep Trizeps4 DIMM-Module"
-	depends on TRIZEPS_PXA
-	select PXA27x
-	select TRIZEPS_PCMCIA
-
-config MACH_TRIZEPS4WL
-	bool "Keith und Koep Trizeps4-WL DIMM-Module"
-	depends on TRIZEPS_PXA
-	select MACH_TRIZEPS4
-	select PXA27x
-	select TRIZEPS_PCMCIA
-
-choice
-	prompt "Select base board for Trizeps module"
-	depends on TRIZEPS_PXA
-
-config MACH_TRIZEPS_CONXS
-	bool "ConXS Eval Board"
-
-config MACH_TRIZEPS_UCONXS
-	bool "uConXS Eval Board"
-
-config MACH_TRIZEPS_ANY
-	bool "another Board"
-
-endchoice
-
-config ARCOM_PCMCIA
-	bool
-	help
-	  Generic option for Arcom Viper/Zeus PCMCIA
-
-config TRIZEPS_PCMCIA
-	bool
-	help
-	  Enable PCMCIA support for Trizeps modules
-
-config MACH_LOGICPD_PXA270
-	bool "LogicPD PXA270 Card Engine Development Platform"
-	depends on UNUSED_BOARD_FILES
-	select PXA27x
-
-config MACH_PCM027
-	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-
-config MACH_PCM990_BASEBOARD
-	bool "PHYTEC PCM-990 development board"
-	depends on UNUSED_BOARD_FILES
-	depends on MACH_PCM027
-
-choice
-	prompt "display on pcm990"
-	depends on MACH_PCM990_BASEBOARD
-
-config PCM990_DISPLAY_SHARP
-	bool "sharp lq084v1dg21 stn display"
-
-config PCM990_DISPLAY_NEC
-	bool "nec nl6448bc20_18d tft display"
-
-config PCM990_DISPLAY_NONE
-	bool "no display"
-
-endchoice
-
-config MACH_COLIBRI
-	bool "Toradex Colibri PXA270"
-	depends on UNUSED_BOARD_FILES
-	select PXA27x
-
-config MACH_COLIBRI_PXA270_INCOME
-	bool "Income s.r.o. PXA270 SBC"
-	depends on UNUSED_BOARD_FILES
-	depends on MACH_COLIBRI
-	select PXA27x
-
-config MACH_COLIBRI300
-	bool "Toradex Colibri PXA300/310"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA300
-	select CPU_PXA310
-	select PXA3xx
-
-config MACH_COLIBRI320
-	bool "Toradex Colibri PXA320"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA320
-	select PXA3xx
-
-config MACH_COLIBRI_EVALBOARD
-	bool "Toradex Colibri Evaluation Carrier Board support"
-	depends on UNUSED_BOARD_FILES
-	depends on MACH_COLIBRI || MACH_COLIBRI300 || MACH_COLIBRI320
-
-config MACH_VPAC270
-	bool "Voipac PXA270"
-	depends on UNUSED_BOARD_FILES
-	select HAVE_PATA_PLATFORM
-	select PXA27x
-	help
-	  PXA270 based Single Board Computer.
-
-comment "End-user Products (sorted by vendor name)"
-
-config MACH_H4700
-	bool "HP iPAQ hx4700"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-
-config MACH_H5000
-	bool "HP iPAQ h5000"
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-
-config MACH_HIMALAYA
-	bool "HTC Himalaya Support"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA26x
-
-config MACH_MAGICIAN
-	bool "Enable HTC Magician Support"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-
-config MACH_MIOA701
-	bool "Mitac Mio A701 Support"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on a
-	  MIO A701. Currently there is only basic support
-	  for this PDA.
-
-config PXA_EZX
-	bool "Motorola EZX Platform"
-	depends on UNUSED_BOARD_FILES
-	select IWMMXT
-	select PXA27x
-
-config MACH_EZX_A780
-	bool "Motorola EZX A780"
-	default y
-	depends on PXA_EZX
-
-config MACH_EZX_E680
-	bool "Motorola EZX E680"
-	default y
-	depends on PXA_EZX
-
-config MACH_EZX_A1200
-	bool "Motorola EZX A1200"
-	default y
-	depends on PXA_EZX
-
-config MACH_EZX_A910
-	bool "Motorola EZX A910"
-	default y
-	depends on PXA_EZX
-
-config MACH_EZX_E6
-	bool "Motorola EZX E6"
-	default y
-	depends on PXA_EZX
-
-config MACH_EZX_E2
-	bool "Motorola EZX E2"
-	default y
-	depends on PXA_EZX
-
-config MACH_MP900C
-	bool "Nec Mobilepro 900/c"
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-
-config ARCH_PXA_PALM
-	bool "PXA based Palm PDAs"
-	depends on UNUSED_BOARD_FILES
-
-config MACH_PALM27X
-	bool
-
-config MACH_PALMTE2
-	bool "Palm Tungsten|E2"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select PXA25x
-	help
-	  Say Y here if you intend to run this kernel on a Palm Tungsten|E2
-	  handheld computer.
-
-config MACH_PALMTC
-	bool "Palm Tungsten|C"
-	default y
-	depends on ARCH_PXA_PALM
-	select PXA25x
-	help
-	  Say Y here if you intend to run this kernel on a Palm Tungsten|C
-	  handheld computer.
-
-config MACH_PALMT5
-	bool "Palm Tungsten|T5"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select IWMMXT
-	select MACH_PALM27X
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on a Palm Tungsten|T5
-	  handheld computer.
-
-config MACH_PALMTX
-	bool "Palm T|X"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select IWMMXT
-	select MACH_PALM27X
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on a Palm T|X
-	  handheld computer.
-
-config MACH_PALMZ72
-	bool "Palm Zire 72"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select IWMMXT
-	select MACH_PALM27X
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on Palm Zire 72
-	  handheld computer.
-
-config MACH_PALMLD
-	bool "Palm LifeDrive"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select IWMMXT
-	select MACH_PALM27X
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on a Palm LifeDrive
-	  handheld computer.
-
-config PALM_TREO
-	bool
-	depends on ARCH_PXA_PALM
-
-config MACH_CENTRO
-	bool "Palm Centro 685 (GSM)"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select IWMMXT
-	select MACH_PALM27X
-	select PALM_TREO
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on Palm Centro 685 (GSM)
-	  smartphone.
-
-config MACH_TREO680
-	bool "Palm Treo 680"
-	depends on UNUSED_BOARD_FILES
-	default y
-	depends on ARCH_PXA_PALM
-	select IWMMXT
-	select MACH_PALM27X
-	select PALM_TREO
-	select PXA27x
-	help
-	  Say Y here if you intend to run this kernel on Palm Treo 680
-	  smartphone.
-
 config PXA_SHARPSL
 	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
 	select SHARP_PARAM
@@ -505,34 +92,6 @@ config PXA_SHARPSL_DETECT_MACH_ID
 	  the Zaurus machine ID at run-time. For latest kexec-based
 	  boot loader, this is not necessary.
 
-config MACH_POODLE
-	bool "Enable Sharp SL-5600 (Poodle) Support"
-	depends on PXA_SHARPSL
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-	select SHARP_LOCOMO
-
-config MACH_CORGI
-	bool "Enable Sharp SL-C700 (Corgi) Support"
-	depends on PXA_SHARPSL
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-	select PXA_SHARP_C7xx
-
-config MACH_SHEPHERD
-	bool "Enable Sharp SL-C750 (Shepherd) Support"
-	depends on PXA_SHARPSL
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-	select PXA_SHARP_C7xx
-
-config MACH_HUSKY
-	bool "Enable Sharp SL-C760 (Husky) Support"
-	depends on PXA_SHARPSL
-	depends on UNUSED_BOARD_FILES
-	select PXA25x
-	select PXA_SHARP_C7xx
-
 config MACH_AKITA
 	bool "Enable Sharp SL-1000 (Akita) Support"
 	depends on PXA_SHARPSL
@@ -554,98 +113,7 @@ config MACH_BORZOI
 	select PXA27x
 	select PXA_SHARP_Cxx00
 
-config MACH_TOSA
-	bool "Enable Sharp SL-6000x (Tosa) Support"
-	depends on UNUSED_BOARD_FILES
-	depends on PXA_SHARPSL
-	select PXA25x
-
-config TOSA_BT
-	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
-	depends on MACH_TOSA && NET
-	select RFKILL
-	help
-	  This is a simple driver that is able to control
-	  the state of built in bluetooth chip on tosa.
-
-config TOSA_USE_EXT_KEYCODES
-	bool "Tosa keyboard: use extended keycodes"
-	depends on MACH_TOSA
-	help
-	  Say Y here to enable the tosa keyboard driver to generate extended
-	  (>= 127) keycodes. Be aware, that they can't be correctly interpreted
-	  by either console keyboard driver or by Kdrive keybd driver.
-
-	  Say Y only if you know, what you are doing!
-
-config MACH_ICONTROL
-	bool "TMT iControl/SafeTCam based on the MXM-8x10 CoM"
-	depends on UNUSED_BOARD_FILES
-	select CPU_PXA320
-	select PXA3xx
-
-config ARCH_PXA_ESERIES
-	bool "PXA based Toshiba e-series PDAs"
-	depends on UNUSED_BOARD_FILES
-	select FB_W100
-	select FB
-	select PXA25x
-
-config MACH_E330
-	bool "Toshiba e330"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e330 family PDA.
-
-config MACH_E350
-	bool "Toshiba e350"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e350 family PDA.
-
-config MACH_E740
-	bool "Toshiba e740"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e740 family PDA.
-
-config MACH_E750
-	bool "Toshiba e750"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e750 family PDA.
-
-config MACH_E400
-	bool "Toshiba e400"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e400 family PDA.
-
-config MACH_E800
-	bool "Toshiba e800"
-	default y
-	depends on ARCH_PXA_ESERIES
-	help
-	  Say Y here if you intend to run this kernel on a Toshiba
-	  e800 family PDA.
-
-config MACH_ZIPIT2
-	bool "Zipit Z2 Handheld"
-	depends on UNUSED_BOARD_FILES
-	select PXA27x
-
 endif # ATAGS
-endmenu
 
 config PXA25x
 	bool
@@ -659,12 +127,6 @@ config PXA27x
 	help
 	  Select code specific to PXA27x variants
 
-config CPU_PXA26x
-	bool
-	select PXA25x
-	help
-	  Select code specific to PXA26x (codename Dalhart)
-
 config PXA3xx
 	bool
 	select CPU_XSC3
@@ -677,37 +139,6 @@ config CPU_PXA300
 	help
 	  PXA300 (codename Monahans-L)
 
-config CPU_PXA310
-	bool
-	select CPU_PXA300
-	select PXA310_ULPI if USB_ULPI
-	help
-	  PXA310 (codename Monahans-LV)
-
-config CPU_PXA320
-	bool
-	select PXA3xx
-	help
-	  PXA320 (codename Monahans-P)
-
-config CPU_PXA930
-	bool
-	select PXA3xx
-	help
-	  PXA930 (codename Tavor-P)
-
-config CPU_PXA935
-	bool
-	select CPU_PXA930
-	help
-	  PXA935 (codename Tavor-P65)
-
-config PXA_SHARP_C7xx
-	bool
-	select SHARPSL_PM
-	help
-	  Enable support for all Sharp C7xx models
-
 config PXA_SHARP_Cxx00
 	bool
 	select SHARPSL_PM
@@ -726,16 +157,4 @@ config SHARPSL_PM_MAX1111
 	select SPI
 	select SPI_MASTER
 
-config PXA310_ULPI
-	bool
-
-config PXA_SYSTEMS_CPLDS
-	tristate "Motherboard cplds"
-	default ARCH_LUBBOCK || MACH_MAINSTONE
-	help
-	  This driver supports the Lubbock and Mainstone multifunction chip
-	  found on the pxa25x development platform system (Lubbock) and pxa27x
-	  development platform system (Mainstone). This IO board supports the
-	  interrupts handling, ethernet controller, flash chips, etc ...
-
 endif
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 0aec36e67dc1..4ca8cac2e60f 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -14,8 +14,6 @@ obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
-obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
-obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 
 # NOTE: keep the order of boards in accordance to their order in Kconfig
 
@@ -24,66 +22,10 @@ obj-$(CONFIG_MACH_PXA25X_DT)	+= pxa-dt.o
 obj-$(CONFIG_MACH_PXA27X_DT)	+= pxa-dt.o
 obj-$(CONFIG_MACH_PXA3XX_DT)	+= pxa-dt.o
 
-# Intel/Marvell Dev Platforms
-obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
-obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
-obj-$(CONFIG_MACH_ZYLONITE300)	+= zylonite.o zylonite_pxa300.o
-obj-$(CONFIG_MACH_ZYLONITE320)	+= zylonite.o zylonite_pxa320.o
-obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
-obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
-obj-$(CONFIG_MACH_SAAR)		+= saar.o
-
 # 3rd Party Dev Platforms
-obj-$(CONFIG_ARCH_PXA_IDP)	+= idp.o
-obj-$(CONFIG_ARCH_VIPER)	+= viper.o
-obj-$(CONFIG_MACH_ARCOM_ZEUS)	+= zeus.o
-obj-$(CONFIG_ARCOM_PCMCIA)	+= viper-pcmcia.o
-obj-$(CONFIG_MACH_BALLOON3)	+= balloon3.o balloon3-pcmcia.o
-obj-$(CONFIG_MACH_CSB726)	+= csb726.o
-obj-$(CONFIG_CSB726_CSB701)	+= csb701.o
-obj-$(CONFIG_MACH_CM_X300)      += cm-x300.o
-obj-$(CONFIG_MACH_CAPC7117)     += capc7117.o mxm8x10.o
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
 obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
 obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
-obj-$(CONFIG_MACH_XCEP)         += xcep.o
-obj-$(CONFIG_MACH_TRIZEPS4)	+= trizeps4.o
-obj-$(CONFIG_TRIZEPS_PCMCIA)	+= trizeps4-pcmcia.o
-obj-$(CONFIG_MACH_LOGICPD_PXA270)	+= lpd270.o
-obj-$(CONFIG_MACH_PCM027)		+= pcm027.o
-obj-$(CONFIG_MACH_PCM990_BASEBOARD)	+= pcm990-baseboard.o
-obj-$(CONFIG_MACH_COLIBRI)		+= colibri-pxa270.o colibri-pcmcia.o
-obj-$(CONFIG_MACH_COLIBRI_EVALBOARD)	+= colibri-evalboard.o
-obj-$(CONFIG_MACH_COLIBRI_PXA270_INCOME)	+= colibri-pxa270-income.o
-obj-$(CONFIG_MACH_COLIBRI300)	+= colibri-pxa3xx.o colibri-pxa300.o
-obj-$(CONFIG_MACH_COLIBRI320)	+= colibri-pxa3xx.o colibri-pxa320.o colibri-pcmcia.o
-obj-$(CONFIG_MACH_VPAC270)	+= vpac270.o vpac270-pcmcia.o
 
 # End-user Products
-obj-$(CONFIG_MACH_H4700)	+= hx4700.o
-obj-$(CONFIG_MACH_H4700)	+= hx4700-pcmcia.o
-obj-$(CONFIG_MACH_H5000)	+= h5000.o
-obj-$(CONFIG_MACH_HIMALAYA)	+= himalaya.o
-obj-$(CONFIG_MACH_MAGICIAN)	+= magician.o
-obj-$(CONFIG_MACH_MIOA701)	+= mioa701.o mioa701_bootresume.o
-obj-$(CONFIG_PXA_EZX)           += ezx.o
-obj-$(CONFIG_MACH_MP900C)	+= mp900.o
-obj-$(CONFIG_MACH_PALMTE2)	+= palmte2.o
-obj-$(CONFIG_MACH_PALMTC)	+= palmtc.o palmtc-pcmcia.o
-obj-$(CONFIG_MACH_PALM27X)	+= palm27x.o
-obj-$(CONFIG_MACH_PALMT5)	+= palmt5.o
-obj-$(CONFIG_MACH_PALMTX)	+= palmtx.o palmtx-pcmcia.o
-obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
-obj-$(CONFIG_MACH_PALMLD)	+= palmld.o palmld-pcmcia.o
-obj-$(CONFIG_PALM_TREO)		+= palmtreo.o
-obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o sharpsl_pm.o corgi_pm.o
 obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o sharpsl_pm.o spitz_pm.o
-obj-$(CONFIG_MACH_POODLE)	+= poodle.o
-obj-$(CONFIG_MACH_TOSA)		+= tosa.o
-obj-$(CONFIG_MACH_ICONTROL)     += icontrol.o mxm8x10.o
-obj-$(CONFIG_ARCH_PXA_ESERIES)	+= eseries.o
-obj-$(CONFIG_MACH_E740)		+= e740-pcmcia.o
-obj-$(CONFIG_MACH_ZIPIT2)	+= z2.o
-
-obj-$(CONFIG_PXA_SYSTEMS_CPLDS)	+= pxa_cplds_irqs.o
-obj-$(CONFIG_TOSA_BT)		+= tosa-bt.o
diff --git a/arch/arm/mach-pxa/balloon3-pcmcia.c b/arch/arm/mach-pxa/balloon3-pcmcia.c
deleted file mode 100644
index 6a27b76cc603..000000000000
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
deleted file mode 100644
index 896d47d9a8dc..000000000000
diff --git a/arch/arm/mach-pxa/balloon3.h b/arch/arm/mach-pxa/balloon3.h
deleted file mode 100644
index 04f3639c4082..000000000000
diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
deleted file mode 100644
index 7712327f56a8..000000000000
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
deleted file mode 100644
index 01f364a66446..000000000000
diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
deleted file mode 100644
index b62af07b8f96..000000000000
diff --git a/arch/arm/mach-pxa/colibri-pcmcia.c b/arch/arm/mach-pxa/colibri-pcmcia.c
deleted file mode 100644
index 9da7b478e5eb..000000000000
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
deleted file mode 100644
index f6eaf464ca83..000000000000
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
deleted file mode 100644
index 5dc669752836..000000000000
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
deleted file mode 100644
index 11ca6c4795e7..000000000000
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
deleted file mode 100644
index 1a59056e181e..000000000000
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
deleted file mode 100644
index 77d6ef5fa42d..000000000000
diff --git a/arch/arm/mach-pxa/colibri.h b/arch/arm/mach-pxa/colibri.h
deleted file mode 100644
index 01a46f36cc1f..000000000000
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
deleted file mode 100644
index 5738496717e2..000000000000
diff --git a/arch/arm/mach-pxa/corgi.h b/arch/arm/mach-pxa/corgi.h
deleted file mode 100644
index b565ca7b8cda..000000000000
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
deleted file mode 100644
index 555a5c1afd96..000000000000
diff --git a/arch/arm/mach-pxa/csb701.c b/arch/arm/mach-pxa/csb701.c
deleted file mode 100644
index 527c9fdf9795..000000000000
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
deleted file mode 100644
index 410b1af87d55..000000000000
diff --git a/arch/arm/mach-pxa/csb726.h b/arch/arm/mach-pxa/csb726.h
deleted file mode 100644
index 628928743bd5..000000000000
diff --git a/arch/arm/mach-pxa/e740-pcmcia.c b/arch/arm/mach-pxa/e740-pcmcia.c
deleted file mode 100644
index 11a2c5d42920..000000000000
diff --git a/arch/arm/mach-pxa/eseries-gpio.h b/arch/arm/mach-pxa/eseries-gpio.h
deleted file mode 100644
index 5c645600d401..000000000000
diff --git a/arch/arm/mach-pxa/eseries-irq.h b/arch/arm/mach-pxa/eseries-irq.h
deleted file mode 100644
index 572d573ce66b..000000000000
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
deleted file mode 100644
index 2e4daeab6278..000000000000
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
deleted file mode 100644
index 69c2ec02a16c..000000000000
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
deleted file mode 100644
index 212efe24aedb..000000000000
diff --git a/arch/arm/mach-pxa/h5000.h b/arch/arm/mach-pxa/h5000.h
deleted file mode 100644
index 58687e94a0c7..000000000000
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
deleted file mode 100644
index 469ffeec6da5..000000000000
diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c b/arch/arm/mach-pxa/hx4700-pcmcia.c
deleted file mode 100644
index e2331dfe427d..000000000000
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
deleted file mode 100644
index 2fd665944103..000000000000
diff --git a/arch/arm/mach-pxa/hx4700.h b/arch/arm/mach-pxa/hx4700.h
deleted file mode 100644
index 0c30e6d9c660..000000000000
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
deleted file mode 100644
index 624088257cfc..000000000000
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
deleted file mode 100644
index 525d01ddfbbb..000000000000
diff --git a/arch/arm/mach-pxa/idp.h b/arch/arm/mach-pxa/idp.h
deleted file mode 100644
index 81b9bd9ba754..000000000000
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
deleted file mode 100644
index 98423a96f440..000000000000
diff --git a/arch/arm/mach-pxa/littleton.h b/arch/arm/mach-pxa/littleton.h
deleted file mode 100644
index a0a8d2bf9d71..000000000000
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
deleted file mode 100644
index 0e4123c5fd42..000000000000
diff --git a/arch/arm/mach-pxa/lpd270.h b/arch/arm/mach-pxa/lpd270.h
deleted file mode 100644
index 4b096fb9d61f..000000000000
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
deleted file mode 100644
index 4f0944f3b262..000000000000
diff --git a/arch/arm/mach-pxa/lubbock.h b/arch/arm/mach-pxa/lubbock.h
deleted file mode 100644
index 55cf91e22ae2..000000000000
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
deleted file mode 100644
index 0827ebca1d38..000000000000
diff --git a/arch/arm/mach-pxa/magician.h b/arch/arm/mach-pxa/magician.h
deleted file mode 100644
index e1e4f9f6b22b..000000000000
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
deleted file mode 100644
index fd386f1c414c..000000000000
diff --git a/arch/arm/mach-pxa/mainstone.h b/arch/arm/mach-pxa/mainstone.h
deleted file mode 100644
index f116c56cf5d9..000000000000
diff --git a/arch/arm/mach-pxa/mfp-pxa320.h b/arch/arm/mach-pxa/mfp-pxa320.h
deleted file mode 100644
index 21c31eb52d6c..000000000000
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
deleted file mode 100644
index d08f962ffb04..000000000000
diff --git a/arch/arm/mach-pxa/mioa701.h b/arch/arm/mach-pxa/mioa701.h
deleted file mode 100644
index d94295c67460..000000000000
diff --git a/arch/arm/mach-pxa/mioa701_bootresume.S b/arch/arm/mach-pxa/mioa701_bootresume.S
deleted file mode 100644
index 4ad2fa27fc41..000000000000
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
deleted file mode 100644
index 8ef8ac4ab4ac..000000000000
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
deleted file mode 100644
index 35546b59c88e..000000000000
diff --git a/arch/arm/mach-pxa/mxm8x10.h b/arch/arm/mach-pxa/mxm8x10.h
deleted file mode 100644
index dcd32321c995..000000000000
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
deleted file mode 100644
index 1a8d25eecac3..000000000000
diff --git a/arch/arm/mach-pxa/palm27x.h b/arch/arm/mach-pxa/palm27x.h
deleted file mode 100644
index bd3075bbb3aa..000000000000
diff --git a/arch/arm/mach-pxa/palmld-pcmcia.c b/arch/arm/mach-pxa/palmld-pcmcia.c
deleted file mode 100644
index 720294a50864..000000000000
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
deleted file mode 100644
index 32308c63884e..000000000000
diff --git a/arch/arm/mach-pxa/palmld.h b/arch/arm/mach-pxa/palmld.h
deleted file mode 100644
index 99a6d8b3a1e3..000000000000
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
deleted file mode 100644
index 463b62ec1b01..000000000000
diff --git a/arch/arm/mach-pxa/palmt5.h b/arch/arm/mach-pxa/palmt5.h
deleted file mode 100644
index cf84aedca717..000000000000
diff --git a/arch/arm/mach-pxa/palmtc-pcmcia.c b/arch/arm/mach-pxa/palmtc-pcmcia.c
deleted file mode 100644
index 8e3f382343fe..000000000000
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
deleted file mode 100644
index 3054ffa397ad..000000000000
diff --git a/arch/arm/mach-pxa/palmtc.h b/arch/arm/mach-pxa/palmtc.h
deleted file mode 100644
index 9257a02c46e5..000000000000
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
deleted file mode 100644
index fedac670a8af..000000000000
diff --git a/arch/arm/mach-pxa/palmte2.h b/arch/arm/mach-pxa/palmte2.h
deleted file mode 100644
index 2589400c1a2f..000000000000
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
deleted file mode 100644
index 238a31f32cba..000000000000
diff --git a/arch/arm/mach-pxa/palmtreo.h b/arch/arm/mach-pxa/palmtreo.h
deleted file mode 100644
index 5715cd505424..000000000000
diff --git a/arch/arm/mach-pxa/palmtx-pcmcia.c b/arch/arm/mach-pxa/palmtx-pcmcia.c
deleted file mode 100644
index 8c2aaad93043..000000000000
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
deleted file mode 100644
index c0d0762540ab..000000000000
diff --git a/arch/arm/mach-pxa/palmtx.h b/arch/arm/mach-pxa/palmtx.h
deleted file mode 100644
index ec88abf0fc6c..000000000000
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
deleted file mode 100644
index 66e8fe6f1661..000000000000
diff --git a/arch/arm/mach-pxa/palmz72.h b/arch/arm/mach-pxa/palmz72.h
deleted file mode 100644
index 40f3f9987983..000000000000
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
deleted file mode 100644
index 7ff6f0d655c8..000000000000
diff --git a/arch/arm/mach-pxa/pcm027.h b/arch/arm/mach-pxa/pcm027.h
deleted file mode 100644
index 58ade4ad6ba3..000000000000
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
deleted file mode 100644
index 33a9d2eeca1c..000000000000
diff --git a/arch/arm/mach-pxa/pcm990_baseboard.h b/arch/arm/mach-pxa/pcm990_baseboard.h
deleted file mode 100644
index 18cf71decb03..000000000000
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
deleted file mode 100644
index 7772a39430ed..000000000000
diff --git a/arch/arm/mach-pxa/poodle.h b/arch/arm/mach-pxa/poodle.h
deleted file mode 100644
index 00798b44f204..000000000000
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
deleted file mode 100644
index e372e6c118de..000000000000
diff --git a/arch/arm/mach-pxa/pxa320.h b/arch/arm/mach-pxa/pxa320.h
deleted file mode 100644
index c701e3f663b0..000000000000
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
deleted file mode 100644
index b9021a40cbd1..000000000000
diff --git a/arch/arm/mach-pxa/pxa930.h b/arch/arm/mach-pxa/pxa930.h
deleted file mode 100644
index bbf25c044641..000000000000
diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
deleted file mode 100644
index eda5a47d7fbb..000000000000
diff --git a/arch/arm/mach-pxa/regs-uart.h b/arch/arm/mach-pxa/regs-uart.h
deleted file mode 100644
index 490e9ca16297..000000000000
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
deleted file mode 100644
index 3275b679792b..000000000000
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index a829baf8d922..929cc51ed7c2 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -170,10 +170,6 @@ extern int max1111_read_channel(int);
  */
 int sharpsl_pm_pxa_read_max1111(int channel)
 {
-	/* Ugly, better move this function into another module */
-	if (machine_is_tosa())
-	    return 0;
-
 	/* max1111 accepts channels from 0-3, however,
 	 * it is encoded from 0-7 here in the code.
 	 */
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
deleted file mode 100644
index a15eb3b9484d..000000000000
diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
deleted file mode 100644
index c9541632b8b1..000000000000
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
deleted file mode 100644
index d41641d6cfcd..000000000000
diff --git a/arch/arm/mach-pxa/tosa.h b/arch/arm/mach-pxa/tosa.h
deleted file mode 100644
index 3b3efa0a0e22..000000000000
diff --git a/arch/arm/mach-pxa/tosa_bt.h b/arch/arm/mach-pxa/tosa_bt.h
deleted file mode 100644
index 56acd5dabec4..000000000000
diff --git a/arch/arm/mach-pxa/trizeps4-pcmcia.c b/arch/arm/mach-pxa/trizeps4-pcmcia.c
deleted file mode 100644
index 25e363770565..000000000000
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
deleted file mode 100644
index 716cce885379..000000000000
diff --git a/arch/arm/mach-pxa/trizeps4.h b/arch/arm/mach-pxa/trizeps4.h
deleted file mode 100644
index b6c19d155ef9..000000000000
diff --git a/arch/arm/mach-pxa/viper-pcmcia.c b/arch/arm/mach-pxa/viper-pcmcia.c
deleted file mode 100644
index 26599dcc49b3..000000000000
diff --git a/arch/arm/mach-pxa/viper-pcmcia.h b/arch/arm/mach-pxa/viper-pcmcia.h
deleted file mode 100644
index a23b58aff9e1..000000000000
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
deleted file mode 100644
index 5b43351ee840..000000000000
diff --git a/arch/arm/mach-pxa/viper.h b/arch/arm/mach-pxa/viper.h
deleted file mode 100644
index 5a8b132229dc..000000000000
diff --git a/arch/arm/mach-pxa/vpac270-pcmcia.c b/arch/arm/mach-pxa/vpac270-pcmcia.c
deleted file mode 100644
index 9fd990c8a5fb..000000000000
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
deleted file mode 100644
index 8f74bafcf1f9..000000000000
diff --git a/arch/arm/mach-pxa/vpac270.h b/arch/arm/mach-pxa/vpac270.h
deleted file mode 100644
index 0cd094d8c553..000000000000
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
deleted file mode 100644
index 6bb02b65fb82..000000000000
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
deleted file mode 100644
index c4d4162a7e6e..000000000000
diff --git a/arch/arm/mach-pxa/z2.h b/arch/arm/mach-pxa/z2.h
deleted file mode 100644
index a78b2e28b1db..000000000000
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
deleted file mode 100644
index ff0d8bb9f557..000000000000
diff --git a/arch/arm/mach-pxa/zeus.h b/arch/arm/mach-pxa/zeus.h
deleted file mode 100644
index 8fa6b2923f63..000000000000
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
deleted file mode 100644
index 8ed75ac29b1a..000000000000
diff --git a/arch/arm/mach-pxa/zylonite.h b/arch/arm/mach-pxa/zylonite.h
deleted file mode 100644
index afe3efcb8e04..000000000000
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
deleted file mode 100644
index 50a8a3547dbc..000000000000
diff --git a/arch/arm/mach-pxa/zylonite_pxa320.c b/arch/arm/mach-pxa/zylonite_pxa320.c
deleted file mode 100644
index 67cab4f1194b..000000000000
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
index c39f49720fe4..85b95ed461e7 100644
--- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -187,16 +187,6 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 		 "mainstone accelerated touchscreen driver, %d samples/sec\n",
 		 cinfo[sp_idx].speed);
 
-	/* IRQ driven touchscreen is used on Palm hardware */
-	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
-		pen_int = 1;
-		/* There is some obscure mutant of WM9712 interbred with WM9713
-		 * used on Palm HW */
-		wm->variant = WM97xx_WM1613;
-	} else if (machine_is_zylonite()) {
-		pen_int = 1;
-	}
-
 	if (pen_int) {
 		gpiod_irq = gpiod_get(wm->dev, "touch", GPIOD_IN);
 		if (IS_ERR(gpiod_irq))
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 0ea41f1411e5..5254028354f4 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -206,13 +206,7 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 
 void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops)
 {
-	int nr = 1;
-
-	if ((ops->first + ops->nr) > 1 ||
-	    machine_is_viper() || machine_is_arcom_zeus())
-		nr = 2;
-
-	pxa_smemc_set_pcmcia_socket(nr);
+	pxa_smemc_set_pcmcia_socket(1);
 }
 EXPORT_SYMBOL(pxa2xx_configure_sockets);
 
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 6c1c2785611b..2a67e33fb5f0 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -216,10 +216,6 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 	if (machine_is_jornada720())
 		ret = pcmcia_jornada720_init(dev);
 #endif
-#ifdef CONFIG_ARCH_LUBBOCK
-	if (machine_is_lubbock())
-		ret = pcmcia_lubbock_init(dev);
-#endif
 #ifdef CONFIG_ASSABET_NEPONSET
 	if (machine_is_assabet())
 		ret = pcmcia_neponset_init(dev);
diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 5f50da524f41..40fba31be174 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -227,20 +227,12 @@ static int rated_capacities[] = {
 	920,	/* NEC */
 	1440,	/* Samsung */
 	1440,	/* BYD */
-#ifdef CONFIG_MACH_H4700
-	1800,	/* HP iPAQ hx4700 3.7V 1800mAh (359113-001) */
-#else
 	1440,	/* Lishen */
-#endif
 	1440,	/* NEC */
 	2880,	/* Samsung */
 	2880,	/* BYD */
 	2880,	/* Lishen */
 	2880,	/* NEC */
-#ifdef CONFIG_MACH_H4700
-	0,
-	3600,	/* HP iPAQ hx4700 3.7V 3600mAh (359114-001) */
-#endif
 };
 
 /* array is level at temps 0°C, 10°C, 20°C, 30°C, 40°C
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index c593fc383481..e19b84a46a1e 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1559,40 +1559,6 @@ static int pxa25x_udc_stop(struct usb_gadget*g)
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-
-#ifdef CONFIG_ARCH_LUBBOCK
-
-/* Lubbock has separate connect and disconnect irqs.  More typical designs
- * use one GPIO as the VBUS IRQ, and another to control the D+ pullup.
- */
-
-static irqreturn_t
-lubbock_vbus_irq(int irq, void *_dev)
-{
-	struct pxa25x_udc	*dev = _dev;
-	int			vbus;
-
-	dev->stats.irqs++;
-	if (irq == dev->usb_irq) {
-		vbus = 1;
-		disable_irq(dev->usb_irq);
-		enable_irq(dev->usb_disc_irq);
-	} else if (irq == dev->usb_disc_irq) {
-		vbus = 0;
-		disable_irq(dev->usb_disc_irq);
-		enable_irq(dev->usb_irq);
-	} else {
-		return IRQ_NONE;
-	}
-
-	pxa25x_udc_vbus_session(&dev->gadget, vbus);
-	return IRQ_HANDLED;
-}
-
-#endif
-
-
 /*-------------------------------------------------------------------------*/
 
 static inline void clear_ep_state (struct pxa25x_udc *dev)
@@ -2413,34 +2379,6 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 	}
 	dev->got_irq = 1;
 
-#ifdef CONFIG_ARCH_LUBBOCK
-	if (machine_is_lubbock()) {
-		dev->usb_irq = platform_get_irq(pdev, 1);
-		if (dev->usb_irq < 0)
-			return dev->usb_irq;
-
-		dev->usb_disc_irq = platform_get_irq(pdev, 2);
-		if (dev->usb_disc_irq < 0)
-			return dev->usb_disc_irq;
-
-		retval = devm_request_irq(&pdev->dev, dev->usb_disc_irq,
-					  lubbock_vbus_irq, 0, driver_name,
-					  dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, dev->usb_disc_irq, retval);
-			goto err;
-		}
-		retval = devm_request_irq(&pdev->dev, dev->usb_irq,
-					  lubbock_vbus_irq, 0, driver_name,
-					  dev);
-		if (retval != 0) {
-			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, dev->usb_irq, retval);
-			goto err;
-		}
-	} else
-#endif
 	create_debug_files(dev);
 
 	retval = usb_add_gadget_udc(&pdev->dev, &dev->gadget);
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 0468ea82159f..346d3e29a843 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -95,8 +95,6 @@ void locomolcd_power(int on)
 	/* read comadj */
 	if (comadj == -1 && machine_is_collie())
 		comadj = 128;
-	if (comadj == -1 && machine_is_poodle())
-		comadj = 118;
 
 	if (on)
 		locomolcd_on(comadj);
@@ -181,14 +179,6 @@ static int locomolcd_probe(struct locomo_dev *ldev)
 
 	locomo_gpio_set_dir(ldev->dev.parent, LOCOMO_GPIO_FL_VR, 0);
 
-	/*
-	 * the poodle_lcd_power function is called for the first time
-	 * from fs_initcall, which is before locomo is activated.
-	 * We need to recall poodle_lcd_power here
-	 */
-	if (machine_is_poodle())
-		locomolcd_power(1);
-
 	local_irq_restore(flags);
 
 	memset(&props, 0, sizeof(struct backlight_properties));
-- 
2.39.0

