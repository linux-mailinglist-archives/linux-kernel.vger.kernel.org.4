Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5556162337E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKITaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKITaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:30:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0DA474;
        Wed,  9 Nov 2022 11:30:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 130so17629343pfu.8;
        Wed, 09 Nov 2022 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HJkA3m4z41ixW5vvs68RcjpRXugbjaOG03xYMJ1aMU=;
        b=mja+7UfyhLK1qpyQkMQPTCjX1zkySzQH+J1RXZS7FcKQcb/xE1aIaFeD6hulqiLFGH
         68hnzP4Jr5HlYABEFYyEv4WcxIAH2kSnj0jLom5V/ICjF5Dw9OkNxmJCe1KKwfKhkbnn
         rmRDxK3w6mOljgKn2fPiYgq7i6M2uf+Uu5ngPze6h0OPdXeFAUlLBJGS5sLO8yUyJfZL
         tQy/8nSmERh8n5r6pLmg2WG8z4YA6A78t4BgifztUEaODBN5tZ3bRm6OImP9GhH9h5W4
         KRCf98aQeL78hBNhObK1wN/IewZNWeux4dV9Z5Ou4TrIhGNlAZjIAM1jndI40PlhcdGq
         hSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HJkA3m4z41ixW5vvs68RcjpRXugbjaOG03xYMJ1aMU=;
        b=JTsr3RSNGaG6Rr/afml2uoZ4ACG73DoF3p0Mei5jUuXYPGh+nr38WnGzwURY1JrS1C
         uE/9wCPWIHwH1jqRsBLzWt8logGj5Fnu+BQ3Jw3yNJVmkcY6QOTWV0iVidVLVWhWSkO1
         Bdi6bV4yJ279/SSxjAsrzLjyK9ybBCLiXKAW+ibHhFDyX7m1TcAiNw5FchuSLQOrsRqp
         dpw/MZmiulKdpb/PbwwmsD3yGKfCuuBIHrxNS2QdcJ2emVWYo5/gz9e6IXnrB6I5vGS2
         u1rkOzeBlU+LRYuqNO8Mw2XWPO5TF/68jefipHEgCQQE/SKO41WOnBVp+IHvPHKdgNE9
         9mkw==
X-Gm-Message-State: ACrzQf3utfgVqCr6CyXQZMwroK3/ALUUpJbURZQBki+yAcKQSD4nLe7K
        86nBoYClyV9Z6cSdGtBT0o0=
X-Google-Smtp-Source: AMsMyM4DnM+K7Tru1k0hYwnwuEVyj2s3FohttORFLSaxFqm9L9I0Hg8ZbIcYFCrosjWePP5O8ui13Q==
X-Received: by 2002:a63:d015:0:b0:46f:b2a4:a34e with SMTP id z21-20020a63d015000000b0046fb2a4a34emr47364062pgf.594.1668022250626;
        Wed, 09 Nov 2022 11:30:50 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186ac4b21cfsm9567462plg.230.2022.11.09.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:30:49 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/6] gpiolib: of: change of_find_gpio() to accept device node
Date:   Wed,  9 Nov 2022 11:30:39 -0800
Message-Id: <20221031-gpiolib-swnode-v3-1-0282162b0fa4@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of switching all OF-based GPIO lookups to go through
of_find_gpio() let's change it to accept device node as its argument as
we do not always have access to device structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 7 +++----
 drivers/gpio/gpiolib-of.h | 4 ++--
 drivers/gpio/gpiolib.c    | 5 +++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index be9c34cca322..52e4ac0fcaa1 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -623,7 +623,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	NULL
 };
 
-struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
+struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 			       unsigned int idx, unsigned long *flags)
 {
 	char prop_name[32]; /* 32 is max size of property name */
@@ -641,8 +641,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			snprintf(prop_name, sizeof(prop_name), "%s",
 				 gpio_suffixes[i]);
 
-		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
-						&of_flags);
+		desc = of_get_named_gpiod_flags(np, prop_name, idx, &of_flags);
 
 		if (!gpiod_not_found(desc))
 			break;
@@ -650,7 +649,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 	/* Properly named GPIO was not found, try workarounds */
 	for (q = of_find_gpio_quirks; gpiod_not_found(desc) && *q; q++)
-		desc = (*q)(dev->of_node, con_id, idx, &of_flags);
+		desc = (*q)(np, con_id, idx, &of_flags);
 
 	if (IS_ERR(desc))
 		return desc;
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 1b5df39a952e..cb8b70a2723e 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -16,7 +16,7 @@ struct gpio_desc;
 struct gpio_device;
 
 #ifdef CONFIG_OF_GPIO
-struct gpio_desc *of_find_gpio(struct device *dev,
+struct gpio_desc *of_find_gpio(struct device_node *np,
 			       const char *con_id,
 			       unsigned int idx,
 			       unsigned long *lookupflags);
@@ -26,7 +26,7 @@ int of_gpio_get_count(struct device *dev, const char *con_id);
 bool of_gpio_need_valid_mask(const struct gpio_chip *gc);
 void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
 #else
-static inline struct gpio_desc *of_find_gpio(struct device *dev,
+static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
 					     unsigned int idx,
 					     unsigned long *lookupflags)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8faedca6b14..c5a80def8be4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4070,14 +4070,15 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	int ret;
 	/* Maybe we have a device name, maybe not */
 	const char *devname = dev ? dev_name(dev) : "?";
-	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
+	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
 
 	/* Using device tree? */
 	if (is_of_node(fwnode)) {
 		dev_dbg(dev, "using device tree for GPIO lookup\n");
-		desc = of_find_gpio(dev, con_id, idx, &lookupflags);
+		desc = of_find_gpio(to_of_node(fwnode),
+				    con_id, idx, &lookupflags);
 	} else if (is_acpi_node(fwnode)) {
 		dev_dbg(dev, "using ACPI for GPIO lookup\n");
 		desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);

-- 
b4 0.11.0-dev-28747
