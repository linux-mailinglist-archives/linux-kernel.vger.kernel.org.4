Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257866A3F89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjB0KhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjB0KhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:37:07 -0500
X-Greylist: delayed 609 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 02:37:05 PST
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA0C14A;
        Mon, 27 Feb 2023 02:37:05 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 31RAQYxl018695-31RAQYxo018695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Feb 2023 18:26:38 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dongliang Mu <dzm91@hust.edu.cn>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: usb: smsusb: fix error handling code in smsusb_init_device
Date:   Mon, 27 Feb 2023 18:24:08 +0800
Message-Id: <20230227102411.3273877-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit 4b208f8b561f moves siano_media_device_register
before smscore_register_device, and adds corresponding error handling
code if smscore_register_device fails. However, it misses the following
error handling code of smsusb_init_device.

Fix this by moving error handling code at the end of smsusb_init_device
and adding a goto statement in the following error handling parts.

Fixes: 4b208f8b561f ("[media] siano: register media controller earlier")
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/media/usb/siano/smsusb.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 6f443c542c6d..07c3dd247e48 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -454,12 +454,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_register_device(&params, &dev->coredev, 0, mdev);
 	if (rc < 0) {
 		pr_err("smscore_register_device(...) failed, rc %d\n", rc);
-		smsusb_term_device(intf);
-#ifdef CONFIG_MEDIA_CONTROLLER_DVB
-		media_device_unregister(mdev);
-#endif
-		kfree(mdev);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	smscore_set_board_id(dev->coredev, board_id);
@@ -476,8 +471,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smsusb_start_streaming(dev);
 	if (rc < 0) {
 		pr_err("smsusb_start_streaming(...) failed\n");
-		smsusb_term_device(intf);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	dev->state = SMSUSB_ACTIVE;
@@ -485,13 +479,20 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_start_device(dev->coredev);
 	if (rc < 0) {
 		pr_err("smscore_start_device(...) failed\n");
-		smsusb_term_device(intf);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	pr_debug("device 0x%p created\n", dev);
 
 	return rc;
+
+err_unregister_device:
+	smsusb_term_device(intf);
+#ifdef CONFIG_MEDIA_CONTROLLER_DVB
+	media_device_unregister(mdev);
+#endif
+	kfree(mdev);
+	return rc;
 }
 
 static int smsusb_probe(struct usb_interface *intf,
-- 
2.39.1

