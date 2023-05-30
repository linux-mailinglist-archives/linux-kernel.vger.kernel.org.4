Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE37159DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjE3JUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjE3JUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:20:09 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343FE41;
        Tue, 30 May 2023 02:19:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vjt6o0o_1685438383;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vjt6o0o_1685438383)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 17:19:44 +0800
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
Subject: [PATCH v3 4/7] driver/perf: Add identifier sysfs file for Yitian 710 DDR
Date:   Tue, 30 May 2023 17:19:31 +0800
Message-Id: <1685438374-33287-5-git-send-email-renyu.zj@linux.alibaba.com>
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
add an "identifier" sysfs file.

The perf tool can match the Yitian 710 DDR metric through the identifier.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index a7689fe..fe075fd 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -236,10 +236,37 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
 	.attrs = ali_drw_pmu_cpumask_attrs,
 };
 
+static ssize_t ali_drw_pmu_identifier_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	return sysfs_emit(page, "%s\n", "ali_drw_pmu");
+}
+
+static umode_t ali_drw_pmu_identifier_attr_visible(struct kobject *kobj,
+						struct attribute *attr, int n)
+{
+	return attr->mode;
+}
+
+static struct device_attribute ali_drw_pmu_identifier_attr =
+	__ATTR(identifier, 0444, ali_drw_pmu_identifier_show, NULL);
+
+static struct attribute *ali_drw_pmu_identifier_attrs[] = {
+	&ali_drw_pmu_identifier_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ali_drw_pmu_identifier_attr_group = {
+	.attrs = ali_drw_pmu_identifier_attrs,
+	.is_visible = ali_drw_pmu_identifier_attr_visible
+};
+
 static const struct attribute_group *ali_drw_pmu_attr_groups[] = {
 	&ali_drw_pmu_events_attr_group,
 	&ali_drw_pmu_cpumask_attr_group,
 	&ali_drw_pmu_format_group,
+	&ali_drw_pmu_identifier_attr_group,
 	NULL,
 };
 
-- 
1.8.3.1

