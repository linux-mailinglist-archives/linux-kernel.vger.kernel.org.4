Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C1372CC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjFLRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFLRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:16:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12AFE10FE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:16:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D119C13D5;
        Mon, 12 Jun 2023 10:17:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C61EA3F5A1;
        Mon, 12 Jun 2023 10:16:41 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, ilkka@os.amperecomputing.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf/arm-cmn: Add sysfs identifier
Date:   Mon, 12 Jun 2023 18:16:33 +0100
Message-Id: <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1686588640.git.robin.murphy@arm.com>
References: <cover.1686588640.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a sysfs identifier encapsulating the CMN part number and revision
so that jevents can narrow down a fundamental set of possible events for
calculating metrics. Configuration-dependent aspects - such as whether a
given node type is present, and/or a given node ID is valid - are still
not covered, and in general it's hard to see how userspace could handle
them, so we won't be removing any data or validation logic from the
driver any time soon, but at least it's a step in a useful direction.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 8cf4ed932950..088dc5c690a4 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1199,19 +1199,31 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
 static struct device_attribute arm_cmn_cpumask_attr =
 		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
 
-static struct attribute *arm_cmn_cpumask_attrs[] = {
+static ssize_t arm_cmn_identifier_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%03x%02x\n", cmn->part, cmn->rev);
+}
+
+static struct device_attribute arm_cmn_identifier_attr =
+		__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
+
+static struct attribute *arm_cmn_other_attrs[] = {
 	&arm_cmn_cpumask_attr.attr,
+	&arm_cmn_identifier_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group arm_cmn_cpumask_attr_group = {
-	.attrs = arm_cmn_cpumask_attrs,
+static const struct attribute_group arm_cmn_other_attrs_group = {
+	.attrs = arm_cmn_other_attrs,
 };
 
 static const struct attribute_group *arm_cmn_attr_groups[] = {
 	&arm_cmn_event_attrs_group,
 	&arm_cmn_format_attrs_group,
-	&arm_cmn_cpumask_attr_group,
+	&arm_cmn_other_attrs_group,
 	NULL
 };
 
-- 
2.39.2.101.g768bb238c484.dirty

