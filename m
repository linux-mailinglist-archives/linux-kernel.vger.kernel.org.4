Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18365BFFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjACMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjACMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:38:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573502BF2;
        Tue,  3 Jan 2023 04:38:48 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NmXLl092KzJqsQ;
        Tue,  3 Jan 2023 20:37:35 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 20:38:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <srinivas.pandruvada@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH] powercap: fix possible name leak in powercap_register_zone()
Date:   Tue, 3 Jan 2023 20:57:26 +0800
Message-ID: <20230103125726.681099-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

In the error path after calling dev_set_name(), the device
name is leaked. To fix this, calling dev_set_name() before
device_register(), and call put_device() if it returns error.
All the resources is released in powercap_release(), so it
can return from powercap_register_zone() directly.

Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/powercap/powercap_sys.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 1f968353d479..e180dee0f83d 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -530,9 +530,6 @@ struct powercap_zone *powercap_register_zone(
 	power_zone->name = kstrdup(name, GFP_KERNEL);
 	if (!power_zone->name)
 		goto err_name_alloc;
-	dev_set_name(&power_zone->dev, "%s:%x",
-					dev_name(power_zone->dev.parent),
-					power_zone->id);
 	power_zone->constraints = kcalloc(nr_constraints,
 					  sizeof(*power_zone->constraints),
 					  GFP_KERNEL);
@@ -555,9 +552,16 @@ struct powercap_zone *powercap_register_zone(
 	power_zone->dev_attr_groups[0] = &power_zone->dev_zone_attr_group;
 	power_zone->dev_attr_groups[1] = NULL;
 	power_zone->dev.groups = power_zone->dev_attr_groups;
+	dev_set_name(&power_zone->dev, "%s:%x",
+					dev_name(power_zone->dev.parent),
+					power_zone->id);
 	result = device_register(&power_zone->dev);
-	if (result)
-		goto err_dev_ret;
+	if (result) {
+		put_device(&power_zone->dev);
+		mutex_unlock(&control_type->lock);
+
+		return ERR_PTR(result);
+	}
 
 	control_type->nr_zones++;
 	mutex_unlock(&control_type->lock);
-- 
2.25.1

