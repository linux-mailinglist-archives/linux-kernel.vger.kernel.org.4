Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9B647A83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLIAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLIAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:10:56 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951C59157;
        Thu,  8 Dec 2022 16:10:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 6so2457277pgm.6;
        Thu, 08 Dec 2022 16:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hGcOwWvd8VSjP2x7GyUv+ttfnkAA4ogAcxWASVR3QU=;
        b=esDMHWXimbKEyQVN9Lb4+mZu+Yim8XfhU/z0Dd5k0BhGOmGaHQ1lR3Bn2YqdhOQOem
         m8ggwgCg6hD5v/Aw3lxFzUTbaHL5HRakvRU5opRIjGCBeMvlfGMotVNwX/MohB3o3net
         NLrNVjuvxYH2FFEJPVSOBdNaV8qlm9IZ6UVYs8nAisfaWj2k3ysg+vmWHGVq8iwEXKsM
         Zl68zbR6eXGhI8X7XdrKhhnDCtbRIVPx4ielYDINCkKaHLRYLw9oR/pldXYPYiSmjsV0
         RjfWhbEo0CGxemxf3zpgkd+IVqwSazLxfbBZpDaHSNnEkRbzNfW/fpca5olyd6JrsfX/
         Y41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hGcOwWvd8VSjP2x7GyUv+ttfnkAA4ogAcxWASVR3QU=;
        b=0UQ6pfV+MxkksU+ZL01CM8zpIZnhW9eQqmwEiiY7CJuubbyyUArsLWxEPbzXs9qf+H
         Z5sLMobZUtpnjIb2IpsG+/6g7ZCiyIDs+b4gkOcau9ByMmZiBH8vNinO69y7b6Kl/etE
         /bsKg6YnjIwEk5KF8FDQdTuyK1sz3DIrsRhDNlg/901yAFnYH4QSAWgVTaU90di4kDjD
         fXMMFSg/2gQWNKWiDjuF0mF3d1VNuWd6OrTf+XCJFwz1X+Bxxl8NI1j7bz8f1zTo8zm+
         Ifu1pQxs1YIvoVSwyJD6/xXPnlQdwntzPdinS6l09bSkAZsaWFkLoRIpszcewznHUeAO
         s/hQ==
X-Gm-Message-State: ANoB5pkBbWNSWH9OoPxI+S4ZQjKqsloxJMtWdwAG397SBmMzkwOuciUX
        MSVre7yWH3AXmiJbIpXhd9IsD2bts9pT0A==
X-Google-Smtp-Source: AA0mqf5JTJQZcRViyqICA3HlvhT1cfKj6ObyIlglQQJDskKeAo38lLj6UiY8ChNJPf/h+hxIS0FTmw==
X-Received: by 2002:a05:6a00:4188:b0:577:bd6c:5936 with SMTP id ca8-20020a056a00418800b00577bd6c5936mr2493846pfb.16.1670544654141;
        Thu, 08 Dec 2022 16:10:54 -0800 (PST)
Received: from harry-home.bne.opengear.com (115-64-202-229.static.tpgi.com.au. [115.64.202.229])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00000300b005758d26fbf7sm76432pfk.58.2022.12.08.16.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:10:53 -0800 (PST)
From:   Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To:     u.kleine-koenig@pengutronix.de
Cc:     Qingtao Cao <qingtao.cao@digi.com>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] leds: ledtrig-tty.c: call led_set_brightness() when the blocking callback is not available
Date:   Fri,  9 Dec 2022 10:10:38 +1000
Message-Id: <20221209001039.7287-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell GPIO controller's driver will setup its struct gpio_chip's can_sleep
false, making create_gpio_led() setting up the brightness_set function pointer
instead of the brightness_set_blocking function pointer. In this case the
nonblocking version led_set_brightness() should be fallen back on by ledtrig_tty_work()

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/leds/trigger/ledtrig-tty.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index f62db7e520b5..e43d285b5d06 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -122,12 +122,18 @@ static void ledtrig_tty_work(struct work_struct *work)
 
 	if (icount.rx != trigger_data->rx ||
 	    icount.tx != trigger_data->tx) {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+		if (trigger_data->led_cdev->brightness_set_blocking)
+			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+		else if (trigger_data->led_cdev->brightness_set)
+			led_set_brightness(trigger_data->led_cdev, LED_ON);
 
 		trigger_data->rx = icount.rx;
 		trigger_data->tx = icount.tx;
 	} else {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+		if (trigger_data->led_cdev->brightness_set_blocking)
+			led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+		else if (trigger_data->led_cdev->brightness_set)
+			led_set_brightness(trigger_data->led_cdev, LED_OFF);
 	}
 
 out:
-- 
2.34.1

