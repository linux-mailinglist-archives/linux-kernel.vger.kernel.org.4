Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8838664DF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLOQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiLOQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:57:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCB1F2DA;
        Thu, 15 Dec 2022 08:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 750B7B81BA1;
        Thu, 15 Dec 2022 16:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04BEC433D2;
        Thu, 15 Dec 2022 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123452;
        bh=oxPz7HtXrfByGYf3eU7B6+A8T/7fxcrvKYYneerUSm4=;
        h=From:To:Cc:Subject:Date:From;
        b=givVkMtFWaotvmJ1+XDJbSdN2Na3UB6kWl4YGwo8W6P71kfN/7Ea8/LI8qyhouhMp
         diMEiY+Z0QzZdDcMgz1eyM/A6y3hbTxmiI3CHqr+aTpeuZ0fKIqAy3mfYr9LMFGjJA
         8AXyX97+eKRCCJlIqXv7XBu4AHz+oK1oL64lQ/rmEjr9SXjxPVFoF0IUt8S9PB3gc5
         8rT1oo0pvJ7fZf5qeKtp296FnPq6XMINzi4THJkiO008w/KB40nBRaLXBR+fwtWug9
         L2wFt7duf9lvdAfk3XJqX2KcHh9SawDeGTLiCT8tpV5m3jfGXQgQnKPvm1/kfkS/hj
         I4aSs8GaOxQ4g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: fotg210: fix OTG-only build
Date:   Thu, 15 Dec 2022 17:57:20 +0100
Message-Id: <20221215165728.2062984-1-arnd@kernel.org>
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

The fotg210 module combines the HCD and OTG drivers, which then
fails to build when only the USB gadget support is enabled
in the kernel but host support is not:

aarch64-linux-ld: drivers/usb/fotg210/fotg210-core.o: in function `fotg210_init':
fotg210-core.c:(.init.text+0xc): undefined reference to `usb_disabled'

Move the check for usb_disabled() after the check for the HCD module,
and let the OTG driver still be probed in this configuration.

A nicer approach might be to have the common portion built as a
library module, with the two platform other files registering
their own platform_driver instances separately.

Fixes: ddacd6ef44ca ("usb: fotg210: Fix Kconfig for USB host modules")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/fotg210/fotg210-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 8a54edf921ac..ee740a6da463 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -144,10 +144,7 @@ static struct platform_driver fotg210_driver = {
 
 static int __init fotg210_init(void)
 {
-	if (usb_disabled())
-		return -ENODEV;
-
-	if (IS_ENABLED(CONFIG_USB_FOTG210_HCD))
+	if (IS_ENABLED(CONFIG_USB_FOTG210_HCD) && !usb_disabled())
 		fotg210_hcd_init();
 	return platform_driver_register(&fotg210_driver);
 }
-- 
2.35.1

