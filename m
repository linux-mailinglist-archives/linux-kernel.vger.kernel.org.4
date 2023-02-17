Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9369AEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBQO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBQO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:58:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B76EBB6;
        Fri, 17 Feb 2023 06:57:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l8so1207742wrv.2;
        Fri, 17 Feb 2023 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIkbvHjFX1aepVxrs4QUTwLFP4ImBsNDdfobFD40cKg=;
        b=TGjSZ/KeZ1/FS2RmSIolooFdSNg22TNco0LgtwOnLS354Z8cPzNyxg9T4qyvUm0/X5
         GTyUIFVEsfriLce0Jd9g8TbUE8h7acPNZqWd1vpaSpCO4pok84r95w/aUz0q7NRw0ytF
         XFE2Vbi84g9QVnGWFVK0QNSwG8yevdLWLrI0JnE8qE28rT3YnJlONseMuyHaUcw3ah/a
         EYS/11OP60OHSqblH12aVdnfhYdcvhlbc2zgbeVhTjkO49bSyk12SKUyW1lAIYgyHVdz
         Oyf4DULeCfZa2gRMUddXhehCGYHqMVphpvV+snYlKeD3ql28nWkDVHs0xWpZevdd12cB
         rcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIkbvHjFX1aepVxrs4QUTwLFP4ImBsNDdfobFD40cKg=;
        b=cexLEkFcVOiN+Mvz1ZO3r7o9tjvd5+tsIPOaPVEAJ4+Uf29abxrI5VLMxD7ZKQezvB
         KxRvR0Z6bRTb9TFVPSvNUX2pen4hqYzj+yMeH/+HN0eqMa7WXvvpJlphtgWZ2SCbRzuB
         LVHlFz6yD6wfxOTOcMuAabZ6JK5wyc5pdSqhRXUtEb6BB259qGwts99whzWRS7F+osj3
         5O7SbgRXUsPUysBZXKblvjWPwh/KZhbtgqRxmZsUXUiqs7eNLBPbNWxuYKWmVWMXvIgr
         Rqp6rqBH+S+MpZG2zD4mYfSZCpCGu0Ac7AigeVF1dz7mJXqazyYZmVAVLIH8j/XPNyq2
         GtEA==
X-Gm-Message-State: AO0yUKUf03TP2upiy/t/csQeenWmoURWctxQOZvXhyfyZOMV01aUTJM9
        6WUy7jaj/qMf8+KjTPiUQbL5yRA9Fck=
X-Google-Smtp-Source: AK7set8cJZhjihYej7RKckLZjdjQ8mUQ33JB4Un5ozw8m54t2mwGmY+L6cFuKucIcDAdS8Y8S0ko2Q==
X-Received: by 2002:a5d:55c5:0:b0:2c5:96a5:5b83 with SMTP id i5-20020a5d55c5000000b002c596a55b83mr4304190wrw.26.1676645857483;
        Fri, 17 Feb 2023 06:57:37 -0800 (PST)
Received: from angelo-ThinkPad-X270.. (host085115199111.static.fidoka.tech. [85.115.199.111])
        by smtp.gmail.com with ESMTPSA id a17-20020adff7d1000000b002c3d29d83d2sm4434221wrq.63.2023.02.17.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:57:36 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
To:     Angelo Compagnucci <angelo@amarulasolutions.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] misc: servo-pwm: Add sysfs entries to control motor angle
Date:   Fri, 17 Feb 2023 15:57:29 +0100
Message-Id: <20230217145731.3018148-2-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217145731.3018148-1-angelo@amarulasolutions.com>
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
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

Servo motor can be moved between 0 and degrees angle.

Add 'angle' sysfs attribute:
  *read*: Current motor position.
  *write*: Moves the motor to the position.

Add 'degrees' sysfs attribute:
  *read*: how many degrees the motor can move

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 .../ABI/testing/sysfs-driver-servo-pwm        | 20 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-servo-pwm

diff --git a/Documentation/ABI/testing/sysfs-driver-servo-pwm b/Documentation/ABI/testing/sysfs-driver-servo-pwm
new file mode 100644
index 000000000000..9c4d897073fa
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-servo-pwm
@@ -0,0 +1,20 @@
+What:		/sys/devices/platform/servo*/angle
+Date:		Feb 2023
+Contact:	Angelo Compagnucci <angelo@amarulasolutions.com>
+Description:
+		(RW) read or write servo motor position angle.
+		Servo motor can move between 0 and max degrees angle.
+		As soon the vale is written, the motor will move to the selected
+		angle. Reading the value gives the motor position.
+Users:		any user space application which wants to move the servo
+		motor position.
+
+What:		/sys/devices/platform/servo*/degrees
+Date:		Feb 2023
+Contact:	Angelo Compagnucci <angelo@amarulasolutions.com>
+Description:
+		(RO) read the servo motor movement degrees.
+		Servo motor can move between 0 and max degrees angle.
+		Reading the value gives the motor max degrees angle supported.
+Users:		any user space application which wants to know the max degrees
+		angle motor supports.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8f4af64deb1b..356daea0861d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8741,6 +8741,7 @@ GENERIC PWM SERVO DRIVER
 M:	"Angelo Compagnucci" <angelo@amarulasolutions.com>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-servo-pwm
 F:	drivers/misc/servo-pwm.c
 
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
-- 
2.34.1

