Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7738169BB37
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBRRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBRRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:21:32 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2615C9B;
        Sat, 18 Feb 2023 09:21:29 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676740887;
        bh=YtT+lMTprYjd+HAo5VfFtrPuqbrUQqfuKSGmUVN8Llw=;
        h=From:Date:Subject:To:Cc:From;
        b=UgJ8QKg6u3AFxZSoFgjtSWEO9UGGA422hnwTMHeQm484cu4MT3yKV40wery0LKgIQ
         u9G9twcGI8w2hF9v+2+DHlaHctZ4zMzwZA2KY6K7jMRs0bTQBRyRLCRV41xN9/y3Yy
         UNZ4+YOGWTbxOyFB7e7MUSc5CE0rmZZSWeipEJOs=
Date:   Sat, 18 Feb 2023 17:21:21 +0000
Subject: [PATCH] leds: Fix reference to led_set_brightness() in doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230218-typo-led-set-v1-1-3c35362a2f2d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABEJ8WMC/x2NwQqDMBAFf0X23IUkQrH9ldJDoi+6EKJkbWkR/
 71LjzMwzEGKJlC6dwc1vEVlrQb+0tG4xDqDZTKm4ELvgh94/24rF0ys2Nn1yLfs0zX7SJakqOD
 UYh0Xi+qrFJNbQ5bP//F4nucPX5FG+3MAAAA=
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Purdie <rpurdie@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676740883; l=1026;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YtT+lMTprYjd+HAo5VfFtrPuqbrUQqfuKSGmUVN8Llw=;
 b=eVROg0imnbioVb9UiQzTtHu5jFZlB+qu/YHlR/xuvi4TUdXUAuaQjWVcDTWMzQ2VPOPJFxvDe
 PoyFKDTp/YTBktSEix5HNFImgBTDUmrJjhiRlw5b/S4qTzIEK29MdqY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referenced function led_classdev_brightness_set() never existed.

Fixes: 5ada28bf7675 ("led-class: always implement blinking")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/leds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index ba4861ec73d3..228acdb52fe2 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -229,7 +229,7 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
  *
  * Note that if software blinking is active, simply calling
  * led_cdev->brightness_set() will not stop the blinking,
- * use led_classdev_brightness_set() instead.
+ * use led_set_brightness() instead.
  */
 void led_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
 		   unsigned long *delay_off);

---
base-commit: 38f8ccde04a3fa317b51b05e63c3cb57e1641931
change-id: 20230218-typo-led-set-03ef9f1b6f1a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

