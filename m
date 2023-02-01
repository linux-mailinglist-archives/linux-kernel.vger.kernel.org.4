Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F4686063
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBAHNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBAHNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:13:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191BCDDD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D1B86145B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D8AC433A7;
        Wed,  1 Feb 2023 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675235596;
        bh=UPrLvL4ctKw2Zf8x33aGj+iLuYJwq7287ZPxq8Zg168=;
        h=From:To:Cc:Subject:Date:From;
        b=Mz3312IUQ5/0tcPHhFquBbNjEDv/3z4S5zZO3oQz4G39WhdyHktBotvzo5lQtiaNS
         obp/n6yQ3QCQW+IjyxrC5ukCBpxgpnn3cAU36QQA6DzjXcj68m3JpBFOP1ztVLrhpO
         6DUFzKA7pXJi7c+qx2ezUaHCEybW5jtkxdrRHYVBWlOvPrb/1KHJ8j1M+inlIcA5rM
         NHBhTEUi7D+mLe1Q43Qrq+wBYPItJfNFXqjhT/F44MTx6axLHoGV1hec4pDjao4eUV
         AHPDcebmiulhVFwOayux8GwWpiaYpoVxjkaQmjeGrkBqIsGY0Dc4/3QN/0+g6a1IcH
         NZa6Mm7gBCCyQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: use %zd format for printing size_t
Date:   Wed,  1 Feb 2023 08:13:04 +0100
Message-Id: <20230201071312.2224452-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The size_t type depends on the architecture, so %lu does not work
on most 32-bit ones:

In file included from include/kunit/assert.h:13,
                 from include/kunit/test.h:12,
                 from mm/kasan/report.c:12:
mm/kasan/report.c: In function 'describe_object_addr':
include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
mm/kasan/report.c:270:9: note: in expansion of macro 'pr_err'
  270 |         pr_err("The buggy address is located %d bytes %s of\n"
      |         ^~~~~~

Fixes: 0e301731f558 ("kasan: infer allocation size by scanning metadata")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e0492124e90a..89078f912827 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -268,7 +268,7 @@ static void describe_object_addr(const void *addr, struct kasan_report_info *inf
 	}
 
 	pr_err("The buggy address is located %d bytes %s of\n"
-	       " %s%lu-byte region [%px, %px)\n",
+	       " %s%zu-byte region [%px, %px)\n",
 	       rel_bytes, rel_type, region_state, info->alloc_size,
 	       (void *)object_addr, (void *)(object_addr + info->alloc_size));
 }
-- 
2.39.0

