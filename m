Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02FE5E6402
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiIVNp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiIVNp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:45:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C5895F8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:45:23 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYGdh6ySvz14QZm;
        Thu, 22 Sep 2022 21:41:12 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:45:21 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:45:20 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 6/8] ACPI: HMAT: use hotplug_memory_notifier() directly
Date:   Thu, 22 Sep 2022 22:19:02 +0800
Message-ID: <20220922141904.3245505-7-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922141904.3245505-1-liushixin2@huawei.com>
References: <20220922141904.3245505-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since patch 316346243be6 has already updated the minimum gcc version to 5.1.
The previous problem mentioned in patch f02c69680088 is not existed. So we
can now revert to use hotplug_memory_notifier() directly rather than
register_hotmemory_notifier().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/acpi/numa/hmat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index c3d783aca196..84dffb3dc30e 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -768,11 +768,6 @@ static int hmat_callback(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block hmat_callback_nb = {
-	.notifier_call = hmat_callback,
-	.priority = 2,
-};
-
 static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
@@ -855,7 +850,7 @@ static __init int hmat_init(void)
 	hmat_register_targets();
 
 	/* Keep the table and structures if the notifier may use them */
-	if (!register_hotmemory_notifier(&hmat_callback_nb))
+	if (!hotplug_memory_notifier(hmat_callback, 2))
 		return 0;
 out_put:
 	hmat_free_structures();
-- 
2.25.1

