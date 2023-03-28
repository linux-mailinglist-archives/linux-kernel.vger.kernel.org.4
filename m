Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599B16CC04F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjC1NMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjC1NMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:12:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E3D10C1;
        Tue, 28 Mar 2023 06:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E3A4B81A99;
        Tue, 28 Mar 2023 13:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C70C433EF;
        Tue, 28 Mar 2023 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680009148;
        bh=Du1SA+Ca2Lsfpl4sOSs73nHArQ6vkFrYJJQP9AjWM1c=;
        h=From:To:Cc:Subject:Date:From;
        b=pGYvTYLzCNEECIR2ZT32e21q5xNQclQ69wKlAuBJ1WDQPDMv/Wvf7DhMk9OMkzwzv
         DF+Ig1ULsaHKZBBqysbrjnIlehdLE54ymwvNE6UppTEQ7QLfqFkw65fF832jF+dH8Y
         XWJxL40MS035F0t6DZh1sGjL+fdL0w0YTwGJKIHsoSfVwOe5v7hw7GpRUBzuXnZPjT
         qKVQ2nhMf8kr0m22miASPjaG6i5DC7YnJ91YO86zh/LRz1RwXkBb3PEETn8Wewrotr
         jbR3+xAo3MVK9Zh0VkttcndW5DutLNg5RadWXCcG0j++Jxmlklwx0LfC4XITUlRlYS
         7gmtv0ipl8H2g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alice Chen <alice_chen@richtek.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: rgb: mt6370: fix CONFIG_LINEAR_RANGES select
Date:   Tue, 28 Mar 2023 15:11:56 +0200
Message-Id: <20230328131222.1390091-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_LINEAR_RANGE does not exist, but selecting is silently ignored.

ERROR: modpost: "linear_range_get_selector_within" [drivers/leds/rgb/leds-mt6370-rgb.ko] undefined!

Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/rgb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 7d86bb26c54b..360c8679c6e2 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -29,7 +29,7 @@ config LEDS_QCOM_LPG
 config LEDS_MT6370_RGB
 	tristate "LED Support for MediaTek MT6370 PMIC"
 	depends on MFD_MT6370
-	select LINEAR_RANGE
+	select LINEAR_RANGES
 	help
 	  Say Y here to enable support for MT6370_RGB LED device.
 	  In MT6370, there are four channel current-sink LED drivers that
-- 
2.39.2

