Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F6663349
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbjAIVkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjAIVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:39:45 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B6E3BE87
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:38:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4755eb8a57bso106023707b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsT6wq4yb7S+NdjklyWb1ngjMGzkBXwNX+64A3lfzpA=;
        b=fvDtcLaeN/uzP3qHT8MCEklfe9OhLf6lmImIfuCacJYjG57XiBued7S3DOodRE/TYJ
         zCKNDg3ctqd3Dd67SPwPhW8ysEt0WGDBME6NGDgBcM5YrM326jXvkSXkPWXqmZwxbxsz
         JlJKx2q3UL/4NVtdfwNCMCP7QlTJxXBQXsxWNIIGkTyzBjhTdHqnlRz7A6SrrXEGohYg
         Y1TskQ4j5YZqdyazr4xhq4xZW9Gypy/dhRHNo7P2nwjIq6XxOhFfSm8keT19RigyoUi+
         Lj952kU65FcH0FMfMGjpPdMsLkeIqjmWXAgeBMVlEt6SVmi5tV7uui22G7kOc9eQRFhz
         T4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsT6wq4yb7S+NdjklyWb1ngjMGzkBXwNX+64A3lfzpA=;
        b=E6doaDt6zk8VjxgdXnWzmHLvKYLrXsRADPuk4EoDBxymm1eZZKHy7whqb93K8ujM9g
         70qzAfreCmqsMol0vnjTtMpZSu//1BihK35koGLEoFVqspumEH/lGhbOw19G8wc9TAyn
         eBq4T//uMGBao8GbXsTaBEJiA/ZY6nc/ODBz7CY7KJj+yzjqEJdkHj957z8HoFHclYXu
         sGokTb88UX4jlcMW5Yh+mVwpNKzAoInyPixWBSZstp7fOAj5JNBWW+Hky9IQu2EYfVnj
         wJg8BwLylKpvwOOpGuIHHVI9uhogt9lwT4uxIOvwUTtxSAP4HVj/SRBtU/xh5orvE0Xa
         bd6w==
X-Gm-Message-State: AFqh2kr81W2h0ef1BpbMPVTgSCGJHkq74vQvkEgzBdm++388hCxxaLYS
        noskJaPWBddmPrzgXW9/fETArHS9lP24SN0=
X-Google-Smtp-Source: AMrXdXtIpfaXFqcDGkNsmQctSMqXPQ/tLvykMkynrX+C5cGc1INOkvBaGX4j41udFUeKmd51zadys8k1Cp1SKbA=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a0d:e241:0:b0:48f:a921:40f2 with SMTP id
 l62-20020a0de241000000b0048fa92140f2mr5685523ywe.275.1673300307137; Mon, 09
 Jan 2023 13:38:27 -0800 (PST)
Date:   Mon,  9 Jan 2023 21:38:05 +0000
In-Reply-To: <20230109213809.418135-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109213809.418135-3-tjmercier@google.com>
Subject: [PATCH 2/4] dmabuf: Add cgroup charge transfer function
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc:     hannes@cmpxchg.org, daniel.vetter@ffwll.ch, android-mm@google.com,
        jstultz@google.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
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

The dma_buf_transfer_charge function provides a way for processes to
transfer charge of a buffer to a different cgroup. This is essential
for the cases where a central allocator process does allocations for
various subsystems, hands over the fd to the client who requested the
memory, and drops all references to the allocated memory.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/dma-buf.c  | 45 ++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h    |  1 +
 include/linux/memcontrol.h |  6 +++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ac45dd101c4d..fd6c5002032b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -11,6 +11,7 @@
  * refining of this idea.
  */
 
+#include <linux/atomic.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
@@ -1618,6 +1619,50 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
 
+/**
+ * dma_buf_transfer_charge - Change the cgroup to which the provided dma_buf is charged.
+ * @dmabuf:	[in]	buffer whose charge will be migrated to a different cgroup
+ * @target:	[in]	the task_struct of the destination process for the cgroup charge
+ *
+ * Only tasks that belong to the same cgroup the buffer is currently charged to
+ * may call this function, otherwise it will return -EPERM.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct task_struct *target)
+{
+	struct mem_cgroup *current_cg, *target_cg;
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_MEMCG))
+		return 0;
+
+	if (WARN_ON(!dmabuf) || WARN_ON(!target))
+		return -EINVAL;
+
+	current_cg = mem_cgroup_from_task(current);
+	target_cg = get_mem_cgroup_from_mm(target->mm);
+
+	if (current_cg == target_cg)
+		goto skip_transfer;
+
+	if (cmpxchg(&dmabuf->memcg, current_cg, target_cg) != current_cg) {
+		/* Only the current owner can transfer the charge */
+		ret = -EPERM;
+		goto skip_transfer;
+	}
+
+	mod_memcg_state(current_cg, MEMCG_DMABUF, -dmabuf->size);
+	mod_memcg_state(target_cg, MEMCG_DMABUF, dmabuf->size);
+
+	mem_cgroup_put(current_cg); /* unref from buffer - buffer keeps new ref to target_cg */
+	return 0;
+
+skip_transfer:
+	mem_cgroup_put(target_cg);
+	return ret;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 1f0ffb8e4bf5..6aa128d76aa7 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -634,4 +634,5 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
 int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
 void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
+int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct task_struct *target);
 #endif /* __DMA_BUF_H__ */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1c1da2da20a6..e5aec27044c7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1298,6 +1298,12 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 	return NULL;
 }
 
+static inline
+struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
+{
+	return NULL;
+}
+
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 }
-- 
2.39.0.314.g84b9a713c41-goog

