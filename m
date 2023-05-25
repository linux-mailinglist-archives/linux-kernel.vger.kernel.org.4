Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9EC710EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbjEYOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjEYOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:54:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9226D19A;
        Thu, 25 May 2023 07:54:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-309d3e8777cso851758f8f.0;
        Thu, 25 May 2023 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685026492; x=1687618492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKIEgFgmjScZJvZv6lwQPPIWSzDEZLIyZZgdXEW7tPM=;
        b=bEpsUQez/S+BHTLLATX9nnqT+iAwWcmnFR/F5Zrz+j9NgVCyzD/nbmVJR8gSou9Uu/
         R5fG3EH/BRx0T1NwikoNCjAoehM82y1mDUiP8Rb9GLsfEtSiqQJNDkxuDvV9Rb5We5fa
         x9qZR7MkCnf5a8Z0fyaI5HsevZ21YMq30yLr7QBspRcsTK77bn+NK6YIu9vzzMpbJbSC
         kSq3n0gclNrP0eotH/usPYVQ37ZP6rbbdfYYta9v6SgQMKToesvNHaE+3y/02uxCkVmk
         VpkpkTmyNMD5e2peNEvVOpJYKzKtqAFLXF2lDywEA9U8K8B/0YpR5fo0pyRXRoRVk1Ef
         AhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026492; x=1687618492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKIEgFgmjScZJvZv6lwQPPIWSzDEZLIyZZgdXEW7tPM=;
        b=bO+SvyPQzjVEZNbaobBZti7PSFUlUND6ETfztUlCVwYM8/ucF+IFRdcKDZwRxLs2Pk
         Nx56b9MuYcbbPomq407iTxTV9irb5dXYDcXHYYzfa4OK55DMr1uh3edo9owXp15DutDH
         amzoSwW98VLDax6mOjfLRqCCoV2vQtIWFHjFxVVCma3VZVLxV3VNGtNk9xGh/20zhF3U
         Su7RZX7T+RUnCPOaeJUmIj8T9qNMEobn98Hk/IsvSPa9aGVJMHtgrVYjn4scJy7uGoIM
         dHRa9zC6jj2y7Y4m2X8WJLrAbhorZsDF1D3LaX18pT9pVxRzoyxVIB5saAly/RnU4owC
         CNLg==
X-Gm-Message-State: AC+VfDytL3JwxuxRjgDjw/Vw2bkbqDfcmS9r34dwUmFK7gy6t1I+ryRH
        aDuHW0faViW1WvAjfQYXkao=
X-Google-Smtp-Source: ACHHUZ5nP5jh06kC6rateL9FNiX9agRpIylAkfx0EYikYnq9vnhtH8p81SosuYRCxtGgECF7+k0XZQ==
X-Received: by 2002:a5d:51c7:0:b0:309:596f:e5a8 with SMTP id n7-20020a5d51c7000000b00309596fe5a8mr2326033wrv.4.1685026491665;
        Thu, 25 May 2023 07:54:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id t11-20020a5d49cb000000b0030732d6e104sm2048043wrs.105.2023.05.25.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:54:51 -0700 (PDT)
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
Subject: [net-next PATCH v2 01/13] leds: add APIs for LEDs hw control
Date:   Thu, 25 May 2023 16:53:49 +0200
Message-Id: <20230525145401.27007-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525145401.27007-1-ansuelsmth@gmail.com>
References: <20230525145401.27007-1-ansuelsmth@gmail.com>
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

