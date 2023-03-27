Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40A6C99B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjC0Cqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjC0Cq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:46:29 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8444BD;
        Sun, 26 Mar 2023 19:46:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VeeqFPR_1679885183;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeeqFPR_1679885183)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 10:46:24 +0800
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
Subject: [PATCH RFC 1/4] driver/perf: Add identifier sysfs file for CMN
Date:   Mon, 27 Mar 2023 10:46:09 +0800
Message-Id: <1679885172-95021-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/perf/arm-cmn.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c968986..0c138ad 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1168,10 +1168,53 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
 	.attrs = arm_cmn_cpumask_attrs,
 };
 
+static ssize_t arm_cmn_identifier_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+	if (cmn->model == CMN700) {
+		return sysfs_emit(buf, "%s\n", "CMN700");
+	}
+	else if (cmn->model == CMN650) {
+		return sysfs_emit(buf, "%s\n", "CMN650");
+	}
+	else if (cmn->model == CMN600) {
+		return sysfs_emit(buf, "%s\n", "CMN600");
+	}
+	else if (cmn->model == CI700) {
+		return sysfs_emit(buf, "%s\n", "CI700");
+	}
+	return sysfs_emit(buf, "%s\n", "UNKNOWN");
+}
+
+static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
+		struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+	if (cmn->model <= 0)
+		return 0;
+	return attr->mode;
+};
+
+static struct device_attribute arm_cmn_identifier_attr =
+__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
+
+static struct attribute *arm_cmn_identifier_attrs[] = {
+	&arm_cmn_identifier_attr.attr,
+	NULL,
+};
+
+static struct attribute_group arm_cmn_identifier_attr_group = {
+	.attrs = arm_cmn_identifier_attrs,
+	.is_visible = arm_cmn_identifier_attr_visible,
+};
+
 static const struct attribute_group *arm_cmn_attr_groups[] = {
 	&arm_cmn_event_attrs_group,
 	&arm_cmn_format_attrs_group,
 	&arm_cmn_cpumask_attr_group,
+	&arm_cmn_identifier_attr_group,
 	NULL
 };
 
-- 
1.8.3.1

