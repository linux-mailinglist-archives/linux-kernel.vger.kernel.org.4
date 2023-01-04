Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639765DD71
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbjADUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:14:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868461A818
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863246; x=1704399246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O+nU4p5hgQUT3M7z+rZZ2tFIqvoh8BbKb8EMQ4dLjNU=;
  b=GYvz7XOAPCMtKTrQM2sZfSs2XBdo2EMqIj0+zua8lx+CQXnn5Fw5Fu8O
   P1i+CiH3fbeliYHLKuErNlu4axZqqu7RGcvzZOhfeq50DI30nx8QZ2gkd
   1Zps0B3F5cNHkPYDbvHTQ/P+LK/JPT+yzbJdsUw33MZVYFaDp1WLYYRjV
   4PuAF8byq7CuB9Lu8aE0LGra32Hsm+eiBK/ZAvCAR3YZi5MamC+67lWpG
   FDqnb9NlCpnsAaQqMK70AojNEuFUFIYV+LHEkHeAN0VLhtEXwiLZnRcDr
   2jq+jXMy+TJgAwgAbNy6N/mGwmJ0fFxkyg/ahTGMqdN8zZr9hs3vRlEWw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322105437"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322105437"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779323969"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="779323969"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 12:14:05 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/9] perf: Add PMU_FORMAT_ATTR_SHOW
Date:   Wed,  4 Jan 2023 12:13:41 -0800
Message-Id: <20230104201349.1451191-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The macro PMU_FORMAT_ATTR facilitates the definition of both the "show"
function and "format_attr". But it only works for a non-hybrid platform.
For a hybrid platform, the name "format_attr_hybrid_" is used.

The definition of the "show" function can be shared between a non-hybrid
platform and a hybrid platform. Add a new macro PMU_FORMAT_ATTR_SHOW.

No functional change. The PMU_FORMAT_ATTR_SHOW will be used in the
following patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No change since V1

 include/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c6a3bac76966..ad92ad37600e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1724,7 +1724,7 @@ static struct perf_pmu_events_attr _var = {				    \
 		  .id = _id, }						\
 	})[0].attr.attr)
 
-#define PMU_FORMAT_ATTR(_name, _format)					\
+#define PMU_FORMAT_ATTR_SHOW(_name, _format)				\
 static ssize_t								\
 _name##_show(struct device *dev,					\
 			       struct device_attribute *attr,		\
@@ -1733,6 +1733,9 @@ _name##_show(struct device *dev,					\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
 	return sprintf(page, _format "\n");				\
 }									\
+
+#define PMU_FORMAT_ATTR(_name, _format)					\
+	PMU_FORMAT_ATTR_SHOW(_name, _format)				\
 									\
 static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
-- 
2.35.1

