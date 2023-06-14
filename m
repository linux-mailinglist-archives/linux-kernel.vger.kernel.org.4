Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192F5730208
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbjFNOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245634AbjFNOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:31:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540322703
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:31:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-976a0a1a92bso129881366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686753092; x=1689345092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6k6f2ympJcu3ns6Ija20elkW6bhMNjpeBhrfJ9xoy0=;
        b=HjkI1d0wFayV/as5yTDNIQtDbssukoexajKlZsiuAA2dK1489xvUAe0557735bTveq
         15L/1h78tKHmG6o5I+zlZ8/h9vEWUfRIrcCwLFAes0eFzNA077iEL8NOgo3t2NHUZb9e
         Rqh+mfO76L1Ogl/rqrQaHRYGPG3mAH7VbHWg5cXreln2+JJD6sZTH7237wspca614BJj
         E0qlB4jY2AHHZtCyaCm5j4jCub9IhPoAgSba6gGTyNACNPX5cCFeqWZCRry9mEBkl9yy
         NoGljNSsMxtRaovXsjNOBc8D0q2Y4tO/7P/HGY7sOsH2HPmUBsSgZQ80khOTvqTkYRSM
         9lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753092; x=1689345092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6k6f2ympJcu3ns6Ija20elkW6bhMNjpeBhrfJ9xoy0=;
        b=aZ6/yGLc04vCbIo91YSNaYZm2YEXXdKrlVQwMioDkmwcgou6Zlbbdb+CUEw13RQNG3
         VOFuF5alUbnfhQw3DFLuSi+qt7gk0YQXRKwFkhFkYqP0iyZSPNAY5835zcfGtar+3xcG
         PJgLRqOg28G+wg3k8TMD6YJNpeAYspMCpvR/0uIcTBeRO2syPpP/DnMGWhb0adNlK4gl
         qQaoS4ceMjEIMU6ugHjIWa4PYmFgyCmoHh8WcqVzw8FpULNBN8EmsL2IRTUSmzsnczxA
         4elP8lA2XCErds+lu+fY0/ZuD1GDxsEjRiTgEOeoRsL+rakOiAw2JaKDmeyCsNthcK30
         pQ8Q==
X-Gm-Message-State: AC+VfDyjjdo/1C9b0gShoZFVXsZK9l5/e9AsN9WhYz32NGx9rBNyQokR
        ptPh4lt2V0jpiJL8iqmCOau8Y1ZjT82g0uTf
X-Google-Smtp-Source: ACHHUZ43SmOvYMDVVok7GBhgV6vKwQB3xnBs5kgWIpWtJgQHOVYnpeYRlK0pBG6kvsVSP+AP9PEeqw==
X-Received: by 2002:a17:907:971d:b0:96f:ea85:3ef6 with SMTP id jg29-20020a170907971d00b0096fea853ef6mr15466663ejc.62.1686753091312;
        Wed, 14 Jun 2023 07:31:31 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-87-21-158-222.retail.telecomitalia.it. [87.21.158.222])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906b21400b009767c4235absm7983749ejz.219.2023.06.14.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:31:30 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Cc:     yosryahmed@google.com, hannes@cmpxchg.org, nphamcs@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH] mm: zswap: invaldiate entry after writeback
Date:   Wed, 14 Jun 2023 16:31:22 +0200
Message-Id: <20230614143122.74471-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When an entry started writeback, it used to be invalidated with ref
count logic alone, meaning that it would stay on the tree until all
references were put. The problem with this behavior is that as soon as
the writeback started, the ownership of the data held by the entry is
passed to the swapcache and should not be left in zswap too.
Currently there are no known issues because of this, but this change
explicitly invalidates an entry that started writeback to reduce
opportunities for future bugs.

This patch is a follow up on the series titled "mm: zswap: move
writeback LRU from zpool to zswap" with message id
<20230612093815.133504-1-cerasuolodomenico@gmail.com> in mm-unstable +
commit f090b7949768("mm: zswap: support exclusive loads") that's in
mm-unstable as well.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 02d0a6f46f4a..c122f042a49d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -599,6 +599,16 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+static void zswap_invalidate_entry(struct zswap_tree *tree,
+				   struct zswap_entry *entry)
+{
+	/* remove from rbtree */
+	zswap_rb_erase(&tree->rbroot, entry);
+
+	/* drop the initial reference from entry creation */
+	zswap_entry_put(tree, entry);
+}
+
 static int zswap_reclaim_entry(struct zswap_pool *pool)
 {
 	struct zswap_entry *entry;
@@ -644,12 +654,13 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 		goto put_unlock;
 	}
 
-	/* Check for invalidate() race */
-	if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
-		goto put_unlock;
-
-	/* Drop base reference */
-	zswap_entry_put(tree, entry);
+	/*
+	 * Writeback started successfully, the page now belongs to the
+	 * swapcache. Drop the entry from zswap - unless invalidate already
+	 * took it out while we had the tree->lock released for IO.
+	 */
+	if (entry == zswap_rb_search(&tree->rbroot, swpoffset))
+		zswap_invalidate_entry(tree, entry);
 
 put_unlock:
 	/* Drop local reference */
@@ -1376,16 +1387,6 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	goto reject;
 }
 
-static void zswap_invalidate_entry(struct zswap_tree *tree,
-				   struct zswap_entry *entry)
-{
-	/* remove from rbtree */
-	zswap_rb_erase(&tree->rbroot, entry);
-
-	/* drop the initial reference from entry creation */
-	zswap_entry_put(tree, entry);
-}
-
 /*
  * returns 0 if the page was successfully decompressed
  * return -1 on entry not found or error
-- 
2.34.1

