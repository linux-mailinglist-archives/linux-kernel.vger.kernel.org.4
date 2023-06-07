Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772E3726A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFGTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjFGTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:51:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53871FFC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:51:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56536dd5f79so128010497b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686167506; x=1688759506;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDOi9DtrG3ImHyAY9qZt/+yVKhA3RZlvADlD5WArGHU=;
        b=1j0E5TB7ktv88hKTSJjc5mFVjUVL+4duocWh9tqI2JWOWupxXbkjIrlCv+0cHVwIIK
         H4nwE4R/ZdC9idZ46oaMCGJoMCi+6ILUzTNC+P7UMx1xRIxSvzJ7TmMvhjYjpN4eIbqN
         axzn6OzQ8nbwAO0OF/jCmu4Xrna7FB9NVCt97Fwg0pBXNfJXDspqzHe4Frhg8GCvzXhs
         /QVUduZQ3zptW3i11al2P0rOu1vrGgD8PhhyiJUWYIj2zYOdt2Td74Dw95n8AHEn1eY9
         HjKMfbNRg7w26pGGDJN5/JOvRQOzS8pEM/qEW1tjPsPnIqmhwFlCeKwr/wKnevG1VQEh
         8fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686167506; x=1688759506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDOi9DtrG3ImHyAY9qZt/+yVKhA3RZlvADlD5WArGHU=;
        b=AfykUzKICidy1tUITi/nLrcSQKaelOMOiyKMptYUzVNOaSrRqIdRes4enbf3UTH5ST
         5NTTs/iIeapgwJpj/lG90pDy6rPONW/T2vTOnxzLJxWZ99KONIljhtb4//ebE98wVTqE
         uUSzHBc3isGjwaGlzIgDjf/AZeP/Z0aX+U5x0lBTV+oAB+b2JBbk4ffpGNZFVVDzCa4j
         xjH8ekOFP7bsnViDi7nN5ygOGIikNJYVyvUudXlq5wgpYV2KCYhGlb2PGsdStauu1JjB
         yG97YniiJ3O49J6EJphQE07aSF/mHFopn2GCN7rzI7IJPVAtlrAsm7Bk3A5UqU3yzjvW
         qeLQ==
X-Gm-Message-State: AC+VfDw4iYjziNkph4q1P+hGfkFEGH9nW26yRBtJw4a7DFd+jSdC8cA2
        +Ijx4oTDQhBsVLWxFsgn7fl/fpDeFZo5Hiij
X-Google-Smtp-Source: ACHHUZ5Mkc+5WtR2XDfFpKKpGuzDmhAT6vsGdBhYndPwEaaJDfsBRWCIcgn73UeB7TSMMrzyW0RYHmyKl3E89BNw
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:707:b0:565:a33a:a49f with SMTP
 id bs7-20020a05690c070700b00565a33aa49fmr3431292ywb.6.1686167505991; Wed, 07
 Jun 2023 12:51:45 -0700 (PDT)
Date:   Wed,  7 Jun 2023 19:51:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607195143.1473802-1-yosryahmed@google.com>
Subject: [PATCH v2 1/2] mm: zswap: support exclusive loads
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
Bring back exclusive loads support to frontswap by adding an "exclusive"
output parameter to frontswap_ops->load.

On the zswap side, add a module parameter to enable/disable exclusive
loads, and a config option to control the boot default value.
Refactor zswap entry invalidation in zswap_frontswap_invalidate_page()
into zswap_invalidate_entry() to reuse it in zswap_frontswap_load() if
exclusive loads are enabled.

With exclusive loads, we avoid having two copies of the same page in
memory (compressed & uncompressed) after faulting it in from zswap. On
the other hand, if the page is to be reclaimed again without being
dirtied, it will be re-compressed. Compression is not usually slow, and
a page that was just faulted in is less likely to be reclaimed again
soon.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Add a module parameter to control whether exclusive loads are enabled
  or not, the config option now controls the default boot value instead.
  Replaced frontswap_ops->exclusive_loads by an output parameter to
  frontswap_ops->load() (Johannes Weiner).

---
 include/linux/frontswap.h |  2 +-
 mm/Kconfig                | 16 ++++++++++++++++
 mm/frontswap.c            | 10 ++++++++--
 mm/zswap.c                | 28 ++++++++++++++++++++--------
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index a631bac12220..eaa0ac5f9003 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -10,7 +10,7 @@
 struct frontswap_ops {
 	void (*init)(unsigned); /* this swap type was just swapon'ed */
 	int (*store)(unsigned, pgoff_t, struct page *); /* store a page */
-	int (*load)(unsigned, pgoff_t, struct page *); /* load a page */
+	int (*load)(unsigned, pgoff_t, struct page *, bool *); /* load a page */
 	void (*invalidate_page)(unsigned, pgoff_t); /* page no longer needed */
 	void (*invalidate_area)(unsigned); /* swap type just swapoff'ed */
 };
diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..12f32f8d26bf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -46,6 +46,22 @@ config ZSWAP_DEFAULT_ON
 	  The selection made here can be overridden by using the kernel
 	  command line 'zswap.enabled=' option.
 
+config ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON
+	bool "Invalidate zswap entries when pages are loaded"
+	depends on ZSWAP
+	help
+	  If selected, exclusive loads for zswap will be enabled at boot,
+	  otherwise it will be disabled.
+
+	  If exclusive loads are enabled, when a page is loaded from zswap,
+	  the zswap entry is invalidated at once, as opposed to leaving it
+	  in zswap until the swap entry is freed.
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
index 279e55b4ed87..2fb5df3384b8 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -206,6 +206,7 @@ int __frontswap_load(struct page *page)
 	int type = swp_type(entry);
 	struct swap_info_struct *sis = swap_info[type];
 	pgoff_t offset = swp_offset(entry);
+	bool exclusive = false;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(!PageLocked(page));
@@ -215,9 +216,14 @@ int __frontswap_load(struct page *page)
 		return -1;
 
 	/* Try loading from each implementation, until one succeeds. */
-	ret = frontswap_ops->load(type, offset, page);
-	if (ret == 0)
+	ret = frontswap_ops->load(type, offset, page, &exclusive);
+	if (ret == 0) {
 		inc_frontswap_loads();
+		if (exclusive) {
+			SetPageDirty(page);
+			__frontswap_clear(sis, offset);
+		}
+	}
 	return ret;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..bfbcedce9c89 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -137,6 +137,10 @@ static bool zswap_non_same_filled_pages_enabled = true;
 module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
 		   bool, 0644);
 
+static bool zswap_exclusive_loads_enabled = IS_ENABLED(
+		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
+module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
+
 /*********************************
 * data structures
 **********************************/
@@ -1329,12 +1333,22 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
 */
 static int zswap_frontswap_load(unsigned type, pgoff_t offset,
-				struct page *page)
+				struct page *page, bool *exclusive)
 {
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry;
@@ -1404,6 +1418,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
+	if (!ret && zswap_exclusive_loads_enabled) {
+		zswap_invalidate_entry(tree, entry);
+		*exclusive = true;
+	}
 	spin_unlock(&tree->lock);
 
 	return ret;
@@ -1423,13 +1441,7 @@ static void zswap_frontswap_invalidate_page(unsigned type, pgoff_t offset)
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
 
-- 
2.41.0.162.gfafddb0af9-goog

