Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464165EB996
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiI0FWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiI0FW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:22:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D61A4B81;
        Mon, 26 Sep 2022 22:22:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so1353512pjh.2;
        Mon, 26 Sep 2022 22:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5b6vS02lBcL3jiVdci8QnBWq6L9THY0v1Cc6XZDee3o=;
        b=RjCa7xJHubp21XdCL3QHpfYBrNYYSkUv3rltmmaG0ty5LcYSVN8Ck3mq/kRH1yFy0V
         7Nmg74AnVi8rKPHaMHuhqzwxfHg+lrZgUAn1sipWPdOpf1DHyOoQDLxKUaBGYtAG6koL
         V+7y2toPKPgS4YPbQLMpwhe3g927VAUX6Wv4X7HVe2AgOXD3m6W3i+k+QURPUEFVUewv
         rmznsiuacX5V9IYJ17J5sR1HnWRYeiZVrXId6GexG358jFVHqLRZP5cs3bkZ0UHKMdaL
         9LJ72DxNlgJ1Tg6aKyffbjfAvnIbKoh5xmib8arlWUBWqM2clhedlHZz9Hqt6dwXhpHm
         fcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5b6vS02lBcL3jiVdci8QnBWq6L9THY0v1Cc6XZDee3o=;
        b=7qtiI9hlHITiNK/Gan2x/bBbNmBp7vztIu1u3fmckqT0KMuANOuQVPJ4zYbThsCwDk
         0eKFlqfvQHm95BvPM/HvoBB1nVuzlQZBqpQNgy4kz0nMlNY/FM1gywm6LAsO+fpklP5b
         lw/hLFu0UJO30eKItQPC51e9502qz3OyH7W4tsDerW+fO4saEJbQ3HESNcc3R7CSqT4o
         IH471XWAnyotyI9H+8WDNdgZkIYL/OwjS/e3nrzSsCJ2kw6mHqz+2dVQsckT7IJiNSDI
         454IHu4VXE79Ftzvj3ablc7APVXdREsk1TbBRc2cDBL8roxRziPq0zqB+T/6i69kWK1D
         +LDQ==
X-Gm-Message-State: ACrzQf1WSCOQYskRuOruOH+SEyTXosx5o96xRhH0wXSl/BLcEnKO8tU4
        pLMpDXr75b7M1Nq0xZ7TNw4=
X-Google-Smtp-Source: AMsMyM7T/r9xXOu4+AVorZg7ySPh0Ogz9jEJdC5xAz3FOqS50LnKcbWr3ezxi/6xbt5z1Ue2F2qJ4A==
X-Received: by 2002:a17:90a:bf18:b0:200:8a12:d7ad with SMTP id c24-20020a17090abf1800b002008a12d7admr2474679pjs.243.1664256145107;
        Mon, 26 Sep 2022 22:22:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id z187-20020a6265c4000000b005367c28fd32sm504811pfb.185.2022.09.26.22.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 22:22:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: adc: twl4030-madc: add missing of.h include
Date:   Mon, 26 Sep 2022 22:22:16 -0700
Message-Id: <20220927052217.2784593-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
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

The driver is using of_device_id and therefore needs to include
of.h header. We used to get this definition indirectly via inclusion
of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
from unnecessary includes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/twl4030-madc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index f8f8aea15612..c279c4f2c9b7 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
-- 
2.38.0.rc1.362.ged0d419d3c-goog

