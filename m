Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D56872D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBBBJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBBBJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B663FF15;
        Wed,  1 Feb 2023 17:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300144; x=1706836144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYv6jDBrHFQqFs42e2Uh3HApFnR2DRe1FCshvQDOYek=;
  b=Q7LpxGFMbxmJ/zMy0X0JoucUlbtduOrZ3BCS8FW9Ko+AYyhPgGufReFG
   rzW1hHxfOro9Xqi5SZOcmVxyygneg2V1VYeCS+jVYCw+nv7TK6RbaGSuO
   bdmRutUGCuO5NYHrkrsa2w/tI1eURGXgAQCOiUObjNpLQu7x6OZ/kaJZq
   Fa35rbnPhKC5T6CJ1EVIjS9fqrNDHUnrR1hXSAfVJtc984Lhjp7iosdZc
   SNGp/0qGQTwP1uM2aI3RNTkLMwWwWFXPMN4t03iowGiPyG9c2mmRYkUnu
   1LVcDAAcO//k+wrnQfgiE0ItvA8/L7qtOmAYAxF/j6Ibk8OW+/wHXjlep
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654320"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654320"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087936"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087936"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:16 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6/7] platform/x86/intel/tpmi: ADD tpmi external interface for tpmi feature drivers
Date:   Wed,  1 Feb 2023 17:07:37 -0800
Message-Id: <20230202010738.2186174-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
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

Add interface to get resources and platform data. This will avoid code
duplication. These interfaces includes:
- Get resource count
- Get resource at an index

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 22 ++++++++++++++++++++++
 include/linux/intel_tpmi.h        |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index e612da579b29..c60733261c89 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -153,6 +153,28 @@ struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *aux
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_platform_data, INTEL_TPMI);
 
+int tpmi_get_resource_count(struct auxiliary_device *auxdev)
+{
+	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
+
+	if (vsec_dev)
+		return vsec_dev->num_resources;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_count, INTEL_TPMI);
+
+struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index)
+{
+	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
+
+	if (vsec_dev && index < vsec_dev->num_resources)
+		return &vsec_dev->resource[index];
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
+
 static const char *intel_tpmi_name(enum intel_tpmi_id id)
 {
 	switch (id) {
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 5b665320ecb4..f505788c05da 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -24,5 +24,7 @@ struct intel_tpmi_plat_info {
 };
 
 struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev);
+struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
+int tpmi_get_resource_count(struct auxiliary_device *auxdev);
 
 #endif
-- 
2.31.1

