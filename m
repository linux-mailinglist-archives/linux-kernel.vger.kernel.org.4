Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396696C99B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjC0Cqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjC0Cqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:46:30 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5A44B5;
        Sun, 26 Mar 2023 19:46:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VeeqFQ2_1679885185;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeeqFQ2_1679885185)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 10:46:26 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH RFC 3/4] driver/perf: Add identifier sysfs file for Yitian 710 DDR
Date:   Mon, 27 Mar 2023 10:46:11 +0800
Message-Id: <1679885172-95021-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow userspace to identify the specific implementation of the device,
add an "identifier" sysfs file.

The perf tool can match the Yitian 710 DDR metric through the identifier.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index a7689fe..6639a57 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -236,10 +236,37 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
 	.attrs = ali_drw_pmu_cpumask_attrs,
 };
 
+static ssize_t ali_drw_pmu_identifier_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	return sysfs_emit(page, "%s\n", "ali_drw_yitian710");
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
+	NULL,
+};
+
+static const struct attribute_group ali_drw_pmu_identifier_attr_group = {
+	.attrs = ali_drw_pmu_identifier_attrs,
+	.is_visible = ali_drw_pmu_identifier_attr_visible,
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

