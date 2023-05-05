Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB136F8161
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjEELRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjEELRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:17:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE89ECB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:17:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac80ed7f26so17383421fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683285420; x=1685877420;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fx9c2gfE/OHP7sBTVMsL9k1RmStALes2Mdy1lhribcY=;
        b=Ya9B2laEOQwnbndke0paotuFnskFR1ibXiV2nc0AsSgOpzh5wJCI5y9JvJ3yMC7w22
         KFoBwISJacxh7su/afZzJDnAtlgR25E9qO3pfE8WuT/i58+5gkuPOYy0azncfae5oqTy
         QmKI/vqmYH7uN3T+NxXo+ZLMnQUcVwSN2j0Vx0tSYUA8fitazr6XU/RHd6P+nVpVIYYI
         XFSYv6Ky2qRLWlF2QWExBLlY+Pd7F5hVG5qy6/Io2ujxOoeote7/fbQ/FMPBYUomTANr
         eoSUXCBd1f+rR9p0sBT2B9dYMXx8vbsdfvBZboK5KMrKcCyVUk2ocgfKBNGzv+4jGdNn
         VFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683285420; x=1685877420;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx9c2gfE/OHP7sBTVMsL9k1RmStALes2Mdy1lhribcY=;
        b=H36zL8oL6kMajBDqG1EphWJTrCsB8VIRUwwDIcvhE+erlROz27sbaa0EpC0E6GexJe
         rUr7VQtZPDVAao44VTj/En9X0dY76+dkX0BuxKE4F94LlSTeVnjnud34Fzsnf3vFYKed
         Z3ku+ORHerTRoJIG+USpYXwJRtMDXX4viHuNuVtH7EnD7qBVfPEyAcWeopM538DbqrpV
         O4Cm2QfP1YFqp5QjprdEGgDJTXrA4lKZDT34WdmAdGlGQlYtntX5ND+uQrmRUfk7Tg1I
         6WvBTYN9mlRZa3KJGdyUdkgQXnJB+nOtJ5BzLDoyTHdd6YQAuywhvtDlz6YINGjEOQS0
         I6zw==
X-Gm-Message-State: AC+VfDwvLXKlvF4Wu+PATB2zh/afh2oYAPSbvH34RamBIpz0fii/E5SS
        PY3LyeHQ2iBi1Wx7AExabh9rFQ==
X-Google-Smtp-Source: ACHHUZ5FKrQODDpnLoBig6okuW3UkdQRwonRuYb5f0VYTah57/AGP42MRpKF5kHhSqrWV15gPrTvjQ==
X-Received: by 2002:a19:a403:0:b0:4ed:b85b:ad5c with SMTP id q3-20020a19a403000000b004edb85bad5cmr413024lfc.0.1683285419888;
        Fri, 05 May 2023 04:16:59 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b004edbf013fe7sm251665lft.49.2023.05.05.04.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:16:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/3] Fix up Nokia 770 regression
Date:   Fri, 05 May 2023 13:16:54 +0200
Message-Id: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKblVGQC/42NQQ7CIBBFr2JYi6FAxbryHsYF0LGdqGCGhmia3
 l3ozo1x+f/Mf29mCQghseNmZgQZE8ZQgtpumB9tGIBjXzKTQiqhleAh3tAaIzjBQJDqP5eutcL
 ozoDvWFk6m4A7ssGPdfuwaQKqhyfBFV+r7nwpecQ0RXqv9tzU9rcoN1zwrpQa1N6JTp/uGCzFX
 aSBVWCWf0BkhRw09MrbVutvyLIsH02gpWwVAQAA
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
Changes in v3:
- Fix a compile error in the ADS7846 driver by dropping some
  leftover OF ifdeffery.
- Link to v2: https://lore.kernel.org/r/20230430-nokia770-regression-v2-0-984ed3ca5444@linaro.org

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
 drivers/input/touchscreen/ads7846.c     | 113 +++++++-----------
 drivers/mmc/host/omap.c                 |  46 +++++++-
 drivers/video/fbdev/omap/lcd_mipid.c    |  10 ++
 include/linux/platform_data/lcd-mipid.h |   2 -
 include/linux/platform_data/mmc-omap.h  |   2 -
 include/linux/spi/ads7846.h             |   2 -
 11 files changed, 262 insertions(+), 219 deletions(-)
---
base-commit: 348551ddaf311c76b01cdcbaf61b6fef06a49144
change-id: 20230430-nokia770-regression-2b5a07497ec9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

