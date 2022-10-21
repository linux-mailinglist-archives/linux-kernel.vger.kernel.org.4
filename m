Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F2607229
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJUI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJUI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:27:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB51FB7AB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:27:14 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtyBd3zLvzVj4w;
        Fri, 21 Oct 2022 16:22:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:27:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:27:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] mm: memory-failure: avoid pfn_valid() twice in soft_offline_page()
Date:   Fri, 21 Oct 2022 16:46:10 +0800
Message-ID: <20221021084611.53765-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
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

Simplify WARN_ON_ONCE(flags & MF_COUNT_INCREASED) under !pfn_valid().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b94152abb1c9..ca0199d0f79d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2554,10 +2554,10 @@ int soft_offline_page(unsigned long pfn, int flags)
 	bool try_again = true;
 	struct page *page;
 
-	WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));
-
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn)) {
+		WARN_ON_ONCE(flags & MF_COUNT_INCREASED);
 		return -ENXIO;
+	}
 
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	page = pfn_to_online_page(pfn);
-- 
2.35.3

