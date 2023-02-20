Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89E69C785
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjBTJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBTJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:17:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8184914981
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id g14so645848pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676884637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zoWZenRiYoNEE8cLwabKUnZ2EMcSBm37bQ/nay5M2Q=;
        b=pwzSI/vf4Vj+GnZxNmyMXkgptBLDA76ZJ1o4OmWFlr6dQarsPx2C++HYAz6Dpn2Aht
         AJqCW7TXaRjGCwXrIkRHBWZUa/9Uq4ShcEkudpvCqCUfsPPUCgYIFXYWtN9++5OxpAqO
         gLMuad7DyF/pXHMjpwmBdYV9XSfe7U12nWp4ShfpW3jKBm3KNO+XTZT5cAaCcrQzzIV1
         oqisd022sPfT5wczUD241WMl4IN/0R3a2LXx3Bxnlvt0dMus9chI20ZmPMJtAtZCf//h
         6YyC4HjkwgSHI06kMieLeE16TKJuxDd6RvwRYYtadIFV1TOrOtPRFHlt9t2tMxB1hTiB
         KYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676884637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zoWZenRiYoNEE8cLwabKUnZ2EMcSBm37bQ/nay5M2Q=;
        b=SOqQQPWO1hlJxwFaWFEJzS4vyQ8fdb3VXNPaWjXFyW/EEauLiPKAAB2jY08jz+gXFD
         6wzO/+z2PWA28aFLyB7O+TlPi+Y6Sn0QaLtLYhBkw5wmTauKOArWtcwCjDyiDHs4DXWw
         F6zs43lo39VLsW5g13BQqmTjpdopmv3VasXAFOfwmfl1kMu/6mesjiM69DNFl23riVZh
         1Jj8W8IWiwOrs1SFHleIfVCf89QNlrW0jfCLVPnCa4hPKvnBS2g9OsIxHuaForz5CYGE
         wLFhNNCvicDs69h1JTEJHcGBeh/fhCPwk9G6UBLNBXE9BqyrK/CVdB8tb3tb+JyJgmer
         2dAA==
X-Gm-Message-State: AO0yUKWks6xla4hBOmy6BAu8ZQN+N9gTofVHGTOCfW7Jvocb11gdrh9t
        tO7csMOZM1nxv/ZGVd+xJDUJww==
X-Google-Smtp-Source: AK7set/u/nMGrcmsUwC5AW5uACSHbng2msaMYYygQeSDbSQ22MPUA9tjyQkhFmQoA6dgXKjSY0gUIw==
X-Received: by 2002:a17:90a:c915:b0:234:175:839a with SMTP id v21-20020a17090ac91500b002340175839amr660167pjt.4.1676884637069;
        Mon, 20 Feb 2023 01:17:17 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id fs13-20020a17090af28d00b002339195a47bsm432382pjb.53.2023.02.20.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:17:16 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     tkhai@ya.ru, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/5] mm: shrinkers: make count and scan in shrinker debugfs lockless
Date:   Mon, 20 Feb 2023 17:16:35 +0800
Message-Id: <20230220091637.64865-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
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

Like global and memcg slab shrink, also use SRCU to
make count and scan operations in memory shrinker
debugfs lockless.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker_debug.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 39c3491e28a3..6a26e8ac40aa 100644
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
+	int ret, nid, srcu_idx;
 
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

