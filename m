Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDDB609039
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJVWFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJVWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:05:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BF5972A;
        Sat, 22 Oct 2022 15:05:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so10052824wrb.8;
        Sat, 22 Oct 2022 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2Not6vWEj/EXAhyq7bMF/7ChA29esth2VpSlZbgOZw=;
        b=SFQVJESBnmW6WPrWGvgWwUJTgDxkoKS9I29HLdL1dIwy/11LEof4cFph9B4UheCBrA
         E/AAwP1ioFmAXRunR1+tgc49nCu5bHEQZ0WvGwRxx8loQRXSWszOLO5B4+aijp1xal/e
         Kf0t4+MV7qN6IOSWd7nKcry+IADtnntty3fZLnyZ2e96JFjlf5cblU7fONB5wlIBwh8E
         ULklPni6rloZGNw8laDCdTk50TtfMAlHZSKEz1IRGG6QhsOGjJF0aEZpEeBW5AQ+BmsV
         2x/uqyeb+0CE/uCDvF2u5wN9e2XVTcpo/lHqrAiRYFzG3WhQGb3d/O4zFFqKsDb77guc
         4rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2Not6vWEj/EXAhyq7bMF/7ChA29esth2VpSlZbgOZw=;
        b=f/S6XsQyAwDu2lUYNuVw0+iWusl7Q9zKDAXFS0lWCEX06XirLSXIkq/Oug0G7EGmG9
         PhXQQCIAZun5jm/ixtn/mSP/OEfhNFXTME5Tt2HBRey269LHgW3liATQnjJgA0Ir2rAO
         0YlAumu3GNr0kJnRlz4CyYmtXbT4YFXdEEiSG2BPu1o6mzv93OpLoggtDWqpla9ZftTl
         BFDPyN1vcGfoTeOlGrHu8lMWalx0/SfpfSof+5Cjs2kUq7PpTcVtDVv7RhwfZPtC214r
         cCWICe9F+b3Wdi0xVBaP9hctBZ35hgR1hej5o9CSAYA1Bw+9suNkllMxs+IH1D8ie4uo
         JYiQ==
X-Gm-Message-State: ACrzQf2fbsGlK/w94GiW4DMuTQB7qs6yp5sN54lTx8CoAlpeLhhpiGWS
        QwgqsuY9aMI73IihRml30cV+FlNEILRbUg==
X-Google-Smtp-Source: AMsMyM6nZYjAQAh4Z5ESRtpk0ycubeRqy+oXlHNqX/IMvXXWPLoA0vsIK9tjOIFqvFlWt6heAcuBfw==
X-Received: by 2002:a05:6000:1051:b0:22e:5d8a:d3d5 with SMTP id c17-20020a056000105100b0022e5d8ad3d5mr16321206wrx.476.1666476334126;
        Sat, 22 Oct 2022 15:05:34 -0700 (PDT)
Received: from localhost.localdomain (37.94.131.77.rev.sfr.net. [77.131.94.37])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0022e6f0d0d7csm26825100wrb.18.2022.10.22.15.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:05:33 -0700 (PDT)
From:   Benoit Maurin <maurinbe@gmail.com>
Cc:     Benoit Maurin <maurinbe@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input/xpad: LED controllable through input events
Date:   Sun, 23 Oct 2022 00:05:07 +0200
Message-Id: <20221022220508.37489-1-maurinbe@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(EV_LED, LED_MISC, #VALUE) can now be used to control leds on the
xpad gamepad (was only possible through /sys/class/leds/xpad0/brightness)
with permissions of /dev/input/xxx

To test the code (xpad can be compiled out-of-tree with some slight
tweaks):

```
import evdev
device = evdev.InputDevice('/dev/input/event15') # not js0
device.set_led(8, 2)
device.set_led(8, 0) # this won't be delivered
device.set_led(8, 16) # must do this instead
device.set_led(8, 15)
```

Signed-off-by: Benoit Maurin <maurinbe@gmail.com>
---
 drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2959d80f7..fcf4d2c8f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1646,6 +1646,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 		goto err_free_mem;
 	}
 
+	input_set_capability(xpad->dev, EV_LED, LED_MISC);
 	snprintf(led->name, sizeof(led->name), "xpad%d", xpad->pad_nr);
 	led->xpad = xpad;
 
@@ -1824,6 +1825,28 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 	}
 }
 
+static int xpad_event(struct input_dev *dev, unsigned int type,
+		      unsigned int code, int value)
+{
+	struct usb_xpad *xpad = input_get_drvdata(dev);
+
+	if (type != EV_LED || xpad->led == NULL)
+		return 0;
+	xpad_send_led_command(xpad, value);
+	xpad->led->led_cdev.brightness = value;
+	/* Bit clearing is necessary otherwise two events with
+	 * different non-null values will deliver only the first one.
+	 * To work around this, we clear the bit to indicate that the
+	 * current value is zero. The downside is that events with zero
+	 * value won't be delivered. It's not a big deal since a value of
+	 * 16 can be sent which is the same as 0
+	 * See xpad_send_led_command, command %= 16
+	 */
+
+	clear_bit(code, xpad->dev->led);
+	return 0;
+}
+
 static int xpad_init_input(struct usb_xpad *xpad)
 {
 	struct input_dev *input_dev;
@@ -1851,6 +1874,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 		input_dev->open = xpad_open;
 		input_dev->close = xpad_close;
 	}
+	input_dev->event = xpad_event;
 
 	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
 		/* set up axes */
-- 
2.38.1

