Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADDC61076D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiJ1Bs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiJ1Bsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C3AC4AD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f8so2606200qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IF9Itq+l7pSB7LEj0A4UotSxHZaA/dpnq4u6qwUxWA=;
        b=CgkTQuuaZKVOSuly1y766VzaHMeskYfkNUpQf4ucFCzCJ0KcqwJPOKGJZYZUn9U/oS
         gUiKpBC8dWz8yJSYfRNv5ObChBFaqGcVgOzs5pVRWqmBs+Az089yfR5rVsrO3qIQ1MH5
         RjkSmDllmkiqRco2hgwD38JtvpYaXe320+nECWJ+d6Z11lg+8qYrzg2UCw3gXTSx7QiE
         ccvG3h3wFrnkH/LVfNg4Ztw4U80IZ4stHMWOjFZFmBrXQZlQKSUGLStCJInubPC7ZYT5
         76eUzXjqHShoOO51cxEkNnYNVNx/xASMUMTek7WXk6Fro3uw2UV3EST6LLDuTrOQ+pVd
         IUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IF9Itq+l7pSB7LEj0A4UotSxHZaA/dpnq4u6qwUxWA=;
        b=NkwHaGbdUvhg+1vDFNX3ibqHq1HmH3kBtiOiswZn4HnVSPNyFnDxucvBHidAxN7XcX
         ADbtXkxdwWzwW5WiC427AVK6TSXbS5lCWXmwADYWVSFKBK8eZFIh8igM0pojGYK4a0WG
         mEHvHkWYUc9Ggn0m3u7apA/BM9pVN6sKB3d9pIKugYarnPwaHWb5wOy/79zd7esGmtXT
         S7P9/MKrJ5wuMqXn1nO11ww3Gb7W4icxuZfJcvCbiT3wmDJeBeN/1IrNU71WvrP2i6C/
         eca8/d3jusEeynkVcr7MmjP6o95J65zLVeid7idWysdgBljsEsVZ9yufdZR5zNVuvZJE
         y36Q==
X-Gm-Message-State: ACrzQf0iukDeQXhneir+VbKnGBnSwTdqMISbYAveMDVpCWYUD9aHVbgP
        LVkRI9zizC/D+jwOb/pSFuzjuHf2uws=
X-Google-Smtp-Source: AMsMyM75HKMzogQ0g4EEdQ4MyHZQ55k1MsZ5yjy7/p8es8O9/4JnE6Kc0oiE+jDQKXtgmXnqAUG6DQ==
X-Received: by 2002:a05:620a:a46:b0:6f8:7886:6f1b with SMTP id j6-20020a05620a0a4600b006f878866f1bmr10715267qka.1.1666921722477;
        Thu, 27 Oct 2022 18:48:42 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id q11-20020a37f70b000000b006ce0733caebsm2015725qkj.14.2022.10.27.18.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:42 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 4/6] bitmap: replace _reg_op(REG_OP_ISFREE) with bitmap_empty_from()
Date:   Thu, 27 Oct 2022 18:48:32 -0700
Message-Id: <20221028014834.572819-5-yury.norov@gmail.com>
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

_reg_op(REG_OP_ISFREE) duplicates bitmap_empty_from(). Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 813962bdbd93..389446b6f248 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1315,7 +1315,7 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
 	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
-		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+		if (!bitmap_empty_from(bitmap, pos, pos + BIT(order)))
 			continue;
 		bitmap_set(bitmap, pos, pos + BIT(order));
 		return pos;
@@ -1354,7 +1354,7 @@ EXPORT_SYMBOL(bitmap_release_region);
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+	if (!bitmap_empty_from(bitmap, pos, pos + BIT(order)))
 		return -EBUSY;
 	bitmap_set(bitmap, pos, pos + BIT(order));
 	return 0;
-- 
2.34.1

