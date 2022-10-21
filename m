Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3F6073DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJUJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiJUJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:19:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DB2BE09
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:19:26 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MtzP725z7zJn2B;
        Fri, 21 Oct 2022 17:16:43 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 17:19:23 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <dedekind@linutronix.de>, <haver@vnet.ibm.com>,
        <bbrezillon@kernel.org>
CC:     <lizetao1@huawei.com>, <boris.brezillon@free-electrons.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ubi: Fix use-after-free when volume resizing failed
Date:   Fri, 21 Oct 2022 18:21:56 +0800
Message-ID: <20221021102157.1341807-2-lizetao1@huawei.com>
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

There is an use-after-free problem reported by KASAN:
  ==================================================================
  BUG: KASAN: use-after-free in ubi_eba_copy_table+0x11f/0x1c0 [ubi]
  Read of size 8 at addr ffff888101eec008 by task ubirsvol/4735

  CPU: 2 PID: 4735 Comm: ubirsvol
  Not tainted 6.1.0-rc1-00003-g84fa3304a7fc-dirty #14
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
  BIOS 1.14.0-1.fc33 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   print_report+0x171/0x472
   kasan_report+0xad/0x130
   ubi_eba_copy_table+0x11f/0x1c0 [ubi]
   ubi_resize_volume+0x4f9/0xbc0 [ubi]
   ubi_cdev_ioctl+0x701/0x1850 [ubi]
   __x64_sys_ioctl+0x11d/0x170
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0
   </TASK>

When ubi_change_vtbl_record() returns an error in ubi_resize_volume(),
"new_eba_tbl" will be freed on error handing path, but it is holded
by "vol->eba_tbl" in ubi_eba_replace_table(). It means that the liftcycle
of "vol->eba_tbl" and "vol" are different, so when resizing volume in
next time, it causing an use-after-free fault.

Fix it by not freeing "new_eba_tbl" after it replaced in
ubi_eba_replace_table(), while will be freed in next volume resizing.

Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/mtd/ubi/vmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 8fcc0bdf0635..74637575346e 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -464,7 +464,7 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
 		for (i = 0; i < -pebs; i++) {
 			err = ubi_eba_unmap_leb(ubi, vol, reserved_pebs + i);
 			if (err)
-				goto out_acc;
+				goto out_free;
 		}
 		spin_lock(&ubi->volumes_lock);
 		ubi->rsvd_pebs += pebs;
@@ -512,6 +512,8 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
 		ubi->avail_pebs += pebs;
 		spin_unlock(&ubi->volumes_lock);
 	}
+	return err;
+
 out_free:
 	kfree(new_eba_tbl);
 	return err;
-- 
2.31.1

