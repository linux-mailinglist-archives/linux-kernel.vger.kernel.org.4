Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2D63EA13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLAHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLAHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:00:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E75963D4A;
        Wed, 30 Nov 2022 23:00:54 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN6Qb0yJ6zHw6f;
        Thu,  1 Dec 2022 15:00:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 15:00:49 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <lv.zheng@intel.com>,
        <david.e.box@linux.intel.com>
CC:     <lizetao1@huawei.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPICA: Fix use-after-free in acpi_ut_copy_ipackage_to_ipackage()
Date:   Thu, 1 Dec 2022 16:05:14 +0800
Message-ID: <20221201080514.3015400-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an use-after-free reported by KASAN:

  BUG: KASAN: use-after-free in acpi_ut_remove_reference+0x3b/0x82
  Read of size 1 at addr ffff888112afc460 by task modprobe/2111
  CPU: 0 PID: 2111 Comm: modprobe Not tainted 6.1.0-rc7-dirty
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
  Call Trace:
   <TASK>
   kasan_report+0xae/0xe0
   acpi_ut_remove_reference+0x3b/0x82
   acpi_ut_copy_iobject_to_iobject+0x3be/0x3d5
   acpi_ds_store_object_to_local+0x15d/0x3a0
   acpi_ex_store+0x78d/0x7fd
   acpi_ex_opcode_1A_1T_1R+0xbe4/0xf9b
   acpi_ps_parse_aml+0x217/0x8d5
   ...
   </TASK>

The root cause of the problem is that the acpi_operand_object
is freed when acpi_ut_walk_package_tree() fails in
acpi_ut_copy_ipackage_to_ipackage(), lead to repeated release in
acpi_ut_copy_iobject_to_iobject(). The problem was introduced
by "8aa5e56eeb61" commit, this commit is to fix memory leak in
acpi_ut_copy_iobject_to_iobject(), repeatedly adding remove
operation, lead to "acpi_operand_object" used after free.

Fix it by removing acpi_ut_remove_reference() in
acpi_ut_copy_ipackage_to_ipackage(). acpi_ut_copy_ipackage_to_ipackage()
is called to copy an internal package object into another internal
package object, when it fails, the memory of acpi_operand_object
should be freed by the caller.

Fixes: 8aa5e56eeb61 ("ACPICA: Utilities: Fix memory leak in acpi_ut_copy_iobject_to_iobject")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/acpi/acpica/utcopy.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 400b9e15a709..63c17f420fb8 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -916,13 +916,6 @@ acpi_ut_copy_ipackage_to_ipackage(union acpi_operand_object *source_obj,
 	status = acpi_ut_walk_package_tree(source_obj, dest_obj,
 					   acpi_ut_copy_ielement_to_ielement,
 					   walk_state);
-	if (ACPI_FAILURE(status)) {
-
-		/* On failure, delete the destination package object */
-
-		acpi_ut_remove_reference(dest_obj);
-	}
-
 	return_ACPI_STATUS(status);
 }
 
-- 
2.31.1

