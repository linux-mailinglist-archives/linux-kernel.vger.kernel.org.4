Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66EE5E98E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiIZFoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiIZFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:44:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260925EB4;
        Sun, 25 Sep 2022 22:44:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a80so5617117pfa.4;
        Sun, 25 Sep 2022 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3nZUhNbViybhmYD0MhKu9JuoHfiHk4b0Rj6jyo4az0Y=;
        b=bcD9RuCCB0XGv9sYjvGu5Gb85JgKYL5bYn2gH7H9Bfy+PF3fRNh5jTVr4nndQqoLGx
         E68IJA3dAJgofhhnDxocagKMv04U+8ua5KqJTV4Mx2mrp5i9xWKudCZzgtFEoO7AzVqP
         +iWe2zBkyWXQ0ZYKkfNumnpMdfxOPnE3oY8WHgFCdSEdwNyUXQNa5CNyrho+1WKB40eY
         m/vLfoDTBcRcsweoJ44eGXx642ejX+XcAkmG0jAO5AATS8Mz2wKNAL1kES8jj8gRvqQd
         JE5VUdxNJHHmz7CWO4AsD3423EfOuBtNPCQIgVHYbaA5k7Wiq5Z3AVS+OI0tw0ZttkAw
         wurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3nZUhNbViybhmYD0MhKu9JuoHfiHk4b0Rj6jyo4az0Y=;
        b=bOZvGwb1mUZKR/MFQSIOiCTtaU1erfkbGKjGW3IszxSJpzBeAG43fpN+4jbYvQkuaP
         TE9BmaX907qKexleIpuCe05/SoJ0M+tKh4XCSxOzpUegFG7198NTovsufZ2qwvvnnwKX
         BcrQfNBJO+mWKl1BmH6Y89IvVJDYQZe7XpM2Tqv+cDQqN2X0z64VGAeq17LGSPAM6RX3
         vWThr3aIzhJxzgqfhR1yY0fOhJ7gd1sKHKbcIG5Ew1LO6v0kQ5FVt/LRqQya8RdriMj6
         vQ0OTIUpS5XxMP06jQ7OEevz/rgOuhEY7b8XhhgxSRHRAIva/7MH+eJvfVbj53q+AHv4
         qi+w==
X-Gm-Message-State: ACrzQf2+e6lDYlP/D+GFB2tIfi8J5BuSXIA1wXDoRScxzNJOoajDqHi+
        kwFEzyVXEasP4a7USsv8Ia5UTrCHODU=
X-Google-Smtp-Source: AMsMyM4NpakFGuRrEBIpxqgleALCtlcrWpC1KRBSruG7B4YPaKbtbKxU9MqMgCVaQZ9tKd0kDXUyQA==
X-Received: by 2002:a63:d603:0:b0:43c:6762:20d9 with SMTP id q3-20020a63d603000000b0043c676220d9mr11323075pgg.68.1664171065007;
        Sun, 25 Sep 2022 22:44:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm10110489pls.64.2022.09.25.22.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:44:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 2/5] mfd: madera: include correct gpio API
Date:   Sun, 25 Sep 2022 22:44:18 -0700
Message-Id: <20220926054421.1546436-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
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

The driver is using gpiod API and therefore should include
linux/gpio/consumer.h, not linux/gpio.h. Also, the driver does not use
any of the APIs from of_gpio.h, so we should not be including it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/madera-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a2abc0094def..bdbd5bfc9714 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -8,13 +8,12 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-- 
2.37.3.998.g577e59143f-goog

