Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613C6620766
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiKHDbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKHDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:31:19 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7C2F397;
        Mon,  7 Nov 2022 19:31:18 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5tt20sn1z15MTB;
        Tue,  8 Nov 2022 11:31:06 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:31:16 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:31:16 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <daniel.baluta@intel.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] iio: core: Fix entry not deleted when iio_register_sw_trigger_type() fails
Date:   Tue, 8 Nov 2022 11:28:02 +0800
Message-ID: <20221108032802.168623-1-chenzhongjin@huawei.com>
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

In iio_register_sw_trigger_type(), configfs_register_default_group() is
possible to fail, but the entry add to iio_trigger_types_list is not
deleted.

This leaves wild in iio_trigger_types_list, which can cause page fault
when module is loading again. So fix this by list_del(&t->list) in error
path.

BUG: unable to handle page fault for address: fffffbfff81d7400
RIP: 0010:__iio_find_sw_trigger_type.isra.3+0x62/0xb0 [industrialio_sw_trigger]
Call Trace:
<TASK>
 iio_register_sw_trigger_type+0x65/0x1f0 [industrialio_sw_trigger]
 do_one_initcall+0xd0/0x4e0
 do_init_module+0x1cf/0x6b0
 load_module+0x65c2/0x7820
 ...

Fixes: b662f809d410 ("iio: core: Introduce IIO software triggers")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/iio/industrialio-sw-trigger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 994f03a71520..d86a3305d9e8 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -58,8 +58,12 @@ int iio_register_sw_trigger_type(struct iio_sw_trigger_type *t)
 
 	t->group = configfs_register_default_group(iio_triggers_group, t->name,
 						&iio_trigger_type_group_type);
-	if (IS_ERR(t->group))
+	if (IS_ERR(t->group)) {
+		mutex_lock(&iio_trigger_types_lock);
+		list_del(&t->list);
+		mutex_unlock(&iio_trigger_types_lock);
 		ret = PTR_ERR(t->group);
+	}
 
 	return ret;
 }
-- 
2.17.1

