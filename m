Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBEC6D63BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjDDNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjDDNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:47:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA56B1BCD;
        Tue,  4 Apr 2023 06:47:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrTY42VhBz6J6qW;
        Tue,  4 Apr 2023 21:45:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:47:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: [PATCH 10/32] perf/xgene: Assign parents for event_source devices
Date:   Tue, 4 Apr 2023 14:42:03 +0100
Message-ID: <20230404134225.13408-11-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all these devices appear directly under /sys/devices/
Only root busses should appear there, so instead assign the pmu->dev
parents to be the hardware related struct device.

Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
Cc: Khuong Dinh <khuong@os.amperecomputing.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/xgene_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0c32dffc7ede..451c01dbc1d6 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1104,6 +1104,7 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 
 	/* Perf driver registration */
 	pmu_dev->pmu = (struct pmu) {
+		.parent		= pmu_dev->parent->dev,
 		.attr_groups	= pmu_dev->attr_groups,
 		.task_ctx_nr	= perf_invalid_context,
 		.pmu_enable	= xgene_perf_pmu_enable,
-- 
2.37.2

