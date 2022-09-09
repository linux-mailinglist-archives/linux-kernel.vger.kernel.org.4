Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70D5B33E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiIIJ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIIJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F74D833
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP9VB5mFCzlVkQ;
        Fri,  9 Sep 2022 17:21:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 10/16] mm, memory_hotplug: remove obsolete generic_free_nodedata()
Date:   Fri, 9 Sep 2022 17:24:45 +0800
Message-ID: <20220909092451.24883-11-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220909092451.24883-1-linmiaohe@huawei.com>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 390511e1476e ("mm, memory_hotplug: drop arch_free_nodedata")
drops the last caller of generic_free_nodedata(). Remove it too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/memory_hotplug.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 51052969dbfe..9fcbf5706595 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -43,11 +43,6 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
 ({								\
 	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
 })
-/*
- * This definition is just for error path in node hotadd.
- * For node hotremove, we have to replace this.
- */
-#define generic_free_nodedata(pgdat)	kfree(pgdat)
 
 extern pg_data_t *node_data[];
 static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
@@ -63,9 +58,6 @@ static inline pg_data_t *generic_alloc_nodedata(int nid)
 	BUG();
 	return NULL;
 }
-static inline void generic_free_nodedata(pg_data_t *pgdat)
-{
-}
 static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
 {
 }
-- 
2.23.0

