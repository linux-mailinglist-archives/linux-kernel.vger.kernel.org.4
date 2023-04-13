Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB96E03AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDMB3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDMB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:29:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D1121;
        Wed, 12 Apr 2023 18:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681349363; x=1712885363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eiGf+YK8D5uXT76f7SsOIA1fFUZIqBbQIs663qB/YBM=;
  b=QbjZ+EwrWkn8LQukRDF7J8HTPIDK56mOCHYoquP8yctSGOgbDg8hAExO
   zxq4l6AbjV6VRI+EsXGEFijDX4/t5yysVp9DhHrns0brkqUz9B86AQfW0
   ISiwpxTOlTooNH/TwyZ4azgzgdbZHTrQFQyq37cGBftTBnWtg9qa+WHQu
   wYyDhzZ3S8uSD9kbP9sOdNyuwN0j1WFRIfHChu8HXZVMTugdsSVsthEwK
   bvTcpklftYoaUvE+4o6jYAwGawFFokYK8oz7zUy+/hYh+5viUwMRt9jZk
   CrpqdCokY9Amem6CCmQeKoEV0npib5uG/UfLyL6S4OWyyftAaErNvDoNf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323684527"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323684527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 18:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719613941"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719613941"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2023 18:29:23 -0700
Received: from debox1-desk4.intel.com (unknown [10.251.6.61])
        by linux.intel.com (Postfix) with ESMTP id D7253580BEE;
        Wed, 12 Apr 2023 18:29:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmt: Ignore uninitialized entries
Date:   Wed, 12 Apr 2023 18:29:22 -0700
Message-Id: <20230413012922.1521377-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Xeon, unused PMT regions will have uninitialized discovery headers
containing all 0xF. Instead of returning an error, just skip the region.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/telemetry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 71cdef42084a..39cbc87cc28a 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -78,7 +78,7 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
 	 * reserved for future use. They have zero size. Do not fail
 	 * probe for these. Just ignore them.
 	 */
-	if (header->size == 0)
+	if (header->size == 0 || header->access_type == 0xF)
 		return 1;
 
 	return 0;

base-commit: 5b309e80f457ebb41770e0122766825a78cfc11b
prerequisite-patch-id: a3bf21940fa02eb2f3adb4bd2d3a93df14df077a
-- 
2.34.1

