Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA31706104
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEQHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEQHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:21:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30548127;
        Wed, 17 May 2023 00:21:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae50da739dso2945265ad.1;
        Wed, 17 May 2023 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684308106; x=1686900106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bO7kgZPMTczSDirdqXKJBZBl86uOQNuTuLV9E8hKZ0g=;
        b=ErjQ1I34trxvh85J/nUAqawgZm/oIrl9Qy1FEcFN59V2peV60DVFxrPdkzeXbUsEM5
         mwMCuOtXH/vN/M0Uc2sPZy93QXunsRErLzqNA640OCFN7TDRe7cbGqJ8mcdT6Bn2duDc
         C1EBVXLZEqu3SgwHlZywH4GtiVl98wKp2xC5L/2QnXPAhyv+5zKsZCI/TvLnSVf9ee7D
         2oBmvfV95AY/CRgI0MPcxLg5/ePyLuAFcAjY0dkkZMI0Ola6X7mraiBZMdQq6stOBd+7
         hIBnnxDMgqvmoZVsl7sVxOv6ZWEIb7RsGvBomjzq1sh7EIfBBVCaI8ZgJYK+lJ1we/qK
         SDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308106; x=1686900106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO7kgZPMTczSDirdqXKJBZBl86uOQNuTuLV9E8hKZ0g=;
        b=e5zX71vsslXqoT2mzSlWK+qlJGdbKTOMotoYg0j3D49ia0fTiH3jdhVaANGLQ4+sF/
         JDh/55iBAFlGC1SLv16f8DR6p7oFh+pspY6GAyhczFYG+cm8ujTdk63tckANEkksJa/q
         zgB0OeTdv79MBJVH8ZXmoAVZJm8GlfQnriFF9k3XouLq98uTSWC4lSXUtDzL+C+qUYdV
         qr1WJ+dkFLYScluVTzsBMlyB/8W3kA81Ox6e6odIEwBOgb/iL4GCfAGlLDZNtWZoLBGq
         4zwoG5bDRhJkf3DYSpbRpCC9IVcKsxuNTgxOfW/of3jth89hdtHQFdLHjjodiMoouOmA
         ty7Q==
X-Gm-Message-State: AC+VfDxAngWfvpXwU86t7z3qdN8gpQ1wuvhwMJ34/8EP1VtcJKL8657o
        5zYarTFIXyHrsb35Qf2zPVM=
X-Google-Smtp-Source: ACHHUZ7pkFksq4U4zfaVs0PuDD5w8EqhGIDAiVcwoMxbS24ydWiatMAzS9p4ZoZQ0M7G+qr2/bhUhQ==
X-Received: by 2002:a17:902:ce8a:b0:1ad:ddf0:1311 with SMTP id f10-20020a170902ce8a00b001adddf01311mr25224279plg.50.1684308106634;
        Wed, 17 May 2023 00:21:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001a212a93295sm16717005plb.189.2023.05.17.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:21:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E504010627B; Wed, 17 May 2023 14:21:42 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Watchdog Drivers <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] SPDX conversion for watchdog drivers
Date:   Wed, 17 May 2023 14:21:38 +0700
Message-Id: <20230517072140.1086660-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=bagasdotme@gmail.com; h=from:subject; bh=RzAHt46+x5HRUtzf6AB4LZaIKGmFYqv5SXHMr3/Aplg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpDQ0ZDvLKF3ly+6a6T0oP0WBNO+m39455WZz9W4/lR xqqHxZ2lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCJrXjEydPE8/O/S0GZ+bafu 0gssb/pen07mTGrouq57Kn9iyuqmNYwMP55YsQSlTo98cibkctzU5RaGy534Xzpliv9TZPr7xEq AAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini SPDX conversion series focuses on watchdog drivers. It is
splitted from v2 of my SPDX conversion series that is triggered by
Didi's GPL full name fixes [1] to easify review.

The only missing bit compared to v2 is driver for SiByte SB1 watchdog
driver (drivers/watchdog/sb_wdog.c). The driver is skipped because
although theoretically SPDX license identifier for it is
GPL-1.0-only OR GPL-2.0-only, it doesn't satisfy spdxcheck test.
On the other hand, GPL-1.0+ isn't the answer either, since it will
include GPL v3. With above constraints, the licensing requirement
for sb_wdog can't be expressed acceptably, and so it is omitted
from this series.

Happy reviewing!

[1]: https://lore.kernel.org/linux-spdx/20230512100620.36807-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  watchdog: Convert GPL 2.0 notice to SPDX identifier
  watchdog: ibmasr: Replace GPL license notice with SPDX identifier

 drivers/watchdog/ep93xx_wdt.c     | 5 +----
 drivers/watchdog/ibmasr.c         | 3 +--
 drivers/watchdog/m54xx_wdt.c      | 4 +---
 drivers/watchdog/max63xx_wdt.c    | 5 +----
 drivers/watchdog/moxart_wdt.c     | 4 +---
 drivers/watchdog/octeon-wdt-nmi.S | 5 +----
 drivers/watchdog/orion_wdt.c      | 4 +---
 drivers/watchdog/rtd119x_wdt.c    | 2 +-
 drivers/watchdog/sbc_fitpc2_wdt.c | 4 +---
 drivers/watchdog/ts4800_wdt.c     | 4 +---
 drivers/watchdog/ts72xx_wdt.c     | 4 +---
 11 files changed, 11 insertions(+), 33 deletions(-)


base-commit: 10f67d1fd275528e62109de2ece26371833638e5
-- 
An old man doll... just what I always wanted! - Clara

