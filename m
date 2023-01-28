Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2567F6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjA1JRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1JRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:17:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CDF4EE1;
        Sat, 28 Jan 2023 01:17:46 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P3pdV72G9zJqH1;
        Sat, 28 Jan 2023 17:13:18 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 17:17:43 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <emilne@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <zhongjinghua@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH-next v2 1/2] driver core: introduce get_device_unless_zero()
Date:   Sat, 28 Jan 2023 17:41:45 +0800
Message-ID: <20230128094146.205858-2-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230128094146.205858-1-zhongjinghua@huawei.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dev reference count is 0, calling get_device will go from 0 to 1,
which will cause errors in some place of the kernel. So introduce a
get_devcie_unless_zero method that returns NULL when the dev reference
count is 0.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 drivers/base/core.c    | 8 ++++++++
 include/linux/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d02501933467..6f17a93a3443 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3613,6 +3613,14 @@ struct device *get_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(get_device);
 
+struct device __must_check *get_device_unless_zero(struct device *dev)
+{
+	if (!dev || !kobject_get_unless_zero(&dev->kobj))
+		return NULL;
+	return dev;
+}
+EXPORT_SYMBOL_GPL(get_device_unless_zero);
+
 /**
  * put_device - decrement reference count.
  * @dev: device in question.
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..c63bac6d51c8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1069,6 +1069,7 @@ extern int (*platform_notify_remove)(struct device *dev);
  *
  */
 struct device *get_device(struct device *dev);
+struct device __must_check *get_device_unless_zero(struct device *dev);
 void put_device(struct device *dev);
 bool kill_device(struct device *dev);
 
-- 
2.31.1

