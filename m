Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35596E23F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDNNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDNNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:00:43 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FC977C;
        Fri, 14 Apr 2023 06:00:25 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33ECwwkT018300-33ECwwkW018300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Apr 2023 20:59:03 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Vicki Pfau <vi@endrift.com>, Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: xpad - fix GPF in xpad_probe
Date:   Fri, 14 Apr 2023 20:55:47 +0800
Message-Id: <20230414125603.686123-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xpad_probe(), it does not allocate xpad->dev with input_dev type.
Then, when it invokes dev_warn with 1st argument - &xpad->dev->dev, it
would trigger GPF.

Fix this by allocating xpad->dev, its error handling and cleanup
operations in the remove function.

Note that this crash does not have any reproducer, so the patch
only passes compilation testing.

Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/input/joystick/xpad.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 66a92691a047..2e077b52f46a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1944,6 +1944,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
+	struct input_dev *input_dev;
 	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
 	int i, error;
 
@@ -1957,9 +1958,13 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 
 	xpad = kzalloc(sizeof(struct usb_xpad), GFP_KERNEL);
-	if (!xpad)
-		return -ENOMEM;
+	input_dev = input_allocate_device();
+	if (!xpad || !input_dev) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
 
+	xpad->dev = input_dev;
 	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
 	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
 
@@ -2134,6 +2139,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 err_free_idata:
 	usb_free_coherent(udev, XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
 err_free_mem:
+	input_free_device(input_dev);
 	kfree(xpad);
 	return error;
 }
@@ -2159,6 +2165,7 @@ static void xpad_disconnect(struct usb_interface *intf)
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
+	input_free_device(xpad->dev);
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);
-- 
2.39.2

