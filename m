Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03A623AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKJDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiKJDto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:49:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAA20BE4;
        Wed,  9 Nov 2022 19:49:42 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N77BG6QZmzmVGY;
        Thu, 10 Nov 2022 11:49:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:49:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 11:49:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] drivers: base: transport_class: fix possible memory leak
Date:   Thu, 10 Nov 2022 11:48:09 +0800
Message-ID: <20221110034809.17258-1-yangyingliang@huawei.com>
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

Current some drivers(like iscsi) call transport_register_device()
failed, they don't call transport_destroy_device() to release the
memory allocated in transport_setup_device(), because they don't
know what was done, it should be internal thing to release the
resource in register function. So fix this leak by calling destroy
function inside register function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/transport_class.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/transport_class.h b/include/linux/transport_class.h
index 63076fb835e3..f4835250bbfc 100644
--- a/include/linux/transport_class.h
+++ b/include/linux/transport_class.h
@@ -70,8 +70,15 @@ void transport_destroy_device(struct device *);
 static inline int
 transport_register_device(struct device *dev)
 {
+	int ret;
+
 	transport_setup_device(dev);
-	return transport_add_device(dev);
+	ret = transport_add_device(dev);
+	if (ret) {
+		transport_destroy_device(dev);
+	}
+
+	return ret;
 }
 
 static inline void
-- 
2.25.1

