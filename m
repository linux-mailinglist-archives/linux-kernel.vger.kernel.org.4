Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4958F716F56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjE3VC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjE3VC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:02:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3E100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:02:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c9e9e164so9147782276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685480575; x=1688072575;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=clX13NUM0l8GVoG+aLcKYNzWuyZrIUKrfqkjH8gJ434=;
        b=MELA/owQN9WZjUGW2K4FLaeB8I5CH0Il+yW3Q6bKo29meHUE6otFdK/LnFhpVGKQPD
         tutVMozMDTL39UC9+M/M7Pa6AfujhbCB8wl0Hbnz3bPxYRAx9NnN6YH1cRK+s2n6jJJX
         XY6ImcudjCs5hftn125k/UZs1mBm/i6WXYnkEW6xH5bHjihOV6Rx4TIKIkPW9PjSWKtT
         lCsKHXLnAWf3e2TxcGu3pFLQho8wGzrVnn3J828AN+MZ7YFTuu0Byt1uyHfk6GNlq1+C
         xoKanqRmXCnO3hIA7k05yPeiFPDCJwlLmaTrjFTGgGek+Ag77zNpiIeUe6mrtdUd7Cnr
         MW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685480575; x=1688072575;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clX13NUM0l8GVoG+aLcKYNzWuyZrIUKrfqkjH8gJ434=;
        b=cbcjhSVALpxGBGkFkeBkrmB0/Wu3E0oohjFcM7pSgBFEmPitRl56iX4A8BzgLI28xq
         EwZxxw76KE6wuhp033Zug5zt1EvOmt0Ug7v6tIERBLw3FOEkAq4aDCyVbJU34Xm0DJl0
         tTJXqtayET5/lQ9rtKvRgXM+EOgwoW7IA3mdU98NhxG6v1oMpvcDS4l2VMYNsKKveu9+
         d2B9F7BzCAdPjPKO80TKVylzFsvJr4aDEFRxl00AGhVjqwVnyC+EF2OVtRg5mdqehZtA
         Jp7GnDxGTYC1xhBmi4NUxtOqztSGMQL/GcE3tA0ycc50Vpv1f74XIpozTHn6aSp+CnAs
         bRRA==
X-Gm-Message-State: AC+VfDxaSn+tJiYtcftf3GsHBugDdboGrDT1sAWkPNOCf2eh0mEH1dfP
        ZY4ciJMnAokVhh3PD0lAP6MdoR3HM0jCC8sq
X-Google-Smtp-Source: ACHHUZ6G1wOkpbTQg6TcS/5ScAmUVYScppyPgo7GvIIhzP8RJzF4ipWfuZXl6zHtOWK/wHuyV/wtjsFvVblxbKpG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:bf81:0:b0:ba8:4ba3:5b54 with SMTP
 id l1-20020a25bf81000000b00ba84ba35b54mr1474573ybk.11.1685480575473; Tue, 30
 May 2023 14:02:55 -0700 (PDT)
Date:   Tue, 30 May 2023 21:02:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530210251.493194-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: support exclusive loads
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71024cb4a0bf ("frontswap: remove frontswap_tmem_exclusive_gets")
removed support for exclusive loads from frontswap as it was not used.

Bring back exclusive loads support to frontswap by adding an
exclusive_loads argument to frontswap_ops. Add support for exclusive
loads to zswap behind CONFIG_ZSWAP_EXCLUSIVE_LOADS.

Refactor zswap entry invalidation in zswap_frontswap_invalidate_page()
into zswap_invalidate_entry() to reuse it in zswap_frontswap_load().

With exclusive loads, we avoid having two copies of the same page in
memory (compressed & uncompressed) after faulting it in from zswap. On
the other hand, if the page is to be reclaimed again without being
dirtied, it will be re-compressed. Compression is not usually slow, and
a page that was just faulted in is less likely to be reclaimed again
soon.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/frontswap.h |  1 +
 mm/Kconfig                | 13 +++++++++++++
 mm/frontswap.c            |  7 ++++++-
 mm/zswap.c                | 23 +++++++++++++++--------
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index a631bac12220..289561e12cad 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -13,6 +13,7 @@ struct frontswap_ops {
 	int (*load)(unsigned, pgoff_t, struct page *); /* load a page */
 	void (*invalidate_page)(unsigned, pgoff_t); /* page no longer needed */
 	void (*invalidate_area)(unsigned); /* swap type just swapoff'ed */
+	bool exclusive_loads; /* pages are invalidated after being loaded */
 };
 
 int frontswap_register_ops(const struct frontswap_ops *ops);
diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..92c30879bf67 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -46,6 +46,19 @@ config ZSWAP_DEFAULT_ON
 	  The selection made here can be overridden by using the kernel
 	  command line 'zswap.enabled=' option.
 
+config ZSWAP_EXCLUSIVE_LOADS
+	bool "Invalidate zswap entries when pages are loaded"
+	depends on ZSWAP
+	help
+	  If selected, when a page is loaded from zswap, the zswap entry is
+	  invalidated at once, as opposed to leaving it in zswap until the
+	  swap entry is freed.
+
+	  This avoids having two copies of the same page in memory
+	  (compressed and uncompressed) after faulting in a page from zswap.
+	  The cost is that if the page was never dirtied and needs to be
+	  swapped out again, it will be re-compressed.
+
 choice
 	prompt "Default compressor"
 	depends on ZSWAP
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 279e55b4ed87..e5d6825110f4 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -216,8 +216,13 @@ int __frontswap_load(struct page *page)
 
 	/* Try loading from each implementation, until one succeeds. */
 	ret = frontswap_ops->load(type, offset, page);
-	if (ret == 0)
+	if (ret == 0) {
 		inc_frontswap_loads();
+		if (frontswap_ops->exclusive_loads) {
+			SetPageDirty(page);
+			__frontswap_clear(sis, offset);
+		}
+	}
 	return ret;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..fba80330afd1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1329,6 +1329,16 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	goto reject;
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
 /*
  * returns 0 if the page was successfully decompressed
  * return -1 on entry not found or error
@@ -1403,6 +1413,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		count_objcg_event(entry->objcg, ZSWPIN);
 freeentry:
 	spin_lock(&tree->lock);
+	if (!ret && IS_ENABLED(CONFIG_ZSWAP_EXCLUSIVE_LOADS))
+		zswap_invalidate_entry(tree, entry);
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
 
@@ -1423,13 +1435,7 @@ static void zswap_frontswap_invalidate_page(unsigned type, pgoff_t offset)
 		spin_unlock(&tree->lock);
 		return;
 	}
-
-	/* remove from rbtree */
-	zswap_rb_erase(&tree->rbroot, entry);
-
-	/* drop the initial reference from entry creation */
-	zswap_entry_put(tree, entry);
-
+	zswap_invalidate_entry(tree, entry);
 	spin_unlock(&tree->lock);
 }
 
@@ -1472,7 +1478,8 @@ static const struct frontswap_ops zswap_frontswap_ops = {
 	.load = zswap_frontswap_load,
 	.invalidate_page = zswap_frontswap_invalidate_page,
 	.invalidate_area = zswap_frontswap_invalidate_area,
-	.init = zswap_frontswap_init
+	.init = zswap_frontswap_init,
+	.exclusive_loads = IS_ENABLED(CONFIG_ZSWAP_EXCLUSIVE_LOADS),
 };
 
 /*********************************
-- 
2.41.0.rc0.172.g3f132b7071-goog

