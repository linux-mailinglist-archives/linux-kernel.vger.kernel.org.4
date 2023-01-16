Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0466BD65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAPL7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjAPL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:59:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F155196A9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:59:04 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NwVr33dTNzRrlw;
        Mon, 16 Jan 2023 19:57:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:58:56 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v2 3/4] mm/mempolicy: return EINVAL if len overflows for mbind
Date:   Mon, 16 Jan 2023 19:58:12 +0800
Message-ID: <20230116115813.2956935-4-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116115813.2956935-1-mawupeng1@huawei.com>
References: <20230116115813.2956935-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Return -EINVAL if len overflows for mbind.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/mempolicy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 153fda1ebb9c..4cb19a6e368b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1258,6 +1258,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		     nodemask_t *nmask, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long old_len = len;
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
@@ -1278,7 +1279,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	len = PAGE_ALIGN(len);
 	end = start + len;
 
-	if (end < start)
+	if (end < start || (old_len != 0 && len == 0))
 		return -EINVAL;
 	if (end == start)
 		return 0;
-- 
2.25.1

