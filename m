Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D481623CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiKJH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiKJH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:29:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1984326E8;
        Wed,  9 Nov 2022 23:29:47 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N7D0z4DvSzJncj;
        Thu, 10 Nov 2022 15:26:43 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 15:29:45 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 15:29:45 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
CC:     <skhan@linuxfoundation.org>, <kieran.bingham@ideasonboard.com>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <helen.koike@collabora.com>, <chenzhongjin@huawei.com>
Subject: [PATCH] media: vimc: Fix wrong function called when vimc_init() fails
Date:   Thu, 10 Nov 2022 15:26:33 +0800
Message-ID: <20221110072633.210437-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vimc_init(), when platform_driver_register(&vimc_pdrv) fails,
platform_driver_unregister(&vimc_pdrv) is wrongly called rather than
platform_device_unregister(&vimc_pdev), which causes kernel warning:

 Unexpected driver unregister!
 WARNING: CPU: 1 PID: 14517 at drivers/base/driver.c:270 driver_unregister+0x8f/0xb0
 RIP: 0010:driver_unregister+0x8f/0xb0
 Call Trace:
  <TASK>
  vimc_init+0x7d/0x1000 [vimc]
  do_one_initcall+0xd0/0x4e0
  do_init_module+0x1cf/0x6b0
  load_module+0x65c2/0x7820

Fixes: 4a29b7090749 ("[media] vimc: Subdevices as modules")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/media/test-drivers/vimc/vimc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index 2ae7a0f11ebf..e82cfa5ffbf4 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -433,7 +433,7 @@ static int __init vimc_init(void)
 	if (ret) {
 		dev_err(&vimc_pdev.dev,
 			"platform driver registration failed (err=%d)\n", ret);
-		platform_driver_unregister(&vimc_pdrv);
+		platform_device_unregister(&vimc_pdev);
 		return ret;
 	}
 
-- 
2.17.1

