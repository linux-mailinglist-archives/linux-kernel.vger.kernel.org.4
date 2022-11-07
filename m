Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAD61EEDC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiKGJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKGJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:25:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3E186F3;
        Mon,  7 Nov 2022 01:24:39 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5QhC1nf6zpSsj;
        Mon,  7 Nov 2022 17:20:59 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:24:37 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:24:37 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>
CC:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <chenzhongjin@huawei.com>
Subject: [PATCH] ACPICA: Fix pop_walk_state called after walk_state is deleted
Date:   Mon, 7 Nov 2022 17:21:22 +0800
Message-ID: <20221107092122.110204-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous fix patch acpi_ds_pop_walk_state() is called after
acpi_ds_delete_walk_state() in cleanup, so the problem is not fixed
because it is acpi_ds_pop_walk_state(NULL) called actually.

Also, when acpi_ds_create_walk_state() failed and next_walk_state is
NULL, it pops the normal walk_state_list and make the memory leaked.

Check if next_walk_state is NULL, and do pop_walk_state() before it is
deleted.

Fixes: 539663bb068f ("ACPICA: Fix use-after-free in acpi_ps_parse_aml()")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/acpi/acpica/dsmethod.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 19da7fc73186..cb15c66d5aac 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -580,8 +580,9 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	/* On error, we must terminate the method properly */
 
 	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
+	if (next_walk_state)
+		acpi_ds_pop_walk_state(thread);
 	acpi_ds_delete_walk_state(next_walk_state);
-	acpi_ds_pop_walk_state(thread);
 
 	return_ACPI_STATUS(status);
 }
-- 
2.17.1

