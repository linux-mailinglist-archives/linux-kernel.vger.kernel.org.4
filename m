Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4CB5F0AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiI3LkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiI3Ljt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:39:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BDE1323D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:31:51 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf7Jd6Z0LzpSyX;
        Fri, 30 Sep 2022 19:28:17 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 19:31:16 +0800
Received: from huawei.com (10.67.174.245) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 19:31:16 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <spice-devel@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <airlied@redhat.com>, <kraxel@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <chenzhongjin@huawei.com>
Subject: [PATCH -next] drm/qxl: Remove unused variable 'count'
Date:   Mon, 10 Oct 2022 10:44:25 +0800
Message-ID: <20221010024425.2873821-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.245]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_DATE_IN_FUTURE_96_Q autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'count' is introduced in this commit
'commit f64122c1f6ad("drm: add new QXL driver. (v1.4)")'

However, since introduced it was just iterated and never been used.
Remove it for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 7b00c955cd82..fe8b179b4f5f 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -429,7 +429,7 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 {
 	uint32_t handle;
 	int idr_ret;
-	int count = 0;
+
 again:
 	idr_preload(GFP_ATOMIC);
 	spin_lock(&qdev->surf_id_idr_lock);
@@ -441,7 +441,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 	handle = idr_ret;
 
 	if (handle >= qdev->rom->n_surfaces) {
-		count++;
 		spin_lock(&qdev->surf_id_idr_lock);
 		idr_remove(&qdev->surf_id_idr, handle);
 		spin_unlock(&qdev->surf_id_idr_lock);
-- 
2.33.0

