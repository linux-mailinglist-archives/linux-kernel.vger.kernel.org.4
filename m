Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E36220C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKIA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKIA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:27:03 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D75EFB1;
        Tue,  8 Nov 2022 16:26:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b29so15211817pfp.13;
        Tue, 08 Nov 2022 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdJFy/Jw06zpP+63ffqxVPckP7PtfLIb1CoKR1TTueA=;
        b=B6xgDrY0FQj+FeOAhKIAYNhe4CsrKt4yX/MzFScf+l6bg0804fCWBAAmfQPozPsrxp
         tOWrMYTaexVuozV8NcFDcjvEJ8xIW81CY29hEEZ1iKLqEekUhyc4uwITGo4c+8u5uD4g
         VlfgdFJ3sxpQO2je1ttQjgWxlZOwupqfl6kBsGLZCgY71LdxGBrN4x5CxsLa7/kcYtBZ
         Cr+7021m0HzaFzBQcwy4zGBVNOuVDZQll9Md6Kg5sWNV/6IgYrf/xh7UCpOmqGbxpdeY
         qulG20zUXOnmCG9j64yA49r/FZ0YHMuQg2YTGS4SxWl/2sgkBrUHwnrmaIX6VyuFT3g/
         5Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdJFy/Jw06zpP+63ffqxVPckP7PtfLIb1CoKR1TTueA=;
        b=TciNV4tkobjnuVX+9NuVvGR5JzLUAIjbHCn2WRMnyC65b6PpDOzGAhPm5LDvsG9MfU
         N/i1Yu6zx5k1nU4aKi6/s6JhefPtFUymhtyfXDh+SkZ5jG1swr2/4Oaz5h5ejn3PHtLM
         ILdDAzgkqPq30u8ELi35BsdCye3nhjYUBlvJc/T5ZwbcAL+ehEWBX/aICpYSSujv5Ybd
         nqiOxGb8uEbkkucjiil/TBnsIQBp+JbV2tO7+W63MEBD51dnL64u5fMJHHn4pL4OSgOp
         adLZEwqtJCZTClFDvHpwo7aUb5FxpB3WPmtDj7+8kXhwSxqhb3GPvfgZIk7ShP40ju4b
         pICg==
X-Gm-Message-State: ANoB5pnuJJeFd/d0UuFRAP08bbkoxf3M6JMmEaagAHceukA9dD8X/I42
        cgHv9luSp8xXYuL1ouNlEQk=
X-Google-Smtp-Source: AA0mqf6cq77sVAjFrtWY7KsMrtzH87UogLsLJf136+kvmIcfyZBvJliTJdR4lmwpNpW11nBSNFlOzA==
X-Received: by 2002:a05:6a00:1689:b0:56e:d7f4:3aca with SMTP id k9-20020a056a00168900b0056ed7f43acamr19140154pfc.55.1667953619205;
        Tue, 08 Nov 2022 16:26:59 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id i65-20020a626d44000000b0056bd737fdf3sm6907324pfc.123.2022.11.08.16.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:26:58 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] gpiolib: acpi: change acpi_find_gpio() to accept firmware node
Date:   Tue,  8 Nov 2022 16:26:47 -0800
Message-Id: <20221031-gpiolib-swnode-v2-2-81f55af5fa0e@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
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
