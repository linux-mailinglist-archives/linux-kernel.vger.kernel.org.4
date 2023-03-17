Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB16BE712
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCQKnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCQKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:42:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A36AB88B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:42:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so18569837ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1679049766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkfNtTihu45jzEqQQleEFOaEIxvSCDmLNTTKMA47LCc=;
        b=T0xpT7kvD9ovyo6CNPlz8NeB0CSRIN6ehsEtQsnCvIKUt8asgWqjii0ZmQAi7dBTwd
         OQxFN1LInWJuVDrtbp1tkap80Tiu5gr9/XQ9xp/S6ZfdmUgnzWaP1kC/FitY/2x6jyV6
         neJSMovfubqclwIfM0MCjhmptZ4AqutElCThU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679049766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkfNtTihu45jzEqQQleEFOaEIxvSCDmLNTTKMA47LCc=;
        b=s/eJDYmbZnBfRHTpB2PYERygfTm1y0uqvT1iDqpKGqRO+8bwDyuuN69ATSCpRbL9MR
         C6I56GeoAgzVT+9YEPoZqOnaW/aTqCdpHs42c9PV4R8EqlMRKXEAwDjDSPCHGFfRiQut
         +LjQRHyLbqpUAHr6mMrK+I0GUXCRuZXlS4kwIl/INhATuo5xacbOmYH76WtOvxGYR/B5
         cxA4Oybm+CHCxxXw5vFOzieJ02S54x2Y1mT2P/AIAXxlQ8Pq4S7bnJvBdzhDGbKjNfGL
         6dHPrFpaSEA4wLdyepKt00l9/XTivn1/zsa2uu8/kgGZDefkty76/0Q51MEmoghq/5Sb
         asvQ==
X-Gm-Message-State: AO0yUKW6NJL8ux4ShCspa5RPGMg/dLEDwafkGEea4cLawQd/WUYwkRmb
        iPwBaoAqzOhOwCDywvV5SrPpMg==
X-Google-Smtp-Source: AK7set++hMIxaZKWRaCBbsvPOCseXshHFD/kENQSovsW16TP8BG+38vlEH+SAmQpsYBACT3jw68Lwg==
X-Received: by 2002:a17:906:6a28:b0:930:ba36:2211 with SMTP id qw40-20020a1709066a2800b00930ba362211mr6837498ejc.0.1679049766698;
        Fri, 17 Mar 2023 03:42:46 -0700 (PDT)
Received: from localhost.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906314500b009236ae669ecsm816144eje.191.2023.03.17.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:42:46 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
Date:   Fri, 17 Mar 2023 11:42:28 +0100
Message-Id: <20230317104229.1392742-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317104229.1392742-1-alvin@pqrs.dk>
References: <20230317104229.1392742-1-alvin@pqrs.dk>
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

