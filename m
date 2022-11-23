Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E56361F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiKWOgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiKWOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:36:40 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42F1D314;
        Wed, 23 Nov 2022 06:36:38 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHNwN745nz15M0R;
        Wed, 23 Nov 2022 22:36:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 22:36:35 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal/of: Fix memory leak in thermal_of_zone_register()
Date:   Wed, 23 Nov 2022 22:33:25 +0800
Message-ID: <20221123143325.183870-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the entry of this function, it has allocated memory by kmemdup() and
save it in @of_ops, it should be freed on the error paths, otherwise
memory leak issue happens, fix it.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/thermal/thermal_of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..95d3da9051c4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -604,13 +604,15 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	if (IS_ERR(np)) {
 		if (PTR_ERR(np) != -ENODEV)
 			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(np);
+		ret = PTR_ERR(np);
+		goto out_kfree_ops;
 	}
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_kfree_ops;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -659,6 +661,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	kfree(tzp);
 out_kfree_trips:
 	kfree(trips);
+out_kfree_ops:
+	kfree(of_ops);
 
 	return ERR_PTR(ret);
 }
-- 
2.17.1

