Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35087734BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjFSGvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjFSGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:51:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B713D;
        Sun, 18 Jun 2023 23:51:27 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ql0m93YPPz1GDDs;
        Mon, 19 Jun 2023 14:51:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 14:51:25 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <stable@vger.kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH stable 5.10] mm/memory_hotplug: extend offline_and_remove_memory() to handle more than one memory block
Date:   Mon, 19 Jun 2023 14:51:21 +0800
Message-ID: <20230619065121.1720912-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
References: <cd9688dc-a716-3031-489e-a867df0d1ea2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

commit 8dc4bb58a146655eb057247d7c9d19e73928715b upstream.

virtio-mem soon wants to use offline_and_remove_memory() memory that
exceeds a single Linux memory block (memory_block_size_bytes()). Let's
remove that restriction.

Let's remember the old state and try to restore that if anything goes
wrong. While re-onlining can, in general, fail, it's highly unlikely to
happen (usually only when a notifier fails to allocate memory, and these
are rather rare).

This will be used by virtio-mem to offline+remove memory ranges that are
bigger than a single memory block - for example, with a device block
size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
block size of 128MB.

While we could compress the state into 2 bit, using 8 bit is much
easier.

This handling is similar, but different to acpi_scan_try_to_offline():

a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
optimization is still relevant - it should only apply to ZONE_NORMAL
(where we have no guarantees). If relevant, we can always add it.

b) acpi_scan_try_to_offline() simply onlines all memory in case
something goes wrong. It doesn't restore previous online type. Let's do
that, so we won't overwrite what e.g., user space configured.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20201112133815.13332-28-david@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f0633f9a9116..9ec9e1e67705 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1788,39 +1788,112 @@ int remove_memory(int nid, u64 start, u64 size)
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 
+static int try_offline_memory_block(struct memory_block *mem, void *arg)
+{
+	uint8_t online_type = MMOP_ONLINE_KERNEL;
+	uint8_t **online_types = arg;
+	struct page *page;
+	int rc;
+
+	/*
+	 * Sense the online_type via the zone of the memory block. Offlining
+	 * with multiple zones within one memory block will be rejected
+	 * by offlining code ... so we don't care about that.
+	 */
+	page = pfn_to_online_page(section_nr_to_pfn(mem->start_section_nr));
+	if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
+		online_type = MMOP_ONLINE_MOVABLE;
+
+	rc = device_offline(&mem->dev);
+	/*
+	 * Default is MMOP_OFFLINE - change it only if offlining succeeded,
+	 * so try_reonline_memory_block() can do the right thing.
+	 */
+	if (!rc)
+		**online_types = online_type;
+
+	(*online_types)++;
+	/* Ignore if already offline. */
+	return rc < 0 ? rc : 0;
+}
+
+static int try_reonline_memory_block(struct memory_block *mem, void *arg)
+{
+	uint8_t **online_types = arg;
+	int rc;
+
+	if (**online_types != MMOP_OFFLINE) {
+		mem->online_type = **online_types;
+		rc = device_online(&mem->dev);
+		if (rc < 0)
+			pr_warn("%s: Failed to re-online memory: %d",
+				__func__, rc);
+	}
+
+	/* Continue processing all remaining memory blocks. */
+	(*online_types)++;
+	return 0;
+}
+
 /*
- * Try to offline and remove a memory block. Might take a long time to
- * finish in case memory is still in use. Primarily useful for memory devices
- * that logically unplugged all memory (so it's no longer in use) and want to
- * offline + remove the memory block.
+ * Try to offline and remove memory. Might take a long time to finish in case
+ * memory is still in use. Primarily useful for memory devices that logically
+ * unplugged all memory (so it's no longer in use) and want to offline + remove
+ * that memory.
  */
 int offline_and_remove_memory(int nid, u64 start, u64 size)
 {
-	struct memory_block *mem;
-	int rc = -EINVAL;
+	const unsigned long mb_count = size / memory_block_size_bytes();
+	uint8_t *online_types, *tmp;
+	int rc;
 
 	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
-	    size != memory_block_size_bytes())
-		return rc;
+	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
+		return -EINVAL;
+
+	/*
+	 * We'll remember the old online type of each memory block, so we can
+	 * try to revert whatever we did when offlining one memory block fails
+	 * after offlining some others succeeded.
+	 */
+	online_types = kmalloc_array(mb_count, sizeof(*online_types),
+				     GFP_KERNEL);
+	if (!online_types)
+		return -ENOMEM;
+	/*
+	 * Initialize all states to MMOP_OFFLINE, so when we abort processing in
+	 * try_offline_memory_block(), we'll skip all unprocessed blocks in
+	 * try_reonline_memory_block().
+	 */
+	memset(online_types, MMOP_OFFLINE, mb_count);
 
 	lock_device_hotplug();
-	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
-	if (mem)
-		rc = device_offline(&mem->dev);
-	/* Ignore if the device is already offline. */
-	if (rc > 0)
-		rc = 0;
+
+	tmp = online_types;
+	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
 	/*
-	 * In case we succeeded to offline the memory block, remove it.
+	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
 	 */
 	if (!rc) {
 		rc = try_remove_memory(nid, start, size);
-		WARN_ON_ONCE(rc);
+		if (rc)
+			pr_err("%s: Failed to remove memory: %d", __func__, rc);
+	}
+
+	/*
+	 * Rollback what we did. While memory onlining might theoretically fail
+	 * (nacked by a notifier), it barely ever happens.
+	 */
+	if (rc) {
+		tmp = online_types;
+		walk_memory_blocks(start, size, &tmp,
+				   try_reonline_memory_block);
 	}
 	unlock_device_hotplug();
 
+	kfree(online_types);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
-- 
2.25.1

