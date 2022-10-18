Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35816029FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJRLQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:16:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5551EA;
        Tue, 18 Oct 2022 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666091791; x=1697627791;
  h=from:to:cc:subject:date:message-id;
  bh=pA0PdqTHxsHL7/a/8drLbW+gda7QFfqXPuVNuMwE6kQ=;
  b=kcniZT7jON9eWYaJZRDgzpYJEkLYg9lreVYaLLbIYHQjlTNuCZEDjfKL
   kh++RGhtTi4u0PmpD4IbW+urR512ftexygXRKAYh2RFkCOS9naqzR+cbz
   HVGDgnS9piaX6bei0cJBfcDdW9k3S868WycGnfi/gm3JKLhCgMIAE2ijo
   RKzT5SPLG9b89AktI4uwpQ/kmVCuU9eOhzgAC0Q7T75CGASGBNBDS67f7
   LIKkI5y7EHY4TcdIkwFj7kMIlt5qGdTssbFagWQKTy5Svl6vIjEBq91Jb
   3pLMIuVE2sibLK+BmrmU1pvopQR1gREo9PKUPsRXpMGF3kcH8gKj9+uWe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370272282"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="370272282"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957724705"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="957724705"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2022 04:16:30 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: hfi: Improve the type of hfi_features::nr_table_pages
Date:   Tue, 18 Oct 2022 04:22:40 -0700
Message-Id: <20221018112240.25647-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Coverity static code scan raised a potential overflow_before_widen
warning when hfi_features::nr_table_pages is used as an argument to
memcpy in intel_hfi_process_event().

Even though the overflow can never happen (the maximum number of pages of
the HFI table is 0x10 and 0x10 << PAGE_SHIFT = 0x10000), using size_t as
the data type of hfi_features::nr_table_pages makes Coverity happy and
matches the data type of the argument 'size' of memcpy().

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index a0640f762dc5..239afe02e518 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -137,7 +137,7 @@ struct hfi_instance {
  * Parameters and supported features that are common to all HFI instances
  */
 struct hfi_features {
-	unsigned int	nr_table_pages;
+	size_t		nr_table_pages;
 	unsigned int	cpu_stride;
 	unsigned int	hdr_size;
 };
-- 
2.25.1

