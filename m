Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB29D6AD7DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCGG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjCGG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:58:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50159405
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:57:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p20so13041455plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ra+jS9qPdJDcLL3tCNVjDgmNt8q5h7NH0ipc1XhyKg=;
        b=PS4W+FgTgUCjDbGtg+QwCoSMgK+PZFy9BY2F1ZThxrjZVSL14yAr0wpqGWIeHjNUI0
         MjcnS5KpgGlvLOSQCUAdkAjQZHluL/aF5sSdv42dRLNv4KIIzh+aWWZDjamM2HQABfg/
         ke15HkP04BOxxAYCBWXNW3bEgB1hjXjR2Uv8/YCxNcS8GL93fqqgDCLTaxFq1I/kUgHl
         LQ/t9QNRUeTUcPEAjMgUEh4v5iqcEyjJI/gJPK3velHfAXIwIh9N1aKawGtD5vTgD5rp
         0q/DlCg3cZIA9QSknjY+zItjUDbIe0idSmifezJtWhrwh7Hi0S+Ju/qHW2bubpQjjP41
         H5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ra+jS9qPdJDcLL3tCNVjDgmNt8q5h7NH0ipc1XhyKg=;
        b=P301nGzFxa2873ciT6LZL7aoZjIXfzYghyRui4ZQr7XfFgopxoO/EwyPDM1ME4jbzZ
         gP8Hrs5LCwpHb7+/BOxt+tyAvCMil2kEQmjrtsVF5Y8THUm0sSdm0Lk0yTMriejL2hff
         Bc8PH16fnaIvNPDfPEAcJGKIPjKiTCLndzjjUVPVH8n1SxewDUgeuXelME0NA2mh2Ag9
         GiSeP6LaUamaKC9q1h1mlIO8m1/2DE2ZF/XFdkcoQ4QaQViDEDaWAF+iHzpWyOwbXQSp
         /BSne+R6Dli1nXnYBy0iPUbxF9E0ySOpZdHXjwfYMX28oRjLwo6lwJqkKkdCOQB6a+Zb
         yA9w==
X-Gm-Message-State: AO0yUKWJ/zTvj7Js1E6UVDpGWeu37OJWfif6OPtEcJC9xEqNLaMwMD2z
        VkqJO6HZogQSF/otzXNDs29Hng==
X-Google-Smtp-Source: AK7set8QBMQzgGkmZ61qFh+1VNZI1JIL768E7/TAERxebGQIVfkBE4dBJCz38jB1/9PqBut3D4RTmw==
X-Received: by 2002:a05:6a20:6914:b0:cc:4118:65c4 with SMTP id q20-20020a056a20691400b000cc411865c4mr14603250pzj.5.1678172219371;
        Mon, 06 Mar 2023 22:56:59 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:56:58 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 5/8] mm: shrinkers: make count and scan in shrinker debugfs lockless
Date:   Tue,  7 Mar 2023 14:56:02 +0800
Message-Id: <20230307065605.58209-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

