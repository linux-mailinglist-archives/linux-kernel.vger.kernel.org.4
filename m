Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA16658858
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiL2BZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2BY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:24:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7213F80;
        Wed, 28 Dec 2022 17:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=N9E7L6Ho6kWI1xmI1za5Zz5R3ypJix8rKxwEiL8bYhE=; b=J5IShLVSPeHxk+qV8WlMFSooAJ
        lefuoIbCCCcCqZPrOKlHoWAuzQK9GHlg5SitDrLB2RT8DbL39r0hdNe7dBISsG7jBNZhbGasEygUg
        Ww+0TGrPE9nZhe4B2p4huUTyZgGSrRIZHZ8aTiaXWzFTyHqPJAy7LJ4aV/t+WrmLqFmfFOPRFxFq7
        K/8q/8p6xypYZcsKDlKSAbKh6u4RTKYda0j2QP2v4PgF0gUWLHS0eWIXhM07BX2JOGM2UEKAjD+X7
        30JVeW1nPtSYCU3MxQvJ8K/37N2lN2i1IYQMKxGfxMQN5A1d/Zmb1QfM0OVreocQ7kysimDGPyT7A
        5aI8Dyiw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAhfJ-009YGt-AW; Thu, 29 Dec 2022 01:25:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] pinctrl: nomadik: fix build when DEBUG_FS is not set
Date:   Wed, 28 Dec 2022 17:24:45 -0800
Message-Id: <20221229012445.16169-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build when DEBUG_FS is not set/enabled by moving the #include
directive.

../drivers/pinctrl/nomadik/pinctrl-nomadik.c: In function 'nmk_gpio_irq_print_chip':
../drivers/pinctrl/nomadik/pinctrl-nomadik.c:1084:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
 1084 |         seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,

Fixes: e5530adc17a7 ("pinctrl: Clean up headers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -17,6 +17,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
@@ -907,8 +908,6 @@ static int nmk_gpio_get_mode(struct nmk_
 	return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0);
 }
 
-#include <linux/seq_file.h>
-
 static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	struct pinctrl_dev *pctldev, struct gpio_chip *chip,
 	unsigned offset, unsigned gpio)
