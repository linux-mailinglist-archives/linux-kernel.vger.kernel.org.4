Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5A69B040
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBQQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBQQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:11:06 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765C6EBAD;
        Fri, 17 Feb 2023 08:11:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 4-20020a05600c22c400b003dc4fd6e61dso1297979wmg.5;
        Fri, 17 Feb 2023 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ofUDbLHG16kE9QAcbRQpoQvk7CR0AkJFCKUXTKtC44=;
        b=FaQM2Ozx54ai0sb4JLNcAH5BqTAphoi1GonYymKWA2t0rYXOF7qWJ9c7Twr9lLM8fL
         dubDVnE2lJcpOGV93i0JeB2tfGGN1sBLfIOPUSm/nFsqdYKQtrTqr7NNJ0tUeUvsW24C
         usx5XcTDgxN24VtLhpFIA6Oru0UMXfjoICi9tSWx05mygS6UiMmdpEUKwm9RaSBhzrET
         zHB7WZcWofDK03NrU6WwPj83sG3+qGeYzn/40/vRBQJYuLln1VWQceZUrX5UD0sFH33g
         eE90m0B1siN9McndU7oC7pvrVBxOY+RqfGsGW2MQmmjqw2BbYAV4MU7iSlgUaDyrmITt
         qdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ofUDbLHG16kE9QAcbRQpoQvk7CR0AkJFCKUXTKtC44=;
        b=RY9S3ShXfKahA67X5o/2uoa7/DCyu/1GPnck5s4g+sTfWibaQtQKmATvhpn0AgNLrE
         35yXGgTA+WBQ1TN/6T50bU3b2r6F0Na7pKE75RCcPYV7xfiUOJsWgT7FaxCKYhGl2EQl
         zW/Xt6Tyv2BITzsf23ki+yAQNZmlr8PMwA5oj8+S6q1/BqIdaNwftzt6VG8x0YF9woQZ
         1sBfvabVv2RdjhOkJh/zA1eh0pAJEGeIG02Zv9J79/aw/YLmVg56s4+YKpDDJhaAmPhW
         a9Nq4h+QzQrk05DcdASFSgdO38Y/Y0c3fT3gZLhvTWEkEy7ImDe1Qxl3jigw7cnM8dMG
         UsIg==
X-Gm-Message-State: AO0yUKVKRUNlYZj7dECRjmu1vopeRBzBjZxXcSkcWZBZSXK7Sh7uv+wm
        YIeDqZUtPNrWK4NFeZLGQ4M=
X-Google-Smtp-Source: AK7set+DDlWiHW7Hls6qR9I6dt+/fhgbJ+dCtqtq/9xWU5dXtD8B91MXtfNyHNWiLQrJJd+56t364g==
X-Received: by 2002:a05:600c:4b29:b0:3e2:147f:ac16 with SMTP id i41-20020a05600c4b2900b003e2147fac16mr4174487wmp.10.1676650261940;
        Fri, 17 Feb 2023 08:11:01 -0800 (PST)
Received: from angelo-ThinkPad-X270.. (host085115199111.static.fidoka.tech. [85.115.199.111])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b002c567881dbcsm4609792wrt.48.2023.02.17.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:11:00 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        linux-pwm@vger.kernel.org (open list:GENERIC PWM SERVO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] misc: servo-pwm: Add sysfs entries to control motor angle
Date:   Fri, 17 Feb 2023 17:10:36 +0100
Message-Id: <20230217161038.3130053-2-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217161038.3130053-1-angelo@amarulasolutions.com>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
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

Servo motor can be moved between 0 and degrees angle.

Add 'angle' sysfs attribute:
  *read*: Current motor position.
  *write*: Moves the motor to the position.

Add 'degrees' sysfs attribute:
  *read*: how many degrees the motor can move

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
v2:
* Added ABI in testing
v3:
* No changes

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

