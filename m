Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F4625115
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiKKCuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiKKCth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:49:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14646DEA2;
        Thu, 10 Nov 2022 18:47:06 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7jlc5b9szRp5B;
        Fri, 11 Nov 2022 10:46:52 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 10:47:04 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 10:47:03 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 1/2] ACPI: PCC: add check for platform interrupt
Date:   Fri, 11 Nov 2022 10:44:47 +0800
Message-ID: <20221111024448.25012-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221111024448.25012-1-lihuisong@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221111024448.25012-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PCC Operation Region driver senses the completion of command by
interrupt way. If platform can not generate an interrupt when a command
complete, the caller never gets the desired result. So let's reject the
setup of the PCC address space on platform that do not support interrupt
mode.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 3e252be047b8..8efd08e469aa 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -53,6 +53,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	struct pcc_data *data;
 	struct acpi_pcc_info *ctx = handler_context;
 	struct pcc_mbox_chan *pcc_chan;
+	static acpi_status ret;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -69,23 +70,35 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	if (IS_ERR(data->pcc_chan)) {
 		pr_err("Failed to find PCC channel for subspace %d\n",
 		       ctx->subspace_id);
-		kfree(data);
-		return AE_NOT_FOUND;
+		ret = AE_NOT_FOUND;
+		goto request_channel_fail;
 	}
 
 	pcc_chan = data->pcc_chan;
+	if (!pcc_chan->mchan->mbox->txdone_irq) {
+		pr_err("This channel-%d does not support interrupt.\n",
+		       ctx->subspace_id);
+		ret = AE_SUPPORT;
+		goto request_channel_fail;
+	}
 	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
 					      pcc_chan->shmem_size);
 	if (!data->pcc_comm_addr) {
 		pr_err("Failed to ioremap PCC comm region mem for %d\n",
 		       ctx->subspace_id);
-		pcc_mbox_free_channel(data->pcc_chan);
-		kfree(data);
-		return AE_NO_MEMORY;
+		ret = AE_NO_MEMORY;
+		goto ioremap_fail;
 	}
 
 	*region_context = data;
 	return AE_OK;
+
+ioremap_fail:
+	pcc_mbox_free_channel(data->pcc_chan);
+request_channel_fail:
+	kfree(data);
+
+	return ret;
 }
 
 static acpi_status
@@ -106,19 +119,17 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 	if (ret < 0)
 		return AE_ERROR;
 
-	if (data->pcc_chan->mchan->mbox->txdone_irq) {
-		/*
-		 * pcc_chan->latency is just a Nominal value. In reality the remote
-		 * processor could be much slower to reply. So add an arbitrary
-		 * amount of wait on top of Nominal.
-		 */
-		usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
-		ret = wait_for_completion_timeout(&data->done,
-						  usecs_to_jiffies(usecs_lat));
-		if (ret == 0) {
-			pr_err("PCC command executed timeout!\n");
-			return AE_TIME;
-		}
+	/*
+	 * pcc_chan->latency is just a Nominal value. In reality the remote
+	 * processor could be much slower to reply. So add an arbitrary
+	 * amount of wait on top of Nominal.
+	 */
+	usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
+	ret = wait_for_completion_timeout(&data->done,
+						usecs_to_jiffies(usecs_lat));
+	if (ret == 0) {
+		pr_err("PCC command executed timeout!\n");
+		return AE_TIME;
 	}
 
 	mbox_chan_txdone(data->pcc_chan->mchan, ret);
-- 
2.22.0

