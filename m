Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7504264C1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiLNBdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiLNBdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:33:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA832AE7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:33:13 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWyXF0DHlzlWYT;
        Wed, 14 Dec 2022 09:32:13 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 09:33:11 +0800
Message-ID: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
Date:   Wed, 14 Dec 2022 09:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   mawupeng <mawupeng1@huawei.com>
Subject: [Qestion] UCE on pud-sized hugepage lead to kernel panic on lts5.10
To:     <naoya.horiguchi@nec.com>
CC:     <mawupeng1@huawei.com>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On current arm64 stable 5.10(v5.10.158). If a UCE happnes pud-sized
hugepage, kernel will panic since current memory failure can not handle
this kind of memory failure since commit 31286a8484a8 ("mm: hwpoison:
disable memory error handling on 1GB hugepage")

The latest kernel(v6.0) can handle this UCE since commit 6f4614886baa ("mm,
hwpoison: enable memory error handling on 1GB hugepage"). We are trying to
backport this patchset to stable 5.10, however too many other patches
should be backport since there are huge difference between 5.10 and 6.0.
The full patch list will be shown at the end of this mail.

We do not think backport all of these patches is doable for stable 5.10. Is
there any better way to fix this problem.

The kernel panic call trace:

  Kernel panic - not syncing: Fatal hardware error!
  CPU: 0 PID: 15 Comm: kworker/0:1 Not tainted 5.10.158_stable_5_10 #1
  Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V3.26.01 06/14/2019
  Workqueue: kacpi_notify acpi_os_execute_deferred
  Call trace:
   dump_backtrace+0x0/0x1ec
   show_stack+0x20/0x30
   dump_stack+0xd0/0x128
   panic+0x154/0x36c
   __raw_spin_lock_irqsave.constprop.0+0x0/0xb0
   ghes_proc+0x148/0x200
   ghes_notify_hed+0x58/0xd4
   blocking_notifier_call_chain+0x74/0xb0
   acpi_hed_notify+0x28/0x3c
   acpi_device_notify+0x24/0x30
   acpi_ev_notify_dispatch+0x68/0x78
   acpi_os_execute_deferred+0x24/0x3c
   process_one_work+0x1d4/0x4b0
   worker_thread+0x180/0x430
   kthread+0x118/0x120
   ret_from_fork+0x10/0x18
  SMP: stopping secondary CPUs
  Kernel Offset: 0x4ed64eb80000 from 0xffff800010000000
  PHYS_OFFSET: 0xffffd24300000000
  CPU features: 0x00000002,62208a38
  Memory Limit: none
  Rebooting in 30 seconds..

Our backport list(bug fixes not included):

  mm,hwpoison: drain pcplists before bailing out for non-buddy zero-refcount page
  mm,hwpoison: take free pages off the buddy freelists
  mm,hwpoison: drop unneeded pcplist draining
  mm,hwpoison: refactor get_any_page
  mm,hwpoison: disable pcplists before grabbing a refcount
  mm,hwpoison: remove drain_all_pages from shake_page
  hugetlb: use page.private for hugetlb specific page flags
  hugetlb: convert page_huge_active() HPageMigratable flag
  hugetlb: convert PageHugeTemporary() to HPageTemporary flag
  hugetlb: convert PageHugeFreed to HPageFreed flag
  mm,hwpoison: fix race with hugetlb page allocation
  mm: hugetlb: gather discrete indexes of tail page
  hugetlb: create remove_hugetlb_page() to separate functionality
  mm,hwpoison: make get_hwpoison_page() call get_any_page()
  mm/hwpoison: disable pcp for page_handle_poison()
  mm/hwpoison: mf_mutex for soft offline and unpoison
  mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
  mm/hwpoison: fix unpoison_memory()
  mm/memory-failure.c: fix race with changing page compound again
  mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
  mm/hugetlb: check gigantic_page_runtime_supported() in return_unused_surplus_pages()
  mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry
  mm, hwpoison, hugetlb: support saving mechanism of raw error pages
  mm/memory-failure.c: simplify num_poisoned_pages_dec
  mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
  mm, hwpoison: set PG_hwpoison for busy hugetlb pages
  mm, hwpoison: make __page_handle_poison returns int
  mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage

