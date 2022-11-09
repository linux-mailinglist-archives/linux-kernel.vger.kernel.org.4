Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF85623381
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiKITa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKITax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:30:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0396727B33;
        Wed,  9 Nov 2022 11:30:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2880070pjc.2;
        Wed, 09 Nov 2022 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdJFy/Jw06zpP+63ffqxVPckP7PtfLIb1CoKR1TTueA=;
        b=JtWyteaZcQLBtx/CeSsFju4zAPJcegVwUkAAr94WHCoBHTARrO84PApYQuQPdF1Obp
         4Nw+CjLoCTLSMtzBm8x+35auFt5GKoDKTscQtxtERq7Kf6/oLE8p4qWOeLIIwBJXvSqL
         FPBu/ABw9G3bCmraid/SSuw0cpfJtvazp4SdQuYYOtMgnkDUH7yxwzBBv3un8s/26JPH
         bAPli+cDWQEbnvD4gJzuppW2uc4ZA9XJMdiN6XUqwYUxQ0I8GUhDRd8yxndj2ak/Pr9l
         4v2dMutZZ98Sl8pcaeLCnjJe2FL4QmmSCtCEanVYk5HAEzOr8ycQ/G0ATyeSUqbykibM
         bWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdJFy/Jw06zpP+63ffqxVPckP7PtfLIb1CoKR1TTueA=;
        b=M4y/yNBKnA2R1ruJofrLC7v5kP/qP+cA+chceQ88dTTe4sywfAuRMh8lS+74CNWHPb
         ukprmIRuoTBTwXDtk3jdde64MAbhCKXCYSkf5PsCiZGUOup5OyqbEWW5WwlkT80rErp+
         FyZ407ZLh99x0cRgAwFRmm8w+itbOtQKgw7dpWV09sidwzq7eeurvyqKVRoinhjlebMe
         BUK//WQSBWqZNI7xYhUkicOGB/752Uh7JPt8nuQpWkoWSR0ffLJqxDJMgdOD+1+HZOuj
         Fb1tbzRvyqj0zcuZlG35DnlZSSyNYA1TJnkm9S7rBAdK15M6vE04rbPFLwBGkGa3yWzo
         lx2A==
X-Gm-Message-State: ACrzQf1mr1gXDb9mdsjWBBy/LFRufG0zhQtIre70lf8k/g0Yi59mbmjW
        v3w+jOUv6qVAorLcAOj95NGXVjDvWOk=
X-Google-Smtp-Source: AMsMyM5fJYa9eCBbDIwGGQ8yFf1xHcJEJhvKfgKK90w/7uA+HXiXpV1zfnvlGzZHeaiuQgQhXl5Nqw==
X-Received: by 2002:a17:90a:7e10:b0:213:9e81:87e2 with SMTP id i16-20020a17090a7e1000b002139e8187e2mr66359796pjl.1.1668022252360;
        Wed, 09 Nov 2022 11:30:52 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186ac4b21cfsm9567462plg.230.2022.11.09.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:30:51 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 2/6] gpiolib: acpi: change acpi_find_gpio() to accept firmware node
Date:   Wed,  9 Nov 2022 11:30:40 -0800
Message-Id: <20221031-gpiolib-swnode-v3-2-0282162b0fa4@gmail.com>
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

In preparation of switching all ACPI-based GPIO lookups to go through
acpi_find_gpio() let's change it to accept device node as its argument
as we do not always have access to device structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++++--
 drivers/gpio/gpiolib-acpi.h | 4 ++--
 drivers/gpio/gpiolib.c      | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 064ba5150fd4..ccb74e208989 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -906,18 +906,22 @@ static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 	return con_id == NULL;
 }
 
-struct gpio_desc *acpi_find_gpio(struct device *dev,
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 const char *con_id,
 				 unsigned int idx,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev;
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
 	int i;
 
+	adev = to_acpi_device_node(fwnode);
+	if (!adev)
+		return ERR_PTR(-ENODEV);
+
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id) {
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 01e0cb480a00..bd1f9b92ea9e 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -60,7 +60,7 @@ int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
 int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 					struct acpi_gpio_info *info);
 
-struct gpio_desc *acpi_find_gpio(struct device *dev,
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 const char *con_id,
 				 unsigned int idx,
 				 enum gpiod_flags *dflags,
@@ -95,7 +95,7 @@ acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 }
 
 static inline struct gpio_desc *
-acpi_find_gpio(struct device *dev, const char *con_id,
+acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id,
 	       unsigned int idx, enum gpiod_flags *dflags,
 	       unsigned long *lookupflags)
 {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c5a80def8be4..eebcdaca5e06 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4081,7 +4081,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 				    con_id, idx, &lookupflags);
 	} else if (is_acpi_node(fwnode)) {
 		dev_dbg(dev, "using ACPI for GPIO lookup\n");
-		desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
+		desc = acpi_find_gpio(fwnode,
+				      con_id, idx, &flags, &lookupflags);
 	}
 
 	/*

-- 
b4 0.11.0-dev-28747
