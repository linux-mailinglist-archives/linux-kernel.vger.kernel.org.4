Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FD744C95
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGBIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 04:00:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC9E4D;
        Sun,  2 Jul 2023 01:00:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc0981756so30488335e9.0;
        Sun, 02 Jul 2023 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688284804; x=1690876804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAUhZCQsdk87kgdWEBUppph6/yxmaqqjG5LD2yozjmE=;
        b=LBRWF0qTQR1vdSojoeWP1/KHAKjxNGrEGOta35tbFekBwztv59f6JpjhB+swxUm03M
         uHYwSjcfeVZtjnG6peUR4eiZyK7foW8X8L2CF2rXFWKMoVjI120mABOGo2+Mi+zAMOqh
         ibiYMjp6XuoG02OvryQ8zxR5J/2+vvCATS69eOt3IQ2bQuNn4Y0PsfHoOUXiD9t3Q8u3
         8CTAQuItiUyFQVWHmevHWJ3bnWdgig+MdazSHOc3Vriu24pE+6Wj2ZX82nkOR6anjNGX
         Ng/aO+61ZqZby1IcBbTTHSPHEcQR382kW760yL9mqRuieCpmpWebiymU9urthu4IHxQh
         eoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688284804; x=1690876804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAUhZCQsdk87kgdWEBUppph6/yxmaqqjG5LD2yozjmE=;
        b=Sx/j7O84SSxn8F5XhHSepHjohHLzvSIv+YDGDeoiDtRiF1Mq+JhEpdp8Z9+VyQJ07Y
         YYcYUVcFtCClYLJyEJzRLs24vKUtIS8qKj01HbU24uuG8gbMI6BQLo+d6OsWzAUBH3k6
         o/NJ/qyHOphuoW1B15V22PavzLoz1XjcgH7xkxnI2Da715aecMybd89ba5osPmZKb01d
         1tByJMTwfcwPL/zwFlN5URgW3hDQDp/Gwr1McjIrSlUNeGXwIt9uU9LfJOcxnDYGTaJy
         aOSk5cpA4z8BLoNH96G9v9hN8YvF5sUicaYPUsXZ0KBjaz7y5kvls8xxITTBzejGNXgA
         uerg==
X-Gm-Message-State: AC+VfDzg7tOMQTWTuBjrwHfg9qy0GpbB75OG93W6ITxcH/QUbcVQaGiK
        QWhCVZwjhk7xSpYqWVtMxZQ=
X-Google-Smtp-Source: ACHHUZ51p/7W85vZ05OKRDLNDDfo8EshPrLib7+JwjGfEjbu9EJG3gx3IjKjhfuy4GzOOT5vGJX+lQ==
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id o10-20020a1c750a000000b003f50878c0c2mr4895518wmc.3.1688284803762;
        Sun, 02 Jul 2023 01:00:03 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00301a351a8d6sm22710943wrb.84.2023.07.02.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 01:00:03 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER
Date:   Sun,  2 Jul 2023 10:03:24 +0200
Message-ID: <20230702080324.120137-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
ultimately causes the module to an early exit at probe time.
In addition the MODULE_ALIASes can be dropped.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/staging/fbtft/fb_ili9341.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index 9ccd0823c3ab..9528bf3cf711 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -145,12 +145,7 @@ static struct fbtft_display display = {
 	},
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "ilitek,ili9341", &display);
-
-MODULE_ALIAS("spi:" DRVNAME);
-MODULE_ALIAS("platform:" DRVNAME);
-MODULE_ALIAS("spi:ili9341");
-MODULE_ALIAS("platform:ili9341");
+FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "ilitek", "ili9341", &display);
 
 MODULE_DESCRIPTION("FB driver for the ILI9341 LCD display controller");
 MODULE_AUTHOR("Christian Vogelgsang");
-- 
2.41.0

