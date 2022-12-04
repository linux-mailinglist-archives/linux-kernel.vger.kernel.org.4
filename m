Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD5641A98
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLDDOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 22:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiLDDOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 22:14:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505D1903B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:14:44 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NPsGG1pZgz15MvX;
        Sun,  4 Dec 2022 11:13:58 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Dec 2022 11:14:42 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <tj@kernel.org>, <dennis@kernel.org>,
        <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH -next 1/1] percpu: cleanup invalid assignment to err in pcpu_alloc
Date:   Sun, 4 Dec 2022 11:14:30 +0800
Message-ID: <20221204031430.662169-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
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

From: Ma Wupeng <mawupeng1@huawei.com>

Assignment to err if is_atomic is true will never be used since warn
message can only be shown if is_atomic is false after label fail. So drop
it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/percpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index acd78da0493b..df86d79325b2 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1817,10 +1817,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
-	if (is_atomic) {
-		err = "atomic alloc failed, no space left";
+	if (is_atomic)
 		goto fail;
-	}
 
 	/* No space left.  Create a new chunk. */
 	if (list_empty(&pcpu_chunk_lists[pcpu_free_slot])) {
-- 
2.25.1

