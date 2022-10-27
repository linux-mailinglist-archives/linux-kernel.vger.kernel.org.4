Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85B60FB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiJ0PK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiJ0PJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF25718F0E9;
        Thu, 27 Oct 2022 08:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 773B1623A7;
        Thu, 27 Oct 2022 15:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526EFC433D7;
        Thu, 27 Oct 2022 15:09:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Vc-00Bvb5-1j;
        Thu, 27 Oct 2022 11:09:28 -0400
Message-ID: <20221027150928.367913405@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: [RFC][PATCH v2 17/31] timers: leds: Use del_timer_shutdown() before freeing timer
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/leds/trigger/ledtrig-activity.c  | 2 +-
 drivers/leds/trigger/ledtrig-heartbeat.c | 2 +-
 drivers/leds/trigger/ledtrig-pattern.c   | 2 +-
 drivers/leds/trigger/ledtrig-transient.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index 30bc9df03636..dc2c7b5ef67e 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -208,7 +208,7 @@ static void activity_deactivate(struct led_classdev *led_cdev)
 {
 	struct activity_data *activity_data = led_get_trigger_data(led_cdev);
 
-	del_timer_sync(&activity_data->timer);
+	del_timer_shutdown(&activity_data->timer);
 	kfree(activity_data);
 	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
 }
diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c b/drivers/leds/trigger/ledtrig-heartbeat.c
index 7fe0a05574d2..7c46457f31a1 100644
--- a/drivers/leds/trigger/ledtrig-heartbeat.c
+++ b/drivers/leds/trigger/ledtrig-heartbeat.c
@@ -151,7 +151,7 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
 	struct heartbeat_trig_data *heartbeat_data =
 		led_get_trigger_data(led_cdev);
 
-	del_timer_sync(&heartbeat_data->timer);
+	del_timer_shutdown(&heartbeat_data->timer);
 	kfree(heartbeat_data);
 	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
 }
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 43a265dc4696..f50da27fea47 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -430,7 +430,7 @@ static void pattern_trig_deactivate(struct led_classdev *led_cdev)
 	if (led_cdev->pattern_clear)
 		led_cdev->pattern_clear(led_cdev);
 
-	del_timer_sync(&data->timer);
+	del_timer_shutdown(&data->timer);
 
 	led_set_brightness(led_cdev, LED_OFF);
 	kfree(data);
diff --git a/drivers/leds/trigger/ledtrig-transient.c b/drivers/leds/trigger/ledtrig-transient.c
index 80635183fac8..1f28f13b1764 100644
--- a/drivers/leds/trigger/ledtrig-transient.c
+++ b/drivers/leds/trigger/ledtrig-transient.c
@@ -180,7 +180,7 @@ static void transient_trig_deactivate(struct led_classdev *led_cdev)
 {
 	struct transient_trig_data *transient_data = led_get_trigger_data(led_cdev);
 
-	del_timer_sync(&transient_data->timer);
+	del_timer_shutdown(&transient_data->timer);
 	led_set_brightness_nosleep(led_cdev, transient_data->restore_state);
 	kfree(transient_data);
 }
-- 
2.35.1
