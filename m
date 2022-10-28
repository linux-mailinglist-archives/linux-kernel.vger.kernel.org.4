Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D661076C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiJ1Bs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiJ1Bsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664A1ACA11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c23so2706150qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DS0XWl1Cbm55Pwimv/H351CT6M0z6e8AP3NS0QMe2jY=;
        b=TsU9DDtchGqKnMoyHMUxHjV8Qlh4o4T7gZdHTFyPH+yl+E+p47xyN0V/lIiPFRdBl+
         oN6qGwSxIIXmY/I6PtOgLs36L/1jPOkA2GynFx5SsVGrZYTiRSZa1qUcgVyHWRFA9LGl
         EZd5rM3gJh5nDL7G8Deu2fk/gdniov82eR5Y8PMcW5dLx5HDLIinataviO0kiWJ8BFQv
         tHdjoZU5jGsWAj+Fxg4dM2wAQ2WP4oRXva2PJ/WK2wyrcc2dI02gKkdvop0x5SS83xzm
         yB9aG1fDftIlCeJRr8NaOol+Yaoi292QOp1QR8UtRt8bEnpqOopGVctWGsFzEd9Tx6l0
         PtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DS0XWl1Cbm55Pwimv/H351CT6M0z6e8AP3NS0QMe2jY=;
        b=R9zootEW0XO+SwuqyXMHtnExepni6g7iUBA0o2pDJle3Lv0UTeWrkLwh5muCbmO+pp
         wJGVk/qKTVh7gpHUQnSPUes3aDhQFkTsRksNo04FmiBR7ZKA0uSWgu9H/ocMvJaPf0D9
         SUcmy3ZzspzqPI01NDtDuuPauTCuOiBQpJTJiUrjFg1rqOGOmY4M4GTazPtsx+IkbWHu
         iY3lAahg3KCBQrCwLvYyO57Z90lfkcsC9RuGpBx30woP47NpL6Ur4exvbE5KjY00GTPD
         WIjAOGvzJSYh4iT2sA1M/kLLqldih2OA1HeamsL5XGvX7YfQdG5jsHUXdm4EjM5oaL42
         3xvA==
X-Gm-Message-State: ACrzQf3BE08y/KztcIkPRw64kMiMP+3AV5Ydfa8Azmq3JwwyNErisi9b
        0hv0TUw/hRNKwqLc2bZD4rpqE03YsRc=
X-Google-Smtp-Source: AMsMyM5n1elT/uyQgKCOnJAQCDnsSwEcbNuVjB7+pR8vI0N++ilHTBvtroxtNfR/UcDcIqDKlOlNdg==
X-Received: by 2002:ac8:5f53:0:b0:39c:e315:114d with SMTP id y19-20020ac85f53000000b0039ce315114dmr45159293qta.346.1666921720240;
        Thu, 27 Oct 2022 18:48:40 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id g23-20020ac84b77000000b003a4efd59754sm1724032qts.12.2022.10.27.18.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:39 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
Date:   Thu, 27 Oct 2022 18:48:30 -0700
Message-Id: <20221028014834.572819-3-yury.norov@gmail.com>
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

_reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1c81413c51f8..28630b57b2ab 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1317,7 +1317,7 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
 		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 			continue;
-		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
+		bitmap_set(bitmap, pos, pos + BIT(order));
 		return pos;
 	}
 	return -ENOMEM;
@@ -1356,7 +1356,8 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 		return -EBUSY;
-	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	bitmap_set(bitmap, pos, pos + BIT(order));
+	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);
 
-- 
2.34.1

