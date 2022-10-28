Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC761076E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiJ1BtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiJ1Bsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F58AC2B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m6so2609112qkm.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4DUoigKs4i4MiSm7mPBHdj9bSfZn7HJiVErqHP64bE=;
        b=UP9smFtqIJjIO979pi3gSZOEWo/rG0oI4HF9M0LEHAkvHp0V+9yCj+EFIWT+WIobvN
         RfXWB5vQJOGlcZIpP5JRkmeKnkUGDAPNU8TE9KKqlYfpywXW7A4opkitijzTa7Dg7Q6l
         fRRc7iK57T0KY6v/5JyGUtzB0dVtv54gf9vhTNn0BTQkbUo54qO3ozfQxN+Lqe7a0+me
         P5/7Q/JRXLtmh2jZ3G+pzxKK4D8uQ56ag8AB6iWUh+hWBZljw85ghQF4Hk+QyWmHrOLk
         +27V0GcsMkSKqYLgMfpF163SYYnLlGY+BNn/bgGUlSWHdWp510X8wk4rVUCqBj7lFfVw
         1POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4DUoigKs4i4MiSm7mPBHdj9bSfZn7HJiVErqHP64bE=;
        b=4Uhoz6VK+QQ+qUV6HKimQY5bBvOWYP3gEz+jV0gznPm3EGEVCEfg+EI6b2mBTqf3Rn
         oNFU7Tn4JxTTYpLE1EMAJvfIvsW/SOW3rJezMzDZ1VP6OoKfGCt19qQmWiu1GDPSjvJW
         VXLpRJp5m4kcgHzOwYPj3oSZmYUXCDy9CBFyFFW7mgk4wzrmouP6qu/HKSrCPadeK99D
         lln80lMGuBbtEk8Qo5Jxa5gO2rp7CuKqhTSMJaNtDaYIpwxx+VFBnxbqreAX6qHpWvRL
         7is7No7sUhhKH3WldUZrbazeNzb9R+h9QDeWJ555ERdp7QyFdBnXgtFH7ablfAkFpU8c
         55MQ==
X-Gm-Message-State: ACrzQf0Kw2nqktin+WX9p4sv20zZraTJYDqtjdmGxWByo1e4OLqpj4iY
        qXodrFYDEI0gV4prEGtRe48Z4OIVvhw=
X-Google-Smtp-Source: AMsMyM62bQm2oaXxoSO0wsgEfbitbvsBYBDq7GQ+ii63cmFBLU9QqGhopJZuWn3ehRSFDIZuxGUAdA==
X-Received: by 2002:a05:620a:2629:b0:6ee:b2cf:aeb5 with SMTP id z41-20020a05620a262900b006eeb2cfaeb5mr36464857qko.62.1666921723522;
        Thu, 27 Oct 2022 18:48:43 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id l13-20020a05620a28cd00b006f8665f483fsm2120991qkp.85.2022.10.27.18.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:43 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/6] bitmap: fix opencoded bitmap_allocate_region()
Date:   Thu, 27 Oct 2022 18:48:33 -0700
Message-Id: <20221028014834.572819-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028014834.572819-1-yury.norov@gmail.com>
References: <20221028014834.572819-1-yury.norov@gmail.com>
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

bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 389446b6f248..2a85fe16f3fa 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1315,10 +1315,8 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
 	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
-		if (!bitmap_empty_from(bitmap, pos, pos + BIT(order)))
-			continue;
-		bitmap_set(bitmap, pos, pos + BIT(order));
-		return pos;
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
 	}
 	return -ENOMEM;
 }
-- 
2.34.1

