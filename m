Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08D6E0FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDMO0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjDMO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:26:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6B9EE3;
        Thu, 13 Apr 2023 07:26:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py21S54Z5z67NYF;
        Thu, 13 Apr 2023 22:25:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 15:26:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 1/5] perf: Allow a PMU to have a parent
Date:   Thu, 13 Apr 2023 15:26:13 +0100
Message-ID: <20230413142617.15995-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMUs have well defined parents such as PCI devices.
As the device_initialize() and device_add() are all within
pmu_dev_alloc() which is called from perf_pmu_register()
there is no opportunity to set the parent from within a driver.

Add a struct device *parent field to struct pmu and use that
to set the parent.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
v6: No change
v5: Move to head of series as may merge as part of:
https://lore.kernel.org/all/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..b99db1eda72c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -303,6 +303,7 @@ struct pmu {
 
 	struct module			*module;
 	struct device			*dev;
+	struct device			*parent;
 	const struct attribute_group	**attr_groups;
 	const struct attribute_group	**attr_update;
 	const char			*name;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d3be3f..32079a332480 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11367,6 +11367,7 @@ static int pmu_dev_alloc(struct pmu *pmu)
 
 	dev_set_drvdata(pmu->dev, pmu);
 	pmu->dev->bus = &pmu_bus;
+	pmu->dev->parent = pmu->parent;
 	pmu->dev->release = pmu_dev_release;
 
 	ret = dev_set_name(pmu->dev, "%s", pmu->name);
-- 
2.37.2

