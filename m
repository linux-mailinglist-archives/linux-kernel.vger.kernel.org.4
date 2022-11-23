Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50E634D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiKWCGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiKWCF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:05:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0358DA70
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:05:56 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH4G76CWyzRpSv;
        Wed, 23 Nov 2022 10:05:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:05:49 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:05:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] kernfs: fix potential null-ptr-deref in kernfs_path_from_node_locked()
Date:   Wed, 23 Nov 2022 10:04:19 +0800
Message-ID: <20221123020419.1867-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the 'buf' is not empty before strlcpy() uses it.

Commit bbe70e4e4211 ("fs: kernfs: Fix possible null-pointer dereferences
in kernfs_path_from_node_locked()") first noticed this, but it didn't
fix it completely.

Fixes: 9f6df573a404 ("kernfs: Add API to generate relative kernfs path")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f33b3baad07cb36..b2422265c86edf2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -140,6 +140,9 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	size_t depth_from, depth_to, len = 0;
 	int i, j;
 
+	if (!buf)
+		return -EINVAL;
+
 	if (!kn_to)
 		return strlcpy(buf, "(null)", buflen);
 
@@ -149,9 +152,6 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	if (kn_from == kn_to)
 		return strlcpy(buf, "/", buflen);
 
-	if (!buf)
-		return -EINVAL;
-
 	common = kernfs_common_ancestor(kn_from, kn_to);
 	if (WARN_ON(!common))
 		return -EINVAL;
-- 
2.25.1

