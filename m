Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBE603ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJSHi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJSHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:38:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A437863F30;
        Wed, 19 Oct 2022 00:38:22 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsjC46y7gzmVFX;
        Wed, 19 Oct 2022 15:33:36 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:38:09 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:38:09 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>
CC:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <lv.zheng@intel.com>, <chenzhongjin@huawei.com>
Subject: [PATCH] ACPICA: Fix use-after-free in acpi_ps_parse_aml()
Date:   Wed, 19 Oct 2022 15:34:43 +0800
Message-ID: <20221019073443.248215-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reports a use-after-free problem and causes kernel panic
triggered by: modprobe acpiphp_ibm

BUG: KASAN:
use-after-free in acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
Read of size 8 at addr ffff888002f843f0 by task modprobe/519

CPU: 2 PID: 519 Comm: modprobe Not tainted 6.0.0+
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
    Call Trace:
    <TASK>
    acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
    acpi_ds_method_error (drivers/acpi/acpica/dsmethod.c:232)
    acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
    ...
    </TASK>

    Allocated by task 519:
    ...
    __kasan_kmalloc (mm/kasan/common.c:526)
    acpi_ds_create_walk_state (drivers/acpi/acpica/dswstate.c:519)
    acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:498)
    acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
    ...

    Freed by task 519:
    ...
    __kmem_cache_free+0xb6/0x3c0
    acpi_ds_delete_walk_state (drivers/acpi/acpica/dswstate.c:722)
    acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:586)
    acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
    ...
---[ end Kernel panic - not syncing: Fatal exception ]---

In the error path in acpi_ps_parse_aml():

    acpi_ds_call_control_method()
        acpi_ds_create_walk_state()
            acpi_ds_push_walk_state()
	    # thread->walk_state_list = walk_state

        acpi_ds_init_aml_walk # *fail*
        goto cleanup:
        acpi_ds_delete_walk_state() # ACPI_FREE(walk_state)

    acpi_ds_method_error()
        acpi_ds_dump_method_stack()
        # using freed thread->walk_state_list

Briefly, the walk_state is pushed to thread, and freed without being poped.
Then it is used in acpi_ds_dump_method_stack() and causes use-after-free.

Add acpi_ds_pop_walk_state(thread) to the error path to fix the problem.

Fixes: 0bac4295526c ("ACPICA: Dispatcher: Move stack traversal code to dispatcher")

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/acpi/acpica/dsmethod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index ae2e768830bf..19da7fc73186 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -581,6 +581,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
 	acpi_ds_delete_walk_state(next_walk_state);
+	acpi_ds_pop_walk_state(thread);
 
 	return_ACPI_STATUS(status);
 }
-- 
2.17.1

