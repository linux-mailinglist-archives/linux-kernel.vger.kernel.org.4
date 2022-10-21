Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1856073DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiJUJTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiJUJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:19:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932E2CE1B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:19:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtzS45g4yzHtwg;
        Fri, 21 Oct 2022 17:19:16 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 17:19:24 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <dedekind@linutronix.de>, <haver@vnet.ibm.com>,
        <bbrezillon@kernel.org>
CC:     <lizetao1@huawei.com>, <boris.brezillon@free-electrons.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ubi: Fix unreferenced object reported by kmemleak in ubi_resize_volume()
Date:   Fri, 21 Oct 2022 18:21:57 +0800
Message-ID: <20221021102157.1341807-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221021102157.1341807-1-lizetao1@huawei.com>
References: <20221021102157.1341807-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a memory leaks problem reported by kmemleak:

unreferenced object 0xffff888102007a00 (size 128):
  comm "ubirsvol", pid 32090, jiffies 4298464136 (age 2361.231s)
  hex dump (first 32 bytes):
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
[<ffffffff8176cecd>] __kmalloc+0x4d/0x150
[<ffffffffa02a9a36>] ubi_eba_create_table+0x76/0x170 [ubi]
[<ffffffffa029764e>] ubi_resize_volume+0x1be/0xbc0 [ubi]
[<ffffffffa02a3321>] ubi_cdev_ioctl+0x701/0x1850 [ubi]
[<ffffffff81975d2d>] __x64_sys_ioctl+0x11d/0x170
[<ffffffff83c142a5>] do_syscall_64+0x35/0x80
[<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

This is due to a mismatch between create and destroy interfaces, and
in detail that "new_eba_tbl" created by ubi_eba_create_table() but
destroyed by kfree(), while will causing "new_eba_tbl->entries" not
freed.

Fix it by replacing kfree(new_eba_tbl) with
ubi_eba_destroy_table(new_eba_tbl)

Fixes: 799dca34ac54 ("UBI: hide EBA internals")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/mtd/ubi/vmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 74637575346e..9fbc64b997ce 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -515,7 +515,7 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
 	return err;
 
 out_free:
-	kfree(new_eba_tbl);
+	ubi_eba_destroy_table(new_eba_tbl);
 	return err;
 }
 
-- 
2.31.1

