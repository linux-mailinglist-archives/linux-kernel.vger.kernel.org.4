Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5596A1B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBXLis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:38:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A63864F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:38:44 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so13730230wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpzAS3s+Cknt6SusAxCgxYC801c1KRUgoMVD/9jWeaQ=;
        b=LmvkL2ICUxHCi5JnX6qNtHeCxijsatAjX0YJDWsunnS/ftTbbj5rUec4lgOaXqOG2k
         OpDu5xoXv2edDxi314/dISSVuwVZMfeGKGpURxqFRt3cjr8ppZhSGKglF1ur2WIC1s5/
         stmZRhkTs6gP0ldUe2814bB4iuPrAR1KQRCsKUW+eWXBPMYEmGM2hoJsVVXdij0PgJxD
         8rqa28nLJA5JdrD9i1FHgcr88B3R1vpKiPrszKKKZsKsgQyUVIR5iU5gHY16oGLw/9A2
         5cAG1oYsurtJHLshKAh3wliUMzdVFsAyOPMxdPVQpNaS7TQ8yXQCwHp9WBQBg1xDgtzk
         q0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpzAS3s+Cknt6SusAxCgxYC801c1KRUgoMVD/9jWeaQ=;
        b=WdWehr/a29/YZF6dqCA0tMjJW+5XP8Oa+jXWmEJI1Nl6b7/Kyz5B1x/NxsL15+8sC+
         vJT1gJ8jIAOMY6MFyM0+V/vPCPIV7upFIHdIl1hXCBKiDpyPO+nJkCC6JlIzp7qmHDu9
         i/3ac7fOXe9QYWU2Xm3SKEBQe48jI85RSQZYpzoT3nnp+yDwO4Awqa7ZdyEFPV64Ju4u
         4Q9KLvQUv3VnDKxWCpoIn/6ZPwV+i8z94KLuPNm1fqiTsxlOnIp7revm46Z9ncT1XUwA
         IizYOsB4MUiGe9YQ+3jKzxxjMU+G+lDlEoozr3NxOwF/tDLAP122Gk+TW5KVGgw+MZif
         m+eg==
X-Gm-Message-State: AO0yUKVsW8Uv7VuJnPUgE8Q4dwx5AYF79c6oGqahKDEDYjEu6jvOUGnq
        gcLyHTWhXwcFarsz0Y3oYmWEBw==
X-Google-Smtp-Source: AK7set+ria7amvD5JkJfXPya3WzHNUc0HXURdmyuPFMgJvFkQ3DJiRy+b8Fi+vNUtyDXKbDyj9Qibg==
X-Received: by 2002:a05:6000:c1:b0:2c5:5308:859c with SMTP id q1-20020a05600000c100b002c55308859cmr11994396wrx.18.1677238722449;
        Fri, 24 Feb 2023 03:38:42 -0800 (PST)
Received: from jerome-BL.. (2a02-8440-5241-7427-e801-6f64-356d-2fd7.rev.sfr.net. [2a02:8440:5241:7427:e801:6f64:356d:2fd7])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b002c592535839sm12769679wro.17.2023.02.24.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:38:41 -0800 (PST)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, tony@atomide.com,
        lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org, Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH 0/2] Add support for TI TPS65219 PMIC GPIO interface.
Date:   Fri, 24 Feb 2023 12:38:35 +0100
Message-Id: <20230224113837.874264-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO interface consist in 3 pins:
Two GPIOS are output only: GPO1, GPO2.

GPIO0 is used for multi device support:
- The input-functionality is only used in multi-PMIC configuration
- In single-PMIC, it can be used as an output

The configuration is static and flashed in NVM in factory.
Description tps65219.pdf chapter 7.3.13

Linux must not change MULTI_DEVICE_ENABLE bit at run time.

This was done for test purpose only to check input/output
correct behavior on EVM board (no access to different NVM config).

Tested on k3-am62x-lp-sk board. This board MULTI_DEVICE_ENABLE=0

Despite the register bits are out of order,
driver is remapping in natural order:
GPIO0 is gpiochip line 0
GPO1/2 are gpiochip line 1/2

 Initial version by Jon Cormier on TI Mainline.
 Ported upstream by Jerome Neanne


Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf

Jerome Neanne (2):
  gpio: tps65219: add GPIO support for TPS65219 PMIC
  mfd: tps65219: Add gpio cell instance

 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |  13 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 167 +++++++++++++++++++++++++++++++++++
 drivers/mfd/tps65219.c       |   7 +-
 5 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-tps65219.c

-- 
2.34.1

