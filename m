Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846B2657671
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiL1Mcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiL1MZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:25:02 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB42BA;
        Wed, 28 Dec 2022 04:25:00 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672230298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMV4Qv2vawvIPldNlgCxLwC6ooI0ZTG3WDHvdQQQ+So=;
        b=eWtODONXkCdzYOiH9EFWtX5QkId0udUHns9htOGytFKvpZjydl+FDR/QIr+WRKwGZqx1lt
        eFTU6cYt72pKUGbu/xwNraGUsP1ZjhZRe7TATXNu+bTQTMujzrL5MYrMBWzlNhbctAhvum
        wUFotRJlONem/dDVjh95TYV0XiIIOis=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH V3 0/3] Make the irqchip immutable
Date:   Wed, 28 Dec 2022 20:24:39 +0800
Message-Id: <20221228122442.392504-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
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
split the patch by each driver. and other comment by baolin in[1]

v3 changes:
fix cocci warnings test by lkp[2].

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

