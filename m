Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E7658E24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiL2O4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiL2O4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:56:17 -0500
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F4A6432
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:56:15 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672325771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bLYw8OpQUwlsZ3K6VZBKjvnvbyH21lb8PABr6jPPy3M=;
        b=A2hSB6FIyTOMx28XeYgGgla6Dba07pxyFDx2kue17026UbQ0iHegnJXkQG0f+3LEVBrsBN
        zUFYW55gUpIjFLCIjVZdHj6jKjXWbVfrBgfvEsAB6sdBkVvs++EasCvZcgBFtcnRgSsb84
        r3Dq6xZ2TOUDnA9wVujkgLabLPfTjng=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH V4 0/3] Make the irqchip immutable
Date:   Thu, 29 Dec 2022 22:55:42 +0800
Message-Id: <20221229145545.14055-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Kernel warns about mutable irq_chips:
    "not an immutable chip, please consider fixing!"

Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
new helper functions, and call the appropriate gpiolib functions.

v2 changes:
Split the patch by each driver. and other comment by baolin in[1]

v3 changes:
Fix cocci warnings test by lkp[2].

v4 changes:
Change the irq name.
Keep the same coding style by using offset for irqd_to_hwirq(data)
Add Reviewed-by tag.

[1]:https://lore.kernel.org/all/97e244d4-6b5c-31c9-7329-b8deef615645@linux.alibaba.com/
[2]:https://lore.kernel.org/all/202212240406.9Nm190P8-lkp@intel.com/

Cixi Geng (3):
  gpio: eic-sprd: Make the irqchip immutable
  gpio: gpio-pmic-eic-sprd: Make the irqchip immutable
  gpio: gpio-sprd: Make the irqchip immutable

 drivers/gpio/gpio-eic-sprd.c      | 23 ++++++++++++++---------
 drivers/gpio/gpio-pmic-eic-sprd.c | 29 ++++++++++++++++++-----------
 drivers/gpio/gpio-sprd.c          |  9 ++++++---
 3 files changed, 38 insertions(+), 23 deletions(-)


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.34.1

