Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00A638416
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKYGit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKYGir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:38:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6B193FC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:38:47 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJQ881gZBzqSf5;
        Fri, 25 Nov 2022 14:34:48 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 14:38:45 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 14:38:45 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <mark-pk.tsai@mediatek.com>,
        <alexander.h.duyck@linux.intel.com>
Subject: [PATCH] driver core: Fix test_async_probe_init saves device in wrong array
Date:   Fri, 25 Nov 2022 14:35:41 +0800
Message-ID: <20221125063541.241328-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In test_async_probe_init, second set of asynchronous devices are saved
in sync_dev[sync_id], which should be async_dev[async_id].
This makes these devices not unregistered when exit.

> modprobe test_async_driver_probe && \
> modprobe -r test_async_driver_probe && \
> modprobe test_async_driver_probe
 ...
> sysfs: cannot create duplicate filename '/devices/platform/test_async_driver.4'
> kobject_add_internal failed for test_async_driver.4 with -EEXIST,
  don't try to register things with the same name in the same directory.

Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/base/test/test_async_driver_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 4d1976ca5072..929410d0dd6f 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -145,7 +145,7 @@ static int __init test_async_probe_init(void)
 	calltime = ktime_get();
 	for_each_online_cpu(cpu) {
 		nid = cpu_to_node(cpu);
-		pdev = &sync_dev[sync_id];
+		pdev = &async_dev[async_id];
 
 		*pdev = test_platform_device_register_node("test_async_driver",
 							   async_id,
-- 
2.17.1

