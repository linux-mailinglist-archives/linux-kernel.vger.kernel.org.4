Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15067E1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjA0Kkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjA0Kkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA782CC4B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so3121508wmo.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQA8ie8gDGnN9i1Gkqhn40XBHeOG+J3va8u+Gl+XlVM=;
        b=xUyNMLLS9r+SAEJJHrAvAUjeGlDUCS0MsFCqN8jBJQOEBAteMPkiFOvkPkEtNggLbw
         g+IPrcJBOAaUPy/h+Bq87sYMPJcbBFWP/LTBijYpoovlnqmU/cXdZvpfPatgEamol52Q
         HULZRCbRz+Z2kfplRBjEsMa0HTvF0fB2w/qPA6w+Qth57PZ+4fQ11JKVqw2vAl9/6JqE
         B03LXZpbRoEkQScZKjgFvKdWQr6kBgDxosUNl3xO4OTy6PsfW7tSmpkmU2ULkFg5Ui9h
         r+qMtxDVGeQX2fB8/ywWsqKvrAHk2QzGVwwsZs/VJQqHgM1S+mjbecMkcIkXWdWqLqy8
         4mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQA8ie8gDGnN9i1Gkqhn40XBHeOG+J3va8u+Gl+XlVM=;
        b=ALytOypMribMvb875Ioxbt6OdtBM14xnSamSO7PEsn3ApNkvgXuMmPOi9zVFwY54nH
         DzW9OQ6/MMHLP6LO4a5I7AHtCuXkkLQxBo0L8HujKrl4yTUnHlSP2ZGd1UWYr1LUwIrI
         npdP9CzWVJwmdJibt6CV1bUkcRF7pQFJjQuDATXlPRyCcCjEiFxHuI3hoeRPbS0Lx2Hs
         HjVKGGTy7/JbICRF3w1/HPEOrr8V5xXb21OeCFlumozv4lsoPjjTGVMS/PADlEcsGpqa
         T3gYiQ4rn6+KgK2GKdaBciv9S1xWnV91udtxFH0AQZb6ookPOPuZRjXs9aH1KoEcWhS4
         7ccg==
X-Gm-Message-State: AFqh2kpZ2j20upxB6VH5RK+UvsaI+hC3Qs6hc/rp9YMStrCBLl6SRzJi
        KvX57UJXmo7TH8/rl2Pelfd1tg==
X-Google-Smtp-Source: AMrXdXsvHJxiuNWojgCPjR8TCJ+EfBZUNvV59SyJ1A9XHpIJpl0+uq8rgDMQpwcrRRrT5XOqZBzasQ==
X-Received: by 2002:a05:600c:434b:b0:3d9:cc40:a8dc with SMTP id r11-20020a05600c434b00b003d9cc40a8dcmr37194425wme.27.1674816027291;
        Fri, 27 Jan 2023 02:40:27 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm1619787wmc.31.2023.01.27.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/10] nvmem: core: remove nvmem_config wp_gpio
Date:   Fri, 27 Jan 2023 10:40:09 +0000
Message-Id: <20230127104015.23839-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

No one provides wp_gpio, so let's remove it to avoid issues with
the nvmem core putting this gpio.

Cc: stable@vger.kernel.org
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 +---
 include/linux/nvmem-provider.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7394a7598efa..608f3ad2e2e4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -772,9 +772,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	nvmem->id = rval;
 
-	if (config->wp_gpio)
-		nvmem->wp_gpio = config->wp_gpio;
-	else if (!config->ignore_wp)
+	if (!config->ignore_wp)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(nvmem->wp_gpio)) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 50caa117cb62..bb15c9234e21 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -70,7 +70,6 @@ struct nvmem_keepout {
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
  * @priv:	User context passed to read/write callbacks.
- * @wp-gpio:	Write protect pin
  * @ignore_wp:  Write Protect pin is managed by the provider.
  *
  * Note: A default "nvmem<id>" name will be assigned to the device if
@@ -85,7 +84,6 @@ struct nvmem_config {
 	const char		*name;
 	int			id;
 	struct module		*owner;
-	struct gpio_desc	*wp_gpio;
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
 	const struct nvmem_keepout *keepout;
-- 
2.25.1

