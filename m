Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE26714E64
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjE2QfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjE2Qes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:34:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B43A3;
        Mon, 29 May 2023 09:34:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30aea656e36so779533f8f.1;
        Mon, 29 May 2023 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685378085; x=1687970085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bow2IlphqQcOV86ezGAfOnUZcJRsC4hY+XSIuwAMdVw=;
        b=TCNNwKXObS/dWdO1Q1TJ9Uwu5/jmmaVfR96PuYXGr/hq86PhgUbTDRf8mJBJMt1psh
         ISbW0tAZT6OkzpSWUWlWN2g+asUpzy+xk8vJC56K5F7bI9rooUacXcpIXoKsojKGdQoT
         6jp+6PJ4rENUtJ1lRvbBdL7iDHVSYPkQjYAupUXWMUp2NzdfCPNb7p1DoMK9MZFefKQP
         1KegwsFQUoTnEr7e/BhQP2fcFRF7c+mRn4YmpnORXgNsBSeDt/6w6eGQJu8l5PJiaWwT
         CKtpW4sUYC3+6IuVFMV2upSrO8or+uuGEbs+a5YoPE6g8B1mUoslQ345hsl21d1PQYh8
         g79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378085; x=1687970085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bow2IlphqQcOV86ezGAfOnUZcJRsC4hY+XSIuwAMdVw=;
        b=H8aCZhY0siSb7o/AV/bXgvzNMuB9uFM0rcqI5QY2Q939iNncRtnKtj0nIrMt36xBgH
         8XdH6AYhhVJaCTBsq6iYLKhA044blMg8BFFd9t8HzVXlIY1Wf/5WqNIgPxNQJK1w1vQX
         H2zh9Irm82poyi0dvEDPvLrIGiJGCPkkhHWDcJrF8TRvcsJhJmPj3V3xDA1RBQUE3r//
         qx0adzF4eBu1pOuY9jy7PHTjyQKmr7M7XebLUOz7SNrObwRgQHp+CGkBpKamwFIzZpTD
         SMetl8aRQIbH8oVhKcyVvzNo82XbdH6dwcBFFX47MnX7CW3h5peOsgUP6lGIBXBFgwHQ
         QVdA==
X-Gm-Message-State: AC+VfDwVp7eN5M00Akjl8gHCX5Xj9KeywDdyFa/KW5Kh2VcUayw+1Q/D
        E7Bgar06UpE1SLx+IXO9xT8=
X-Google-Smtp-Source: ACHHUZ56tanRPzl8lORtX38biVRycR+UuWloQM8mJIJUTmppZGM4bDoqMm4v63Bli1a5jC6JhqFT9Q==
X-Received: by 2002:a05:6000:1b0a:b0:309:4ba8:86a0 with SMTP id f10-20020a0560001b0a00b003094ba886a0mr8417977wrz.17.1685378085402;
        Mon, 29 May 2023 09:34:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id h14-20020a5d6e0e000000b002ff2c39d072sm417513wrz.104.2023.05.29.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:34:44 -0700 (PDT)
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
Subject: [net-next PATCH v4 03/13] Documentation: leds: leds-class: Document new Hardware driven LEDs APIs
Date:   Mon, 29 May 2023 18:32:33 +0200
Message-Id: <20230529163243.9555-4-ansuelsmth@gmail.com>
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

Document new Hardware driven LEDs APIs.

Some LEDs can be programmed to be driven by hardware. This is not
limited to blink but also to turn off or on autonomously.
To support this feature, a LED needs to implement various additional
ops and needs to declare specific support for the supported triggers.

Add documentation for each required value and API to make hw control
possible and implementable by both LEDs and triggers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/leds/leds-class.rst | 81 +++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/leds/leds-class.rst b/Documentation/leds/leds-class.rst
index cd155ead8703..5db620ed27aa 100644
--- a/Documentation/leds/leds-class.rst
+++ b/Documentation/leds/leds-class.rst
@@ -169,6 +169,87 @@ Setting the brightness to zero with brightness_set() callback function
 should completely turn off the LED and cancel the previously programmed
 hardware blinking function, if any.
 
+Hardware driven LEDs
+====================
+
+Some LEDs can be programmed to be driven by hardware. This is not
+limited to blink but also to turn off or on autonomously.
+To support this feature, a LED needs to implement various additional
+ops and needs to declare specific support for the supported triggers.
+
+With hw control we refer to the LED driven by hardware.
+
+LED driver must define the following value to support hw control:
+
+    - hw_control_trigger:
+               unique trigger name supported by the LED in hw control
+               mode.
+
+LED driver must implement the following API to support hw control:
+    - hw_control_is_supported:
+                check if the flags passed by the supported trigger can
+                be parsed and activate hw control on the LED.
+
+                Return 0 if the passed flags mask is supported and
+                can be set with hw_control_set().
+
+                If the passed flags mask is not supported -EOPNOTSUPP
+                must be returned, the LED trigger will use software
+                fallback in this case.
+
+                Return a negative error in case of any other error like
+                device not ready or timeouts.
+
+     - hw_control_set:
+                activate hw control. LED driver will use the provided
+                flags passed from the supported trigger, parse them to
+                a set of mode and setup the LED to be driven by hardware
+                following the requested modes.
+
+                Set LED_OFF via the brightness_set to deactivate hw control.
+
+                Return 0 on success, a negative error number on failing to
+                apply flags.
+
+    - hw_control_get:
+                get active modes from a LED already in hw control, parse
+                them and set in flags the current active flags for the
+                supported trigger.
+
+                Return 0 on success, a negative error number on failing
+                parsing the initial mode.
+                Error from this function is NOT FATAL as the device may
+                be in a not supported initial state by the attached LED
+                trigger.
+
+    - hw_control_get_device:
+                return the device associated with the LED driver in
+                hw control. A trigger might use this to match the
+                returned device from this function with a configured
+                device for the trigger as the source for blinking
+                events and correctly enable hw control.
+                (example a netdev trigger configured to blink for a
+                particular dev match the returned dev from get_device
+                to set hw control)
+
+                Returns a pointer to a struct device or NULL if nothing
+                is currently attached.
+
+LED driver can activate additional modes by default to workaround the
+impossibility of supporting each different mode on the supported trigger.
+Examples are hardcoding the blink speed to a set interval, enable special
+feature like bypassing blink if some requirements are not met.
+
+A trigger should first check if the hw control API are supported by the LED
+driver and check if the trigger is supported to verify if hw control is possible,
+use hw_control_is_supported to check if the flags are supported and only at
+the end use hw_control_set to activate hw control.
+
+A trigger can use hw_control_get to check if a LED is already in hw control
+and init their flags.
+
+When the LED is in hw control, no software blink is possible and doing so
+will effectively disable hw control.
 
 Known Issues
 ============
-- 
2.39.2

