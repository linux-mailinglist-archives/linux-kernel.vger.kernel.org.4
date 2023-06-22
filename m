Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5473A93E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFVT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVT5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:57:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131D1BF0;
        Thu, 22 Jun 2023 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687463866; x=1718999866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BgpRqo4puNcohYTMFAWxOVTW7DldqwzOBNgi36hCvWc=;
  b=P+4zkcKWB/q9HpxDCd/eRNI94SwcTW4jBesvOHLqgF+3O4tjxqD4+PoS
   CMGM2gffjr3xuYVZZWC2ioDvfWtLlBCAqpQsPcn+DG5OI0aXsyrpZKJKy
   da9b+lyJA2v+t82VmEZReO/S2sWvvEfRnxdsVpTv4c8bB3/TRycS8UMVG
   CTzTpp6b4aNnLLt6iO9ISU3LDiupbsEiRCtrB/z785+YvVtkE2ALMJU7h
   2mkMBHwTIeiJsL7xUzK78+7wt+NplIqbCGsaM2BqcdTVOM/zquRZf2utI
   X5lZBY0YdkCYOoSu271+khdf1VqK7bUTOZl+1uFYJUSgwBI9UzaeBasbK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="358088608"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="358088608"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 12:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889204563"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="889204563"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 12:57:28 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel/tpmi: Prevent overflow for cap_offset
Date:   Thu, 22 Jun 2023 12:57:17 -0700
Message-Id: <20230622195717.3125088-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cap_offset is a u16 field, so multiplying with TPMI_CAP_OFFSET_UNIT
(which is equal to 1024) to covert to bytes will cause overflow. This
will be a problem once more TPMI features are added.

This field is not used except for calculating pfs->vsec_offset. So, leave
cap_offset field unchanged and multiply with TPMI_CAP_OFFSET_UNIT while
calculating pfs->vsec_offset.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Rebased on top of
https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
review-hans 

 drivers/platform/x86/intel/tpmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 9c606ee2030c..d1fd6e69401c 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -356,9 +356,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		if (!pfs_start)
 			pfs_start = res_start;
 
-		pfs->pfs_header.cap_offset *= TPMI_CAP_OFFSET_UNIT;
-
-		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset;
+		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset * TPMI_CAP_OFFSET_UNIT;
 
 		/*
 		 * Process TPMI_INFO to get PCI device to CPU package ID.
-- 
2.38.1

