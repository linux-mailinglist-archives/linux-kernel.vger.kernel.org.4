Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C650568F348
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjBHQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjBHQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:37:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6081F4DE3B;
        Wed,  8 Feb 2023 08:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A4FAB81ECB;
        Wed,  8 Feb 2023 16:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4EEC433D2;
        Wed,  8 Feb 2023 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874221;
        bh=QxhX5lLvgYPzFF0gkNix/4c6UNPlcFF+jz/Cbuqdeb0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ok3+MVCJxJDFrEfgfFitAq+yaOGfIvFkpcdsaUDsQbKRLDY8UIG1nmubyI8BPuUqH
         TFM5nfUabmhbBsMNErps7fA8P/ZmJNUQoDoAG6e/rhUv5j2glgxse0f5UzeQuslaGn
         EHheEeJmqd2aQpN5ZZwFHs3SCUA1OGHYvFtAiru0qJ5GIZX9XkmC6GBHvYt0TnYVkA
         ys7ac5XxFwaQP800T2tG7Qo9wS7vcP57KWQSrBc5K7ajEIk4ZOHQSpnWS9/QodBjG9
         Y5aomm9qKndUF6n9YXCxmm6SRXOE86O3qP9fDoUbr38nTmu/UcSbqQrCjc51ptJ0VT
         lYispV5z5UHdA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: int3472/discrete: add LEDS_CLASS dependency
Date:   Wed,  8 Feb 2023 17:36:52 +0100
Message-Id: <20230208163658.2129009-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
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

int3472 now fails to link when the LED support is disabled:

x86_64-linux-ld: drivers/platform/x86/intel/int3472/led.o: in function `skl_int3472_register_pled':
led.c:(.text+0xf4): undefined reference to `led_classdev_register_ext'
x86_64-linux-ld: led.c:(.text+0x131): undefined reference to `led_add_lookup'
x86_64-linux-ld: drivers/platform/x86/intel/int3472/led.o: in function `skl_int3472_unregister_pled':
led.c:(.text+0x16b): undefined reference to `led_remove_lookup'
x86_64-linux-ld: led.c:(.text+0x177): undefined reference to `led_classdev_unregister'

Add an explicit Kconfig dependency.

Fixes: 5ae20a8050d0 ("platform/x86: int3472/discrete: Create a LED class device for the privacy LED")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/int3472/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/int3472/Kconfig b/drivers/platform/x86/intel/int3472/Kconfig
index 62e5d4cf9ee5..17ae997f93ea 100644
--- a/drivers/platform/x86/intel/int3472/Kconfig
+++ b/drivers/platform/x86/intel/int3472/Kconfig
@@ -4,6 +4,7 @@ config INTEL_SKL_INT3472
 	depends on COMMON_CLK
 	depends on I2C
 	depends on GPIOLIB
+	depends on LEDS_CLASS
 	depends on REGULATOR
 	select MFD_CORE
 	select REGMAP_I2C
-- 
2.39.1

