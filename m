Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743CA6BE710
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCQKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCQKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:42:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6315378CB1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:42:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so18462752edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1679049765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mzN/37UoYXUZaB9D3Kvm+oDNKKugvTJRDf02rBTRys=;
        b=mbOx0ApqHiRq7wPARubyIPBIX+wNc6krXZwwVEumSxZJMbtTu7p6cgaitvyO6C+SMb
         E0pjhB6uenC5fFMCQr0d3vw5ml2WQ1A08n2ba0WAF1QJ7h2wlgnVilM0xOBC8a08dFSH
         83A/pM2xDe/8im3WqN9Cs9UHF4/zFemO9PZ/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679049765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mzN/37UoYXUZaB9D3Kvm+oDNKKugvTJRDf02rBTRys=;
        b=aPnMJ53JbiOiKK5IZ50HL4FB1GpqFVpoTbc9SY0Q9w4C4eIbKOUgZPBx1J9ZCVPiAV
         stdo2RfcNV5Zx4dhWPDRGPERhSSIzpDBw+SDIMxQ3poM51IoqRn79CubHHjpLR5Y8O9e
         HL9zHuxZUkI1WTBcC7C/1jS+XSSpX3q99py8SRTT9x0Cqyy7cR4Zx5rDQgSIee3ijrKQ
         V6F5bHPmerXxGyTAvhBxkh3NT12/UoYCJefssZ+l954NtSbzP+FU9uUPUnRjd44D9W0j
         CTrMhdAihkiGwrFFIJKg+vrOgGJg3BUbsJmWJUh38Qp1Attz4EedD3xB0UgS0rT15weV
         keFg==
X-Gm-Message-State: AO0yUKXqKFpMYFWkJgb7dchJZFZVfwocsNGahD4T3db8hXWxlTmM8yIK
        oYcjP3cq43WRmfswDzSnBsvN2A==
X-Google-Smtp-Source: AK7set/A3JcjdNLJx52qZo3Imzp237XXegZMjJzgTtom2W6zEiWpF7C0hM0xWzAEz4eM3T79GXx01g==
X-Received: by 2002:a17:906:4e92:b0:878:72d0:2817 with SMTP id v18-20020a1709064e9200b0087872d02817mr13248540eju.29.1679049764924;
        Fri, 17 Mar 2023 03:42:44 -0700 (PDT)
Received: from localhost.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906314500b009236ae669ecsm816144eje.191.2023.03.17.03.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:42:44 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] extcon: usbc-tusb320: add accessory detection support
Date:   Fri, 17 Mar 2023 11:42:27 +0100
Message-Id: <20230317104229.1392742-1-alvin@pqrs.dk>
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
---
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

