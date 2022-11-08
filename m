Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0766D620791
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiKHDfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHDfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:35:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607ACB46;
        Mon,  7 Nov 2022 19:35:43 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5tzB3WG9zRp5B;
        Tue,  8 Nov 2022 11:35:34 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:35:41 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:35:41 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
CC:     <dwlsalmeida@gmail.com>, <mchehab@kernel.org>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] media: vidtv: Fix use-after-free in vidtv_bridge_dvb_init()
Date:   Tue, 8 Nov 2022 11:32:29 +0800
Message-ID: <20221108033229.169644-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reports a use-after-free:
BUG: KASAN: use-after-free in dvb_dmxdev_release+0x4d5/0x5d0 [dvb_core]
Call Trace:
 ...
 dvb_dmxdev_release+0x4d5/0x5d0 [dvb_core]
 vidtv_bridge_probe+0x7bf/0xa40 [dvb_vidtv_bridge]
 platform_probe+0xb6/0x170
 ...
Allocated by task 1238:
 ...
 dvb_register_device+0x1a7/0xa70 [dvb_core]
 dvb_dmxdev_init+0x2af/0x4a0 [dvb_core]
 vidtv_bridge_probe+0x766/0xa40 [dvb_vidtv_bridge]
 ...
Freed by task 1238:
 dvb_register_device+0x6d2/0xa70 [dvb_core]
 dvb_dmxdev_init+0x2af/0x4a0 [dvb_core]
 vidtv_bridge_probe+0x766/0xa40 [dvb_vidtv_bridge]
 ...

It is because the error handling in vidtv_bridge_dvb_init() is wrong.

First, vidtv_bridge_dmx(dev)_init() will clean themselves when fail, but
goto fail_dmx(_dev): calls release functions again, which causes
use-after-free.

Also, in fail_fe, fail_tuner_probe and fail_demod_probe, j = i will cause
out-of-bound when i finished its loop (i == NUM_FE). And the loop
releasing is wrong, although now NUM_FE is 1 so it won't cause problem.

Fix this by correctly releasing everything.

Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 .../media/test-drivers/vidtv/vidtv_bridge.c   | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 82620613d56b..046e6785f0a3 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -459,26 +459,21 @@ static int vidtv_bridge_dvb_init(struct vidtv_dvb *dvb)
 	for (j = j - 1; j >= 0; --j)
 		dvb->demux.dmx.remove_frontend(&dvb->demux.dmx,
 					       &dvb->dmx_fe[j]);
-fail_dmx_dev:
 	dvb_dmxdev_release(&dvb->dmx_dev);
-fail_dmx:
+fail_dmx_dev:
 	dvb_dmx_release(&dvb->demux);
+fail_dmx:
+fail_demod_probe:
+	for (i = i - 1; i >= 0; --i) {
+		dvb_unregister_frontend(dvb->fe[i]);
 fail_fe:
-	for (j = i; j >= 0; --j)
-		dvb_unregister_frontend(dvb->fe[j]);
+		dvb_frontend_detach(dvb->fe[i]);
+		dvb_module_release(dvb->i2c_client_tuner[i]);
 fail_tuner_probe:
-	for (j = i; j >= 0; --j)
-		if (dvb->i2c_client_tuner[j])
-			dvb_module_release(dvb->i2c_client_tuner[j]);
-
-fail_demod_probe:
-	for (j = i; j >= 0; --j)
-		if (dvb->i2c_client_demod[j])
-			dvb_module_release(dvb->i2c_client_demod[j]);
-
+		dvb_module_release(dvb->i2c_client_demod[i]);
+	}
 fail_adapter:
 	dvb_unregister_adapter(&dvb->adapter);
-
 fail_i2c:
 	i2c_del_adapter(&dvb->i2c_adapter);
 
@@ -550,6 +545,7 @@ static int vidtv_bridge_remove(struct platform_device *pdev)
 
 	for (i = 0; i < NUM_FE; ++i) {
 		dvb_unregister_frontend(dvb->fe[i]);
+		dvb_frontend_detach(dvb->fe[i]);
 		dvb_module_release(dvb->i2c_client_tuner[i]);
 		dvb_module_release(dvb->i2c_client_demod[i]);
 	}
-- 
2.17.1

