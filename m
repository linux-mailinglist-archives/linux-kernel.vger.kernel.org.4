Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A1673510
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjASKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjASKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:04:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085271798
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:03:31 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NyJ3s52m1zqVcV;
        Thu, 19 Jan 2023 17:58:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 18:03:28 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <catalin.marinas@arm.com>,
        <kernel-team@android.com>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 1/3] drivers/perf: hisi: Advertise the PERF_PMU_CAP_NO_EXCLUDE capability
Date:   Thu, 19 Jan 2023 18:03:05 +0800
Message-ID: <20230119100307.3660-2-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230119100307.3660-1-hejunhao3@huawei.com>
References: <20230119100307.3660-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed initialization the variable of pmu::capabilities when extract
the initialization code of hisi_pmu->pmu into a function.

HISI UNCORE PMU drivers counters that not support context exclusion.
So we have to advertise the PERF_PMU_CAP_NO_EXCLUDE capability.
This ensures that perf will prevent us from handling events where
any exclusion flags are set.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index fbc8a93d5eac..2a466477920b 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -546,6 +546,7 @@ void hisi_pmu_init(struct pmu *pmu, const char *name,
 	pmu->stop               = hisi_uncore_pmu_stop;
 	pmu->read               = hisi_uncore_pmu_read;
 	pmu->attr_groups        = attr_groups;
+	pmu->capabilities       = PERF_PMU_CAP_NO_EXCLUDE;
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
 
-- 
2.33.0

