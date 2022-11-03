Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915E617760
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKCHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKCHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:12:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA21A043
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:11:19 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N2w0L0HRJz15MKM;
        Thu,  3 Nov 2022 15:11:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 15:11:18 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 15:11:17 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dinguyen@kernel.org>,
        <richard.gong@intel.com>, <atull@kernel.org>,
        <tien.sung.ang@intel.com>
Subject: [PATCH 2/2] firmware: stratix10-svc: fix error handle while alloc/add device failed
Date:   Thu, 3 Nov 2022 15:09:51 +0800
Message-ID: <20221103070951.1496435-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103070951.1496435-1-yangyingliang@huawei.com>
References: <20221103070951.1496435-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If add device "stratix10-rsu" failed in stratix10_svc_drv_probe(),
the 'svc_fifo' and 'genpool' need be freed in the error path.

If allocate or add device "intel-fcs" failed in stratix10_svc_drv_probe(),
the device "stratix10-rsu" need be unregistered in the error path.

Fixes: e6281c26674e ("firmware: stratix10-svc: Add support for FCS")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/firmware/stratix10-svc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 1a5640b3ab42..bde1f543f529 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1202,19 +1202,20 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	ret = platform_device_add(svc->stratix10_svc_rsu);
 	if (ret) {
 		platform_device_put(svc->stratix10_svc_rsu);
-		return ret;
+		goto err_free_kfifo;
 	}
 
 	svc->intel_svc_fcs = platform_device_alloc(INTEL_FCS, 1);
 	if (!svc->intel_svc_fcs) {
 		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_unregister_dev;
 	}
 
 	ret = platform_device_add(svc->intel_svc_fcs);
 	if (ret) {
 		platform_device_put(svc->intel_svc_fcs);
-		return ret;
+		goto err_unregister_dev;
 	}
 
 	dev_set_drvdata(dev, svc);
@@ -1223,6 +1224,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_unregister_dev:
+	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
 err_destroy_pool:
-- 
2.25.1

