Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22865626A19
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKLPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5592FAFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id t1so4521320wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0vWSKW+cqe7c68hAhigp7JPoCf9OaO1JjK7632mUgk=;
        b=fNnUGCX4WC0Ll7lgheKpYU/zQDvVa4tS/EXYHg3tZjtvFy8sq/t8au5yvQUhK0uZQA
         wormq2fWEZKUiXYSHV8Qh/RpnLoBA4fiB62QQPBag6AqVnnolMabjDpiRfsfS9DJDBW5
         hOegKWme1/7S7aFIDCzEWrr5a90K6ZYXz4I3szy+cE7r5tPcYW9ElC3xUegL3wyF97Zc
         cHDoDZ0I7Y+iYFuApmy88LgEFtrFRHvaMNuFMT4QRfDOWGVFwFoTANXmhP5OW9N2XvrD
         Vs8JtKR9pQPg/VmnF6kenTpsZvRwc2uUgYBXK7nMsOx9wFwkxLBUvdvhv9sQC0xsKBfV
         e+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0vWSKW+cqe7c68hAhigp7JPoCf9OaO1JjK7632mUgk=;
        b=lhmFS13rFFdA4jqSZ3GWOIsGvBGPFv6KAHUI00f71Ddb9XzvRtnopg637gGsvDdRWT
         TOJ1C/dE+6CoyI2QiPb5oAtE8MAgwmy/Q2KpNDPLNgsGorCsiyYsGAwMpGnHlv7frq7w
         6YYMQ49F/OB08t479w/GmJ3ve4Ij1oiEuWjVYqLIdmi10cZEXC8TlK633wS67W4Gtp/P
         oJDrzalrD7ZKJ2qt9IDZMkA8pf0C9y2z0205yfIXJkHuuJCrECUqmi62HGgfWB4H3Bcu
         AzpOT9O3f5916l6rbygMCtEQ0IaDs+l6Inz0J4Kde5IRa8hmmlAUFd79ODRaIgJIbAax
         7qqw==
X-Gm-Message-State: ANoB5pl2Wy5ta+oh2gMkjX63rFzHYZE/dM0F3eJq1RLMsx8DdyDh7aw2
        98yj2TRqzKTJNo8EQw7/i2s=
X-Google-Smtp-Source: AA0mqf5MMX7kck9HUoR0dZWwcAGhSqrFf3yKN/iccC8WXnknXokA3R3k0NO+fJ+TUkbIGOimO/oRxg==
X-Received: by 2002:a05:600c:4408:b0:3cf:89c3:5d0d with SMTP id u8-20020a05600c440800b003cf89c35d0dmr4174560wmn.197.1668266376409;
        Sat, 12 Nov 2022 07:19:36 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4fc5000000b0022cd96b3ba6sm5408315wrw.90.2022.11.12.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:36 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 00/18] mfd: Clean up deprecated regmap-irq functionality
Date:   Sat, 12 Nov 2022 15:18:17 +0000
Message-Id: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Here are some trivial updates to replace old, deprecated regmap-irq APIs
with the new equivalents. There should be no functional changes, but none
of the patches have been tested (besides compile testing).

One issue with WCD934x - after applying the patch, a bug in regmap-irq
will cause a null pointer deref when setting the IRQ type, but a fix is
already in the regmap tree.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?id=84498d1fb35de6ab71bdfdb6270a464fb4a0951b

Aidan MacDonald (18):
  mfd: 88pm800: Replace irqchip mask_invert with unmask_base
  mfd: atc260x: Replace irqchip mask_invert with unmask_base
  mfd: axp20x: Replace irqchip mask_invert with unmask_base
  mfd: gateworks-gsc: Replace irqchip mask_invert with unmask_base
  mfd: max14577: Replace irqchip mask_invert with unmask_base
  mfd: max77650: Remove useless type_invert flag
  mfd: max77693: Replace irqchip mask_invert with unmask_base
  mfd: max77843: Drop useless mask_invert flag on irqchip
  mfd: rn5t618: Replace irqchip mask_invert with unmask_base
  mfd: rohm-bd71828: Replace irqchip mask_invert with unmask_base
  mfd: rohm-bd718x7: Drop useless mask_invert flag on irqchip
  mfd: rt5033: Replace irqchip mask_invert with unmask_base
  mfd: rt5120: Replace irqchip mask_invert with unmask_base
  mfd: sprd-sc27xx-spi: Replace irqchip mask_invert with unmask_base
  mfd: stpmic1: Fix swapped mask/unmask in irq chip
  mfd: sun4i-gpadc: Replace irqchip mask_invert with unmask_base
  mfd: tps65090: Replace irqchip mask_invert with unmask_base
  mfd: wcd934x: Convert irq chip to config regs

 drivers/mfd/88pm800.c         |  3 +--
 drivers/mfd/atc260x-core.c    |  6 ++----
 drivers/mfd/axp20x.c          | 21 +++++++--------------
 drivers/mfd/gateworks-gsc.c   |  3 +--
 drivers/mfd/max14577.c        |  7 ++-----
 drivers/mfd/max77650.c        |  1 -
 drivers/mfd/max77693.c        |  6 +-----
 drivers/mfd/max77843.c        |  1 -
 drivers/mfd/rn5t618.c         |  3 +--
 drivers/mfd/rohm-bd71828.c    |  6 ++----
 drivers/mfd/rohm-bd718x7.c    |  1 -
 drivers/mfd/rt5033.c          |  3 +--
 drivers/mfd/rt5120.c          |  3 +--
 drivers/mfd/sprd-sc27xx-spi.c |  3 +--
 drivers/mfd/stpmic1.c         |  5 +++--
 drivers/mfd/sun4i-gpadc.c     |  3 +--
 drivers/mfd/tps65090.c        |  3 +--
 drivers/mfd/wcd934x.c         | 11 ++++++++---
 18 files changed, 33 insertions(+), 56 deletions(-)

-- 
2.38.1

