Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF89663FE5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiLBCx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiLBCxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:53:25 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862659E469
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:53:23 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NNcqS58sDzJp6D;
        Fri,  2 Dec 2022 10:49:56 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 10:53:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <christian@kohlschutter.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH resend] regulator: core: fix resource leak in regulator_register()
Date:   Fri, 2 Dec 2022 10:51:11 +0800
Message-ID: <20221202025111.496402-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got some resource leak reports while doing fault injection test:

  OF: ERROR: memory leak, expected refcount 1 instead of 100,
  of_node_get()/of_node_put() unbalanced - destroy cset entry:
  attach overlay node /i2c/pmic@64/regulators/buck1

unreferenced object 0xffff88810deea000 (size 512):
  comm "490-i2c-rt5190a", pid 253, jiffies 4294859840 (age 5061.046s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff a0 1e 00 a1 ff ff ff ff  ................
  backtrace:
    [<00000000d78541e2>] kmalloc_trace+0x21/0x110
    [<00000000b343d153>] device_private_init+0x32/0xd0
    [<00000000be1f0c70>] device_add+0xb2d/0x1030
    [<00000000e3e6344d>] regulator_register+0xaf2/0x12a0
    [<00000000e2f5e754>] devm_regulator_register+0x57/0xb0
    [<000000008b898197>] rt5190a_probe+0x52a/0x861 [rt5190a_regulator]

unreferenced object 0xffff88810b617b80 (size 32):
  comm "490-i2c-rt5190a", pid 253, jiffies 4294859904 (age 5060.983s)
  hex dump (first 32 bytes):
    72 65 67 75 6c 61 74 6f 72 2e 32 38 36 38 2d 53  regulator.2868-S
    55 50 50 4c 59 00 ff ff 29 00 00 00 2b 00 00 00  UPPLY...)...+...
  backtrace:
    [<000000009da9280d>] __kmalloc_node_track_caller+0x44/0x1b0
    [<0000000025c6a4e5>] kstrdup+0x3a/0x70
    [<00000000790efb69>] create_regulator+0xc0/0x4e0
    [<0000000005ed203a>] regulator_resolve_supply+0x2d4/0x440
    [<0000000045796214>] regulator_register+0x10b3/0x12a0
    [<00000000e2f5e754>] devm_regulator_register+0x57/0xb0
    [<000000008b898197>] rt5190a_probe+0x52a/0x861 [rt5190a_regulator]

After calling regulator_resolve_supply(), the 'rdev->supply' is set
by set_supply(), after this set, in the error path, the resources
need be released, so call regulator_put() to avoid the leaks.

Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
Fixes: 8a866d527ac0 ("regulator: core: Resolve supply name earlier to prevent double-init")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
Based on commit a4412fdd49dc ("error-injection: Add prompt for function error injection")
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e8c00a884f1f..5e78a5b868db 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5641,6 +5641,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
+	regulator_put(rdev->supply);
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
-- 
2.25.1

