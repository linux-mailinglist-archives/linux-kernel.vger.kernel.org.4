Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A670588B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEPURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEPUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862A1FD2;
        Tue, 16 May 2023 13:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3536063D91;
        Tue, 16 May 2023 20:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D28C433D2;
        Tue, 16 May 2023 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268208;
        bh=nwuUIGOWUcyru2cJZhxAASyVX+0szuVB4QpiMMyDwy0=;
        h=From:To:Cc:Subject:Date:From;
        b=aiuPGr37GHn7v7lQutPMbULOj5wIlEdPI/UZl8dkl0MxZKN8/08dyvpp1h4IZMHID
         s14pxVMJgYPDaOFhRuy/VVsvFCAGQcyaKKvOXgL8RyMLwksksgt3sM7aZX6I8Cuoj+
         4qqk7bwh2CzoptzhNEfaRegvK6dz/ZF/b32Tq2xDQ9xkFQPND7AQNpXLWP9Jj2DD9k
         8g/E0rac5i+HQZcbpDaZTWxyqcPD0zHO/9llCY9+D37Aoj5QHFsGfJU3wwILvkZrEp
         9pQVqdqTSWB7+cB+V8nGukbfGSZH6rCs8wLAnVwysMQBA2EkRJXw/JBrSG9yGApKjU
         wRc2+mcNf0rYw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: sa1100: include <mach/generic.h>
Date:   Tue, 16 May 2023 22:16:37 +0200
Message-Id: <20230516201642.557733-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

sa1100_init_gpio() is declared in a machine specific header so it
can be called from platform code, but the definition is in the device
driver, which causes a warning:

drivers/gpio/gpio-sa1100.c:310:13: error: no previous prototype for 'sa1100_init_gpio' [-Werror=missing-prototypes]

It's already possible to include mach/generic.h from drivers, so add
this one here as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-sa1100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 342a59ea489a..3b1cc8462fcb 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -13,6 +13,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/irqs.h>
+#include <mach/generic.h>
 
 struct sa1100_gpio_chip {
 	struct gpio_chip chip;
-- 
2.39.2

