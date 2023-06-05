Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667FF722417
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjFELCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFELCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA6BD;
        Mon,  5 Jun 2023 04:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AA060FC8;
        Mon,  5 Jun 2023 11:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44120C433EF;
        Mon,  5 Jun 2023 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685962927;
        bh=Spag55BNJ6GIbM2EesmCkqQ4wATuyGuMUTAykQx1tJM=;
        h=From:To:Cc:Subject:Date:From;
        b=VF45WZWxdo8SOPaqLG1NLCOEfjtPDck7Bu+LHOSyZ6q09/3w0OgZTlovqc08Pw+vw
         IWwLob5uw8wUR0zoXZpCJCJ1PS5wr2bNanLwEBCKqERqjR4KxSG7uAJMD/760fYcMv
         tYnzPwawCeWF3f7uXrIjfE/lDeayhBDB82mznrKU0vuwFBbQFWmnnXMzcaM+I0wdGg
         51yyDo5L1M8RVgSmAHXUct9mGPJFWYkgpLWLSyittqXqogNGy52myGd34kJNrm1Ojo
         safK9t/bfPLG1WtoikfXuydBMW0BqegsTrxrJQpnW8RXoU17H/1oOSn9sAIYQZ+Wic
         DzbwzxcnjkDVQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Pandith N <pandith.n@intel.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: delay: add OF_GPIO dependency
Date:   Mon,  5 Jun 2023 13:01:56 +0200
Message-Id: <20230605110200.938902-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new driver fails to build when OF_GPIO is disabled:

drivers/gpio/gpio-delay.c: In function 'gpio_delay_of_xlate':
drivers/gpio/gpio-delay.c:79:39: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'

Fixes: cf5dec80c4e23 ("gpio: Add gpio delay driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a1dac1345f60f..006abaedcae82 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1735,6 +1735,7 @@ config GPIO_AGGREGATOR
 
 config GPIO_DELAY
 	tristate "GPIO delay"
+	depends on OF_GPIO
 	help
 	  Say yes here to enable the GPIO delay, which provides a way to
 	  configure platform specific delays for GPIO ramp-up or ramp-down
-- 
2.39.2

