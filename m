Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C796BBF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjCOWDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCOWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:03:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AADF12F34
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:03:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so127617edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1678917812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnIAkjWXLUKxgzUQABaGNBsVC0Xz294v/24zmIaU2fM=;
        b=DpCdtNKqrJEpglsHttbfk5MuRbcmjFPga1OslUNdmfD/UWOmZsysmL9NCLnHMOWCAC
         r4wyvPyQe9HU/7ppEmyHGXOpWBy9zuJQ4vM55QnC3eIiLPjqAmFmFVBUSblHdBrMMooN
         bqgvNadWzhZF7bBiCnO18X32jRfrofakoKD8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678917812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnIAkjWXLUKxgzUQABaGNBsVC0Xz294v/24zmIaU2fM=;
        b=PvIpigRlFpbK6raFRa5oe3ZwMxp6uStXrQiU4jzEx06b9DDnVnWb7RuL64BEB+/bD5
         0UZYKA+t+3+7vN4SQjuqM4qKHwrU96t1MZTMbtJ2JOb0gTHviCdBeyjNQz5j2meHgUtV
         zY5MtC99uM1u+c8PcDlUB/kxnhK7M7dJyHs6fzBONl7GwqTUEA74/Z9ZdLdQG06E/SXK
         e19HrYACWJfBP1aAtBSYfVdVHtoxb/1p5DJpEmDS5GyvC+NwfkhGo4tN7DVo+L6TyDdR
         NSty+eH9OqhG/mLe10fXcyafRh2haw9i9ebcv89YJE2sYBONpZVVHhSRtEj/TQKCmebg
         buUw==
X-Gm-Message-State: AO0yUKU/5Ru1GUdLRhgJblaCIl5d3FQCMSANU41eDt9IafUQHZqdWiiw
        IvrOzps+h4xFJPw2/+MQxOVqvQ==
X-Google-Smtp-Source: AK7set+c6kRURg/XTaPJOw/AwnvlL71fnfHG29iNJ1qv4jZM5mlTgjJV1+4Ocy6RLEjCiTuFHfEUeA==
X-Received: by 2002:a17:907:a649:b0:8f0:143d:ee34 with SMTP id vu9-20020a170907a64900b008f0143dee34mr9029863ejc.1.1678917811806;
        Wed, 15 Mar 2023 15:03:31 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id tk13-20020a170907c28d00b0090e0a4e1bacsm2995733ejc.159.2023.03.15.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:03:31 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
Date:   Wed, 15 Mar 2023 23:02:46 +0100
Message-Id: <20230315220246.951213-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315220246.951213-1-alvin@pqrs.dk>
References: <20230315220246.951213-1-alvin@pqrs.dk>
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

The connector child node of the TUSB320 device might be linked with a
USB OTG controller with USB role switch capability. Add driver support
for detecting a usb_role_switch and setting its state in the typec
interrupt handler. This follows similar practice in other drivers in the
typec subsystem, which this extcon driver can opt-in to.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/extcon/extcon-usbc-tusb320.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 882d1f48495e..44b55650b6b4 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -16,6 +16,7 @@
 #include <linux/regmap.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
+#include <linux/usb/role.h>
 
 #define TUSB320_REG8				0x8
 #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
@@ -80,6 +81,7 @@ struct tusb320_priv {
 	enum typec_port_type port_type;
 	enum typec_pwr_opmode pwr_opmode;
 	struct fwnode_handle *connector_fwnode;
+	struct usb_role_switch *role_sw;
 };
 
 static const char * const tusb_attached_states[] = {
@@ -275,9 +277,11 @@ static void tusb320_extcon_irq_handler(struct tusb320_priv *priv, u8 reg)
 
 static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 {
+	struct usb_role_switch *role_sw = priv->role_sw;
 	struct typec_port *port = priv->port;
 	struct device *dev = priv->dev;
 	int typec_mode;
+	enum usb_role usb_role;
 	enum typec_role pwr_role;
 	enum typec_data_role data_role;
 	u8 state, mode, accessory;
@@ -300,11 +304,13 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 	switch (state) {
 	case TUSB320_ATTACHED_STATE_DFP:
 		typec_mode = TYPEC_MODE_USB2;
+		usb_role = USB_ROLE_HOST;
 		pwr_role = TYPEC_SOURCE;
 		data_role = TYPEC_HOST;
 		break;
 	case TUSB320_ATTACHED_STATE_UFP:
 		typec_mode = TYPEC_MODE_USB2;
+		usb_role = USB_ROLE_DEVICE;
 		pwr_role = TYPEC_SINK;
 		data_role = TYPEC_DEVICE;
 		break;
@@ -316,6 +322,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 		if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
 		    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
 			typec_mode = TYPEC_MODE_AUDIO;
+			usb_role = USB_ROLE_NONE;
 			pwr_role = TYPEC_SINK;
 			data_role = TYPEC_DEVICE;
 			break;
@@ -323,12 +330,14 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP) {
 			typec_mode = TYPEC_MODE_DEBUG;
 			pwr_role = TYPEC_SOURCE;
+			usb_role = USB_ROLE_HOST;
 			data_role = TYPEC_HOST;
 			break;
 		} else if (accessory ==
 			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP) {
 			typec_mode = TYPEC_MODE_DEBUG;
 			pwr_role = TYPEC_SINK;
+			usb_role = USB_ROLE_DEVICE;
 			data_role = TYPEC_DEVICE;
 			break;
 		}
@@ -339,6 +348,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 		fallthrough;
 	default:
 		typec_mode = TYPEC_MODE_USB2;
+		usb_role = USB_ROLE_NONE;
 		pwr_role = TYPEC_SINK;
 		data_role = TYPEC_DEVICE;
 		break;
@@ -348,6 +358,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 	typec_set_pwr_role(port, pwr_role);
 	typec_set_data_role(port, data_role);
 	typec_set_mode(port, typec_mode);
+	usb_role_switch_set_role(priv->role_sw, usb_role);
 
 	mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
 	if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
@@ -472,10 +483,20 @@ static int tusb320_typec_probe(struct i2c_client *client,
 		goto err_put;
 	}
 
+	/* Find any optional USB role switch that needs reporting to */
+	priv->role_sw = fwnode_usb_role_switch_get(connector);
+	if (IS_ERR(priv->role_sw)) {
+		ret = PTR_ERR(priv->role_sw);
+		goto err_unreg;
+	}
+
 	priv->connector_fwnode = connector;
 
 	return 0;
 
+err_unreg:
+	typec_unregister_port(priv->port);
+
 err_put:
 	fwnode_handle_put(connector);
 
@@ -484,6 +505,7 @@ static int tusb320_typec_probe(struct i2c_client *client,
 
 static void tusb320_typec_remove(struct tusb320_priv *priv)
 {
+	usb_role_switch_put(priv->role_sw);
 	typec_unregister_port(priv->port);
 	fwnode_handle_put(priv->connector_fwnode);
 }
-- 
2.39.2

