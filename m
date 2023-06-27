Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD573FB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjF0LXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjF0LXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999826B1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687864959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fr+vpotgatzONrB41R1RGYN75/TLbh/yXCu/qwGS3Ro=;
        b=B0XUmtXqbClOQr4B6glfkmKN0EiE+QLa8COqa0uTMpwlsiq3OVnzxqXLuPURGvprtMniwg
        un+DPurtDvn95ymNJa0M1rCrVEWvP0b3ElIG8bNHySdPlsC4qmME4k4MIyw1rkfPRNd+KS
        AQBaG9TTLOVx4jlpPuvr8k1dsuTFPYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-5tImlbEUOjm-C3jcDkwNPA-1; Tue, 27 Jun 2023 07:22:34 -0400
X-MC-Unique: 5tImlbEUOjm-C3jcDkwNPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9866800962;
        Tue, 27 Jun 2023 11:22:33 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10AC1200A3AD;
        Tue, 27 Jun 2023 11:22:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 3/5] mm/memory_hotplug: make offline_and_remove_memory() timeout instead of failing on fatal signals
Date:   Tue, 27 Jun 2023 13:22:18 +0200
Message-Id: <20230627112220.229240-4-david@redhat.com>
In-Reply-To: <20230627112220.229240-1-david@redhat.com>
References: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Hubbard writes [1]:

        Some device drivers add memory to the system via memory hotplug.
        When the driver is unloaded, that memory is hot-unplugged.

        However, memory hot unplug can fail. And these days, it fails a
        little too easily, with respect to the above case. Specifically, if
        a signal is pending on the process, hot unplug fails.

        [...]

        So in this case, other things (unmovable pages, un-splittable huge
        pages) can also cause the above problem. However, those are
        demonstrably less common than simply having a pending signal. I've
        got bug reports from users who can trivially reproduce this by
        killing their process with a "kill -9", for example.

Especially with ZONE_MOVABLE, offlining is supposed to work in most
cases when offlining actually hotplugged (not boot) memory, and only fail
in rare corner cases (e.g., some driver holds a reference to a page in
ZONE_MOVABLE, turning it unmovable).

In these corner cases we really don't want to be stuck forever in
offline_and_remove_memory(). But in the general cases, we really want to
do our best to make memory offlining succeed -- in a reasonable
timeframe.

Reliably failing in the described case when there is a fatal signal pending
is sub-optimal. The pending signal check is mostly only relevant when user
space explicitly triggers offlining of memory using sysfs device attributes
("state" or "online" attribute), but not when coming via
offline_and_remove_memory().

So let's use a timer instead and ignore fatal signals, because they are
not really expressive for offline_and_remove_memory() users. Let's default
to 30 seconds if no timeout was specified, and limit the timeout to 120
seconds.

This change is also valuable for virtio-mem in BBM (Big Block Mode) with
"bbm_safe_unplug=off", to avoid endless loops when stuck forever in
offline_and_remove_memory().

While at it, drop the "extern" from offline_and_remove_memory() to make
it fit into a single line.

[1] https://lkml.kernel.org/r/20230620011719.155379-1-jhubbard@nvidia.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c    |  2 +-
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 50 ++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index cb8bc6f6aa90..f8792223f1db 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -738,7 +738,7 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		"offlining and removing memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
-	rc = offline_and_remove_memory(addr, size);
+	rc = offline_and_remove_memory(addr, size, 0);
 	if (!rc) {
 		atomic64_sub(size, &vm->offline_size);
 		/*
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 9fcbf5706595..d5f9e8b5a4a4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -307,7 +307,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			 struct zone *zone, struct memory_group *group);
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
-extern int offline_and_remove_memory(u64 start, u64 size);
+int offline_and_remove_memory(u64 start, u64 size, unsigned int timeout_ms);
 
 #else
 static inline void try_offline_node(int nid) {}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0d2151df4ee1..ca635121644a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -152,6 +152,22 @@ void put_online_mems(void)
 
 bool movable_node_enabled = false;
 
+/*
+ * Protected by the device hotplug lock: offline_and_remove_memory()
+ * will activate a timer such that offlining cannot be stuck forever.
+ *
+ * With an active timer, fatal signals will be ignored, because they can be
+ * counter-productive when dying user space triggers device unplug/driver
+ * unloading that ends up offlining+removing device memory.
+ */
+static bool mhp_offlining_timer_active;
+static atomic_t mhp_offlining_timer_expired;
+
+static void mhp_offline_timer_fn(struct timer_list *unused)
+{
+	atomic_set(&mhp_offlining_timer_expired, 1);
+}
+
 #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
 int mhp_default_online_type = MMOP_OFFLINE;
 #else
@@ -1879,7 +1895,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	do {
 		pfn = start_pfn;
 		do {
-			if (fatal_signal_pending(current)) {
+			/*
+			 * If a timer is active, we're coming via
+			 * offline_and_remove_memory() and want to ignore even
+			 * fatal signals.
+			 */
+			if (mhp_offlining_timer_active) {
+				if (atomic_read(&mhp_offlining_timer_expired)) {
+					ret = -ETIMEDOUT;
+					reason = "timeout";
+					goto failed_removal_isolated;
+				}
+			} else if (fatal_signal_pending(current)) {
 				ret = -EINTR;
 				reason = "signal backoff";
 				goto failed_removal_isolated;
@@ -2232,11 +2259,17 @@ static int try_reonline_memory_block(struct memory_block *mem, void *arg)
  * memory is still in use. Primarily useful for memory devices that logically
  * unplugged all memory (so it's no longer in use) and want to offline + remove
  * that memory.
+ *
+ * offline_and_remove_memory() will not fail on fatal signals. Instead, it will
+ * fail once the timeout has been reached and offlining was not completed. If
+ * no timeout was specified, it will timeout after 30 seconds. The timeout is
+ * limited to 120 seconds.
  */
-int offline_and_remove_memory(u64 start, u64 size)
+int offline_and_remove_memory(u64 start, u64 size, unsigned int timeout_ms)
 {
 	const unsigned long mb_count = size / memory_block_size_bytes();
 	uint8_t *online_types, *tmp;
+	struct timer_list timer;
 	int rc;
 
 	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
@@ -2261,9 +2294,22 @@ int offline_and_remove_memory(u64 start, u64 size)
 
 	lock_device_hotplug();
 
+	if (!timeout_ms)
+		timeout_ms = 30 * MSEC_PER_SEC;
+	timeout_ms = min_t(unsigned int, timeout_ms, 120 * MSEC_PER_SEC);
+
+	timer_setup_on_stack(&timer, mhp_offline_timer_fn, 0);
+	mod_timer(&timer, jiffies + msecs_to_jiffies(timeout_ms));
+	mhp_offlining_timer_active = true;
+
 	tmp = online_types;
 	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
+	timer_delete_sync(&timer);
+	atomic_set(&mhp_offlining_timer_expired, 0);
+	mhp_offlining_timer_active = false;
+	destroy_timer_on_stack(&timer);
+
 	/*
 	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
-- 
2.40.1

