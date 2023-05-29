Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38566714E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjE2Qeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjE2Qeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:34:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D3AD;
        Mon, 29 May 2023 09:34:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so3391953f8f.0;
        Mon, 29 May 2023 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685378083; x=1687970083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhNwz9KNlnd7qmSmx8SMut95dFfRtkNAM+nFVwtGeVc=;
        b=aF5gOIbQR8eYb5W0wqKsv1ikCS4wv3mF3U88FiFDe9rJIMVDznTMSY8q75zN+/eigj
         Uuzwq4x7FdgaeaPIsFHyDT17bu5C3Gwq6pfof26pEfxxGzMTbmzw73rQCCPx4xhpX3S2
         nMLd+VlbLPrjEz2pbXobRwZQSjm0nCph0zTX85ydgYbppRwTkhd27dmVZQd0CzHNvCVP
         4UuS7g839K7nYgBv8kgmy0Ycg9cTyYYmtAmtH5qcTuyWxbW6JZcgWl5w2T42KW1oxmgT
         BchhictIKZl244mzBZVvJ2dWChjmzMWtlDSTyzCWnDaTUw7SikZ+ukh/fgWkPW8oOwHT
         CIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378083; x=1687970083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhNwz9KNlnd7qmSmx8SMut95dFfRtkNAM+nFVwtGeVc=;
        b=l/e3GoCfTYHIW2n/UNDQeV139xOPv644UAVE2pTnfXed7akn03G2M8YwMOHCYlR7DE
         8zzHjaojl7tlb/fRotCRsShfabBzrVKxhGxdgbQlXHAw9j3HWeje5IL7jeIKblC4zuZx
         cS5u+0D+VTTDdXcnfK5eGl8LO7q648LbdKwEs2fnikO7RCXet5L/JZKcWh9mmvhwhDWw
         iPy0iSNhgcLqlDHAtDSu2i0xS+rVRNFZFNoHjiQ+XbcFossGHu0HXp0T0NMUATvS9zZ4
         Z6H7msuLj5nU8OI+0zUUwqOsBsVF6P1RCt+fZThWUEbqZ417QFSPJlUq9wvbMzf3Qezu
         8YOA==
X-Gm-Message-State: AC+VfDwOd0XtKX5iWAdV7py5C+dxek2SUoyK58E8y+b5IUXGeBsrB/ni
        gPVD3y3shw1IUU/3TQTIXs9q5Ty9+go=
X-Google-Smtp-Source: ACHHUZ5QghcrT/T+J6Tc//RJ0COllzktPSYbY/p2zzoYVTcwQ/t7ZnG8UmuuFAyu8qjKU8IiQZIz3Q==
X-Received: by 2002:adf:df12:0:b0:2fe:851c:672f with SMTP id y18-20020adfdf12000000b002fe851c672fmr7961772wrl.8.1685378083010;
        Mon, 29 May 2023 09:34:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id h14-20020a5d6e0e000000b002ff2c39d072sm417513wrz.104.2023.05.29.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:34:42 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-leds@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [net-next PATCH v4 01/13] leds: add APIs for LEDs hw control
Date:   Mon, 29 May 2023 18:32:31 +0200
Message-Id: <20230529163243.9555-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529163243.9555-1-ansuelsmth@gmail.com>
References: <20230529163243.9555-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to permit LED driver to declare support for a specific
trigger to use hw control and setup the LED to blink based on specific
provided modes.

Add APIs for LEDs hw control. These functions will be used to activate
hardware control where a LED will use the provided flags, from an
unique defined supported trigger, to setup the LED to be driven by
hardware.

Add hw_control_is_supported() to ask the LED driver if the requested
mode by the trigger are supported and the LED can be setup to follow
the requested modes.

Deactivate hardware blink control by setting brightness to LED_OFF via
the brightness_set() callback.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/leds.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index c39bbf17a25b..4caf559b1922 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -183,6 +183,43 @@ struct led_classdev {
 
 	/* LEDs that have private triggers have this set */
 	struct led_hw_trigger_type	*trigger_type;
+
+	/* Unique trigger name supported by LED set in hw control mode */
+	const char		*hw_control_trigger;
+	/*
+	 * Check if the LED driver supports the requested mode provided by the
+	 * defined supported trigger to setup the LED to hw control mode.
+	 *
+	 * Return 0 on success. Return -EOPNOTSUPP when the passed flags are not
+	 * supported and software fallback needs to be used.
+	 * Return a negative error number on any other case  for check fail due
+	 * to various reason like device not ready or timeouts.
+	 */
+	int			(*hw_control_is_supported)(struct led_classdev *led_cdev,
+							   unsigned long flags);
+	/*
+	 * Activate hardware control, LED driver will use the provided flags
+	 * from the supported trigger and setup the LED to be driven by hardware
+	 * following the requested mode from the trigger flags.
+	 * Deactivate hardware blink control by setting brightness to LED_OFF via
+	 * the brightness_set() callback.
+	 *
+	 * Return 0 on success, a negative error number on flags apply fail.
+	 */
+	int			(*hw_control_set)(struct led_classdev *led_cdev,
+						  unsigned long flags);
+	/*
+	 * Get from the LED driver the current mode that the LED is set in hw
+	 * control mode and put them in flags.
+	 * Trigger can use this to get the initial state of a LED already set in
+	 * hardware blink control.
+	 *
+	 * Return 0 on success, a negative error number on failing parsing the
+	 * initial mode. Error from this function is NOT FATAL as the device
+	 * may be in a not supported initial state by the attached LED trigger.
+	 */
+	int			(*hw_control_get)(struct led_classdev *led_cdev,
+						  unsigned long *flags);
 #endif
 
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
-- 
2.39.2

