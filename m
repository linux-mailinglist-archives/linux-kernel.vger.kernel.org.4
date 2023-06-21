Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4B73A08F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFVMJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFVMJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:09:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453CE171C;
        Thu, 22 Jun 2023 05:09:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa70ec8d17so5614475e9.1;
        Thu, 22 Jun 2023 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687435781; x=1690027781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAhK5ptsDBv64jGlJql6+rkKJiLJ8n12yCAtGqe3FGM=;
        b=aLeAta5Jy97A7BxULGxrE+pm6Crwgr/JVxvKHVrQ0gCCSAc6+UK+NCez7tCi9M++80
         tAvs/H1xw7drVND1sl+uvWyeqE0nns1Kvv7Tcthg8x3n1cQUzKqhJv3vex6IA3RiF7b9
         MRSAXxb607ONdUiLsLJ3J7MqK5dmdnK9w+4a07JLUgCvMDKq9TZ3257KzimmEc8bnTJ5
         rkF2Fk/oYADEDRTGl3m57UGV9Z6emH5ZmGT7oKI2Fmg+rmk821WC4jfXOsOv7xZGqPD8
         ZmmRRdOaf7L2axbizBq7GW+Q9GO2fYYgwx74/L9KK7uq9ragpFuqVR53SqEFUIvnlshX
         Y7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435781; x=1690027781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAhK5ptsDBv64jGlJql6+rkKJiLJ8n12yCAtGqe3FGM=;
        b=d/FVJlYCFw6EuD+T/sxQNtrn77Ir/hv7qlGMhn4yhIRuGEzw5AlSMMNNz7BBmT+poo
         00HxstdbOq09f+hpXcyXoORPEz+ml1L8LfNjVTIW7PIc5AqcgDxcyGMiZEPEOcsTBV6x
         lj8vMDZ6wccouW3PaovJHr0n7Ga7hCPGzrlk6ViLK3DzH7SNpNVzJtnqSTu5U7I5CLxE
         rLo7Oue6QU5rypJE74orpmvmtSb9F6RGmFHjkwbaoyJ6FDxr1Fz72dxUgiqUaCcwpH0A
         YWWB75mSSENzDjLRyeWyI8gNVVZCSs7prXEgZaAqASHHUbfReQ64nWeI1oeYLMkekgX4
         b2YQ==
X-Gm-Message-State: AC+VfDwe9rLPp8aWJovHk/ONfpN13O6I8ZCpxM9bavIY9BLuIN3QlN+X
        8E4tR/yo1vOEkbJqKyyAaIk=
X-Google-Smtp-Source: ACHHUZ6aEWn6QX4rcuuun6Fi61ABx2Gxlxx2npNn1gGehrLuBHa2CoR/BIVi2oA8qLwMnW3KRc8QKA==
X-Received: by 2002:a05:600c:3657:b0:3f6:8ba:6ea2 with SMTP id y23-20020a05600c365700b003f608ba6ea2mr16872598wmq.15.1687435780387;
        Thu, 22 Jun 2023 05:09:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id o6-20020a05600c378600b003f9c0a7c6bcsm3977773wmr.0.2023.06.22.05.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:09:40 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH] net: dsa: qca8k: add support for additional modes for netdev trigger
Date:   Wed, 21 Jun 2023 11:54:09 +0200
Message-Id: <20230621095409.25859-1-ansuelsmth@gmail.com>
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

The QCA8K switch supports additional modes that can be handled in
hardware for the LED netdev trigger.

Add these additional modes to further support the Switch LEDs and
offload more blink modes.

Add additional modes:
- link_10
- link_100
- link_1000
- half_duplex
- full_duplex

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-leds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 6f02029b454b..1261e0bb21ef 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -68,6 +68,16 @@ qca8k_parse_netdev(unsigned long rules, u32 *offload_trigger)
 		*offload_trigger |= QCA8K_LED_TX_BLINK_MASK;
 	if (test_bit(TRIGGER_NETDEV_RX, &rules))
 		*offload_trigger |= QCA8K_LED_RX_BLINK_MASK;
+	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		*offload_trigger |= QCA8K_LED_LINK_10M_EN_MASK;
+	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		*offload_trigger |= QCA8K_LED_LINK_100M_EN_MASK;
+	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		*offload_trigger |= QCA8K_LED_LINK_1000M_EN_MASK;
+	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+		*offload_trigger |= QCA8K_LED_HALF_DUPLEX_MASK;
+	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+		*offload_trigger |= QCA8K_LED_FULL_DUPLEX_MASK;
 
 	if (rules && !*offload_trigger)
 		return -EOPNOTSUPP;
@@ -322,6 +332,16 @@ qca8k_cled_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
 		set_bit(TRIGGER_NETDEV_TX, rules);
 	if (val & QCA8K_LED_RX_BLINK_MASK)
 		set_bit(TRIGGER_NETDEV_RX, rules);
+	if (val & QCA8K_LED_LINK_10M_EN_MASK)
+		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+	if (val & QCA8K_LED_LINK_100M_EN_MASK)
+		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+	if (val & QCA8K_LED_LINK_1000M_EN_MASK)
+		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+	if (val & QCA8K_LED_HALF_DUPLEX_MASK)
+		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+	if (val & QCA8K_LED_FULL_DUPLEX_MASK)
+		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
 
 	return 0;
 }
-- 
2.40.1

