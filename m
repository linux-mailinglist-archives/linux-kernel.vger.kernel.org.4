Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F505BFA87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiIUJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiIUJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:16:26 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775098E9AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:15:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663751751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y5ZLNbG63SlokUUFvz2qbP26Ghit9Hx14l1hW4m/kAM=;
        b=mBuJvW5lKIPZwgtyYdPiU/o0a3OFbU+urpRpUQDsbY+Tp08B7TP9qCzzu8lfjjUbNH8zQv
        uJx4fDx3Xq40CPRDZRPNKYKLK1UvTAIZulWhiYnF45CwAr4zYJP4V16AD9JZqyHCYAw3fC
        lLAwjeTpnrEVHwQpul6bIYi/pBJt+wc=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] mm, hwpoison: improve handling workload related to hugetlb and memory_hotplug
Date:   Wed, 21 Sep 2022 18:13:55 +0900
Message-Id: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset tries to solve the issue among memory_hotplug, hugetlb and
hwpoison.  Based on the review over v2 by Miaohe (thank you!), 1/4 takes
another approach to prevent hwpoisoned hugepages to be migrated (i.e.
the corrupted data is accessed) in memory hotremove.

In this patchset, memory hotplug handles hwpoison pages like below:

  - hwpoison pages should not prevent memory hotremove,
  - memory block with hwpoison pages should not be onlined.

Any comments and feedbacks would be appreciated.

Thanks,
Naoya Horiguchi

v1: https://lore.kernel.org/linux-mm/20220427042841.678351-1-naoya.horiguchi@linux.dev/T
v2: https://lore.kernel.org/linux-mm/20220905062137.1455537-1-naoya.horiguchi@linux.dev/T
---
Summary:

Naoya Horiguchi (4):
      mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
      mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c
      mm/hwpoison: pass pfn to num_poisoned_pages_*()
      mm/hwpoison: introduce per-memory_block hwpoison counter

 arch/parisc/kernel/pdt.c |  5 ++--
 drivers/base/memory.c    | 36 +++++++++++++++++++++++++++++
 include/linux/hugetlb.h  |  4 ++--
 include/linux/memory.h   |  3 +++
 include/linux/mm.h       | 13 +++++++++++
 include/linux/swapops.h  | 24 ++------------------
 mm/hugetlb.c             |  4 ++--
 mm/internal.h            |  8 -------
 mm/memory-failure.c      | 59 +++++++++++++++++++++++++++---------------------
 mm/sparse.c              |  2 --
 10 files changed, 93 insertions(+), 65 deletions(-)
