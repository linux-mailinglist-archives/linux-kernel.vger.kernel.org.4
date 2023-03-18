Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F886BFB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCRPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCRPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:06:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A134F60
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:06:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h17so6759773wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1679151970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SEDJeUi4nsLFUSMCQcVvgjgip0UQkULl8wcmFVWidI=;
        b=K4NxlqA+zGeOoO2bVASSkaQPsmSwdcctBTsB3Fjsiak9v8clL/vcmPLyD8crHTtWfq
         AygOLoj6r0D39CqUmEq04veDmlg11hhaSZIzPKT9IBo2yCyDFbfwGLsBffcgmC14U1pp
         U4SWmBH5U8J68Xh6MzBuoiQVOXxowsOHlmpak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEDJeUi4nsLFUSMCQcVvgjgip0UQkULl8wcmFVWidI=;
        b=NC1v7uQXpfTSkTTCphzwYNYn0awzIDoXGHZrJm9h6Ld3V6OjnM12jvfDwNon4n9LVa
         Q8LqdHv+AT2ZNOwduzGnKwbJsi93YyaL+kJ/WvS4v0pB/ryxPa0j2pLep5qZaGHv5Flv
         58fBzwBX+r4cjexJ3TQtKiKowb2giOsR3Bm/BFnvt9i5Xm6LdaF1fJ7CG8Oz6WzdjDOF
         hpVvR4l9Mb3AIqKiApo+Zdv0gmR9Ez8IiIC7rg7SmnCOK2BrtFA7N9sHMomkm4Yxkuaw
         YOKXI6Rue9zYgnHBhvVgIgFwQEE+XoRVK5MbKJGXDSHVKbc7/hl87CRgpuaeZbhHDgIy
         TtHw==
X-Gm-Message-State: AO0yUKVYUIrHN3O+OK78o9UiOBKEbS05SBEHgxdLWOHjeSmez9lukHPm
        uw3jjRxBsxYsbjehA9qCu3PT6A==
X-Google-Smtp-Source: AK7set99z1VnJ8zaSN5NqDYpRHJj9CO1VQr3K5GAROqMLEyDNsSnG2BFyZEOikTOymIDDA7SEfluXQ==
X-Received: by 2002:adf:e348:0:b0:2cf:e70a:ad9e with SMTP id n8-20020adfe348000000b002cfe70aad9emr8707886wrj.46.1679151970545;
        Sat, 18 Mar 2023 08:06:10 -0700 (PDT)
Received: from localhost.localdomain ([185.248.85.32])
        by smtp.gmail.com with ESMTPSA id c15-20020adfef4f000000b002c7066a6f77sm4522996wrp.31.2023.03.18.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:06:10 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] extcon: usbc-tusb320: add usb_role_switch support
Date:   Sat, 18 Mar 2023 16:05:54 +0100
Message-Id: <20230318150555.1705749-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318150555.1705749-1-alvin@pqrs.dk>
References: <20230318150555.1705749-1-alvin@pqrs.dk>
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
dual-role capable USB controller. Add driver support for detecting a
usb_role_switch and setting its state in the typec interrupt handler.
This follows similar practice in other drivers in the typec subsystem,
which this extcon driver can opt-in to.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
v3: drop legacy "USB OTG" terminology in commit message; refer to a
    dual-role capable USB controller instead
v2: remove unused variable as reported by kernel test robot
---
 drivers/extcon/extcon-usbc-tusb320.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 882d1f48495e..cc2d0ac7c5f6 100644
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
@@ -278,6 +280,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 	struct typec_port *port = priv->port;
 	struct device *dev = priv->dev;
 	int typec_mode;
+	enum usb_role usb_role;
 	enum typec_role pwr_role;
 	enum typec_data_role data_role;
 	u8 state, mode, accessory;
@@ -300,11 +303,13 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
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
@@ -316,6 +321,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 		if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
 		    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
 			typec_mode = TYPEC_MODE_AUDIO;
+			usb_role = USB_ROLE_NONE;
 			pwr_role = TYPEC_SINK;
 			data_role = TYPEC_DEVICE;
 			break;
@@ -323,12 +329,14 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
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
@@ -339,6 +347,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 		fallthrough;
 	default:
 		typec_mode = TYPEC_MODE_USB2;
+		usb_role = USB_ROLE_NONE;
 		pwr_role = TYPEC_SINK;
 		data_role = TYPEC_DEVICE;
 		break;
@@ -348,6 +357,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
 	typec_set_pwr_role(port, pwr_role);
 	typec_set_data_role(port, data_role);
 	typec_set_mode(port, typec_mode);
+	usb_role_switch_set_role(priv->role_sw, usb_role);
 
 	mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
 	if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
@@ -472,10 +482,20 @@ static int tusb320_typec_probe(struct i2c_client *client,
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
 
@@ -484,6 +504,7 @@ static int tusb320_typec_probe(struct i2c_client *client,
 
 static void tusb320_typec_remove(struct tusb320_priv *priv)
 {
+	usb_role_switch_put(priv->role_sw);
 	typec_unregister_port(priv->port);
 	fwnode_handle_put(priv->connector_fwnode);
 }
-- 
2.39.2

