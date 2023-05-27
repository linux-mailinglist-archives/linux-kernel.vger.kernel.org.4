Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0A713470
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjE0LaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjE0L36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:29:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04AE1A7;
        Sat, 27 May 2023 04:29:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6d01d390bso17285435e9.2;
        Sat, 27 May 2023 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685186970; x=1687778970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2brWjtv6jnUkszMlshgHY3ZyYZyBqSw+5iV+JVswSb0=;
        b=L5KTMgIiO/9V/rW4UXd0/vNZfWmTYhjyXHCbvHtt0VKY+AKdbZ7oX40PlkENMWbE9g
         K66ZFmZTvYt/SquTaVZ9HtkkIo4f82yQtzES8UmCTXUGZna2RFLZ67Rf3pubApXWkN7E
         1Pi7CWsneHZLN54rJYhapKyzLt/ysq14OejARHNd563g7qgaLVco+vklV9z+NwaoXEmf
         rCIrRCj5eArvytFoj1glHriVa4BU5zzJgU1fqKBNXEEar6fHbo0XjK/3VV2PuCMWs1wv
         2/kdKhn0xJdGYhqYWS0wbogCQOBCT9iUgvd3mS+K2AlGRiT4y2vIbzKXB9CFlcxGsDUT
         JpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685186970; x=1687778970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2brWjtv6jnUkszMlshgHY3ZyYZyBqSw+5iV+JVswSb0=;
        b=XukrCTKq4yhz4yAM44WeM2gMNG5vLtntJu7vLXZ52VzEC30CTc8EykzMxFDc+lYsGn
         2WBHQOcpy9br6vI35OkN9R45jfYWa3DrpSA8EP2jTaGtU23KJUH76KaLsZ5O2+Ix7YQj
         clMHy7G/L5NialdVr9/60gpP5EW5xo66XOHzeXc3+KZkhuUh074CzNrE6+6YJkKb4mwl
         lZGutH/JPXOGVyG9Se+lzQ/9/45Dg/TSGcr8KjO35OS1vZHWJFWBGOyBG7UJMIngMnrd
         tnM7IYCyAZ16lgD4i6Bw4psnPpucFQmBiOaC5XYQAxHjujsJVJF81C/m3+zOwzhPirzx
         llCw==
X-Gm-Message-State: AC+VfDy7jzTaaY6xiNOX6fLCgpCFBGidXMtbJ45UTmtHYiVwN2o9t5XL
        epBXNJFFBh17ciSiAN1n7ng=
X-Google-Smtp-Source: ACHHUZ7J1/hGeRrCVmt7IjZL29fn2EaxyD79iKVAh1CqYUQqBhrwRLrnqK4MwhFnyEeWb1ULitFV/Q==
X-Received: by 2002:a05:600c:b54:b0:3f4:2174:b28a with SMTP id k20-20020a05600c0b5400b003f42174b28amr4097003wmr.15.1685186970261;
        Sat, 27 May 2023 04:29:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id q13-20020a7bce8d000000b003f43f82001asm11711000wmj.31.2023.05.27.04.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:29:29 -0700 (PDT)
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
Subject: [net-next PATCH v3 13/13] net: dsa: qca8k: add op to get ports netdev
Date:   Sat, 27 May 2023 13:28:54 +0200
Message-Id: <20230527112854.2366-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230527112854.2366-1-ansuelsmth@gmail.com>
References: <20230527112854.2366-1-ansuelsmth@gmail.com>
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

From: Andrew Lunn <andrew@lunn.ch>

In order that the LED trigger can blink the switch MAC ports LED, it
needs to know the netdev associated to the port. Add the callback to
return the struct device of the netdev.

Add an helper function qca8k_phy_to_port() to convert the phy back to
dsa_port index, as we reference LED port based on the internal PHY
index and needs to be converted back.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-leds.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 1e0c61726487..6f02029b454b 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -5,6 +5,18 @@
 #include "qca8k.h"
 #include "qca8k_leds.h"
 
+static u32 qca8k_phy_to_port(int phy)
+{
+	/* Internal PHY 0 has port at index 1.
+	 * Internal PHY 1 has port at index 2.
+	 * Internal PHY 2 has port at index 3.
+	 * Internal PHY 3 has port at index 4.
+	 * Internal PHY 4 has port at index 5.
+	 */
+
+	return phy + 1;
+}
+
 static int
 qca8k_get_enable_led_reg(int port_num, int led_num, struct qca8k_led_pattern_en *reg_info)
 {
@@ -314,6 +326,20 @@ qca8k_cled_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
 	return 0;
 }
 
+static struct device *qca8k_cled_hw_control_get_device(struct led_classdev *ldev)
+{
+	struct qca8k_led *led = container_of(ldev, struct qca8k_led, cdev);
+	struct qca8k_priv *priv = led->priv;
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(priv->ds, qca8k_phy_to_port(led->port_num));
+	if (!dp)
+		return NULL;
+	if (dp->slave)
+		return &dp->slave->dev;
+	return NULL;
+}
+
 static int
 qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int port_num)
 {
@@ -377,6 +403,7 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		port_led->cdev.hw_control_is_supported = qca8k_cled_hw_control_is_supported;
 		port_led->cdev.hw_control_set = qca8k_cled_hw_control_set;
 		port_led->cdev.hw_control_get = qca8k_cled_hw_control_get;
+		port_led->cdev.hw_control_get_device = qca8k_cled_hw_control_get_device;
 		port_led->cdev.hw_control_trigger = "netdev";
 		init_data.default_label = ":port";
 		init_data.fwnode = led;
-- 
2.39.2

