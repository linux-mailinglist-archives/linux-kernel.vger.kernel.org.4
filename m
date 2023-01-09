Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE73D66334F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjAIVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbjAIVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:39:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C7D19C35
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:38:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l194-20020a2525cb000000b007b411fbdc13so10521428ybl.23
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzZnon9AuhDOmqXXwy+4pPV98gk0DXyzNf2lwwH3FVc=;
        b=MIKhBBBnQ+bqQnJww8/fPsZhi0whxCGIUG6kEGUGMp4FOf1NaJ2uHO5gbQnelxNiQA
         /zZow36TcojzDwPLoUOvG98yay8W+H/pD2HMrI1l93vbQq7yL0EPGLWZQ0R6+VY7DRtV
         JNWPRrorFPERhG5pCoV73P8K4BeUX6WEsXjfyFLgqrSJKvyOp3o0siNMo696W/r6yKXU
         y8RJ2vfZCTDjh6Oi2w1rHjBj4wQlmL0t+ZRPOFSxOTrZS7vGovErpCiunYz6Rey8BJDi
         cncB+zuYtfJ9rQv3FhWwefPz3sWwVINattaPynPAVTeC+nbR6FJw+i6h1qaddB0J7iUL
         VYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzZnon9AuhDOmqXXwy+4pPV98gk0DXyzNf2lwwH3FVc=;
        b=xYacJHP40bNwZZ9twnGYb5PCc8dpJkchSlDL1xF2i5PTJ7ZHxpwYyqDWxJRQq6uWg2
         Yy6TKQ44ZPUlsJXDr0kkEUQd9jqEbXIXx+NoUzjetoz8srSk6LYmLzEYDBGcBjJVls3u
         JRrs7qAkURMiStp29GN6Z5Izkg/zAwKJ0Sx8Qv3+4N3OjDEYYtnAOt041OfNibz3IT1a
         vmPgeKDtvJ1B9rN79BM7ubUSrPFASFxKeB1zCw/2blzF09500N76+PqpPUkBAnE0fNTu
         7Mhb4dLkeFMcgizGYXP0C0V6KGuaJ/5OYXZnL+guHdKfudoyk4U3zmQ/pr8hoDqdqTF/
         QSow==
X-Gm-Message-State: AFqh2kpb1hLG0CF0ZIBaiK0HRHfIDnH+sbYs3nntm7gSBlERwEoVTEj/
        OcEgeZEmKZA22A3zFYVQ1gUcx9nNUN1VVJ0=
X-Google-Smtp-Source: AMrXdXtOrlHW8ygC4EeYcDKs1WQIoeE3W+TEcqNZ/tFdoHO00Cnd/PEn3XI5TMhGx2JhnY0yguaIzWNDLrFIktg=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a81:6784:0:b0:460:c029:6c76 with SMTP id
 b126-20020a816784000000b00460c0296c76mr2274300ywc.515.1673300304313; Mon, 09
 Jan 2023 13:38:24 -0800 (PST)
Date:   Mon,  9 Jan 2023 21:38:04 +0000
In-Reply-To: <20230109213809.418135-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109213809.418135-2-tjmercier@google.com>
Subject: [PATCH 1/4] memcg: Track exported dma-buffers
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a buffer is exported to userspace, use memcg to attribute the
buffer to the allocating cgroup until all buffer references are
released.

Unlike the dmabuf sysfs stats implementation, this memcg accounting
avoids contention over the kernfs_rwsem incurred when creating or
removing nodes.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 drivers/dma-buf/dma-buf.c               | 5 +++++
 include/linux/dma-buf.h                 | 3 +++
 include/linux/memcontrol.h              | 1 +
 mm/memcontrol.c                         | 4 ++++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c8ae7c897f14..538ae22bc514 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1455,6 +1455,10 @@ PAGE_SIZE multiple when read back.
 		Amount of memory used for storing in-kernel data
 		structures.
 
+	  dmabuf (npn)
+		Amount of memory used for exported DMA buffers allocated by the cgroup.
+		Stays with the allocating cgroup regardless of how the buffer is shared.
+
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
 
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index e6528767efc7..ac45dd101c4d 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -75,6 +75,8 @@ static void dma_buf_release(struct dentry *dentry)
 	 */
 	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
 
+	mod_memcg_state(dmabuf->memcg, MEMCG_DMABUF, -dmabuf->size);
+	mem_cgroup_put(dmabuf->memcg);
 	dma_buf_stats_teardown(dmabuf);
 	dmabuf->ops->release(dmabuf);
 
@@ -673,6 +675,9 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	if (ret)
 		goto err_dmabuf;
 
+	dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
+	mod_memcg_state(dmabuf->memcg, MEMCG_DMABUF, dmabuf->size);
+
 	file->private_data = dmabuf;
 	file->f_path.dentry->d_fsdata = dmabuf;
 	dmabuf->file = file;
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 6fa8d4e29719..1f0ffb8e4bf5 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
+#include <linux/memcontrol.h>
 
 struct device;
 struct dma_buf;
@@ -446,6 +447,8 @@ struct dma_buf {
 		struct dma_buf *dmabuf;
 	} *sysfs_entry;
 #endif
+	/* The cgroup to which this buffer is currently attributed */
+	struct mem_cgroup *memcg;
 };
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d3c8203cab6c..1c1da2da20a6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -37,6 +37,7 @@ enum memcg_stat_item {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+	MEMCG_DMABUF,
 	MEMCG_NR_STAT,
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab..680189bec7e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1502,6 +1502,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "unevictable",		NR_UNEVICTABLE			},
 	{ "slab_reclaimable",		NR_SLAB_RECLAIMABLE_B		},
 	{ "slab_unreclaimable",		NR_SLAB_UNRECLAIMABLE_B		},
+	{ "dmabuf",			MEMCG_DMABUF			},
 
 	/* The memory events */
 	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
@@ -1519,6 +1520,7 @@ static int memcg_page_state_unit(int item)
 	switch (item) {
 	case MEMCG_PERCPU_B:
 	case MEMCG_ZSWAP_B:
+	case MEMCG_DMABUF:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
 	case WORKINGSET_REFAULT_ANON:
@@ -4042,6 +4044,7 @@ static const unsigned int memcg1_stats[] = {
 	WORKINGSET_REFAULT_ANON,
 	WORKINGSET_REFAULT_FILE,
 	MEMCG_SWAP,
+	MEMCG_DMABUF,
 };
 
 static const char *const memcg1_stat_names[] = {
@@ -4057,6 +4060,7 @@ static const char *const memcg1_stat_names[] = {
 	"workingset_refault_anon",
 	"workingset_refault_file",
 	"swap",
+	"dmabuf",
 };
 
 /* Universal VM events cgroup1 shows, original sort order */
-- 
2.39.0.314.g84b9a713c41-goog

