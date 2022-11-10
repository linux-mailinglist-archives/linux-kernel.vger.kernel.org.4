Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF5623938
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiKJBxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiKJBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:52:50 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136ADBC85;
        Wed,  9 Nov 2022 17:52:50 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N74XB2WGqzJnZL;
        Thu, 10 Nov 2022 09:49:46 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:52:48 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:52:47 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 3/3] mailbox: pcc: fix 'pcc_chan_count' when fail to initialize PCC
Date:   Thu, 10 Nov 2022 09:50:34 +0800
Message-ID: <20221110015034.7943-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221110015034.7943-1-lihuisong@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, 'pcc_chan_count' is a non-zero value if PCC subspaces are parsed
successfully and subsequent processes is failure during initializing PCC
process. This may cause that pcc_mbox_request_channel() can still be
executed successfully , which will misleads the caller that this channel is
available.

Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 7cee37dd3b73..47d70c5884e3 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -294,6 +294,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 		pr_err("Channel not found for idx: %d\n", subspace_id);
 		return ERR_PTR(-EBUSY);
 	}
+
 	dev = chan->mbox->dev;
 
 	spin_lock_irqsave(&chan->lock, flags);
@@ -735,7 +736,8 @@ static int __init pcc_init(void)
 
 	if (ret) {
 		pr_debug("ACPI PCC probe failed.\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	pcc_pdev = platform_create_bundle(&pcc_mbox_driver,
@@ -743,10 +745,13 @@ static int __init pcc_init(void)
 
 	if (IS_ERR(pcc_pdev)) {
 		pr_debug("Err creating PCC platform bundle\n");
-		return PTR_ERR(pcc_pdev);
+		ret = PTR_ERR(pcc_pdev);
+		goto out;
 	}
 
-	return 0;
+out:
+	pcc_chan_count = 0;
+	return ret;
 }
 
 /*
-- 
2.22.0

