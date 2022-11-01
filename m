Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E16143B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 04:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKADmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 23:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKADm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 23:42:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898717885
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 20:42:26 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N1bSH4z9Nz15MD6;
        Tue,  1 Nov 2022 11:42:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:42:25 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 11:42:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <sre@kernel.org>, <sebastian.reichel@collabora.com>,
        <carlos.chinea@nokia.com>, <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] HSI: omap_ssi_core: fix unbalanced pm_runtime_disable()
Date:   Tue, 1 Nov 2022 11:41:18 +0800
Message-ID: <20221101034118.1331731-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error label 'out1' path in ssi_probe(), the pm_runtime_enable()
has not been called yet, so pm_runtime_disable() is not needed.

Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 80bf09bc5d15..052cf3e92dd6 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -538,9 +538,9 @@ static int ssi_probe(struct platform_device *pd)
 	device_for_each_child(&pd->dev, NULL, ssi_remove_ports);
 out2:
 	ssi_remove_controller(ssi);
+	pm_runtime_disable(&pd->dev);
 out1:
 	platform_set_drvdata(pd, NULL);
-	pm_runtime_disable(&pd->dev);
 
 	return err;
 }
-- 
2.25.1

