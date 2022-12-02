Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB31F640407
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiLBKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiLBKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:04:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660217AB2;
        Fri,  2 Dec 2022 02:04:24 -0800 (PST)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NNpN145WtzqSv2;
        Fri,  2 Dec 2022 18:00:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 18:04:21 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <mchehab@kernel.org>, <matthias.bgg@gmail.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH v3] media: platform: mtk-mdp3: Fix return value check in mdp_probe()
Date:   Fri, 2 Dec 2022 18:18:36 +0800
Message-ID: <20221202101836.19858-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function mtk_mutex_get()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().
And also fix the err_free_mutex case.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---

v3:
 - rebase on top of media_stage tree.
v2:
 - Add fix the err_return case.

 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 2d1f6ae9f080..97edcd9d1c81 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -207,8 +207,8 @@ static int mdp_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < MDP_PIPE_MAX; i++) {
 		mdp->mdp_mutex[i] = mtk_mutex_get(&mm_pdev->dev);
-		if (!mdp->mdp_mutex[i]) {
-			ret = -ENODEV;
+		if (IS_ERR(mdp->mdp_mutex[i])) {
+			ret = PTR_ERR(mdp->mdp_mutex[i]);
 			goto err_free_mutex;
 		}
 	}
@@ -289,7 +289,8 @@ static int mdp_probe(struct platform_device *pdev)
 	mdp_comp_destroy(mdp);
 err_free_mutex:
 	for (i = 0; i < MDP_PIPE_MAX; i++)
-		mtk_mutex_put(mdp->mdp_mutex[i]);
+		if (!IS_ERR_OR_NULL(mdp->mdp_mutex[i]))
+			mtk_mutex_put(mdp->mdp_mutex[i]);
 err_destroy_device:
 	kfree(mdp);
 err_return:
-- 
2.32.0

