Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABC61076B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiJ1Bsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiJ1Bso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A7ACA2D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:42 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b25so2609201qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKWEDhFwn+ThPGCDnydjZuc7yxzkqodEM30ZzuABrJA=;
        b=LyT2cefOPSq6japO6tCAFrOEBVLx0Ph4si20US1N90P5wLTkRNJY3t1oYVvrdSidp1
         +yrPVi65R/D7VqqYurnbGZ/XQw0VxPSQRNcyONiLh+lxFXBRwhEg6YsZp2nezdPw4GVk
         4EgO9Ye7CjiuiS0+6q9FUcLSHeynX5p8uR5Et+3q26EOp9rKguUo7VSZypYNXJoC8gh0
         ss/X6zTx0t9z90GNfEg2eZJrgGd8Vz02Bk7XdF4GTh3nV6BJOozHHUQ5SSDXa3Vd1mJ0
         MuNKuB5Uun6SRBFigYAlNESlVfONP+s5HOpGjsSfi9P1k4OuRe5NLoHmZsj2SJeELqzn
         0pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKWEDhFwn+ThPGCDnydjZuc7yxzkqodEM30ZzuABrJA=;
        b=GKUd27p/fvahwk/il//SYa64UOw5IGMAcwgweHxxq29FeSu5ZYpruBO5XBw0FjeXEs
         d0efjAduY5UbW47ld6K9w3fKjBI3EPEjRIXn8WTn5TnjQqIiVRK7BXAZA5xxpmACX1GF
         WcBsXxQx7UTjjJzBurEu/wPNTSeD+YlGtUWakl4uzhQR9+wP7iICjsiZZX0mJ/RWvlj1
         KP4mlqal5FeLm2nUcb8ftzOkA5hvxd/95F7ENq8G47Yoo66VDOLV3V2d4Gj4X1rqe6T3
         ONjskfHd060aNm7JTlUkMoBXwv+syf+2KrU1BzIoFrzoM0yHNi/fPBf5GMeHn5YC/B3u
         HN6g==
X-Gm-Message-State: ACrzQf0iBhIo2yBJZMwZDZUxJjxLnFR2UA0vLaNjUCFFwHLnItonOXuM
        hcIC2ggI4P7XQO9E24UUyeNk+h9Dv0E=
X-Google-Smtp-Source: AMsMyM4lcxWUPtZNUOKa55qeOo6Gw3tpZbUy28BpZTbqi+Xn1EmERXRy8RjegbNSaZnZR1CZD/BcjQ==
X-Received: by 2002:a05:620a:6d4:b0:6f9:f6af:4cc2 with SMTP id 20-20020a05620a06d400b006f9f6af4cc2mr3731460qky.445.1666921721385;
        Thu, 27 Oct 2022 18:48:41 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id u15-20020a05622a14cf00b0039a8b075248sm1723722qtx.14.2022.10.27.18.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/6] bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
Date:   Thu, 27 Oct 2022 18:48:31 -0700
Message-Id: <20221028014834.572819-4-yury.norov@gmail.com>
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

_reg_op(REG_OP_RELEASE) duplicates bitmap_clear(). Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 28630b57b2ab..813962bdbd93 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1337,7 +1337,7 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
+	bitmap_clear(bitmap, pos, pos + BIT(order));
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
-- 
2.34.1

