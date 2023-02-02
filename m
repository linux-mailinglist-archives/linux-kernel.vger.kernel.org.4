Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C557687AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBBK4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBBK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:56:49 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6E191
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:56:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s67so1041970pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZGQd3ZEpfxEWx84AJ4S31lQeA7DALcbnss414kwTcQ=;
        b=Fq1Jm4kPEFl3xG9CTLGkZqGijugCF5EjdmP3maNkfFSzj7483YEIlFW4dNuE4H1+Vk
         nPjD6Zzj39eaKLWO8oqEpUAtmd8pLqvYyZ0wHFl9q3hG0lUaQ1UECvjYfb3gZRROuZUR
         ft9oTETPHpUaW1ji6qmkmmV3C130M0nOHlSgfSWoIIZ2ehDL45UcKHW9djW17WJwBgus
         ZdgZGdp8Rf/C2kkdNl0c94BE74UhImB7pdraRcEs13NLJXgjpgAXA6847mJeTjKyjpAq
         mDMlCDFQyr2ACpYGKHoE7YJeq1cZRVAvhFmh2JBMkgIqBgWfw6QwILbVGq94sAEy1d2y
         BCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZGQd3ZEpfxEWx84AJ4S31lQeA7DALcbnss414kwTcQ=;
        b=SiW/8cOOdyJ+0c9MwcxE4enIQbWeyokZzUC0cvdYpIS509yQLfv9P/09fPFZkGoqYI
         tyD5pG0djvDxBQxuODDIgwbBEWrWkMIlig7/2gwRlbElnNyGNQxQQE5vrdnE5c0gueXV
         lncIlV/d/frQpdh6troa/sowV9wCd8IEFpdba2qOwD7xWuCIvau60w7285gbtZzORi3u
         suXTX/T0tJ2cha5nsZhG6vW0S/qYY4ELtkWx6UC6b50qvnlvpbwC+mvgFX/A0h/ey/5o
         XN8g26ecBc8z4Gd3US0B35zH9xywnzobh2+H359G2zuFZnvXU3j07d8hznwdAEX7xO6m
         2qXg==
X-Gm-Message-State: AO0yUKX2VVB6jwdN5NiO4DIOrLY7DVOV3qHQ7mFjO9C8lALMy+ZjGtGR
        2jBIbyqurnJBUb3l4BWzD0QNNQ==
X-Google-Smtp-Source: AK7set/qOspKd7ukDh0t1ooBxwcrETdnU7/QgWjdADcGUSDcZq/s27xvhFg7hwvYHKqEttTDiYzaBQ==
X-Received: by 2002:a05:6a00:1d13:b0:593:b112:5cf2 with SMTP id a19-20020a056a001d1300b00593b1125cf2mr5589835pfx.2.1675335382252;
        Thu, 02 Feb 2023 02:56:22 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 144-20020a621996000000b0058bcb42dd1asm13262409pfz.111.2023.02.02.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:56:21 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, roman.gushchin@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: shrinkers: fix deadlock in shrinker debugfs
Date:   Thu,  2 Feb 2023 18:56:12 +0800
Message-Id: <20230202105612.64641-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_remove_recursive() is invoked by unregister_shrinker(),
which is holding the write lock of shrinker_rwsem. It will waits
for the handler of debugfs file complete. The handler also needs
to hold the read lock of shrinker_rwsem to do something. So it
may cause the following deadlock:

 	CPU0				CPU1

debugfs_file_get()
shrinker_debugfs_count_show()/shrinker_debugfs_scan_write()

     				unregister_shrinker()
				--> down_write(&shrinker_rwsem);
				    debugfs_remove_recursive()
					// wait for (A)
				    --> wait_for_completion();

    // wait for (B)
--> down_read_killable(&shrinker_rwsem)
debugfs_file_put() -- (A)

				    up_write() -- (B)

The down_read_killable() can be killed, so that the above deadlock
can be recovered. But it still requires an extra kill action,
otherwise it will block all subsequent shrinker-related operations,
so it's better to fix it.

Fixes: 5035ebc644ae ("mm: shrinkers: introduce debugfs interface for memory shrinkers")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h |  4 ++--
 mm/shrinker_debug.c      | 13 ++++++++-----
 mm/vmscan.c              |  6 +++++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 71310efe2fab..0cf3e0d31433 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -107,7 +107,7 @@ extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern void shrinker_debugfs_remove(struct shrinker *shrinker);
+extern struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker);
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
 #else /* CONFIG_SHRINKER_DEBUG */
@@ -115,7 +115,7 @@ static inline int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	return 0;
 }
-static inline void shrinker_debugfs_remove(struct shrinker *shrinker)
+static inline struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
 {
 }
 static inline __printf(2, 3)
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index b05295bab322..39c3491e28a3 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -246,18 +246,21 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 }
 EXPORT_SYMBOL(shrinker_debugfs_rename);
 
-void shrinker_debugfs_remove(struct shrinker *shrinker)
+struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
 {
+	struct dentry *entry = shrinker->debugfs_entry;
+
 	lockdep_assert_held(&shrinker_rwsem);
 
 	kfree_const(shrinker->name);
 	shrinker->name = NULL;
 
-	if (!shrinker->debugfs_entry)
-		return;
+	if (entry) {
+		ida_free(&shrinker_debugfs_ida, shrinker->debugfs_id);
+		shrinker->debugfs_entry = NULL;
+	}
 
-	debugfs_remove_recursive(shrinker->debugfs_entry);
-	ida_free(&shrinker_debugfs_ida, shrinker->debugfs_id);
+	return entry;
 }
 
 static int __init shrinker_debugfs_init(void)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637fcd8f9..74342caf8022 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -741,6 +741,8 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
+	struct dentry *debugfs_entry;
+
 	if (!(shrinker->flags & SHRINKER_REGISTERED))
 		return;
 
@@ -749,9 +751,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
-	shrinker_debugfs_remove(shrinker);
+	debugfs_entry = shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
+	debugfs_remove_recursive(debugfs_entry);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
-- 
2.20.1

