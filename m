Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31C65EDDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAENuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjAENty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73545E665;
        Thu,  5 Jan 2023 05:48:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F05561AB2;
        Thu,  5 Jan 2023 13:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9444AC433F0;
        Thu,  5 Jan 2023 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926469;
        bh=d0VrXYd1VyYVae2y2CAy3hUeqsRl1cgMCNli4yO+pUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQuGSNp/u2tEo+5T1yDVTtDX4qUoeT9odKXq04i0UiXXPygKlF3dYc6nF52cQ48Ui
         1RYy6HGwyQkX9x8aYtA4C0bU9X6dpGGS0aGt63yOQdQGH1Edsn8U4MP8qKvloeGr6c
         HIunvU2oa6PkEoPIK+w/fOI8HnDcqM+j2EGLOZJ5wcIaELEPDpI2wyLcInGmjFZXgG
         G0oyEBQf3j2DhwqwyX1bRSjBH+Pjlbo9PfW0bBNAoWwIckxGmOMxiVuKPRyXYB2f1B
         0MIIBuEn5jnjnzhhVO+kyti45FYgdM30mZNuNdi/HAcj4kmMqDD1rt1LnjNnUNpsZj
         Mh3okR/KgYpwg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 25/27] usb: remove ohci-tmio driver
Date:   Thu,  5 Jan 2023 14:46:20 +0100
Message-Id: <20230105134622.254560-26-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
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

The TMIO MFD driver is getting removed, so its OHCI portion is not
used any more either.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ohci-hcd.c  |  18 --
 drivers/usb/host/ohci-tmio.c | 364 -----------------------------------
 2 files changed, 382 deletions(-)
 delete mode 100644 drivers/usb/host/ohci-tmio.c

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 0457dd9f6c19..4f9982ecfb58 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1264,11 +1264,6 @@ MODULE_LICENSE ("GPL");
 #define SM501_OHCI_DRIVER	ohci_hcd_sm501_driver
 #endif
 
-#ifdef CONFIG_MFD_TC6393XB
-#include "ohci-tmio.c"
-#define TMIO_OHCI_DRIVER	ohci_hcd_tmio_driver
-#endif
-
 static int __init ohci_hcd_mod_init(void)
 {
 	int retval = 0;
@@ -1306,19 +1301,9 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_sm501;
 #endif
 
-#ifdef TMIO_OHCI_DRIVER
-	retval = platform_driver_register(&TMIO_OHCI_DRIVER);
-	if (retval < 0)
-		goto error_tmio;
-#endif
-
 	return retval;
 
 	/* Error path */
-#ifdef TMIO_OHCI_DRIVER
-	platform_driver_unregister(&TMIO_OHCI_DRIVER);
- error_tmio:
-#endif
 #ifdef SM501_OHCI_DRIVER
 	platform_driver_unregister(&SM501_OHCI_DRIVER);
  error_sm501:
@@ -1345,9 +1330,6 @@ module_init(ohci_hcd_mod_init);
 
 static void __exit ohci_hcd_mod_exit(void)
 {
-#ifdef TMIO_OHCI_DRIVER
-	platform_driver_unregister(&TMIO_OHCI_DRIVER);
-#endif
 #ifdef SM501_OHCI_DRIVER
 	platform_driver_unregister(&SM501_OHCI_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
deleted file mode 100644
index 49539b9f0e94..000000000000
-- 
2.39.0

