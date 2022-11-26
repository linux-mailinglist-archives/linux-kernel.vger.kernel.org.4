Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31D6395B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKZLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 06:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKZLRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:17:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B3B4BB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:17:42 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NK8MN6Qy7zmW99;
        Sat, 26 Nov 2022 19:17:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 19:17:40 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 19:17:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2] kernfs: remove an unused if statement in kernfs_path_from_node_locked()
Date:   Sat, 26 Nov 2022 19:16:34 +0800
Message-ID: <20221126111634.1994-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes no sense to call kernfs_path_from_node_locked() with NULL buf,
and no one is doing that right now.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/kernfs/dir.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f33b3baad07cb36..8a11bf189970274 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -149,9 +149,6 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
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

