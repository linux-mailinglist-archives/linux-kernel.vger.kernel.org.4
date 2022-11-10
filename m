Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3749623937
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiKJBw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiKJBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:52:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4AB497;
        Wed,  9 Nov 2022 17:52:49 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N74WQ34YlzpWKF;
        Thu, 10 Nov 2022 09:49:06 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:52:47 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:52:46 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/3] mailbox: pcc: rename platform interrupt bit macro name
Date:   Thu, 10 Nov 2022 09:50:32 +0800
Message-ID: <20221110015034.7943-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221110015034.7943-1-lihuisong@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the name of platform interrupt bit macro, ACPI_PCCT_DOORBELL,
is not very appropriate. The doorbell is generally considered as an action
when send mailbox data. Actually, the macro value comes from Platform
Interrupt in Platform Communications Channel Global Flags. If the bit is
'1', it means that the platform is capable of generating an interrupt to
indicate completion of a command.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 2 +-
 include/acpi/actbl2.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3c2bc0ca454c..7cee37dd3b73 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -665,7 +665,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
 
 	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
-	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
+	if (acpi_pcct_tbl->flags & BIT(ACPI_PCCT_FLAGS_PLAT_INTERRUPT_B))
 		pcc_mbox_ctrl->txdone_irq = true;
 
 	for (i = 0; i < count; i++) {
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 655102bc6d14..3840507fdc79 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1810,7 +1810,7 @@ struct acpi_table_pcct {
 
 /* Values for Flags field above */
 
-#define ACPI_PCCT_DOORBELL              1
+#define ACPI_PCCT_FLAGS_PLAT_INTERRUPT_B              1
 
 /* Values for subtable type in struct acpi_subtable_header */
 
-- 
2.22.0

