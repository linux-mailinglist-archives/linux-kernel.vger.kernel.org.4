Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC76F7EED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjEEIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjEEIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:23:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD1A18146
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:23:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso1656831e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683274984; x=1685866984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnd/xQ9KZ246IQDxJ2NOt5q5tpp1CWxMQbhMQ4P/5po=;
        b=iTkAyCNQZIDmc7TsUIJSK2Z751T4I7mzLgK0CQ4gMufVO4DZ3YIUcqyRAYY6pvbTWj
         zhv08bKk2h3HMZMhokO2mX3ooVPioEum5wcb7WZmIVj6Fjn5rwgHknTUbSXIsUWrn6SF
         c0QoKwwnVoNoSjl7FeewCQLx3tEwn+CozU09keA8foFgOx/WruDRUZyC7Dsr0w4NaFeG
         sFAS/r4ItUvq8jJgN0H5Y3tsHHds4dq1945O4WyF7GPHu0Y6S4R4lqM+6IbI62WI68aa
         BiePUnvCYwvxJ40PA8E4RGNVc8WGFZIky57bNprYuBJVw1XB2sOKGCHdxGIWOH0Hgceh
         +zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683274984; x=1685866984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wnd/xQ9KZ246IQDxJ2NOt5q5tpp1CWxMQbhMQ4P/5po=;
        b=T4UvSzzuwI9m+7QlftuDO+g227nRaTVlLdefyhRlyAUM7smA9CsvY8beCNYU2PzhZA
         kxZaB5+ICtzsL7K1NxxvxhVrU3G94cVgR9IptKFqDeOVa/JoJ+qwR9/7FNHknCh/ep5a
         e+tfKDDYRpcBwnZDZq1v+13AWRPXs7KwHs49w3m+NVWIUJJKsMyoKyBLgG3OWuYZhiSr
         CUCeGXQFCr8QI4DC51MIolT+Z75nibTQtjFzVYbyhwihkCtKtQCPqFnMPKDeHUOniQxa
         wAfFkQBd/VIYTiDMmZlf8p/5to162J0x6nyobWh8rCV4SnFrz8Y+wwOxucMK+wCsJN55
         S7ig==
X-Gm-Message-State: AC+VfDwsSHO9RXcX1FTiDSj4xY/qSdgDCklUi3FU2kc3tVCzan/2ZU28
        4A35mjaofavxgn1ANnpFXtMvoA==
X-Google-Smtp-Source: ACHHUZ72VNoJxBvksLAw/aSFYz4OGaMDpRtLO5cqt4SyXRbTqQwJbV+BjsXJPzKO1UcDj5nh4IOjIg==
X-Received: by 2002:ac2:5990:0:b0:4ed:d5b0:7fd9 with SMTP id w16-20020ac25990000000b004edd5b07fd9mr281906lfn.19.1683274984113;
        Fri, 05 May 2023 01:23:04 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h8-20020ac250c8000000b004d023090504sm200647lfm.84.2023.05.05.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:23:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/3] Fix up Nokia 770 regression
Date:   Fri, 05 May 2023 10:22:59 +0200
Message-Id: <20230430-nokia770-regression-v2-0-984ed3ca5444@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOO8VGQC/32NTQ7CIBBGr9KwdgylKMGV9zBdDHVsJyqYoWk0T
 e8ueACX7/vJW1UmYcrq1KxKaOHMKRYwu0YNE8aRgK+FldGm07bTENOd0TkNQqNQrnsw4YDaWe9
 o8Ko8A2aCIBiHqX6fmGeSWryEbvz+6S594YnznOTzsy9tTf+LlhY0+BJa6o5Be3t+cERJ+ySj6
 rdt+wI3YvGW0AAAAA==
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Changes in v2:
- Thoroughly rewrote the approach taken for the ADS7846 touchscreen
  following Dmitry's ambition to go a step further and take a swnode
  approach to this conversion: I'm fine with that, the patch just
  get a bit bigger.
- Picked up Ulf's ACK on the MMC patch.
- Link to v1: https://lore.kernel.org/r/20230430-nokia770-regression-v1-0-97704e36b094@linaro.org

---
Linus Walleij (3):
      Input: ads7846 - Convert to use software nodes
      ARM/mmc: Convert old mmci-omap to GPIO descriptors
      ARM: omap1: Fix up the Nokia 770 board device IRQs

 arch/arm/mach-omap1/board-nokia770.c    | 198 +++++++++++++++++++-------------
 arch/arm/mach-omap1/board-sx1-mmc.c     |   1 -
 arch/arm/mach-omap2/board-n8x0.c        |  85 +++++---------
 arch/arm/mach-pxa/spitz.c               |  11 +-
 arch/mips/alchemy/devboards/db1000.c    |  11 +-
 drivers/input/touchscreen/ads7846.c     | 101 +++++++---------
 drivers/mmc/host/omap.c                 |  46 +++++++-
 drivers/video/fbdev/omap/lcd_mipid.c    |  10 ++
 include/linux/platform_data/lcd-mipid.h |   2 -
 include/linux/platform_data/mmc-omap.h  |   2 -
 include/linux/spi/ads7846.h             |   2 -
 11 files changed, 260 insertions(+), 209 deletions(-)
---
base-commit: 348551ddaf311c76b01cdcbaf61b6fef06a49144
change-id: 20230430-nokia770-regression-2b5a07497ec9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

