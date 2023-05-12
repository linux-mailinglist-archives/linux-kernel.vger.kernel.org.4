Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAD6FFF05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbjELClW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjELClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:41:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88497559E;
        Thu, 11 May 2023 19:41:18 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QHXxs1czyzLprV;
        Fri, 12 May 2023 10:38:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 10:41:15 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH] coresight: etm4x: fix trctraceid sysfs always invisible
Date:   Fri, 12 May 2023 10:39:33 +0800
Message-ID: <20230512023933.961-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trctraceid sysfs interface is current in etm4x mgmt group.
Each attr in the mgmt group will call the function is_visible()
to check whether the register is implemented. However the trctraceid
does not bound to any register. So the trctraceid sysfs will
always be invisible.

Move it to etmv4 group to fix that.

Fixes: df4871204e5d ("coresight: etm4x: Update ETM4 driver to use Trace ID API")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 .../coresight/coresight-etm4x-sysfs.c         | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 5e62aa40ecd0..0ea71de0f56b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2335,6 +2335,26 @@ static ssize_t ts_source_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(ts_source);
 
+/*
+ * Trace ID allocated dynamically on enable - but also allocate on read
+ * in case sysfs or perf read before enable to ensure consistent metadata
+ * information for trace decode
+ */
+static ssize_t trctraceid_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int trace_id;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	trace_id = etm4_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
+
+	return sysfs_emit(buf, "0x%x\n", trace_id);
+}
+static DEVICE_ATTR_RO(trctraceid);
+
 static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_nr_pe_cmp.attr,
 	&dev_attr_nr_addr_cmp.attr,
@@ -2390,29 +2410,10 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_vmid_masks.attr,
 	&dev_attr_cpu.attr,
 	&dev_attr_ts_source.attr,
+	&dev_attr_trctraceid.attr,
 	NULL,
 };
 
-/*
- * Trace ID allocated dynamically on enable - but also allocate on read
- * in case sysfs or perf read before enable to ensure consistent metadata
- * information for trace decode
- */
-static ssize_t trctraceid_show(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
-{
-	int trace_id;
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	trace_id = etm4_read_alloc_trace_id(drvdata);
-	if (trace_id < 0)
-		return trace_id;
-
-	return sysfs_emit(buf, "0x%x\n", trace_id);
-}
-static DEVICE_ATTR_RO(trctraceid);
-
 struct etmv4_reg {
 	struct coresight_device *csdev;
 	u32 offset;
@@ -2549,7 +2550,6 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	&dev_attr_trctraceid.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
-- 
2.33.0

