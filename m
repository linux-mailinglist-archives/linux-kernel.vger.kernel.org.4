Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC362665A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiKLCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKLCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:07:45 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB760E86;
        Fri, 11 Nov 2022 18:07:44 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N8JmQ60NxzJnfr;
        Sat, 12 Nov 2022 10:04:38 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:07:42 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:07:42 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH V3 1/2] ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available
Date:   Sat, 12 Nov 2022 10:05:27 +0800
Message-ID: <20221112020528.7837-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221112020528.7837-1-lihuisong@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221112020528.7837-1-lihuisong@huawei.com>
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

Currently, PCC OpRegion handler depends on the availability of platform
interrupt to be functional currently. If it is not available, the OpRegion
can't be executed successfully or the desired outcome won't be possible.
So let's reject setting up the PCC OpRegion handler on the platform if
it doesn't support or have platform interrupt available.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 3e252be047b8..07a034a53aca 100644
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
+		goto err_free_data;
 	}
 
 	pcc_chan = data->pcc_chan;
+	if (!pcc_chan->mchan->mbox->txdone_irq) {
+		pr_err("This channel-%d does not support interrupt.\n",
+		       ctx->subspace_id);
+		ret = AE_SUPPORT;
+		goto err_free_channel;
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
+		goto err_free_channel;
 	}
 
 	*region_context = data;
 	return AE_OK;
+
+err_free_channel:
+	pcc_mbox_free_channel(data->pcc_chan);
+err_free_data:
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

