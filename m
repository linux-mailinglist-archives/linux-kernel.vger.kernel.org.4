Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8FF5BE250
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiITJsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiITJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:47:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7FD6F554;
        Tue, 20 Sep 2022 02:47:46 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWxV14DnlzpTDQ;
        Tue, 20 Sep 2022 17:44:57 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 17:47:45 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 17:47:44 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/2] ACPI: PCC: replace wait_for_completion()
Date:   Tue, 20 Sep 2022 17:44:59 +0800
Message-ID: <20220920094500.11283-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220920094500.11283-1-lihuisong@huawei.com>
References: <20220920094500.11283-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the function waiting for completion of mailbox operation is
'wait_for_completion()'.  The PCC method will be permanently blocked if
this mailbox message fails to execute. So this patch replaces it with
'wait_for_completion_timeout()'. And set the timeout interval to an
arbitrary retries on top of nominal to prevent the remote processor is
slow to respond to PCC commands.

Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/acpi_pcc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index a12b55d81209..a1052fe998bf 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -23,6 +23,12 @@
 
 #include <acpi/pcc.h>
 
+/*
+ * Arbitrary retries in case the remote processor is slow to respond
+ * to PCC commands
+ */
+#define PCC_CMD_WAIT_RETRIES_NUM	500
+
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
 	void __iomem *pcc_comm_addr;
@@ -86,6 +92,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 {
 	int ret;
 	struct pcc_data *data = region_context;
+	u64 usecs_lat;
 
 	reinit_completion(&data->done);
 
@@ -96,8 +103,20 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 	if (ret < 0)
 		return AE_ERROR;
 
-	if (data->pcc_chan->mchan->mbox->txdone_irq)
-		wait_for_completion(&data->done);
+	if (data->pcc_chan->mchan->mbox->txdone_irq) {
+		/*
+		 * pcc_chan->latency is just a Nominal value. In reality the remote
+		 * processor could be much slower to reply. So add an arbitrary
+		 * amount of wait on top of Nominal.
+		 */
+		usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
+		ret = wait_for_completion_timeout(&data->done,
+						  usecs_to_jiffies(usecs_lat));
+		if (ret == 0) {
+			pr_err("PCC command executed timeout!\n");
+			return AE_TIME;
+		}
+	}
 
 	mbox_client_txdone(data->pcc_chan->mchan, ret);
 
-- 
2.33.0

