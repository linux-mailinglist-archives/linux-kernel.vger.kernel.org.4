Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917E36B6EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 06:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCMFTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 01:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCMFTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 01:19:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3D3BDA7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 22:19:09 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PZlHG5nrzzSkZh;
        Mon, 13 Mar 2023 13:15:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 13:19:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm: memory-failure: directly use IS_ENABLED(CONFIG_HWPOISON_INJECT)
Date:   Mon, 13 Mar 2023 13:39:29 +0800
Message-ID: <20230313053929.84607-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
References: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more clear and simple to just use IS_ENABLED(CONFIG_HWPOISON_INJECT)
to check whether or not to enable HWPoison injector module instead of
CONFIG_HWPOISON_INJECT/CONFIG_HWPOISON_INJECT_MODULE.

Reviewed-by: David Hildenbrand <david@redhat.com> 
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2:
- add Ack/Rb, also update the suject/changelog suggested by Andrew
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fae9baf3be16..f761704d27d7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -168,7 +168,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 	return true;
 }
 
-#if defined(CONFIG_HWPOISON_INJECT) || defined(CONFIG_HWPOISON_INJECT_MODULE)
+#if IS_ENABLED(CONFIG_HWPOISON_INJECT)
 
 u32 hwpoison_filter_enable = 0;
 u32 hwpoison_filter_dev_major = ~0U;
-- 
2.35.3

