Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE66F3CAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjEBEYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBEYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:24:43 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7840D9
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 21:24:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Q9Rn20bnMz9sdB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683001478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jAsWBU5Jz2xyI1evBp7DMC5SZ+wXfWgZStgBNcv5u1M=;
        b=pGFGFe6dANVRvzGEz2dkq+if6+YlT3UX+1p6G4TCHvb8fApphciUERWCQwIGQ2/7nqStMx
        nrM5br6UjC7XHisnwzI+tgqo+yHug7ZvIK1RU/h13JAGb6WdaTt5r19djwk2anBK06IRoW
        s1sFm75AJX+BJld6cn79ziiQFn4zuKn/8U6LadAY2Q0t/ne6ee9ld99vHc68AWWPCUEz8H
        9YSoV6T0MR5PzxMlpqFXBCI1yPShkmXoNqpUfLcZigdduUzC0MYVt335ZbUj92Dog1LrsH
        2SJi4JzshwFBP2L/YJQ2BRkNSwTLAXg77FXjN4ST7C77y04U5CxG5SeNlUDkJQ==
Message-ID: <ba90a4f9a402044c110a087155e7c077ef469f35.camel@mailbox.org>
Subject: Library: [RFC PATCH 3/3] btree_blue - A simple btree with fast
 linear traverse
From:   liuwf <liuwf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 02 May 2023 00:23:11 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 228e05d88b5c0cf9c5a
X-MBO-RS-META: kpxn1ctxnhzor1m1hu5cr87gyr9saast
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Library: [RFC PATCH 3/3] btree_blue - A simple btree with fast linear traverse

From: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>

This is test prog file

Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <liuwf@mailbox.org>
---
 lib/btree_blue_test.c | 70 ++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/lib/btree_blue_test.c b/lib/btree_blue_test.c
index b0a73836523d..715dc614e7dd 100644
--- a/lib/btree_blue_test.c
+++ b/lib/btree_blue_test.c
@@ -128,7 +128,8 @@ static int btree_blue_test_init(void)
 		goto exit;
 	}
 
-	printk(KERN_EMERG "%lu inserts to a empty tree ...\n", RANDOM_NR);
+	printk(KERN_EMERG "insert %lu random keys to a empty tree ...\n",
+	       RANDOM_NR);
 	err = 0;
 
 	t0 = ktime_get_ns();
@@ -142,7 +143,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "maple tree %lu inserts use time: %lu ns\n",
+	printk(KERN_EMERG
+	       "maple tree inserts %lu random keys use time: %lu ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -159,8 +161,8 @@ static int btree_blue_test_init(void)
 		rb_add(&entry_ptr->node, &rbtree_root, rbtree_entry_less);
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree %lu inserts use time: %ld ns\n", RANDOM_NR,
-	       t0);
+	printk(KERN_EMERG "rbtree inserts %lu random keys use time: %ld ns\n",
+	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
@@ -187,10 +189,13 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree_blue %lu inserts use time: %ld ns\n",
+	printk(KERN_EMERG
+	       "btree_blue inserts %lu random keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
-	printk(KERN_EMERG "%lu searches ...\n", RANDOM_NR);
+	printk(KERN_EMERG
+	       "search %lu random keys in  a tree which has those keys ...\n",
+	       RANDOM_NR);
 	err = 0;
 
 	t0 = ktime_get_ns();
@@ -205,7 +210,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "maple tree %lu searches use time: %lu ns\n",
+	printk(KERN_EMERG
+	       "maple tree search %lu random keys use time: %lu ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -219,8 +225,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree %lu searches use time: %ld ns\n", RANDOM_NR,
-	       t0);
+	printk(KERN_EMERG "rbtree search %lu random keys use time: %ld ns\n",
+	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
@@ -233,8 +239,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree %lu searches use time: %ld ns\n", RANDOM_NR,
-	       t0);
+	printk(KERN_EMERG "btree search %lu random keys use time: %ld ns\n",
+	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
@@ -249,11 +255,12 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree_blue %lu searches use time: %ld ns\n",
+	printk(KERN_EMERG
+	       "btree_blue search %lu random keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	printk(KERN_EMERG
-	       "%lu mixed insert + delete based on a tree which has %lu keys ...\n",
+	       "%lu random mixed insert + delete based on a tree which has %lu keys ...\n",
 	       RANDOM_NR, RANDOM_NR);
 	err = 0;
 
@@ -277,7 +284,7 @@ static int btree_blue_test_init(void)
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "maple tree %lu mixed insert + delete use time: %ld ns\n",
+	       "maple tree %lu random mixed insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -306,7 +313,8 @@ static int btree_blue_test_init(void)
 		kmem_cache_free(rbtree_node_cache, entry_ptr);
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree %lu mixed insert + delete use time: %ld ns\n",
+	printk(KERN_EMERG
+	       "rbtree %lu random mixed insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -329,7 +337,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree %lu mixed insert + delete use time: %ld ns\n",
+	printk(KERN_EMERG
+	       "btree %lu random mixed insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -354,11 +363,10 @@ static int btree_blue_test_init(void)
 	}
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "btree_blue %lu mixed insert + delete use time: %ld ns\n",
+	       "btree_blue %lu random mixed insert + delete use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
-	printk(KERN_EMERG
-	       "get prev key in a tree which has %lu keys to empty ...\n",
+	printk(KERN_EMERG "get prev key in a tree which has %lu keys ...\n",
 	       RANDOM_NR);
 	err = 0;
 
@@ -427,7 +435,7 @@ static int btree_blue_test_init(void)
 					     btree_blue_visit, GET_PREV);
 	t0 = ktime_get_ns() - t0;
 	printk(KERN_EMERG
-	       "btree_blue get %lu prev keys in traversal way use time %ld ns\n",
+	       "btree_blue get %lu prev keys in callback way use time %ld ns\n",
 	       total, t0);
 
 	printk(KERN_EMERG
@@ -473,11 +481,11 @@ static int btree_blue_test_init(void)
 			return -1;
 		}
 	}
-	printk(KERN_EMERG
-	       "btree_blue %lu traversed values are verified successfully\n",
+	printk(KERN_EMERG "btree_blue %lu traversed values are verified OK\n",
 	       RANDOM_NR);
 
-	printk(KERN_EMERG "delete a tree which has %lu keys to empty ...\n",
+	printk(KERN_EMERG
+	       "random delete a tree which has %lu keys to empty ...\n",
 	       RANDOM_NR);
 	err = 0;
 
@@ -492,7 +500,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "maple tree %lu deletes use time: %ld ns\n",
+	printk(KERN_EMERG
+	       "maple tree random deletes %lu keys use time: %ld ns\n",
 	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
@@ -510,8 +519,8 @@ static int btree_blue_test_init(void)
 		kmem_cache_free(rbtree_node_cache, entry_ptr);
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "rbtree %lu deletes use time: %ld ns\n", RANDOM_NR,
-	       t0);
+	printk(KERN_EMERG "rbtree random deletes %lu keys use time: %ld ns\n",
+	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
@@ -525,8 +534,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree %lu deletes use time: %lu ns\n", RANDOM_NR,
-	       t0);
+	printk(KERN_EMERG "btree random deletes %lu keys use time: %lu ns\n",
+	       RANDOM_NR, t0);
 
 	t0 = ktime_get_ns();
 	for (long i = 0; i < RANDOM_NR; i++) {
@@ -541,7 +550,8 @@ static int btree_blue_test_init(void)
 		}
 	}
 	t0 = ktime_get_ns() - t0;
-	printk(KERN_EMERG "btree_blue %lu deletes use time: %lu ns\n",
+	printk(KERN_EMERG
+	       "btree_blue random deletes %lu keys use time: %lu ns\n",
 	       RANDOM_NR, t0);
 
 exit:
@@ -555,7 +565,7 @@ static int btree_blue_test_init(void)
 	btree_blue_destroy(&btree_blue_root);
 
 	if (!err) {
-		printk(KERN_EMERG "Test successfully finished.\n");
+		printk(KERN_EMERG "Test finished successfully.\n");
 		return 0;
 	} else
 		return -1;
-- 
2.30.2


