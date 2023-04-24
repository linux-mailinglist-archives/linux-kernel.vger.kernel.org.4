Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236026EC93E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDXJol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjDXJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:44:38 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB93630C5;
        Mon, 24 Apr 2023 02:44:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VgsU8jM_1682329469;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VgsU8jM_1682329469)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 17:44:29 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
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
Subject: [PATCH v2 1/5] driver/perf: Add identifier sysfs file for CMN
Date:   Mon, 24 Apr 2023 17:44:12 +0800
Message-Id: <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
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
add an "identifier" sysfs file.

The perf tool can match the arm CMN metric through the identifier.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 drivers/perf/arm-cmn.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c968986..f425610 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -334,6 +334,7 @@ struct arm_cmn {
 
 	struct pmu pmu;
 	struct dentry *debug;
+	const char *identifier;
 };
 
 #define to_cmn(p)	container_of(p, struct arm_cmn, pmu)
@@ -1168,10 +1169,41 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
 	.attrs = arm_cmn_cpumask_attrs,
 };
 
+static ssize_t arm_cmn_identifier_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%s\n", cmn->identifier);
+}
+
+static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
+		struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+
+	if (cmn->identifier == NULL)
+		return 0;
+	return attr->mode;
+};
+
+static struct device_attribute arm_cmn_identifier_attr =
+__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
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
 
@@ -2241,6 +2273,22 @@ static int arm_cmn600_of_probe(struct device_node *np)
 	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
 }
 
+const char *arm_cmn_identifier(unsigned long model)
+{
+	switch (model) {
+	case CMN600:
+		return "cmn600";
+	case CMN650:
+		return "cmn650";
+	case CMN700:
+		return "cmn700";
+	case CI700:
+		return "ci700";
+	default:
+		return NULL;
+	}
+}
+
 static int arm_cmn_probe(struct platform_device *pdev)
 {
 	struct arm_cmn *cmn;
@@ -2254,6 +2302,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
+	cmn->identifier = arm_cmn_identifier(cmn->model);
 	platform_set_drvdata(pdev, cmn);
 
 	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
-- 
1.8.3.1

