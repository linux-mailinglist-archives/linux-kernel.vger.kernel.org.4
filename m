Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF0666C40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjALISF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbjALIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:17:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE9A392DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:17:38 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nsy711HjGzJrR7;
        Thu, 12 Jan 2023 16:16:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 16:17:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 0/7] mm: remove cgroup_throttle_swaprate() completely
Date:   Thu, 12 Jan 2023 16:29:59 +0800
Message-ID: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Kefeng Wang (7):
  mm: huge_memory: make __do_huge_pmd_anonymous_page() to take a folio
  mm: memory: convert do_anonymous_page() to use a folio
  mm: memory: convert do_cow_fault to use folios
  mm: memory: convert page_copy_prealloc() to use a folio
  mm: memory: convert wp_page_copy() to use folios
  mm: memory: use folio_throttle_swaprate() in do_swap_page()
  mm: swap: remove unneeded cgroup_throttle_swaprate()

 include/linux/swap.h |  12 ++---
 mm/huge_memory.c     |  23 +++++-----
 mm/memory.c          | 104 +++++++++++++++++++++++--------------------
 mm/swapfile.c        |   4 +-
 4 files changed, 74 insertions(+), 69 deletions(-)

-- 
2.35.3

