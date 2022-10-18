Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5E602C29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJRMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJRMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:52:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F31C4C3D;
        Tue, 18 Oct 2022 05:52:32 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MsDKM5X4kzHtt3;
        Tue, 18 Oct 2022 20:52:23 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 20:52:29 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:52:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@lst.de>, <axboe@kernel.dk>, <gregkh@linuxfoundation.org>,
        <willy@infradead.org>, <martin.petersen@oracle.com>,
        <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 1/2] kobject: add return value for kobject_put()
Date:   Tue, 18 Oct 2022 21:14:31 +0800
Message-ID: <20221018131432.434167-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221018131432.434167-1-yukuai3@huawei.com>
References: <20221018131432.434167-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value will be used in later patch to fix uaf for slave_dir
and bd_holder_dir in block layer.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/kobject.h | 2 +-
 lib/kobject.c           | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 57fb972fea05..f12de6274c51 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -110,7 +110,7 @@ extern int __must_check kobject_move(struct kobject *, struct kobject *);
 extern struct kobject *kobject_get(struct kobject *kobj);
 extern struct kobject * __must_check kobject_get_unless_zero(
 						struct kobject *kobj);
-extern void kobject_put(struct kobject *kobj);
+extern bool kobject_put(struct kobject *kobj);
 
 extern const void *kobject_namespace(struct kobject *kobj);
 extern void kobject_get_ownership(struct kobject *kobj,
diff --git a/lib/kobject.c b/lib/kobject.c
index a0b2dbfcfa23..f86c55ae7376 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -711,15 +711,18 @@ static void kobject_release(struct kref *kref)
  *
  * Decrement the refcount, and if 0, call kobject_cleanup().
  */
-void kobject_put(struct kobject *kobj)
+bool kobject_put(struct kobject *kobj)
 {
 	if (kobj) {
 		if (!kobj->state_initialized)
 			WARN(1, KERN_WARNING
 				"kobject: '%s' (%p): is not initialized, yet kobject_put() is being called.\n",
 			     kobject_name(kobj), kobj);
-		kref_put(&kobj->kref, kobject_release);
+		if (kref_put(&kobj->kref, kobject_release))
+			return true;
 	}
+
+	return false;
 }
 EXPORT_SYMBOL(kobject_put);
 
-- 
2.31.1

