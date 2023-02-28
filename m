Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFEE6A5F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjB1S7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1S7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:59:36 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869923670
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cf14so11695115qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677610775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Its3K4FdLw/13miclZgxgoNlHtt0neRvLqenIgh9k18=;
        b=WKv24j0CwRxeOeiJyOqdFu2m7VNBUhZXf09UmDICNVLAGVe7CYB4ol/MlOlQdKM9ms
         /UrUCnroldi1siuY6JYeDgOIhkvjg6TcfC+9BPdywnNF1w83UAAJOz5Ic+fKCySMcwzV
         xirMRHV5gkXZnBAGS8tnRCOp9aS8UXCQMt4BIIvtFjpp5IaUg7894bVKRSPuXYiDg9Wp
         GATIXYUvmSpTqZfx5J3wgJUEqe3dKGzMKBKzMzpBPa31SZZ0TjVo0elNEBn8YK0QuEVo
         xEDmcrQ1GeYlhIcR0dmkl2MJqHcJA5VC0rUzbNmmuuvErTmSxf9yOwv0La+RC+TB9HSo
         Jovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677610775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Its3K4FdLw/13miclZgxgoNlHtt0neRvLqenIgh9k18=;
        b=uYvSdV5KIGMSjf5ymxcmVMyx8jztzFXqYxStQUNS0CQBNDX+dsDPX1V7ZEFKJA80D6
         E9lDiLfPU9KiyXLjJ8jQ6+7zpH90RtMuKKbBaUKrAdLrakSvazNiCCBvpJZ9MzCivFZN
         VMbew/tlge9YJXxscfc9akljl5k8aLbTZaWSfiW2fH/175ADRO16WRVXyHJ9gwV7rhAC
         eCfnECt4lvWhulPua+DC7nSSVWH5XVjlHY+z3fYW7qxdDDWJ+LjhUBPxHlezL0gITvvc
         dU9+uO4e9RisJ8AWdQV6duKQIhBHCHbprIZyjrWciarGshVppe1K7nhqnKkzGhEpJFVa
         aEOA==
X-Gm-Message-State: AO0yUKWs5sQN9kmT1Q4d+R+UP3QZ0KAnxUg97KxB2dLqp/xtyhrJciuN
        QHKijsWBGCfv3rS0MbpZFNMHcw==
X-Google-Smtp-Source: AK7set9NAU5vgSQ0hHLEbREdwsDWMipqeyurMCkFkspvw+Hj9dfcaE4G2RntZwXtKpx1WyC/yTBRaQ==
X-Received: by 2002:a05:622a:186:b0:3bf:c388:cbea with SMTP id s6-20020a05622a018600b003bfc388cbeamr6632499qtw.43.1677610774784;
        Tue, 28 Feb 2023 10:59:34 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b003b646123691sm6905181qts.31.2023.02.28.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:59:34 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/3] gpio: gpio-regmap: Expose struct gpio_regmap in linux/gpio/regmap.h
Date:   Mon, 27 Feb 2023 20:53:41 -0500
Message-Id: <5c0354c87d4d2a082cf0c331076d5aad18a93169.1677547393.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677547393.git.william.gray@linaro.org>
References: <cover.1677547393.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A struct gpio_regmap is passed as a parameter for reg_mask_xlate(), but
for callbacks to access its members the declaration must be exposed.
Move the struct gpio_regmap declaration from drivers/gpio/gpio-regmap.c
to include/linux/gpio/regmap.h so callbacks can properly interact with
struct gpio_regmap members.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-regmap.c  | 20 --------------------
 include/linux/gpio/regmap.h | 23 ++++++++++++++++++++++-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index fca17d478984..ad34750779c7 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -11,26 +11,6 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
-struct gpio_regmap {
-	struct device *parent;
-	struct regmap *regmap;
-	struct gpio_chip gpio_chip;
-
-	int reg_stride;
-	int ngpio_per_reg;
-	unsigned int reg_dat_base;
-	unsigned int reg_set_base;
-	unsigned int reg_clr_base;
-	unsigned int reg_dir_in_base;
-	unsigned int reg_dir_out_base;
-
-	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
-			      unsigned int offset, unsigned int *reg,
-			      unsigned int *mask);
-
-	void *driver_data;
-};
-
 static unsigned int gpio_regmap_addr(unsigned int addr)
 {
 	if (addr == GPIO_REGMAP_ADDR_ZERO)
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index a9f7b7faf57b..1132c0f7e907 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -3,15 +3,36 @@
 #ifndef _LINUX_GPIO_REGMAP_H
 #define _LINUX_GPIO_REGMAP_H
 
+#include <linux/gpio/driver.h>
+
 struct device;
 struct fwnode_handle;
-struct gpio_regmap;
 struct irq_domain;
 struct regmap;
 
 #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
+struct gpio_regmap {
+	struct device *parent;
+	struct regmap *regmap;
+	struct gpio_chip gpio_chip;
+
+	int reg_stride;
+	int ngpio_per_reg;
+	unsigned int reg_dat_base;
+	unsigned int reg_set_base;
+	unsigned int reg_clr_base;
+	unsigned int reg_dir_in_base;
+	unsigned int reg_dir_out_base;
+
+	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
+			      unsigned int offset, unsigned int *reg,
+			      unsigned int *mask);
+
+	void *driver_data;
+};
+
 /**
  * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
  * @parent:		The parent device
-- 
2.39.2

