Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2C70288E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbjEOJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjEOJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:28:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B61995;
        Mon, 15 May 2023 02:27:49 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QKYnL4s75zTkmh;
        Mon, 15 May 2023 17:23:02 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:27:47 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC:     <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <linux-acpi@vger.kernel.org>, <liwei391@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH 2/2] acpi: CPPC: read delivered_reg and reference_reg in critical section
Date:   Mon, 15 May 2023 18:00:04 +0800
Message-ID: <20230515100005.3540793-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515100005.3540793-1-zengheng4@huawei.com>
References: <20230515100005.3540793-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the content of delivered_reg and reference_reg should be in
the same critical section, in case any interrupt comes, which could
lead to inaccurate frequency calculation.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c51d3ccb4cca..176f3e2e67f8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	u64 delivered, reference, ref_perf, ctr_wrap_time;
 	int ret = 0, regs_in_pcc = 0;
+	unsigned long flags;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1350,8 +1351,11 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
+	local_irq_save(flags);
 	cpc_read(cpunum, delivered_reg, &delivered);
 	cpc_read(cpunum, reference_reg, &reference);
+	local_irq_restore(flags);
+
 	cpc_read(cpunum, ref_perf_reg, &ref_perf);
 
 	/*
-- 
2.25.1

