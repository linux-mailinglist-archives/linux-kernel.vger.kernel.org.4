Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA9609CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJXIer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJXIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:34:38 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225511AD8A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:34:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VSvcrCI_1666600471;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSvcrCI_1666600471)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 16:34:32 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, ying.huang@intel.com, ziy@nvidia.com,
        shy828301@gmail.com, apopple@nvidia.com,
        baolin.wang@linux.alibaba.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm: migrate: Try again if THP split is failed due to page refcnt
Date:   Mon, 24 Oct 2022 16:34:22 +0800
Message-Id: <6784730480a1df82e8f4cba1ed088e4ac767994b.1666599848.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
References: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
References: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a virtual machine, we will use memfd_create() to get
a file descriptor which can be used to create share memory mappings
using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
flag to allocate physical pages for the virtual machine.

When allocating physical pages for the guest, the host can fallback to
allocate some CMA pages for the guest when over half of the zone's free
memory is in the CMA area.

In guest os, when the application wants to do some data transaction with
DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
create IOMMU mappings for the DMA pages. However, when calling
VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
failed to longterm-pin sometimes.

After some invetigation, we found the pages used to do DMA mapping can
contain some CMA pages, and these CMA pages will cause a possible
failure of the longterm-pin, due to failed to migrate the CMA pages.
The reason of migration failure may be temporary reference count or
memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
ioctl returns error, which makes the application failed to start.

I observed one migration failure case (which is not easy to reproduce) is
that, the 'thp_migration_fail' count is 1 and the 'thp_split_page_failed'
count is also 1.

That means when migrating a THP which is in CMA area, but can not allocate
a new THP due to memory fragmentation, so it will split the THP. However
THP split is also failed, probably the reason is temporary reference count
of this THP. And the temporary reference count can be caused by dropping
page caches (I observed the drop caches operation in the system), but we
can not drop the shmem page caches due to they are already dirty at that time.

Especially for THP split failure, which is caused by temporary reference
count, we can try again to mitigate the failure of migration in this case
according to previous discussion [1].

[1] https://lore.kernel.org/all/470dc638-a300-f261-94b4-e27250e42f96@redhat.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
Changes from v2:
 - Add reviewed tag from Ying. Thanks.
Changes from v1:
 - Use another variable to save the return value of THP split.
---
 mm/huge_memory.c |  4 ++--
 mm/migrate.c     | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ad17c8d..a79f03b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2666,7 +2666,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	 * split PMDs
 	 */
 	if (!can_split_folio(folio, &extra_pins)) {
-		ret = -EBUSY;
+		ret = -EAGAIN;
 		goto out_unlock;
 	}
 
@@ -2716,7 +2716,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			xas_unlock(&xas);
 		local_irq_enable();
 		remap_page(folio, folio_nr_pages(folio));
-		ret = -EBUSY;
+		ret = -EAGAIN;
 	}
 
 out_unlock:
diff --git a/mm/migrate.c b/mm/migrate.c
index 2eb16f8..14562ab 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1506,9 +1506,22 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				if (is_thp) {
 					nr_thp_failed++;
 					/* THP NUMA faulting doesn't split THP to retry. */
-					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
-						nr_thp_split++;
-						break;
+					if (!nosplit) {
+						int ret = try_split_thp(page, &thp_split_pages);
+
+						if (!ret) {
+							nr_thp_split++;
+							break;
+						} else if (reason == MR_LONGTERM_PIN &&
+							   ret == -EAGAIN) {
+							/*
+							 * Try again to split THP to mitigate
+							 * the failure of longterm pinning.
+							 */
+							thp_retry++;
+							nr_retry_pages += nr_subpages;
+							break;
+						}
 					}
 				} else if (!no_subpage_counting) {
 					nr_failed++;
-- 
1.8.3.1

