Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21DA73FBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjF0MIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjF0MIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:08:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F946198D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:08:41 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qr3QG5QRCzqV0Q;
        Tue, 27 Jun 2023 20:08:22 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 20:08:38 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH 1/2] swap: Cleanup duplicated WARN_ON in add_to_avail_list
Date:   Tue, 27 Jun 2023 20:08:32 +0800
Message-ID: <20230627120833.2230766-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627120833.2230766-1-mawupeng1@huawei.com>
References: <20230627120833.2230766-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Empty check for plist_node is checked in add_to_avail_list and plist_add.
Drop the duplicate one in add_to_avail_list.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/swapfile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..879cb80bf37b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -713,10 +713,8 @@ static void add_to_avail_list(struct swap_info_struct *p)
 	int nid;
 
 	spin_lock(&swap_avail_lock);
-	for_each_node(nid) {
-		WARN_ON(!plist_node_empty(&p->avail_lists[nid]));
+	for_each_node(nid)
 		plist_add(&p->avail_lists[nid], &swap_avail_heads[nid]);
-	}
 	spin_unlock(&swap_avail_lock);
 }
 
-- 
2.25.1

