Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA6681BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjA3U4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjA3U4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:56:14 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 12:56:11 PST
Received: from out-151.mta1.migadu.com (out-151.mta1.migadu.com [IPv6:2001:41d0:203:375::97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1842DFD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:56:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0DgDHv6v1bes9QPJYpLqp7kkvT0kapBOv6TW2IBB/k=;
        b=SpOJ60TVzVtNFGeOaSWoGCVnRntGXp1f0lNFPUS22mPwdXy3FThUKBl7SnU05auY2/luej
        U9SfMepHYn2N9o3X7GDdHcULipCyR7H9ZY2KmHg7SPMUng4KqZBLC+Iovl8L0HP2Tv7Ojv
        sy1806UWb20v/N9S8fxWCNto4gVc1H8=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 03/18] lib/stackdepot: use pr_fmt to define message format
Date:   Mon, 30 Jan 2023 21:49:27 +0100
Message-Id: <3600069e0b0b3df602999ec8a2d4fc14fcc56a01.1675111415.git.andreyknvl@google.com>
In-Reply-To: <cover.1675111415.git.andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Use pr_fmt to define the format for printing stack depot messages instead
of duplicating the "Stack Depot" prefix in each message.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 23d2a68a587b..90c4dd48d75e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -19,6 +19,8 @@
  * Based on code by Dmitry Chernenkov.
  */
 
+#define pr_fmt(fmt) "stackdepot: " fmt
+
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
@@ -98,7 +100,7 @@ static int __init is_stack_depot_disabled(char *str)
 
 	ret = kstrtobool(str, &stack_depot_disable);
 	if (!ret && stack_depot_disable) {
-		pr_info("Stack Depot is disabled\n");
+		pr_info("disabled\n");
 		stack_table = NULL;
 	}
 	return 0;
@@ -142,7 +144,7 @@ int __init stack_depot_early_init(void)
 						1UL << STACK_HASH_ORDER_MAX);
 
 	if (!stack_table) {
-		pr_err("Stack Depot hash table allocation failed, disabling\n");
+		pr_err("hash table allocation failed, disabling\n");
 		stack_depot_disable = true;
 		return -ENOMEM;
 	}
@@ -177,11 +179,11 @@ int stack_depot_init(void)
 		if (entries > 1UL << STACK_HASH_ORDER_MAX)
 			entries = 1UL << STACK_HASH_ORDER_MAX;
 
-		pr_info("Stack Depot allocating hash table of %lu entries with kvcalloc\n",
+		pr_info("allocating hash table of %lu entries with kvcalloc\n",
 				entries);
 		stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
 		if (!stack_table) {
-			pr_err("Stack Depot hash table allocation failed, disabling\n");
+			pr_err("hash table allocation failed, disabling\n");
 			stack_depot_disable = true;
 			ret = -ENOMEM;
 		}
-- 
2.25.1

