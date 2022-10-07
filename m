Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7270D5F7276
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiJGBIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiJGBIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:08:01 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307454CAA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:07:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665104878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4PsFfjeizUMHGv0WhgRRPa7WVxesnagcY058B1kh/Ig=;
        b=BtRiu1RO5hPQKU1Ev9TlZfS7kp4A7iM6SZpW6KMdGn2lBZvHa4e5JIcft1o0xarN96wPMN
        FHynmITx+IW7qZKmLGWjADETllyvSCZVhcaE0xqxjEintap25Cm4sCtvJEv8Jean+lXLyy
        UIpliklJkR7M7VxBIk61QHFdmqvYbrE=
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
Subject: [PATCH v6 0/4] mm, hwpoison: improve handling workload related to hugetlb and memory_hotplug
Date:   Fri,  7 Oct 2022 10:07:02 +0900
Message-Id: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset tries to solve the issue among memory_hotplug, hugetlb and hwpoison.
In this patchset, memory hotplug handles hwpoison pages like below:

  - hwpoison pages should not prevent memory hotremove,
  - memory block with hwpoison pages should not be onlined.

Changes in this version:

  - applied comments for previous versions (thank you, reviewers),
  - fixed a few build errors (sorry for making noises on linux-next),
  - unpoison_memory() properly cancels per-memblk hwpoison counter,
  - rebased onto akpm/mm-unstable on Oct 4.

Thanks,
Naoya Horiguchi

v1: https://lore.kernel.org/linux-mm/20220427042841.678351-1-naoya.horiguchi@linux.dev/T
v2: https://lore.kernel.org/linux-mm/20220905062137.1455537-1-naoya.horiguchi@linux.dev/T
v3-5: https://lore.kernel.org/linux-mm/20220921091359.25889-1-naoya.horiguchi@linux.dev/T
---
Summary:

Naoya Horiguchi (4):
      mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
      mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c
      mm/hwpoison: pass pfn to num_poisoned_pages_*()
      mm/hwpoison: introduce per-memory_block hwpoison counter

 arch/parisc/kernel/pdt.c |  5 ++--
 drivers/base/memory.c    | 40 +++++++++++++++++++++++++++
 include/linux/hugetlb.h  | 10 ++++---
 include/linux/memory.h   |  3 ++
 include/linux/mm.h       | 29 ++++++++++++++++++--
 include/linux/swapops.h  | 24 ++--------------
 mm/hugetlb.c             |  9 +++---
 mm/internal.h            |  8 ------
 mm/memory-failure.c      | 71 +++++++++++++++++++++++++++---------------------
 mm/sparse.c              |  2 --
 10 files changed, 125 insertions(+), 76 deletions(-)
