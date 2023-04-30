Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE176F2834
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjD3JW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjD3JWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 05:22:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04097171E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 02:22:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4efe8991bafso2023852e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682846538; x=1685438538;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XYiqBkbxAPVH0i8/+HRFP2RyVqV+Ef0zJV3FNvWAug=;
        b=jZ7a8oFyUCEhBD/VYSGnvEywFuGPvXH9CkIQCaZnzRa10FvuqTYPkuwk4Lr3soy+Qw
         cS/D0EwhBBUqMR5QQKaqfmx4m0kWRk3oABnWGNXyLHRvDSWrt6ukZY0NkqUKmJmmX/nw
         Yl7pcDjR/CT5ywrNBOUcy952x1dJUkuMXWe451YbNlJcdFDdyzVg+Cy3z1JF9t0oRBHq
         awtSzBNcnJ14K79hYFeYNS5m6Z28nX0Xbb17AT9fiVojefU056TtrNFkVhkFdedrpvvH
         6wGlbtTUhiHKJSkIX7vueG8HW6++JWhTTUjetYyB2LrjYa1dhlrR1NByhkAXSKd4Z+sY
         JseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682846538; x=1685438538;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XYiqBkbxAPVH0i8/+HRFP2RyVqV+Ef0zJV3FNvWAug=;
        b=gRCnPhr0i6KRb6myf6w9FhKJ9HRYHhvEsJPqR7e2mvJxkl38eoZGC5MrZVYD3zE4C7
         D+v05R9BiNlj+fGBPX4rTiFPN5PUdzi0dU+zwfF5zMCYlrPznJBIGuhB2MZiWytFF9qN
         TQ4stoX+YbgWGCFMHo+u396h/wUiFLL3KGXnjQtOnn+hzDNNUzWhgxAgvqGl+C870z2h
         BFqZumItLkHDBQbPbibmSyRkOgm3lKcb6vE7nS/i0oM4ogAbhMfEMGbN6ApuwpA0r0K6
         vHpGK3mCk1pRTU1L7E31S4oVqwhXXDUCCBlLGe18rQmb+TEKaroqBevG/kdddmZ0qY1f
         zOAw==
X-Gm-Message-State: AC+VfDzYgH6HEi3Lpn8SsuzxxIUJkEm9CSPfgpAWtuEeaQk4t0mREP6y
        o2d6YfyUH41oACb5NNybra1Utg==
X-Google-Smtp-Source: ACHHUZ7ucxXpCoxlsl8Xi/raDdSh8iRbO7nc1MRAHlpM1B6zhSYps+j7m4I3APPsFeVbaBj0fqnijA==
X-Received: by 2002:a19:7003:0:b0:4ef:f017:e52 with SMTP id h3-20020a197003000000b004eff0170e52mr2741998lfc.5.1682846538033;
        Sun, 30 Apr 2023 02:22:18 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004ec62d9a7f9sm4077327lft.62.2023.04.30.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 02:22:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] Fix up Nokia 770 regression
Date:   Sun, 30 Apr 2023 11:22:15 +0200
Message-Id: <20230430-nokia770-regression-v1-0-97704e36b094@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEczTmQC/x2N0QrCMAxFf2Xk2UDsJmX+iviQ1rgFsZNEZDD27
 2t9PJx7uBu4mIrDtdvA5KeuS6lwPnWQZy6ToD4qQ6DQ09ATluWlHCOhyWTibY8hXZjiMEbJI9Q
 ysQsm45Ln1r7Zv2JNfEyeuv7vbvd9PwB3HfOZfgAAAA==
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to use dynamic GPIO base allocation in the
OMAP GPIO driver caused a regression in some OMAP1 boards.
This series fixes up the Nokia 770 board from 2005:
https://en.wikipedia.org/wiki/Nokia_770_Internet_Tablet

I don't know how urgent the fix is, you decide. For me,
it is fair if fringe systems get fixed in due time, as
they are hardly anyones main development laptop.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (4):
      Input/ARM: ads7846: Get pendown IRQ from descriptors
      fbdev/ARM: Fix up LCD MIPID GPIO usage
      ARM/mmc: Convert old mmci-omap to GPIO descriptors
      ARM: omap1: Fix up the Nokia 770 board device IRQs

 arch/arm/mach-omap1/board-nokia770.c    | 136 ++++++++++++++++++--------------
 arch/arm/mach-omap1/board-sx1-mmc.c     |   1 -
 arch/arm/mach-omap2/board-n8x0.c        |  85 ++++++--------------
 arch/arm/mach-pxa/spitz.c               |  11 ++-
 arch/mips/alchemy/devboards/db1000.c    |  11 ++-
 drivers/input/touchscreen/ads7846.c     |  32 ++------
 drivers/mmc/host/omap.c                 |  46 ++++++++++-
 drivers/video/fbdev/omap/lcd_mipid.c    |  10 +++
 include/linux/platform_data/lcd-mipid.h |   2 -
 include/linux/platform_data/mmc-omap.h  |   2 -
 include/linux/spi/ads7846.h             |   2 -
 11 files changed, 186 insertions(+), 152 deletions(-)
---
base-commit: 825a0714d2b3883d4f8ff64f6933fb73ee3f1834
change-id: 20230430-nokia770-regression-2b5a07497ec9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

