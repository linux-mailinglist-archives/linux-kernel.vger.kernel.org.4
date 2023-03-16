Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E46BC34B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCPB2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:28:05 -0400
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9C3929D;
        Wed, 15 Mar 2023 18:28:01 -0700 (PDT)
X-QQ-mid: bizesmtp88t1678929921t8u0hujh
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 16 Mar 2023 09:25:19 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000000
X-QQ-FEAT: XBN7tc9DADInawRw6jdAUZ44VnwO3c57Fz7vH9MBathCjMyDHzQi1aWRllgAo
        +VYrJn9XLcUhtaJgBYmMVdpgGheSmFrXnnG/7OKViMNtH3gI+MHcfiBL/VNCvqvzI/wPwFp
        No8RbJN35NWOemsO0nim5X2cy+mjgn8EHq3c1a1ZoocchtaYgXRLPluEC1KQ/AIZCVKaC8M
        n1BDBMAbnmWqUP6QxzAB1uwePYG5z0P0pbIUvpRpTIYmu8CJ7QxUnpgX7rbcxSuQGFEk0Z1
        2LV4OPlhzN4P7bdvuTk/FY/Y6FnH8dvkK1Zkc/HUwJrX0EivMzCWjv/BgBrdKaobXl+WUew
        /G4GDNka4JSOxm3qscgyLBeGRtndwXnaCm6cb7XJyvwmw3BsnLVIM0vXXJkb4faYil37mj/
X-QQ-GoodBg: 1
From:   gouhao@uniontech.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mm/slub: reduce the calculation times of 'MAX_OBJS_PER_PAGE'
Date:   Thu, 16 Mar 2023 09:25:17 +0800
Message-Id: <20230316012517.10479-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

when calling calc_slab_order(), 'slub_min_order'
and 'size' are fixed values, if the condition of
'MAX_OBJS_PER_PAGE' is true, it will be returned from
here every time.

So we can calculate the condition of 'MAX_OBJS_PER_PAGE'
before calling calculate_order().

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 mm/slub.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce3..ed6d797a5cd8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4094,9 +4094,6 @@ static inline unsigned int calc_slab_order(unsigned int size,
 	unsigned int min_order = slub_min_order;
 	unsigned int order;
 
-	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
-		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
-
 	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
 			order <= max_order; order++) {
 
@@ -4457,9 +4454,14 @@ static int calculate_sizes(struct kmem_cache *s)
 	size = ALIGN(size, s->align);
 	s->size = size;
 	s->reciprocal_size = reciprocal_value(size);
-	order = calculate_order(size);
 
-	if ((int)order < 0)
+
+	if (order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)
+		order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
+	else
+		order = calculate_order(size);
+
+	if ((int)order < 0 || order > slub_max_order)
 		return 0;
 
 	s->allocflags = 0;
-- 
2.34.1

