Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0D6C159A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjCTOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjCTOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:52:15 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3728E84
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:50:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c10so2094474qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679323828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ubabgTfuQRUHcQ6nKf64nxm8BOFtXJ8YmpeRNoMRoE=;
        b=VgzMDQtzc2uS93M5NqYUM9GW1/DSCkXn5WixLv5WihMtmetUYprltbDnXBQm4g76vJ
         JJw6O8YxEABBK0ksy6TriZYj+5onqsoNZYlcXamfnOf2nzh6GG8zMvj0SkxFt243/QkN
         m5YqZDjgG1kqvCZPpQbhgzpGX32BfqKuUAZnWF2Degt46aFo45W8FZFOuf/IED7HG1FG
         4iY1kCEh8pc+cT3SbHT74+rmOOuyJtjJxtSU1fCP98zFpbr6ZheUp2rtVPvQot7SFFpZ
         VN2ArSINAz+oF5RqsIGJiOXnsNcfpTrDp8uHeWJHvq4z1/c86rl+MQZc2DxuDBnjFXI1
         NvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ubabgTfuQRUHcQ6nKf64nxm8BOFtXJ8YmpeRNoMRoE=;
        b=ev3Yj0q4ptYlTCB7sBj9hh26oL9iZ93CaZRgdJergYh5j9F6FSqyVxYO54OwGitTtQ
         hb2pvI+pN9s1vyxVofMhjIf48HHRY6DZsJBXLlwf8IkOdC3qAThh8UgfTqu5c9qHIcxT
         JuvsHMYPvQxMvtz7L2L6TheYl/twTMWzvhZ9hEtpZ2JnLv8d1wSIXW6lKe4+37PNt8wH
         bDWlRH/JFYfxnyf10HOd6noMy7DdcUJCK8QVylXRXad40i4XciiApgVnLhU6Y396EnUb
         z3pqy0aCeL8rrq496Vo4wcZwmUEmLBlf6/dFXxefGwdokcj/K/rIhxedMpdBhEzYhMUH
         nHyw==
X-Gm-Message-State: AO0yUKXMJELYl0Q/gDwS+aWtAcBtbJIj00qxMKEidZaLzdqm0iI3KBwW
        uyYgAsxg8dCIKyyqLVxvDZm4NQ==
X-Google-Smtp-Source: AK7set+D0Rm41SOApjBFCQ5yh30ru/0ykF0WLXGC9d6vTpRvFPoE1Xf2cQLng+XR7vx5OJx3VBc/5g==
X-Received: by 2002:ac8:5f86:0:b0:3d2:a927:21bc with SMTP id j6-20020ac85f86000000b003d2a92721bcmr25454885qta.18.1679323827850;
        Mon, 20 Mar 2023 07:50:27 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o14-20020ac872ce000000b003e03178112dsm2661003qtp.13.2023.03.20.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:50:27 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 2/2] regmap-irq: Drop map from handle_mask_sync() parameters
Date:   Mon, 20 Mar 2023 10:50:16 -0400
Message-Id: <1f44fb0fbcd3dccea3371215b00f1b9a956c1a12.1679323449.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679323449.git.william.gray@linaro.org>
References: <cover.1679323449.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the map parameter from the struct regmap_irq_chip callback
handle_mask_sync() because it can be passed via the irq_drv_data
parameter instead. The gpio-104-dio-48e driver is the only consumer of
this callback and is thus updated accordingly.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/base/regmap/regmap-irq.c | 5 ++---
 drivers/gpio/gpio-104-dio-48e.c  | 2 +-
 include/linux/regmap.h           | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 8c903b8c9714..a9337192ddd3 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -116,8 +116,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	for (i = 0; i < d->chip->num_regs; i++) {
 		if (d->mask_base) {
 			if (d->chip->handle_mask_sync)
-				d->chip->handle_mask_sync(d->map, i,
-							  d->mask_buf_def[i],
+				d->chip->handle_mask_sync(i, d->mask_buf_def[i],
 							  d->mask_buf[i],
 							  d->chip->irq_drv_data);
 			else {
@@ -915,7 +914,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 		if (d->mask_base) {
 			if (chip->handle_mask_sync) {
-				ret = chip->handle_mask_sync(d->map, i,
+				ret = chip->handle_mask_sync(i,
 							     d->mask_buf_def[i],
 							     d->mask_buf[i],
 							     chip->irq_drv_data);
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 3516321c92b0..509864d36940 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -109,7 +109,7 @@ struct dio48e_gpio {
 	unsigned int irq_mask;
 };
 
-static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
+static int dio48e_handle_mask_sync(const int index,
 				   const unsigned int mask_buf_def,
 				   const unsigned int mask_buf,
 				   void *const irq_drv_data)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4d10790adeb0..6e18d8b405b1 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1644,8 +1644,7 @@ struct regmap_irq_chip {
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
-	int (*handle_mask_sync)(struct regmap *map, int index,
-				unsigned int mask_buf_def,
+	int (*handle_mask_sync)(int index, unsigned int mask_buf_def,
 				unsigned int mask_buf, void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
-- 
2.39.2

