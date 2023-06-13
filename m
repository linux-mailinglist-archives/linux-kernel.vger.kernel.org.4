Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2172DE03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbjFMJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjFMJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:44:35 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 02:44:32 PDT
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FA10DC;
        Tue, 13 Jun 2023 02:44:31 -0700 (PDT)
Received: from W388ANL.actianordic.se (10.12.12.26) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 11:29:27 +0200
From:   Jonas Blixt <jonas.blixt@actia.se>
To:     <shuah@kernel.org>, <valentina.manea.m@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonas Blixt <jonas.blixt@actia.se>
Subject: [PATCH] USB: usbip: fix stub_dev hub disconnect
Date:   Tue, 13 Jun 2023 11:29:18 +0200
Message-ID: <20230613092918.4191895-1-jonas.blixt@actia.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.12.12.26]
X-EsetResult: clean, is OK
X-EsetId: 37303A294A191A536D766B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a hub is disconnected that has device(s) that's attached to the usbip layer
the disconnect function might fail because it tries to release the port
on an already disconnected hub.

Fixes: 6080cd0e9239 ("staging: usbip: claim ports used by shared devices")
Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
---
 drivers/usb/usbip/stub_dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 2305d425e6c9..257861787cdf 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -427,8 +427,12 @@ static void stub_disconnect(struct usb_device *udev)
 	/* release port */
 	rc = usb_hub_release_port(udev->parent, udev->portnum,
 				  (struct usb_dev_state *) udev);
-	if (rc) {
-		dev_dbg(&udev->dev, "unable to release port\n");
+	/*
+	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
+	 * device usb_hub_release_port will return -ENODEV.
+	 */
+	if (rc && (rc != -ENODEV)) {
+		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
 		return;
 	}
 
-- 
2.25.1

