Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05556E8312
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjDSVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjDSVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:08:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C1F5BB2;
        Wed, 19 Apr 2023 14:08:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f0a80b686eso1202865e9.1;
        Wed, 19 Apr 2023 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681938499; x=1684530499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnAvpgJtv8CT4PCBV0v1f+gT06nFs4wcweY9SHoaOe4=;
        b=Gxa5hgO2fbz+1mGgBavdX42YSG9adBCLJcXMD7lqySdsOWAigehdu2GrvA89FsztyZ
         fWHnK7y5Qmf1xDw5VH+PXzYWRg1SFbg83ffni13yXtOz07yM2vaCopXbgeJysOVgIuOR
         Sgx/hDM7Oy0ndZzQTOXUrDyrnjMlOZZKhBgu2od8189h9TZa5tTVGtydgmH+D1BZIb9A
         KQ9SmTaqjIT/l8UXf85hunnBzjGFUY6ZBn30r/URt/Gsr1fcwVRb2tzeOCNL+3OKEOKb
         ID+sYhUEDa1ZUMPQMGIKwvmsSB58+Ql/Jbd25cy6EXoEcW6FIzMVByArrRRvBv1IP25/
         H4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938499; x=1684530499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnAvpgJtv8CT4PCBV0v1f+gT06nFs4wcweY9SHoaOe4=;
        b=l/tNdxdcahjvwm78x1j+GilU3/iw/R8KqvkCDbZzATviu2WAl8AsGrAg8HYm5q2A0Q
         Z9YXQLAT9YnRiIZzsXdXFOqFm3/V241pYyjhrJU4a63zr3bIt8j4cXfgsz1sb4QddqrH
         LnWRhoe/uD181s9C4+ArIPCWath+jMUxaDPH2Xv9LpCkz8V0EkUgYH0sCxDOIQU/eS5/
         h1XsFGsfzlYlC+CetA16LjWThDu5QaT4nv0JKPu5PDMPp2tBnF6QLr32ve6QPvXT2i23
         9zRhf0gFK5LJBOUNbccCQ5tZk6onIAI/CvQp2vrYEUNgF80cwI9/PykoWQlFu3sJbcBs
         iDWg==
X-Gm-Message-State: AAQBX9cG12kyzsy8XKSdM6LRBXua/kJGLlFlqbMXHJI+fq3931C7hY+o
        40UQwuEhMQ2i8lkOh0lx+q8=
X-Google-Smtp-Source: AKy350ZGUISU3+H5QR9F3j7kQaZJkQ1GTvwjCNUWa1lBywwNB8Cr/v6vUVQMlFDqIeCsWtigsf0MrQ==
X-Received: by 2002:adf:e791:0:b0:2fc:7a4:839b with SMTP id n17-20020adfe791000000b002fc07a4839bmr5380969wrm.61.1681938498828;
        Wed, 19 Apr 2023 14:08:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm81295wrw.92.2023.04.19.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:08:18 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 4/5] leds: trigger: netdev: convert device attr to macro
Date:   Wed, 19 Apr 2023 23:07:42 +0200
Message-Id: <20230419210743.3594-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419210743.3594-1-ansuelsmth@gmail.com>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
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

Convert link tx and rx device attr to a common macro to reduce common
code and in preparation for additional attr.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 57 ++++++++-------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 0d4649e7a84d..5a47913c813c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -198,47 +198,22 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	return size;
 }
 
-static ssize_t link_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	return netdev_led_attr_show(dev, buf, NETDEV_ATTR_LINK);
-}
-
-static ssize_t link_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t size)
-{
-	return netdev_led_attr_store(dev, buf, size, NETDEV_ATTR_LINK);
-}
-
-static DEVICE_ATTR_RW(link);
-
-static ssize_t tx_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	return netdev_led_attr_show(dev, buf, NETDEV_ATTR_TX);
-}
-
-static ssize_t tx_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t size)
-{
-	return netdev_led_attr_store(dev, buf, size, NETDEV_ATTR_TX);
-}
-
-static DEVICE_ATTR_RW(tx);
-
-static ssize_t rx_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	return netdev_led_attr_show(dev, buf, NETDEV_ATTR_RX);
-}
-
-static ssize_t rx_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t size)
-{
-	return netdev_led_attr_store(dev, buf, size, NETDEV_ATTR_RX);
-}
-
-static DEVICE_ATTR_RW(rx);
+#define DEFINE_NETDEV_TRIGGER(trigger_name, trigger) \
+	static ssize_t trigger_name##_show(struct device *dev, \
+		struct device_attribute *attr, char *buf) \
+	{ \
+		return netdev_led_attr_show(dev, buf, trigger); \
+	} \
+	static ssize_t trigger_name##_store(struct device *dev, \
+		struct device_attribute *attr, const char *buf, size_t size) \
+	{ \
+		return netdev_led_attr_store(dev, buf, size, trigger); \
+	} \
+	static DEVICE_ATTR_RW(trigger_name)
+
+DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
+DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
+DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
 
 static ssize_t interval_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
-- 
2.39.2

