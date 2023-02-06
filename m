Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADE968C92E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBFWNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBFWNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:13:04 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970D1167E;
        Mon,  6 Feb 2023 14:13:00 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8C04560004;
        Mon,  6 Feb 2023 22:12:57 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH v2 1/3] HID: logitech-hidpp: Add more debug statements
Date:   Mon,  6 Feb 2023 23:12:54 +0100
Message-Id: <20230206221256.129198-1-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should help us figure out some hairy problems with some devices.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---

Fixed kernel test bot warning:
   drivers/hid/hid-logitech-hidpp.c: In function 'hidpp_send_fap_command_sync':
>> drivers/hid/hid-logitech-hidpp.c:343:25: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Wformat=]
     343 |                         "Invalid number of parameters passed to command (%d != %ld)\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 drivers/hid/hid-logitech-hidpp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f44ba7be3cc5..1952d8d3b6b2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -338,8 +338,13 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message;
 	int ret;
 
-	if (param_count > sizeof(message->fap.params))
+	if (param_count > sizeof(message->fap.params)) {
+		hid_dbg(hidpp->hid_dev,
+			"Invalid number of parameters passed to command (%d != %llu)\n",
+			param_count,
+			(unsigned long long) sizeof(message->fap.params));
 		return -EINVAL;
+	}
 
 	message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
 	if (!message)
@@ -3440,11 +3445,17 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 		ret = hidpp10_enable_scrolling_acceleration(hidpp);
 		multiplier = 8;
 	}
-	if (ret)
+	if (ret) {
+		hid_dbg(hidpp->hid_dev,
+			"Could not enable hi-res scrolling: %d\n", ret);
 		return ret;
+	}
 
-	if (multiplier == 0)
+	if (multiplier == 0) {
+		hid_dbg(hidpp->hid_dev,
+			"Invalid multiplier 0 from device, setting it to 1\n");
 		multiplier = 1;
+	}
 
 	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
 	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
-- 
2.39.1

