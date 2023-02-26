Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446406A3178
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjBZO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjBZOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:55:45 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE114223
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:51:05 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id p20so2987759plw.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ra+jS9qPdJDcLL3tCNVjDgmNt8q5h7NH0ipc1XhyKg=;
        b=PLf5B69Jh3pz5GXkfJ0kzyAzNE9QmfDh24Eym4+RIsIY+kh7/HFsEQ2eahiZrlAtR+
         4MxgpRyO+JR9bXbQmyfDQ7Xzvmlu8kCxHtggdFCMFTGHU/zrqq+iyrlQZ1x2SIvb3hxE
         GprjsegftQOiKVGJiPih2MUwmk/ZVPeSzgftTgUUilU4HagO6HlGsAjToabMn30Ye2jJ
         D1sW5UHlLVaMC0PQVaPxtdHsFbPDqUB7VsgFSalXcyA5wqm6EJXO+viNO6MMi5fGoOK4
         u4SJ8zlHcmMYd0X0NrZ/p1mkOI0zz70UPWZaATCxnS4NbaHp2WXdx+JDlArqTdLRnVOn
         lPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ra+jS9qPdJDcLL3tCNVjDgmNt8q5h7NH0ipc1XhyKg=;
        b=FJApLAFXdKlFvXPpOomb1WAu7un9LMHeCfjsahFcsjzLGYM2Ou/Hca9QDkKQPkPD+7
         SaqANBo09j1HGyU1BQeWlrvMuE65kFcklZLJD6KF0uw6t6Vy7iEy77uooypxyIZIb9OT
         vAkXoCd+h41iwolBToRK8kAuWLCF5HeBg2i/YKNNjGpThyRUT3Sq8kKrnzF8JP0lcvDC
         yMQ0nho4hCn7oe7tT2W38RFycCJRYKy7lRHzNxZheev9Ep+eZj+LxBipDUTqzmWXeHjp
         ZRAOGg22LI4lq4axzzK79bNA31Ei9/EcWPGb+eJYAK4tfz8KZH1HUspK9p8BwTkXYKeH
         fs7A==
X-Gm-Message-State: AO0yUKWMb6pWVbtvSHKMaHWNSNLPKq7SUBw0CJ/ctNk9TRsBXJO+REFo
        zfi1wG7tkA3JPZoBALHPBUfN/g==
X-Google-Smtp-Source: AK7set+f72fXg+fOOH45vAOIpM4RdqUXZxaFOCsUrACUIANqZsAcaZRsNmxNPLzIzBDfISXFBkJnQw==
X-Received: by 2002:a17:903:2291:b0:19a:8202:2dad with SMTP id b17-20020a170903229100b0019a82022dadmr23250501plh.2.1677422919354;
        Sun, 26 Feb 2023 06:48:39 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:39 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 5/8] mm: shrinkers: make count and scan in shrinker debugfs lockless
Date:   Sun, 26 Feb 2023 22:46:52 +0800
Message-Id: <20230226144655.79778-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

