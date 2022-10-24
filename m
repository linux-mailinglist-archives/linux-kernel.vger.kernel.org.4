Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61D3609A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJXGUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJXGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:20:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845740BF5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:20:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666592426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=83UJL5fJPtb/iVfLXDHgaxM+tRPdlO0Uy7hw8QI04yQ=;
        b=CDLMPJfcld1kZNeMeqAbrlvCnzZ/OK2XZ81Y2BFtg3E0YU8IbocxFsMD5CzOStZYacCukJ
        M3a4vMXpeiHtj4dqkri19AtbpgFZxC4uG0JxaCObs8ntpXFZipTBuQLhbeCqoHmFAhpn4v
        9T7C/Dxpmee+5B7zuqNvnFTPqx3FTKo=
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
Subject: [PATCH v7 0/4] mm, hwpoison: improve handling workload related to hugetlb and memory_hotplug
Date:   Mon, 24 Oct 2022 15:20:08 +0900
Message-Id: <20221024062012.1520887-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

  - (patch 1/4) determine migratable_cleared atomically by introducing
    TESTCLEARHPAGEFLAG (suggested by Miaohe),
  - (patch 4/4) cleaned up declarations of counter API,
  - rebased onto akpm/mm-unstable on Oct 23.

Thanks,
Naoya Horiguchi

v1: https://lore.kernel.org/linux-mm/20220427042841.678351-1-naoya.horiguchi@linux.dev/T
v2: https://lore.kernel.org/linux-mm/20220905062137.1455537-1-naoya.horiguchi@linux.dev/T
v3-5: https://lore.kernel.org/linux-mm/20220921091359.25889-1-naoya.horiguchi@linux.dev/T
v6: https://lore.kernel.org/linux-mm/20221007010706.2916472-1-naoya.horiguchi@linux.dev/T
---
Summary:

Naoya Horiguchi (4):
      mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
      mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c
      mm/hwpoison: pass pfn to num_poisoned_pages_*()
      mm/hwpoison: introduce per-memory_block hwpoison counter

 arch/parisc/kernel/pdt.c |  5 ++--
 drivers/base/memory.c    | 38 ++++++++++++++++++++++++++
 include/linux/hugetlb.h  | 19 ++++++++++---
 include/linux/memory.h   |  3 +++
 include/linux/mm.h       | 29 ++++++++++++++++++--
 include/linux/swapops.h  | 24 ++---------------
 mm/hugetlb.c             |  9 ++++---
 mm/internal.h            |  8 ------
 mm/memory-failure.c      | 69 ++++++++++++++++++++++++++----------------------
 mm/sparse.c              |  2 --
 10 files changed, 130 insertions(+), 76 deletions(-)
