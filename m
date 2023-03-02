Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8000D6A8155
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCBLjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCBLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:39:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405FB34307
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:38:49 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PS8CV0bpyzSkQp;
        Thu,  2 Mar 2023 19:34:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 19:37:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/7] mm: remove cgroup_throttle_swaprate() completely
Date:   Thu, 2 Mar 2023 19:58:28 +0800
Message-ID: <20230302115835.105364-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all the caller functions of cgroup_throttle_swaprate() to use
folios, and use folio_throttle_swaprate(),  which allows us to remove
cgroup_throttle_swaprate() completely.

v2:
- address comments from Matthew Wilcox, eg, 
  1) folio conversion inside  __do_huge_pmd_anonymous_page() function,
  2) rename __cgroup_throttle_swaprate() to __folio_throttle_swaprate()
  3) rename gfp_mask to gfp

Kefeng Wang (7):
  mm: huge_memory: convert __do_huge_pmd_anonymous_page() to use a folio
  mm: memory: use folio_throttle_swaprate() in do_swap_page()
  mm: memory: use folio_throttle_swaprate() in page_copy_prealloc()
  mm: memory: use folio_throttle_swaprate() in wp_page_copy()
  mm: memory: use folio_throttle_swaprate() in do_anonymous_page()
  mm: memory: use folio_throttle_swaprate() in do_cow_fault()
  mm: swap: remove unneeded cgroup_throttle_swaprate()

 include/linux/swap.h | 12 ++++--------
 mm/huge_memory.c     | 21 +++++++++++----------
 mm/memory.c          | 10 +++++-----
 mm/swapfile.c        |  6 +++---
 4 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.35.3

