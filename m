Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7E6F4E95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjECBcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECBcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:32:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560E1BCA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 18:32:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so2769851f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 18:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683077564; x=1685669564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTZgBzt/Dt27iMmQO6dhb2LS1gvv1g1KyF6acTixJxs=;
        b=O5S0To9nyxHcJIw7kPTikmqTRPb8hGKGfJiX/+CaUyeBf/Q8KNQLEa5qQG7qOvFFiw
         CYsfOJ7l4XASubNxVyVApEX3Bl8ME+BvLsmqnS1g/MpfUqgX3eWAfB7LkMTyA3/44KTV
         E6ldthUiLttApU2v+jWdw4olhg8atOZJWE9U9BFeTr4Tu/QEjekRGMPBFc0/omb2gC4D
         dnuzDaxjCI7QyW6Lxzc7kDZXsZ2w67pDeVr8DvaBQmaNAjJRmI2mp4E9mrJ1BnsoYQSf
         zMHaX0ZXKLm5nsetB8esqGry5Kv3k3CRAZmIE8brVX8X4l3Zf1mtk5xJwhAo+nl1PlBI
         NJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683077564; x=1685669564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTZgBzt/Dt27iMmQO6dhb2LS1gvv1g1KyF6acTixJxs=;
        b=Unj7NALvm9FJ8aEib0kkfhVFr56TZ4cqYSYgvmNflquZrnsZh5zsQlykZlX/E9G8En
         7rGEoB5J0icQdvqLpGbd99/Kq8zIChTNfsab1TexaBPR6mbwjFTDAqG43yZuPCkVQptD
         F96BBANCkO53Ccyr3RqgkmwbnumNXqSTGQzcCg7lSWcVo/NeqTCIV8HuNd3HDkNptf/l
         UYfPaFu+eogMJrxO91Pq7j1rUu2ShM3uT7GX0qKL+cShDtNsE/TMrom/TSBmq5v6oTgr
         kbWKagDkpJuMBMeZ+wEN3PvPaLZ9LaIGtFw/HWgU8eLhe6bez8uGqO2xsameUxQKnY9S
         mo7g==
X-Gm-Message-State: AC+VfDwIIedY3qmY9x/tIGY2w9vgU4Drt/XYlvQx0a7hFOqNcSfysKF3
        cd1iUsh9FTXcjmCogVjNnLI=
X-Google-Smtp-Source: ACHHUZ4wJxiINWHqiPZ1tK0Urj08OmEq65prz3nTqgIPb9vpzcA8vu2n1QK7yL9oCdNarP6qzxagjQ==
X-Received: by 2002:a05:6000:1191:b0:306:34f6:de8a with SMTP id g17-20020a056000119100b0030634f6de8amr3239356wrx.71.1683077563489;
        Tue, 02 May 2023 18:32:43 -0700 (PDT)
Received: from solport.. (24.red-83-42-52.dynamicip.rima-tde.net. [83.42.52.24])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d6e07000000b003048084a57asm22744019wrz.79.2023.05.02.18.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 18:32:42 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: [PATCH] mm: shrinkers: fix race condition on debugfs cleanup
Date:   Wed,  3 May 2023 01:32:32 +0000
Message-Id: <20230503013232.299211-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When something registers and unregisters many shrinkers, such as:
    for x in $(seq 10000); do unshare -Ui true; done

Sometimes the following error is printed to the kernel log:
    debugfs: Directory '...' with parent 'shrinker' already present!

This occurs since commit badc28d4924b ("mm: shrinkers: fix deadlock in
shrinker debugfs") / v6.2: Since the call to `debugfs_remove_recursive`
was moved outside the `shrinker_rwsem`/`shrinker_mutex` lock, but the call
 to `ida_free` stayed inside, a newly registered shrinker can be
 re-assigned that ID and attempt to create the debugfs directory before
the directory from the previous shrinker has been removed.

The locking changes in commit f95bdb700bc6 ("mm: vmscan: make global slab
shrink lockless") made the race condition more likely, though it existed
before then.

Commit badc28d4924b ("mm: shrinkers: fix deadlock in shrinker debugfs")
could be reverted since the issue is addressed should no longer occur
since the count and scan operations are lockless since commit 20cd1892fcc3
("mm: shrinkers: make count and scan in shrinker debugfs lockless").
However, since this is a contended lock, prefer instead moving `ida_free`
outside the lock to avoid the race.

Fixes: badc28d4924b ("mm: shrinkers: fix deadlock in shrinker debugfs")
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
---
 include/linux/shrinker.h | 13 +++++++++++--
 mm/shrinker_debug.c      | 15 ++++++++++-----
 mm/vmscan.c              |  5 +++--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 7bde8e1c228a..224293b2dd06 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -107,7 +107,10 @@ extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker);
+extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+					      int *debugfs_id);
+extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+				    int debugfs_id);
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
 #else /* CONFIG_SHRINKER_DEBUG */
@@ -115,10 +118,16 @@ static inline int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	return 0;
 }
-static inline struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
+static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+						     int *debugfs_id)
 {
+	*debugfs_id = -1;
 	return NULL;
 }
+static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+					   int debugfs_id)
+{
+}
 static inline __printf(2, 3)
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 3f83b10c5031..fe10436d9911 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -237,7 +237,8 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 }
 EXPORT_SYMBOL(shrinker_debugfs_rename);
 
-struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
+struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+				       int *debugfs_id)
 {
 	struct dentry *entry = shrinker->debugfs_entry;
 
@@ -246,14 +247,18 @@ struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
 	kfree_const(shrinker->name);
 	shrinker->name = NULL;
 
-	if (entry) {
-		ida_free(&shrinker_debugfs_ida, shrinker->debugfs_id);
-		shrinker->debugfs_entry = NULL;
-	}
+	*debugfs_id = entry ? shrinker->debugfs_id : -1;
+	shrinker->debugfs_entry = NULL;
 
 	return entry;
 }
 
+void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
+{
+	debugfs_remove_recursive(debugfs_entry);
+	ida_free(&shrinker_debugfs_ida, debugfs_id);
+}
+
 static int __init shrinker_debugfs_init(void)
 {
 	struct shrinker *shrinker;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5bde07409303..c7d0faa343e0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -805,6 +805,7 @@ EXPORT_SYMBOL(register_shrinker);
 void unregister_shrinker(struct shrinker *shrinker)
 {
 	struct dentry *debugfs_entry;
+	int debugfs_id;
 
 	if (!(shrinker->flags & SHRINKER_REGISTERED))
 		return;
@@ -814,13 +815,13 @@ void unregister_shrinker(struct shrinker *shrinker)
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
-	debugfs_entry = shrinker_debugfs_remove(shrinker);
+	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 	mutex_unlock(&shrinker_mutex);
 
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
-	debugfs_remove_recursive(debugfs_entry);
+	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.40.1

