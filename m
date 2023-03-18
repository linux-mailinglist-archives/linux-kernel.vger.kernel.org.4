Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07F6BFB1A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCRPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:06:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256F34F51
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:06:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so6767332wrh.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1679151969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUAy70Y4flVHOO6/NxtK8gNZM/g6UbSdwdapwKKHF+s=;
        b=MPmDTLtLTbZA1uxoZTGV+exzuA5S4+YxgosovywX0117X5g6JrIODPWedYpcn6V0eE
         ihYcSVflxoVbtPirmMCJswgQj4af45oyrLk/Eyb90fmEzOTJ5uFKG5kSXUK5SofSuQmz
         i0x6B+0WC5hnSw+LbSO5865YHS4/mudU5UMbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUAy70Y4flVHOO6/NxtK8gNZM/g6UbSdwdapwKKHF+s=;
        b=gfSEG4c8acxOji4F6tHDzKhTzUSFEhVKKAkrWQdtHtOhOBbVgvdPfGykG2fRLwtnvz
         iBKZJHG/1KvvxOv1Gke8XpNXQEwW8fdcq5YVScrmOYXcdJP1Qd8i4lsiNzV0Oyoc1OLe
         /NNSa+9ZwNHrQFbvduht/Bvaex2Bs5Ebfsktydgq3qs4GDGjxrH0ADLhKOiX8bKhCUWN
         cBVtGp4oum6R97G45Ndw+xirH0NwlSCbQVyl2J3/qsmEgyHMpV488qVtXr67CrbtCQnJ
         Yg6Hr2Oox36s4ZfGPRZ9e59KD7QhaE5D/EgAEghI6Sb8LJN8WEPztq+BvrqQyikB39++
         8zCw==
X-Gm-Message-State: AO0yUKW1/z1VDUwjeF481VJ7C4c7NcI4KQkxDuu1KnLeXQJm6y+GYL1M
        sfPvRSB8H6eXLYlq6n+Pm0wO+A==
X-Google-Smtp-Source: AK7set/iE8DJdLs+CnPZ9FRmHsL3P3kLuSsfEL/m40dApWv4FnUsIXIRGWdS0tNxieV73JC6GApdrQ==
X-Received: by 2002:a05:6000:120d:b0:2d2:d65f:9309 with SMTP id e13-20020a056000120d00b002d2d65f9309mr5434987wrx.55.1679151969473;
        Sat, 18 Mar 2023 08:06:09 -0700 (PDT)
Received: from localhost.localdomain ([185.248.85.32])
        by smtp.gmail.com with ESMTPSA id c15-20020adfef4f000000b002c7066a6f77sm4522996wrp.31.2023.03.18.08.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:06:09 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] extcon: usbc-tusb320: add accessory detection support
Date:   Sat, 18 Mar 2023 16:05:53 +0100
Message-Id: <20230318150555.1705749-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The TUSB320 can detect the following types of accessory:

  - Audio Accessory
  - Audio Accessory with charge-thru
  - Debug Accessory (DFP)
  - Debug Accessory (UFP)

Moreover, the typec subsystem can be informed of this through the
typec_set_mode() function. The information will be propagated to any
linked typec muxes. Add the necessary support to the driver.

Note that for the Debug Accessory modes, an educated guess was made that
for the USB data role, DFP implies HOST and UFP implies DEVICE. But this
might want to be made configurable at a later date.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v3: add Heikki's Acked-by
v2: no change
---
 drivers/extcon/extcon-usbc-tusb320.c | 90 +++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 22 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 10dff1c512c4..882d1f48495e 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_altmode.h>
 
 #define TUSB320_REG8				0x8
 #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
@@ -26,16 +27,16 @@
 #define TUSB320_REG8_CURRENT_MODE_DETECT_MED	0x1
 #define TUSB320_REG8_CURRENT_MODE_DETECT_ACC	0x2
 #define TUSB320_REG8_CURRENT_MODE_DETECT_HI	0x3
-#define TUSB320_REG8_ACCESSORY_CONNECTED	GENMASK(3, 2)
+#define TUSB320_REG8_ACCESSORY_CONNECTED	GENMASK(3, 1)
 #define TUSB320_REG8_ACCESSORY_CONNECTED_NONE	0x0
 #define TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO	0x4
-#define TUSB320_REG8_ACCESSORY_CONNECTED_ACC	0x5
-#define TUSB320_REG8_ACCESSORY_CONNECTED_DEBUG	0x6
+#define TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG	0x5
+#define TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP	0x6
+#define TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP	0x7
 #define TUSB320_REG8_ACTIVE_CABLE_DETECTION	BIT(0)
 
 #define TUSB320_REG9				0x9
-#define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
-#define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
+#define TUSB320_REG9_ATTACHED_STATE		GENMASK(7, 6)
 #define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
 #define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
 
@@ -250,8 +251,7 @@ static void tusb320_extcon_irq_handler(struct tusb320_priv *priv, u8 reg)
 {
 	int state, polarity;
 
-	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
-		TUSB320_REG9_ATTACHED_STATE_MASK;
+	state = FIELD_GET(TUSB320_REG9_ATTACHED_STATE, reg);
 	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
 
 	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
@@ -277,32 +277,78 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 {
 	struct typec_port *port = priv->port;
 	struct device *dev = priv->dev;
-	u8 mode, role, state;
+	int typec_mode;
+	enum typec_role pwr_role;
+	enum typec_data_role data_role;
+	u8 state, mode, accessory;
 	int ret, reg8;
 	bool ori;
 
+	ret = regmap_read(priv->regmap, TUSB320_REG8, &reg8);
+	if (ret) {
+		dev_err(dev, "error during reg8 i2c read, ret=%d!\n", ret);
+		return;
+	}
+
 	ori = reg9 & TUSB320_REG9_CABLE_DIRECTION;
 	typec_set_orientation(port, ori ? TYPEC_ORIENTATION_REVERSE :
 					  TYPEC_ORIENTATION_NORMAL);
 
-	state = (reg9 >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
-		TUSB320_REG9_ATTACHED_STATE_MASK;
-	if (state == TUSB320_ATTACHED_STATE_DFP)
-		role = TYPEC_SOURCE;
-	else
-		role = TYPEC_SINK;
+	state = FIELD_GET(TUSB320_REG9_ATTACHED_STATE, reg9);
+	accessory = FIELD_GET(TUSB320_REG8_ACCESSORY_CONNECTED, reg8);
+
+	switch (state) {
+	case TUSB320_ATTACHED_STATE_DFP:
+		typec_mode = TYPEC_MODE_USB2;
+		pwr_role = TYPEC_SOURCE;
+		data_role = TYPEC_HOST;
+		break;
+	case TUSB320_ATTACHED_STATE_UFP:
+		typec_mode = TYPEC_MODE_USB2;
+		pwr_role = TYPEC_SINK;
+		data_role = TYPEC_DEVICE;
+		break;
+	case TUSB320_ATTACHED_STATE_ACC:
+		/*
+		 * Accessory detected. For debug accessories, just make some
+		 * qualified guesses as to the role for lack of a better option.
+		 */
+		if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
+		    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
+			typec_mode = TYPEC_MODE_AUDIO;
+			pwr_role = TYPEC_SINK;
+			data_role = TYPEC_DEVICE;
+			break;
+		} else if (accessory ==
+			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP) {
+			typec_mode = TYPEC_MODE_DEBUG;
+			pwr_role = TYPEC_SOURCE;
+			data_role = TYPEC_HOST;
+			break;
+		} else if (accessory ==
+			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP) {
+			typec_mode = TYPEC_MODE_DEBUG;
+			pwr_role = TYPEC_SINK;
+			data_role = TYPEC_DEVICE;
+			break;
+		}
 
-	typec_set_vconn_role(port, role);
-	typec_set_pwr_role(port, role);
-	typec_set_data_role(port, role == TYPEC_SOURCE ?
-				  TYPEC_HOST : TYPEC_DEVICE);
+		dev_warn(priv->dev, "unexpected ACCESSORY_CONNECTED state %d\n",
+			 accessory);
 
-	ret = regmap_read(priv->regmap, TUSB320_REG8, &reg8);
-	if (ret) {
-		dev_err(dev, "error during reg8 i2c read, ret=%d!\n", ret);
-		return;
+		fallthrough;
+	default:
+		typec_mode = TYPEC_MODE_USB2;
+		pwr_role = TYPEC_SINK;
+		data_role = TYPEC_DEVICE;
+		break;
 	}
 
+	typec_set_vconn_role(port, pwr_role);
+	typec_set_pwr_role(port, pwr_role);
+	typec_set_data_role(port, data_role);
+	typec_set_mode(port, typec_mode);
+
 	mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
 	if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
 		typec_set_pwr_opmode(port, TYPEC_PWR_MODE_USB);
-- 
2.39.2

