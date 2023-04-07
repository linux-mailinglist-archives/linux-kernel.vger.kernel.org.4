Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A96DAC5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDGLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDGLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:50:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F37A83
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:50:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-545e907790fso675938767b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680868213; x=1683460213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ubabgTfuQRUHcQ6nKf64nxm8BOFtXJ8YmpeRNoMRoE=;
        b=hRivsHU7hbGZ+2Lv6GeonKLicOhLM9ZrddVEEPh3CNRhx5Mdzf53lkstvRsPKe2aTt
         HSJVcEz3PS/6AU1I0Js8/KfZiqpSziN8pqEDRJ/fjS69B6JBGxnkbZPTK0fEtVi+GC5N
         MQIRozs/3wD4oCHS3z4944A6SnRw5BNPXLxvIjoELyrLEXolhDFIkJ2729dcuzunJL9l
         EL0GAp2zYvtjaRanctzc6gduAv3q89IW4JgXSjNb8tkqQ1xmHOiUx0i6BeFnrFIDkez8
         5yvrkzt60/LMZi42GspLPQZKvTOMJLdYlz2rSn8TJ37jBb3004fG8UXOSWo7+eQja/se
         vuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680868213; x=1683460213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ubabgTfuQRUHcQ6nKf64nxm8BOFtXJ8YmpeRNoMRoE=;
        b=mfENPPbuan4lDxwRg9+aqjVpfTkcQH1rDjzavhCjLukHylEmoWOs/8mjrDYddxE0gX
         Iy+K5HHhZj8TiRctlFtxD+dB3AQ1fDGEII43+UVYzHvvaarIZVet4Eb6o1Ai72SBLnYO
         9I7DBzUErw31vPo4R6O+FwoNDaCYFErEVZMsH7yHteN7jmkY+gM6TDIn756v6EsTUEs8
         8qnQ8LE+dxai2si+tAcmeCn1gBU5cjUb0GFdFFcdgK30Mebw9NlRZGE/uC5yn4EiwLt2
         uTsuHYyeimtpVjkXOiOcoji8TbhIWSnKkHytuVdW4/fpQpxedhoeJS8/1YeSuMdivZ3Y
         FSww==
X-Gm-Message-State: AAQBX9emyJ2Y7787FVHaDrUaO0HS+dFayr76aAUaPDxKax0k+/frjsuQ
        TakKbkyih9F0ICQesY5ARwCK0g==
X-Google-Smtp-Source: AKy350bbV41TFLJ0OkIpzobmndMZ6tHBalSNDHQSNra3NjbpWRB+pw8eHG7SU/PfusJbM6HyseHURg==
X-Received: by 2002:a0d:db97:0:b0:544:656c:c183 with SMTP id d145-20020a0ddb97000000b00544656cc183mr1627561ywe.5.1680868213152;
        Fri, 07 Apr 2023 04:50:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bw28-20020a05690c079c00b00545a08184bfsm955644ywb.79.2023.04.07.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:50:12 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RESEND PATCH v3 2/2] regmap-irq: Drop map from handle_mask_sync() parameters
Date:   Fri,  7 Apr 2023 07:47:33 -0400
Message-Id: <1f44fb0fbcd3dccea3371215b00f1b9a956c1a12.1679323449.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679323449.git.william.gray@linaro.org>
References: <cover.1679323449.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

