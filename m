Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C062B41F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKPHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiKPHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:45:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFD8DEE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:45:15 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBw3B2Wt2zqST7;
        Wed, 16 Nov 2022 15:41:26 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 15:45:13 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <lgirdwood@gmail.com>, <vz@mleia.com>, <broonie@kernel.org>,
        <mirq-linux@rere.qmqm.pl>
CC:     <zengheng4@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] regulator: core: fix kobject release warning and memory leak in regulator_register()
Date:   Wed, 16 Nov 2022 15:43:39 +0800
Message-ID: <20221116074339.1024240-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a warning report about lack of registered release()
from kobject lib:

Device '(null)' does not have a release() function, it is broken and must be fixed.
WARNING: CPU: 0 PID: 48430 at drivers/base/core.c:2332 device_release+0x104/0x120
Call Trace:
 kobject_put+0xdc/0x180
 put_device+0x1b/0x30
 regulator_register+0x651/0x1170
 devm_regulator_register+0x4f/0xb0

When regulator_register() returns fail and directly goto `clean` symbol,
rdev->dev has not registered release() function yet (which is registered
by regulator_class in the following), so rdev needs to be freed manually.
If rdev->dev.of_node is not NULL, which means the of_node has gotten by
regulator_of_get_init_data(), it needs to call of_node_put() to avoid
refcount leak.

Otherwise, only calling put_device() would lead memory leak of rdev
in further:

unreferenced object 0xffff88810d0b1000 (size 2048):
  comm "107-i2c-rtq6752", pid 48430, jiffies 4342258431 (age 1341.780s)
  backtrace:
    kmalloc_trace+0x22/0x110
    regulator_register+0x184/0x1170
    devm_regulator_register+0x4f/0xb0

When regulator_register() returns fail and goto `wash` symbol,
rdev->dev has registered release() function, so directly call
put_device() to cleanup everything.

Fixes: d3c731564e09 ("regulator: plug of_node leak in regulator_register()'s error path")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/regulator/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bcccad8f7516..77126cb1ae8c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5644,11 +5644,15 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
+	put_device(&rdev->dev);
+	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
+	if (rdev && rdev->dev.of_node)
+		of_node_put(rdev->dev.of_node);
+	kfree(rdev);
 	kfree(config);
-	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
-- 
2.25.1

