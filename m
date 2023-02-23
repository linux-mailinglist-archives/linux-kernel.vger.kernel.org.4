Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6570C6A0A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBWN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:16 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC232E41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q23so396099pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ra+jS9qPdJDcLL3tCNVjDgmNt8q5h7NH0ipc1XhyKg=;
        b=DpDn8Y+EU7riH4+ntcDG6C1rbsBVGtUkMmoAHDS+pC4P++8EynweyAV0JYqlyYGOtq
         X1Q+BLwoJwcnB84jpi52eVKNQ4Z7H9xuUGTHfERfoIzzzU6ACyTdYigUXyW6IU9Ious4
         Dcv7MyI3TgRfz/xnXu5LeFECNtdpthD72ekZGWDFwliGf58bj+lRnE/qeFjqbyzPR/dU
         QS9YrLbbOfovo0TIt/QhGWwwvNLxWcvBspvW0zUIZAUavOJoYjXfSG6Wy0VfFlInlS7B
         HNvoy7xqBZa0nU3FIEoV776Q0WiC55EpZXUOtrYeZXGMXYVopQbU7AkcvEji/pZV0uXq
         Rv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ra+jS9qPdJDcLL3tCNVjDgmNt8q5h7NH0ipc1XhyKg=;
        b=EOH+8mc5ZoMOuS8Z+f0TutJe8L+3xekWgzJOYt0yR5dGenWZwvKDz+mE+XZN52jX0q
         08y/pICnSO6aA5NF2w9u625xkHA0JZluKqhuMmbIHMov+TR3Qn7v97a9eknVCbnv1gfl
         r/xZRMs9+HL4PZSXkO316sbRSLyUumLiIGQw29/+/u2rafzt0g1cnFhMKxxUxbvKXvCd
         envoLjrPyd0bu1NOkZ/HmgzeUlJRWVWiz7LV2uo25SehWS8NxRwPirdzSvVdh8ls1Nbo
         o2wItosdzTIcLx9iM3dhe+ai2rKk0VB+MRNxC5pzjIErYLBUvv/EdYAkHkla76BPRxFW
         WBqQ==
X-Gm-Message-State: AO0yUKWtsGKTO1K1eSX0InzCnCwV7O51wr9hWMzlswUVa6MafxC1Trz+
        VhcUfUg874b3mkN6BEXnXBjAPg==
X-Google-Smtp-Source: AK7set8Z/82YLh8rwyoUePgrhBmvgU8h/2aIZeBSX/0142PpIqvK6RYABRkBwNOTr58e5iHS5l9UsQ==
X-Received: by 2002:a05:6a00:299b:b0:5a8:ae97:25f2 with SMTP id cj27-20020a056a00299b00b005a8ae9725f2mr12832291pfb.0.1677158893792;
        Thu, 23 Feb 2023 05:28:13 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:28:13 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 4/7] mm: shrinkers: make count and scan in shrinker debugfs lockless
Date:   Thu, 23 Feb 2023 21:27:22 +0800
Message-Id: <20230223132725.11685-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like global and memcg slab shrink, also use SRCU to
make count and scan operations in memory shrinker
debugfs lockless.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker_debug.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 39c3491e28a3..6aa7a7ec69da 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -9,6 +9,7 @@
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
 extern struct list_head shrinker_list;
+extern struct srcu_struct shrinker_srcu;
 
 static DEFINE_IDA(shrinker_debugfs_ida);
 static struct dentry *shrinker_debugfs_root;
@@ -49,18 +50,13 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	struct mem_cgroup *memcg;
 	unsigned long total;
 	bool memcg_aware;
-	int ret, nid;
+	int ret = 0, nid, srcu_idx;
 
 	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
 	if (!count_per_node)
 		return -ENOMEM;
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		kfree(count_per_node);
-		return ret;
-	}
-	rcu_read_lock();
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
 
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
 
@@ -91,8 +87,7 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 
 	kfree(count_per_node);
 	return ret;
@@ -115,9 +110,8 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		.gfp_mask = GFP_KERNEL,
 	};
 	struct mem_cgroup *memcg = NULL;
-	int nid;
+	int nid, srcu_idx;
 	char kbuf[72];
-	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -146,11 +140,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EINVAL;
 	}
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		mem_cgroup_put(memcg);
-		return ret;
-	}
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
 
 	sc.nid = nid;
 	sc.memcg = memcg;
@@ -159,7 +149,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.20.1

