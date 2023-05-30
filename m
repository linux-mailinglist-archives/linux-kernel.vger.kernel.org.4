Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA07159DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjE3JUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjE3JUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:20:07 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630241BF;
        Tue, 30 May 2023 02:19:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vjt6o.G_1685438381;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vjt6o.G_1685438381)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 17:19:41 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v3 1/7] driver/perf: Add identifier sysfs file for CMN
Date:   Tue, 30 May 2023 17:19:28 +0800
Message-Id: <1685438374-33287-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow userspace to identify the specific implementation of the device,
add an "identifier" sysfs file. The "identifier" consists of model name
and revision. One of possible identifier is "arm_cmn700_0".

The perf tool can match the arm CMN metric through the identifier.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 drivers/perf/arm-cmn.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c968986..cd6962b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -334,6 +334,7 @@ struct arm_cmn {
 
 	struct pmu pmu;
 	struct dentry *debug;
+	const char *identifier;
 };
 
 #define to_cmn(p)	container_of(p, struct arm_cmn, pmu)
@@ -347,6 +348,11 @@ struct arm_cmn_nodeid {
 	u8 dev;
 };
 
+struct arm_cmn_device_data {
+	const char * model_name;
+	enum cmn_model model;
+};
+
 static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
 {
 	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
@@ -1168,10 +1174,43 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
 	.attrs = arm_cmn_cpumask_attrs,
 };
 
+static ssize_t arm_cmn_identifier_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%s\n", cmn->identifier);
+}
+
+static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
+					       struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+
+	if (cmn->identifier == NULL)
+		return 0;
+	return attr->mode;
+}
+
+static struct device_attribute arm_cmn_identifier_attr =
+	__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
+
+static struct attribute *arm_cmn_identifier_attrs[] = {
+	&arm_cmn_identifier_attr.attr,
+	NULL
+};
+
+static struct attribute_group arm_cmn_identifier_attr_group = {
+	.attrs = arm_cmn_identifier_attrs,
+	.is_visible = arm_cmn_identifier_attr_visible
+};
+
 static const struct attribute_group *arm_cmn_attr_groups[] = {
 	&arm_cmn_event_attrs_group,
 	&arm_cmn_format_attrs_group,
 	&arm_cmn_cpumask_attr_group,
+	&arm_cmn_identifier_attr_group,
 	NULL
 };
 
@@ -2247,13 +2286,15 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	const char *name;
 	static atomic_t id;
 	int err, rootnode, this_id;
+	const struct arm_cmn_device_data * dev_data;
 
 	cmn = devm_kzalloc(&pdev->dev, sizeof(*cmn), GFP_KERNEL);
 	if (!cmn)
 		return -ENOMEM;
 
 	cmn->dev = &pdev->dev;
-	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
+	dev_data = (const struct arm_cmn_device_data *)device_get_match_data(cmn->dev);
+	cmn->model = dev_data->model;
 	platform_set_drvdata(pdev, cmn);
 
 	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
@@ -2281,6 +2322,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	cmn->identifier = devm_kasprintf(
+		cmn->dev, GFP_KERNEL, "%s_%d", dev_data->model_name, cmn->rev);
 	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
@@ -2330,12 +2373,32 @@ static int arm_cmn_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct arm_cmn_device_data arm_cmn600_data = {
+	.model_name = "arm_cmn600",
+	.model = CMN600
+};
+
+static const struct arm_cmn_device_data arm_cmn650_data = {
+	.model_name = "arm_cmn650",
+	.model = CMN650
+};
+
+static const struct arm_cmn_device_data arm_cmn700_data = {
+	.model_name = "arm_cmn700",
+	.model = CMN700
+};
+
+static const struct arm_cmn_device_data arm_ci700_data = {
+	.model_name = "arm_ci700",
+	.model = CI700
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id arm_cmn_of_match[] = {
-	{ .compatible = "arm,cmn-600", .data = (void *)CMN600 },
-	{ .compatible = "arm,cmn-650", .data = (void *)CMN650 },
-	{ .compatible = "arm,cmn-700", .data = (void *)CMN700 },
-	{ .compatible = "arm,ci-700", .data = (void *)CI700 },
+	{ .compatible = "arm,cmn-600", .data = (void *)&arm_cmn600_data },
+	{ .compatible = "arm,cmn-650", .data = (void *)&arm_cmn650_data },
+	{ .compatible = "arm,cmn-700", .data = (void *)&arm_cmn700_data },
+	{ .compatible = "arm,ci-700", .data = (void *)&arm_ci700_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, arm_cmn_of_match);
@@ -2343,9 +2406,9 @@ static int arm_cmn_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id arm_cmn_acpi_match[] = {
-	{ "ARMHC600", CMN600 },
-	{ "ARMHC650", CMN650 },
-	{ "ARMHC700", CMN700 },
+	{ "ARMHC600", (kernel_ulong_t)&arm_cmn600_data },
+	{ "ARMHC650", (kernel_ulong_t)&arm_cmn650_data },
+	{ "ARMHC700", (kernel_ulong_t)&arm_cmn700_data },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
-- 
1.8.3.1

