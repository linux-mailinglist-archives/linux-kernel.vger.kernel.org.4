Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D44714E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjE2Qey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjE2Qer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:34:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA9B0;
        Mon, 29 May 2023 09:34:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ae141785bso2470133f8f.3;
        Mon, 29 May 2023 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685378084; x=1687970084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XcetGsyY64nRsofxWNfYd5cm6afWXm/2XDUNvEa4CI=;
        b=HFWU7xPpyF1Sqf3McJK/3jtP3yLRKr9Epc1ZFFCzerp8QaSCiJ1VPp7nOlqZWFnfZ8
         /Babpv/epN5qcfjtfS+Usb8n61gT0plcNkYcWGUWeJ6xc2V3lctdXonyf/zkXjXE2ga5
         qi2JghkkKM/vbCyoxP5dTe0E9+X/NuzAg1LmBK+6kpYdutor58I4+K6iXjkPbK6JbRJZ
         Yr9l+P5sIQxDQ4j0w7+SucXVFUwfUqfQBJeHe2iHDNS6G1Ta8JDB9PRF02QLHBmTtxO+
         hgSrPeMSgRZ9Gsjjjtl4K86lhFzOLrJ7irGBV7i/jSME7OIu92NpmjLUg+lDMn+ag/I2
         JRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378084; x=1687970084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XcetGsyY64nRsofxWNfYd5cm6afWXm/2XDUNvEa4CI=;
        b=ZfyuYhVJfqNQmF48EQrFAw2T2aYdLLVARtK/slp9YZGULN2r99h3mB6icw6mVXwaaX
         FXKgUXyRLFVm9hyvMMKvtFyC7UqAn7dcjiea0HwP1sz1DPMZrwooNw35j6HuEqZlCtMQ
         SJN4UbGHhRoYex21iF9iEQjS+1jJWehschcAeHM3qtaAKtSg/NYv1I978v9fhvjhOtFy
         vNnDoxnkgRfkADJK7n2huGpII2qkLFWbfmGTe05+V5CG96b8w+0fNcmou6KWh8MHWb5S
         yfewBYpFVt1ef2ZMrOrS2e6dI7WeU/xkpfAp6+GZ1nYcyeQ/QgLySTC+dzFd2Ar728nR
         yEhQ==
X-Gm-Message-State: AC+VfDx1ZIkw+Ca58zrbsaQhvAdVslGf0rwPGFZpe3+oRK72ZxnGUjVX
        NaDI/CLM+OfG24Idv+QHsU4=
X-Google-Smtp-Source: ACHHUZ4vlx4sCUPTm2NGLOnreG+bh6hw9QNazuM8T8EqONcv36VhSp+Ff8VFNpcFnNpzRzdN3iVu6A==
X-Received: by 2002:adf:ff8d:0:b0:30a:e954:fde2 with SMTP id j13-20020adfff8d000000b0030ae954fde2mr4160062wrr.53.1685378084233;
        Mon, 29 May 2023 09:34:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id h14-20020a5d6e0e000000b002ff2c39d072sm417513wrz.104.2023.05.29.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:34:43 -0700 (PDT)
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
Subject: [net-next PATCH v4 02/13] leds: add API to get attached device for LED hw control
Date:   Mon, 29 May 2023 18:32:32 +0200
Message-Id: <20230529163243.9555-3-ansuelsmth@gmail.com>
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

From: Andrew Lunn <andrew@lunn.ch>

Some specific LED triggers blink the LED based on events from a device
or subsystem.
For example, an LED could be blinked to indicate a network device is
receiving packets, or a disk is reading blocks. To correctly enable and
request the hw control of the LED, the trigger has to check if the
network interface or block device configured via a /sys/class/led file
match the one the LED driver provide for hw control for.

Provide an API call to get the device which the LED blinks for.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/leds.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 4caf559b1922..3268b4e789d6 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -220,6 +220,12 @@ struct led_classdev {
 	 */
 	int			(*hw_control_get)(struct led_classdev *led_cdev,
 						  unsigned long *flags);
+	/*
+	 * Get the device this LED blinks in response to.
+	 * e.g. for a PHY LED, it is the network device. If the LED is
+	 * not yet associated to a device, return NULL.
+	 */
+	struct device		*(*hw_control_get_device)(struct led_classdev *led_cdev);
 #endif
 
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
-- 
2.39.2

