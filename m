Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C525691943
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjBJHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjBJHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:35:02 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863E70965
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:35:01 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PClnT4ck9z16NWS;
        Fri, 10 Feb 2023 15:32:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 15:34:58 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <chenwandun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>, <xialonglong1@huawei.com>
Subject: [PATCH -next 2/3] driver core: add error handling for devtmpfs_create_node()
Date:   Fri, 10 Feb 2023 07:33:08 +0000
Message-ID: <20230210073309.4050841-3-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210073309.4050841-1-xialonglong1@huawei.com>
References: <Y9t0pqN/1PaUlKoT@kroah.com>
 <20230210073309.4050841-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, devtmpfs_create_node() can return error value.
So, make use of it.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 drivers/base/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7dab705f2937..aaa3088e5456 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3405,7 +3405,9 @@ int device_add(struct device *dev)
 		if (error)
 			goto SysEntryError;
 
-		devtmpfs_create_node(dev);
+		error = devtmpfs_create_node(dev);
+		if (error)
+			goto DevtmpfsError;
 	}
 
 	/* Notify clients of device addition.  This call must come
@@ -3461,6 +3463,8 @@ int device_add(struct device *dev)
 done:
 	put_device(dev);
 	return error;
+ DevtmpfsError:
+	device_remove_sys_dev_entry(dev);
  SysEntryError:
 	if (MAJOR(dev->devt))
 		device_remove_file(dev, &dev_attr_dev);
-- 
2.25.1

