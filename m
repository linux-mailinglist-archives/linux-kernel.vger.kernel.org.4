Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67C602633
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJRHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJRHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:53:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D332EC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:53:05 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ms5Zh1XWSzVhx5;
        Tue, 18 Oct 2022 15:48:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 15:53:02 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 15:53:02 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>
CC:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH] ocfs2: possible memory leak in mlog_sys_init()
Date:   Tue, 18 Oct 2022 15:52:13 +0800
Message-ID: <20221018075213.736562-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject fault while probing module, kset_register() may fail,
if it fails, but the refcount of kobject is not decreased to
0, the name allocated in kobject_set_name() is leaked. Fix
this by calling kset_put(), so that name can be freed in
callback function kobject_cleanup().

unreferenced object 0xffff888100da9348 (size 8):
  comm "modprobe", pid 257, jiffies 4294701096 (age 33.334s)
  hex dump (first 8 bytes):
    6c 6f 67 6d 61 73 6b 00                          logmask.
  backtrace:
    [<00000000306e441c>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000007c491a9e>] kstrdup+0x3a/0x70
    [<0000000015719a3b>] kstrdup_const+0x63/0x80
    [<0000000084e458ea>] kvasprintf_const+0x149/0x180
    [<0000000091302b42>] kobject_set_name_vargs+0x56/0x150
    [<000000005f48eeac>] kobject_set_name+0xab/0xe0

Fixes: 34980ca8faeb ("Drivers: clean up direct setting of the name of a kset")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/ocfs2/cluster/masklog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..7f9ba816d955 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -156,6 +156,7 @@ static struct kset mlog_kset = {
 int mlog_sys_init(struct kset *o2cb_kset)
 {
 	int i = 0;
+	int ret;
 
 	while (mlog_attrs[i].attr.mode) {
 		mlog_default_attrs[i] = &mlog_attrs[i].attr;
@@ -165,7 +166,11 @@ int mlog_sys_init(struct kset *o2cb_kset)
 
 	kobject_set_name(&mlog_kset.kobj, "logmask");
 	mlog_kset.kobj.kset = o2cb_kset;
-	return kset_register(&mlog_kset);
+	ret = kset_register(&mlog_kset);
+	if (ret)
+		kset_put(&mlog_kset);
+
+	return ret;
 }
 
 void mlog_sys_shutdown(void)
-- 
2.25.1

