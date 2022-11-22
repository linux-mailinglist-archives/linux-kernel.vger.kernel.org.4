Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759F6337DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiKVJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiKVJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:04:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A4CE25
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:04:53 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGdc60fQPz15MqS;
        Tue, 22 Nov 2022 17:04:22 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:04:51 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:04:51 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>
Subject: [PATCH] coresight: trbe: remove cpuhp instance node before remove cpuhp state
Date:   Tue, 22 Nov 2022 17:03:55 +0800
Message-ID: <20221122090355.23533-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuhp_state_add_instance() and cpuhp_state_remove_instance() should
be used in pairs. Or there will lead to the warn on
cpuhp_remove_multi_state() since the cpuhp_step list is not empty.

The following is the error log with 'rmmod coresight-trbe':
Error: Removing state 215 which has instances left.
Call trace:
  __cpuhp_remove_state_cpuslocked+0x144/0x160
  __cpuhp_remove_state+0xac/0x100
  arm_trbe_device_remove+0x2c/0x60 [coresight_trbe]
  platform_remove+0x34/0x70
  device_remove+0x54/0x90
  device_release_driver_internal+0x1e4/0x250
  driver_detach+0x5c/0xb0
  bus_remove_driver+0x64/0xc0
  driver_unregister+0x3c/0x70
  platform_driver_unregister+0x20/0x30
  arm_trbe_exit+0x1c/0x658 [coresight_trbe]
  __arm64_sys_delete_module+0x1ac/0x24c
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0x58/0x1a0
  do_el0_svc+0x38/0xd0
  el0_svc+0x2c/0xc0
  el0t_64_sync_handler+0x1ac/0x1b0
  el0t_64_sync+0x19c/0x1a0
 ---[ end trace 0000000000000000 ]---

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2b386bb848f8..1fc4fd79a1c6 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1434,6 +1434,7 @@ static int arm_trbe_probe_cpuhp(struct trbe_drvdata *drvdata)

 static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
 {
+	cpuhp_state_remove_instance(drvdata->trbe_online, &drvdata->hotplug_node);
 	cpuhp_remove_multi_state(drvdata->trbe_online);
 }

--
2.24.0

