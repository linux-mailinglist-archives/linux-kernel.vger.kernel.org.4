Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2266E43F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjAQQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjAQQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D54391D;
        Tue, 17 Jan 2023 08:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6AC614E2;
        Tue, 17 Jan 2023 16:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C81C433D2;
        Tue, 17 Jan 2023 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974735;
        bh=xnRyzXW91e2r6suRzGxVFkiG622vIDzIB8fw1t4QyPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=q3PWjkxKD6ijz8S4Vw7qAo20AF6nDHny8xZF2t4X7TEy9S4061CByav8X6uU4K+lF
         +bd07EpXSAz4pDB4U3lOx1V47s8ZONryHeBebaojMs3/nGd1ovMTtE7sTqsRDHwwy/
         8/DXhUJBYQgSBy4rKjWipOVoZaKw7oXCOAHOUXyB5IuSCOMgD4ErAvejPaZTBuj5yN
         gXNd77zP4pNnYD6iG7BmrlTj1AfDA8qNMK1EULLPvoA6ELc3WNW3szwyBDo5GL2/IM
         K6y3+onEIMAik9UpiILbfFIHOyXQlsQuvTbriQ71tXQwE9OWskPcMfSmFpFXqpQMtA
         kAKe/ox8cvmtA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: stkwebcam: add USB dependency
Date:   Tue, 17 Jan 2023 17:58:42 +0100
Message-Id: <20230117165851.2300111-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Before the move, this driver had implicit dependencies on both
CONFIG_USB and MEDIA_SUPPORT, which can be =m even in combination
with CONFIG_MEDIA_USB_SUPPORT=y, so without the dependency we
get a link failure when USB is a loadable module but stkwebcam
is built-in:

arm-linux-gnueabi-ld: drivers/staging/media/deprecated/stkwebcam/stk-webcam.o: in function `stk_camera_probe':
stk-webcam.c:(.text+0xcbc): undefined reference to `usb_get_dev'
arm-linux-gnueabi-ld: stk-webcam.c:(.text+0xccc): undefined reference to `usb_get_intf'
arm-linux-gnueabi-ld: stk-webcam.c:(.text+0xd68): undefined reference to `usb_put_intf'
arm-linux-gnueabi-ld: stk-webcam.c:(.text+0xd70): undefined reference to `usb_put_dev'
arm-linux-gnueabi-ld: drivers/staging/media/deprecated/stkwebcam/stk-webcam.o: in function `stk_prepare_iso':
stk-webcam.c:(.text+0xfcc): undefined reference to `usb_free_urb'
arm-linux-gnueabi-ld: stk-webcam.c:(.text+0x1010): undefined reference to `usb_alloc_urb'
arm-linux-gnueabi-ld: stk-webcam.c:(.text+0x10d8): undefined reference to `usb_kill_urb'

Add back the original dependency.

Fixes: 1943fb1e50d1 ("media: staging/media: add a STAGING_MEDIA_DEPRECATED option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/media/deprecated/stkwebcam/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/deprecated/stkwebcam/Kconfig b/drivers/staging/media/deprecated/stkwebcam/Kconfig
index 7234498e634a..e4ebee3c628a 100644
--- a/drivers/staging/media/deprecated/stkwebcam/Kconfig
+++ b/drivers/staging/media/deprecated/stkwebcam/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_STKWEBCAM
 	tristate "USB Syntek DC1125 Camera support (DEPRECATED)"
 	depends on VIDEO_DEV
 	depends on MEDIA_USB_SUPPORT && MEDIA_CAMERA_SUPPORT
+	depends on USB && MEDIA_SUPPORT
 	help
 	  Say Y here if you want to use this type of camera.
 	  Supported devices are typically found in some Asus laptops,
-- 
2.39.0

