Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414F6192DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKDIhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:37:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F876F77
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:37:46 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N3YsZ3cBKz15MHy;
        Fri,  4 Nov 2022 16:37:38 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 16:37:43 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <sgarzare@redhat.com>,
        <eperezma@redhat.com>, <gautam.dawar@xilinx.com>,
        <elic@nvidia.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] vdpa_sim: fix possible memory leak in vdpasim_net_init() and vdpasim_blk_init()
Date:   Fri, 4 Nov 2022 16:34:23 +0800
Message-ID: <20221104083423.2090463-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_register() returns error in vdpasim_net_init() or
vdpasim_blk_init(), name of kobject which is allocated in dev_set_name()
called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop
the reference count that was set in device_initialize() when it fails,
so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c6db1a1baf76..f745926237a8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -427,8 +427,10 @@ static int __init vdpasim_blk_init(void)
 	int ret;
 
 	ret = device_register(&vdpasim_blk_mgmtdev);
-	if (ret)
+	if (ret) {
+		put_device(&vdpasim_blk_mgmtdev);
 		return ret;
+	}
 
 	ret = vdpa_mgmtdev_register(&mgmt_dev);
 	if (ret)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225ea469..11f5a121df24 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -305,8 +305,10 @@ static int __init vdpasim_net_init(void)
 	int ret;
 
 	ret = device_register(&vdpasim_net_mgmtdev);
-	if (ret)
+	if (ret) {
+		put_device(&vdpasim_net_mgmtdev);
 		return ret;
+	}
 
 	ret = vdpa_mgmtdev_register(&mgmt_dev);
 	if (ret)
-- 
2.25.1

