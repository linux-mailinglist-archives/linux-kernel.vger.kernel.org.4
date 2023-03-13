Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAE6B75FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCMLaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCMLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEA570AC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u5so12549651plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678707009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxd2ThxTJ6UijCJ4SDDL7FUC7F7cO/btWP9US9pLSzo=;
        b=MvlGryeRy82G7VkgqEKuMpQfzAezLp2xXrHbHKrQM/eEt81Oq/AfYVdlB/GIobl8It
         7j2/egtK7yEFhJCwQO1OEf29hlspWlTFr6UYJKW30dRAjzdPoQtwo+yeUuFCO5XjM1fR
         QTpRAX/3KhabhS2FMYkh8JFMbk32znCcnVB0I8hQW5KZXN6S0Oxh6LXvEwjcTlYALXpV
         G6Kh9bDRNBabSRjM+xuJvnmQWOWsrkeBNmVU+B+cq0i32zf+AmsgqKMTYjYBMPOnHkL9
         Scfe6Zs4rWOLcpW74stS1wV1wpoCCzVwzmigR2g2N6q5dgesopZRoP+7gE0A+6gqZQ3p
         5mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxd2ThxTJ6UijCJ4SDDL7FUC7F7cO/btWP9US9pLSzo=;
        b=3JxYf2QSH3XS4UaJemiAHwqhbY8tJDc3FGUBxeTwnJYBTVU/Phz0A+tptEBxuya4N4
         ho7lgbRpwKeEZfF1IKt36HH5Ta0D5yMiBJ2PYf3zfF9N60b47pDS3TDMGDVMZQlL+q8V
         HLLpZpUlHyxhvEC9GEeEhGGvR/99tGrfCUpHcPw1+zc0GM+zcI6BHV1EQCsQ4uL2t0/A
         VCmG689yP5v9HjRjj0BIoTjM5GDRPO6JKJGnBXeIE4mNesFswxV5XgEsbeEop7nnWvd0
         H0rzSVMKiSaGejWQX7cV5CWGREH4DiQ3O/u+EYo/DD855Tf48LJtCth+HONG0Nu3eAob
         gjHQ==
X-Gm-Message-State: AO0yUKWNLuxUNd0L66Wqcr4+E85sDoXtBwKExFQdRY+3czVVhoN8g99c
        Bsx4NigkK1NBD83wOtfBITxqLg==
X-Google-Smtp-Source: AK7set/YpeTiNPrxyPdk7ef1TN6nco5qoqim2zvGi95z+KNjYPKTOUxtpQzpzKaJth1w+KxBldYOuQ==
X-Received: by 2002:a05:6a20:6914:b0:cc:4118:65c4 with SMTP id q20-20020a056a20691400b000cc411865c4mr12735774pzj.5.1678707009311;
        Mon, 13 Mar 2023 04:30:09 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:30:08 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 5/8] mm: shrinkers: make count and scan in shrinker debugfs lockless
Date:   Mon, 13 Mar 2023 19:28:16 +0800
Message-Id: <20230313112819.38938-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
References: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <tkhai@ya.ru>
---
 mm/shrinker_debug.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 39c3491e28a3..37d54d037495 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -5,10 +5,12 @@
 #include <linux/seq_file.h>
 #include <linux/shrinker.h>
 #include <linux/memcontrol.h>
+#include <linux/srcu.h>
 
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
 extern struct list_head shrinker_list;
+extern struct srcu_struct shrinker_srcu;
 
 static DEFINE_IDA(shrinker_debugfs_ida);
 static struct dentry *shrinker_debugfs_root;
@@ -49,18 +51,13 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
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
 
@@ -91,8 +88,7 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 
 	kfree(count_per_node);
 	return ret;
@@ -115,9 +111,8 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		.gfp_mask = GFP_KERNEL,
 	};
 	struct mem_cgroup *memcg = NULL;
-	int nid;
+	int nid, srcu_idx;
 	char kbuf[72];
-	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -146,11 +141,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
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
@@ -159,7 +150,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.20.1

