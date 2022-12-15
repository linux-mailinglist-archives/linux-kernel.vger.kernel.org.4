Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F064DF29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLORBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLORBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:01:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C18B1A3B4;
        Thu, 15 Dec 2022 09:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B6D61E50;
        Thu, 15 Dec 2022 17:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B9FC433EF;
        Thu, 15 Dec 2022 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123668;
        bh=RRg69Zv0fSJqhIaCebQ4VqYqr3NypZRiXKo9W0an9KU=;
        h=From:To:Cc:Subject:Date:From;
        b=aMexPlRE2sEHLa6io+/F+BvdjIGtwzxUXvrY9wAijgDUtCV1c7oeEy6dWpRanyWps
         QkC1mFu6kXlyI8b7ybHgoHccyCBAN+oqCWUMqfPem6gNnGdTNYGgmTYPZyMq0h6BHi
         Pjdx4Fjspp38KAz2bmHDX4VlUwzEg0wL2KwbQ6f3lkyDsBhvDYShsjIoR00o8Jft4t
         DbrEe60YqtI38eoVmlcWcTc51O4F4pMeOfLmsEm6REdSIWMsMKq1Z71K2wuuH3XBP7
         aSRbIskKkoRe74faCw1fv57PC0mBu6B5Tb4uJGCnlidrjmhxfITVFc4pBKTn5TcxC0
         Mhst/3spDXDAQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: nomadik: include linux/seq_file.h
Date:   Thu, 15 Dec 2022 18:00:57 +0100
Message-Id: <20221215170103.2349282-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

In some randconfig builds, the missing #include causes a
build failure:

drivers/pinctrl/nomadik/pinctrl-nomadik.c: In function 'nmk_gpio_irq_print_chip':
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1084:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
 1084 |         seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,
      |         ^~~~~~~~~~
      |         bstr_printf

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f7d02513d8cc..1d8e36c2785d 100644
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
-- 
2.35.1

