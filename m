Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB563F8A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiLAT5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLAT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB892A10
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924636; x=1701460636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=26LDl5gEfOUK1vLXLl8rkZu+pPxLEfyA+JmOQyiRqI0=;
  b=ewe8Su+ziWIjDThDstqvbRndTrLthYJqI01YCDbAdVC9V46w5WFisPXM
   20V1c4bBbZ/SFt52n2mi5Rs0sHfjIfSiVi0l0OLVVYxEWOhgYmO0GGPwR
   5YdXh3ztdQMroGBvBk1NBcIC0QH77pa9t7WrA7a7c1CUcEZTywgEwaRa2
   dZWK3z5fmr2gZpjxFEvzYq2nEZR/Zw4+/ctJeL+TRmleQUGOcfr7fX0or
   Vsm8/ZW87yYvCnawADJMe32MZsetNoVboZBAw9AtTnNLrx7Md9OoWFhFD
   3oclwOQmqW7y2+aqHAgnfMhZ6IryVO0Oi2bmVHIOFT3vPmo8FH13MLof7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303391852"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303391852"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708205026"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708205026"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 11:57:15 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/9] perf: Add PMU_FORMAT_ATTR_SHOW
Date:   Thu,  1 Dec 2022 11:56:56 -0800
Message-Id: <20221201195704.2330866-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0031f7b4d9ab..ab251c737f97 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1661,7 +1661,7 @@ static struct perf_pmu_events_attr _var = {				    \
 		  .id = _id, }						\
 	})[0].attr.attr)
 
-#define PMU_FORMAT_ATTR(_name, _format)					\
+#define PMU_FORMAT_ATTR_SHOW(_name, _format)				\
 static ssize_t								\
 _name##_show(struct device *dev,					\
 			       struct device_attribute *attr,		\
@@ -1670,6 +1670,9 @@ _name##_show(struct device *dev,					\
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

