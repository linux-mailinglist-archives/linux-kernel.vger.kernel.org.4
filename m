Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFE697C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjBOMrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjBOMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:47:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F26037F20;
        Wed, 15 Feb 2023 04:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB6E761BAF;
        Wed, 15 Feb 2023 12:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D27C433EF;
        Wed, 15 Feb 2023 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676465237;
        bh=jFdktRMcQDcTG0Z5a7yd0aX1ExmXHVV5grkvalZHdKw=;
        h=From:To:Cc:Subject:Date:From;
        b=BBLKAnktoCel8IkPRAHwzDdPDxfvGd1AM29/8NXl6zxgQkihTmKge6VlFT8OPrH14
         w665bc52qNRgrUs7FCETQHydbUeq1Vq9VjjA1168v94AiP8Ry4igkfp1oxreckLDMt
         iMFpge9/ZY4O8RFt3fzpojCWiNjK1nKDl5KK91odZMBU7XHxeJvPW7LYKcjBx4Yt9P
         2iwQJgOlx1kb378LhBSVrML3UlHlqoBksrZFgOMDpFHvVWY5wYuFkI/YEMGrLSB1rI
         cBBePrxUp3YiDc0mqLe9Z4lgZ3js/JpgsrPsCc/QID7pxd8G8qrh0vDocyfjzyZ+UJ
         tkzatn+cWcjqw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Asmaa Mnebhi <asmaa@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: odroid-go-ultra: fix I2C dependency
Date:   Wed, 15 Feb 2023 13:47:08 +0100
Message-Id: <20230215124714.2872813-1-arnd@kernel.org>
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

Since this driver can only be built-in, it fails to link when
the I2C layer is in a loadable module:

x86_64-linux-ld: drivers/power/reset/odroid-go-ultra-poweroff.o: in function `odroid_go_ultra_poweroff_get_pmic_device':
odroid-go-ultra-poweroff.c:(.text+0x30): undefined reference to `i2c_find_device_by_fwnode'

Tighten the dependency to only allow enabling
POWER_RESET_ODROID_GO_ULTRA_POWEROFF is I2C is built-in as well.

Fixes: cec3b46b8bda ("power: reset: add Odroid Go Ultra poweroff driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 7059bd1f2ee7..8c87eeda0fec 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -144,7 +144,7 @@ config POWER_RESET_OCELOT_RESET
 config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
 	bool "Odroid Go Ultra power-off driver"
 	depends on ARCH_MESON || COMPILE_TEST
-	depends on I2C && OF
+	depends on I2C=y && OF
 	help
 	  This driver supports Power off for Odroid Go Ultra device.
 
-- 
2.39.1

