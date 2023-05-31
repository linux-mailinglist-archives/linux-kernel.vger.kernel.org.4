Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAE717D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjEaLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjEaLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:00:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AA612B;
        Wed, 31 May 2023 04:00:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWR880rmzz67J0f;
        Wed, 31 May 2023 18:58:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 12:00:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Namhyung Kim <namhyung@gmail.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@reresetdhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v8 1/5] perf: Allow a PMU to have a parent
Date:   Wed, 31 May 2023 12:00:07 +0100
Message-ID: <20230531110011.13963-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531110011.13963-1-Jonathan.Cameron@huawei.com>
References: <20230531110011.13963-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index db016e418931..285cf6ca6e81 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11379,6 +11379,7 @@ static int pmu_dev_alloc(struct pmu *pmu)
 
 	dev_set_drvdata(pmu->dev, pmu);
 	pmu->dev->bus = &pmu_bus;
+	pmu->dev->parent = pmu->parent;
 	pmu->dev->release = pmu_dev_release;
 
 	ret = dev_set_name(pmu->dev, "%s", pmu->name);
-- 
2.39.2

