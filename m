Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E629625366
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKKGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKGKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:10:18 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41425C4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:10:17 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7pB12sn0zbmDR;
        Fri, 11 Nov 2022 14:06:33 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 14:10:15 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 14:10:15 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] kobject: hide illegible sysfs warning of kobject_del()
Date:   Fri, 11 Nov 2022 14:58:07 +0800
Message-ID: <20221111065807.3278713-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some consumers do not care whether kobject_add() succeed or failed such as
irqdesc. They call kobject_del() all the time even if kobject_add() failed.
Then kernel will report some illegible sysfs warning like this:

 kernfs: can not remove 'actions', no directory
 WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
[...]
 Call Trace:
  <TASK>
  remove_files.isra.0+0x3f/0xb0
  sysfs_remove_group+0x68/0xe0
  sysfs_remove_groups+0x41/0x70
  __kobject_del+0x45/0xc0
  kobject_del+0x2a/0x40
  free_desc+0x44/0x70
  irq_free_descs+0x5d/0x90
[...]

Check whether kobject is added successfully by using kobj->state_in_sysfs
in kobject_del() and skip deleting it if not added at all.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index a0b2dbfcfa23..f6163a3a41c2 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -604,7 +604,7 @@ void kobject_del(struct kobject *kobj)
 {
 	struct kobject *parent;
 
-	if (!kobj)
+	if (!kobj || !kobj->state_in_sysfs)
 		return;
 
 	parent = kobj->parent;
-- 
2.25.1

