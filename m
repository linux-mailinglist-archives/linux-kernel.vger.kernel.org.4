Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4E739FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjFVLoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:44:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE43D3;
        Thu, 22 Jun 2023 04:44:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b4725e9917so72683211fa.2;
        Thu, 22 Jun 2023 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687434274; x=1690026274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVmHxQFpvqY7IwmyaWzTBpCtQuGSXHWJX1dpQpAyhE8=;
        b=mr1/UtQmFba0+SF4mL7YxXD2kU7wnD67Y7ihCEp58x6pohU8w2EVRv7QV4RcEw7+Pw
         0QkIKpc5PQ2Q7DlM/E7aaonxJjkfEQTdshgg2z9kFTJqcuu1tgpV0WET3HgaXrPIeK97
         LDMN22d4tuPtdVjLcGlTJeBvgrjemeMas5vQQ0NhH+eSTQwleGUyMhJ1d8c10V1gvWZe
         TLcp1YF8E7KgWWVJcWDIA+QMqW9pb50fiYBTThBqvsSnyyicpu36X/U6EnbfIlTiwB72
         tudza0FdoExMRL9yXX8yOr4yQca4ov2aNUOrH+S4wjoYLWKIU/9hQfqx2Ey9X7kQMeou
         aKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434274; x=1690026274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVmHxQFpvqY7IwmyaWzTBpCtQuGSXHWJX1dpQpAyhE8=;
        b=QnarrHBgeK/6OIzA2Glu/z3mTnzDybLC6vmiz7VQ0MHHI8lZqWbZxCCjfjvMnBXPXq
         ynSxoxUMo0hrIaz2Zgk0j14C/2JRI//AYqhRKbh7/3MCH6dfE1L150h4rd8uluFpaVPx
         4x0mhLIGLvvdI9j9gOXN1BYhAi7cZpaEsVRtIJrDqel/9iFAWlBRY6G3QeLaRPFGPHgq
         HH9xoO028gulEqVDh1/Uug9tb76z8tC2O7u6BF74tdllDuxMpUJgH/qomkdh0HCKBeSp
         THKk0ls6IrY4R9Kz9CZXhByGWai4pJGkCLMYrMhDacl/tSuwS905hfeAWCH3o67V7B2+
         Dfyw==
X-Gm-Message-State: AC+VfDyFMfqbL28rhyWs/E0FEgnZ8Y7sRrbSb90zw2jl69sQhqB7vBjN
        jt/IpcqyCg06LlTEsW5fW7g=
X-Google-Smtp-Source: ACHHUZ42zItZAP+UecMaUptnUBOTycAnlXEP9zRo5USemDhZPUvfJ+/eGkdY7naOacPNeKFf3FceSA==
X-Received: by 2002:a05:6512:3b23:b0:4f9:6221:8fae with SMTP id f35-20020a0565123b2300b004f962218faemr1632868lfv.49.1687434273224;
        Thu, 22 Jun 2023 04:44:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id p20-20020a05600c205400b003f9a6f3f240sm11513712wmg.14.2023.06.22.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:44:32 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH] docs: ABI: sysfs-class-led-trigger-netdev: add new modes and entry
Date:   Wed, 21 Jun 2023 11:26:53 +0200
Message-Id: <20230621092653.23172-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document newly introduced modes and entry for the LED netdev trigger.

Add documentation for new modes:
- link_10
- link_100
- link_1000
- half_duplex
- full_duplex

Add documentation for new entry:
- hw_control

Also add additional info for the interval entry and the tx/rx modes with
the special case of hw_control ON.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../testing/sysfs-class-led-trigger-netdev    | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
index 646540950e38..78b62a23b14a 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
@@ -13,6 +13,11 @@ Description:
 		Specifies the duration of the LED blink in milliseconds.
 		Defaults to 50 ms.
 
+		With hw_control ON, the interval value MUST be set to the
+		default value and cannot be changed.
+		Trying to set any value in this specific mode will return
+		an EINVAL error.
+
 What:		/sys/class/leds/<led>/link
 Date:		Dec 2017
 KernelVersion:	4.16
@@ -39,6 +44,9 @@ Description:
 		If set to 1, the LED will blink for the milliseconds specified
 		in interval to signal transmission.
 
+		With hw_control ON, the blink interval is controlled by hardware
+		and won't reflect the value set in interval.
+
 What:		/sys/class/leds/<led>/rx
 Date:		Dec 2017
 KernelVersion:	4.16
@@ -50,3 +58,84 @@ Description:
 
 		If set to 1, the LED will blink for the milliseconds specified
 		in interval to signal reception.
+
+		With hw_control ON, the blink interval is controlled by hardware
+		and won't reflect the value set in interval.
+
+What:		/sys/class/leds/<led>/hw_control
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Communicate whether the LED trigger modes are driven by hardware
+		or software fallback is used.
+
+		If 0, the LED is using software fallback to blink.
+
+		If 1, the LED is using hardware control to blink and signal the
+		requested modes.
+
+What:		/sys/class/leds/<led>/link_10
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link speed state of 10Mbps of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link state
+		speed of 10MBps of the named network device.
+		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/link_100
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link speed state of 100Mbps of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link state
+		speed of 100Mbps of the named network device.
+		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/link_1000
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link speed state of 1000Mbps of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link state
+		speed of 1000Mbps of the named network device.
+		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/half_duplex
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link half duplex state of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link half
+		duplex state of the named network device.
+		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/full_duplex
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link full duplex state of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link full
+		duplex state of the named network device.
+		Setting this value also immediately changes the LED state.
-- 
2.40.1

