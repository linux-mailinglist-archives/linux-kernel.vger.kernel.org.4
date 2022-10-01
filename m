Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB85F1DE3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJAQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJAQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD972260F;
        Sat,  1 Oct 2022 09:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56BCD60C5F;
        Sat,  1 Oct 2022 16:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A82C433C1;
        Sat,  1 Oct 2022 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664643092;
        bh=wmqG3e8DO7Hk5XvhD4YCjgDlD1JFzPPjEgvwPFzy37M=;
        h=From:To:Cc:Subject:Date:From;
        b=07VZiZouEsfwuJAGEa0y/AFnHt60BzrODCRluDso7njDMvf/AmREd5os8rrYui7Kx
         HIEEONFjosZo/6hbIoNbq3eXZS/wI9AQn4bd6u88Ni6HjRXY04LDVCI1dFqCMABL/k
         ezI2oz6prWpwtyRNHERdQ2xNtWYVEDhFiajSm4BQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Juergen Stuber <starblue@users.sourceforge.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] USB: make devnode() callback in usb_class_driver take a const *
Date:   Sat,  1 Oct 2022 18:51:28 +0200
Message-Id: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3228; i=gregkh@linuxfoundation.org; h=from:subject; bh=wmqG3e8DO7Hk5XvhD4YCjgDlD1JFzPPjEgvwPFzy37M=; b=owGbwMvMwCRo6H6F97bub03G02pJDMkWBfx3tXPf9HM2H1j8tXviU4/TamFdvAe12n+u/VHFPznw 4lq1jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIvl0Mc8XTlxk4+gtuUpDuDhVk/n d4r7brTYZ5NvPer99to9y8Smvzq0eZL6wk3qsFAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the changes to the driver core to make more pointers const, the USB
subsystem also needs to be modified to take a const * for the devnode
callback so that the driver core's constant pointer will also be
properly propagated.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>
Cc: Juergen Stuber <starblue@users.sourceforge.net>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/usbhid/hiddev.c     | 2 +-
 drivers/usb/class/usblp.c       | 2 +-
 drivers/usb/misc/iowarrior.c    | 2 +-
 drivers/usb/misc/legousbtower.c | 2 +-
 include/linux/usb.h             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 2fb2991dbe4c..59cf3ddfdf78 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -857,7 +857,7 @@ static const struct file_operations hiddev_fops = {
 	.llseek		= noop_llseek,
 };
 
-static char *hiddev_devnode(struct device *dev, umode_t *mode)
+static char *hiddev_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "usb/%s", dev_name(dev));
 }
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index f27b4aecff3d..5a2e43331064 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1090,7 +1090,7 @@ static const struct file_operations usblp_fops = {
 	.llseek =	noop_llseek,
 };
 
-static char *usblp_devnode(struct device *dev, umode_t *mode)
+static char *usblp_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "usb/%s", dev_name(dev));
 }
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 988a8c02e7e2..f9427a67789c 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -717,7 +717,7 @@ static const struct file_operations iowarrior_fops = {
 	.llseek = noop_llseek,
 };
 
-static char *iowarrior_devnode(struct device *dev, umode_t *mode)
+static char *iowarrior_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "usb/%s", dev_name(dev));
 }
diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index 1c9e09138c10..379cf01a6e96 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -245,7 +245,7 @@ static const struct file_operations tower_fops = {
 	.llseek =	tower_llseek,
 };
 
-static char *legousbtower_devnode(struct device *dev, umode_t *mode)
+static char *legousbtower_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "usb/%s", dev_name(dev));
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9ff1ad4dfad1..316e0a6b50e2 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1272,7 +1272,7 @@ struct usb_device_driver {
  */
 struct usb_class_driver {
 	char *name;
-	char *(*devnode)(struct device *dev, umode_t *mode);
+	char *(*devnode)(const struct device *dev, umode_t *mode);
 	const struct file_operations *fops;
 	int minor_base;
 };
-- 
2.37.3

