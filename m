Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13A73CD6E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFXXRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFXXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:17:34 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C701A1;
        Sat, 24 Jun 2023 16:17:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b5915d0816so1679562a34.1;
        Sat, 24 Jun 2023 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687648652; x=1690240652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WdDt11MYZioKMB3gqCGdUJFk6irWr34L7VPfhui5X0=;
        b=QF2t+42ZS3kkfqWiy5x68D9/icqbQeVXG7007BWDQvOdK8xdc0E811AzokmBtAg1dM
         4qDoC1sl12bC0wyeeIl1ZdXwWJHaDmwTgQw66+snmRa0+RrDSYHKnoBdRPH23Aaoi18r
         ZdyFG2LCoh8fYMfRhM8K+b22Xp+/uK+YAyn0MIGAPJA7yKx40+T8gy2q5j+KQH/qeV4S
         gQee7pB6JeqBKrYLfftanC81JRVHDpjBYpg+3BHo0230YkdyH1yqOEogQXup1B7Jv6xU
         6g6B05P871MzJQicDhVIe3Vj1kTA3ItZ3yM0s+QudcSCCsmnlzKt0Ad16zDBUQjiV3LU
         Pcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687648652; x=1690240652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WdDt11MYZioKMB3gqCGdUJFk6irWr34L7VPfhui5X0=;
        b=eGucHQAUQxYHRLxEATE7ZH68QKAa2rkAVt4gMGAY8fu9MQIj4dU76806ARtBu2OtGm
         AmVNBtOCDD1XGtTzO4c2gJO8Rn3GHIVrRxRU64VmjNCzlk9NVfrcggDKpIE9w6K27XGP
         5q1JhCyjlIGB8cCXztsYIt9qmfYkoZQkr9ecxvWyUEnSCb6muqbvH+iIxkaFO1jfakmV
         u0De9ZAr8iR95bO44dJ+4UjHefypqQER2PA8AHX1DZecL9h2HGzxkE5rpi3QEertsV3d
         kqiobLWr3unyTr7VoX7S20mXh7StnYwKb3b0Bg6Xi62ecWoPBuQQipHZr1Mi+MvR1uFu
         lPeQ==
X-Gm-Message-State: AC+VfDxCwrDuPr8rbK/UAIclZsqzyCCvVLOq1JcLfIIFTx8GcWQqj8i3
        XiJ9pREiK0r37ames+RA3aFrbStm6vE=
X-Google-Smtp-Source: ACHHUZ7vVQSxbHx2xn9+X8KL47TXb/MKqY3Q4envHApbfY3f5paoMuiF/bR7e3Lfcke87zfacr8u2w==
X-Received: by 2002:a9d:61d0:0:b0:6b7:3fda:20d5 with SMTP id h16-20020a9d61d0000000b006b73fda20d5mr276236otk.32.1687648652223;
        Sat, 24 Jun 2023 16:17:32 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id h17-20020a9d6411000000b006b720475c38sm1189811otl.45.2023.06.24.16.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 16:17:30 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     Jerrod Frost <jcfrosty@proton.me>, derekjohn.clark@gmail.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH] hwmon: (oxp-sensors) Add support for AOKZOE A1 PRO
Date:   Sat, 24 Jun 2023 20:16:33 -0300
Message-ID: <20230624231637.14941-2-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jerrod Frost <jcfrosty@proton.me>

This device is an iteration over the AOKZOE A1 with the same EC mapping
and features. It also has support for tt_toggle.

Thanks to Jerrod for authoring and testing.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst | 2 ++
 drivers/hwmon/oxp-sensors.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 0ca1f7728c34..3adeb7406243 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -30,6 +30,7 @@ Supported devices
 Currently the driver supports the following handhelds:
 
  - AOK ZOE A1
+ - AOK ZOE A1 PRO
  - Aya Neo 2
  - Aya Neo AIR
  - Aya Neo AIR Pro
@@ -40,6 +41,7 @@ Currently the driver supports the following handhelds:
 
 "Turbo/Silent" button behaviour toggle is only supported on:
  - AOK ZOE A1
+ - AOK ZOE A1 PRO
  - OneXPlayer mini AMD (only with updated alpha BIOS)
  - OneXPlayer mini AMD PRO
 
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 1e59d97219c4..e1a907cae820 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -77,6 +77,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aok_zoe_a1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AOKZOE A1 Pro"),
+		},
+		.driver_data = (void *)aok_zoe_a1,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.41.0

