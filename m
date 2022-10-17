Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE83160053C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJQCeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiJQCeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:34:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222BF5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:34:19 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrLfX6v13zHvpG;
        Mon, 17 Oct 2022 10:34:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 10:34:05 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:34:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: [PATCH] kobject: fix possible memory leak in kset_create_and_add()
Date:   Mon, 17 Oct 2022 10:33:27 +0800
Message-ID: <20221017023327.1793893-1-yangyingliang@huawei.com>
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

If kset_register() fails in kset_create_and_add(), the name allocated
in kset_create() will be leaked. To fix this by calling kset_put() so
that the name will be freed in callback function kobject_cleanup() and
kset will be freed in kset_release().

unreferenced object 0xffff888103cc8c08 (size 8):
  comm "modprobe", pid 508, jiffies 4294915182 (age 120.020s)
  hex dump (first 8 bytes):
    62 79 5f 6e 61 6d 65 00                          by_name.
  backtrace:
    [<00000000572f97f9>] __kmalloc_track_caller+0x1ae/0x320
    [<00000000a167a5cc>] kstrdup+0x3a/0x70
    [<000000001cd0d05e>] kstrdup_const+0x68/0x80
    [<00000000b9101e6d>] kvasprintf_const+0x10b/0x190
    [<0000000088f2b8df>] kobject_set_name_vargs+0x56/0x150
    [<000000003f8aca68>] kobject_set_name+0xab/0xe0
    [<00000000249f7816>] kset_create_and_add+0x72/0x200

Fixes: b727c702896f ("kset: add kset_create_and_add function")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index a0b2dbfcfa23..f5e943c9027b 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -982,7 +982,7 @@ struct kset *kset_create_and_add(const char *name,
 		return NULL;
 	error = kset_register(kset);
 	if (error) {
-		kfree(kset);
+		kset_put(kset);
 		return NULL;
 	}
 	return kset;
-- 
2.25.1

