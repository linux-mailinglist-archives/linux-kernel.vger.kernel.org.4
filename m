Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AC72A274
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjFISiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjFIShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0868359A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686335847; x=1717871847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqKTca5gyr7Im4WSf8/P06PY9UT7NdBNnxnbcZy0OCE=;
  b=Xc/2danfFPgfvQIqNzl2NRRTTEDEp60FaHLAUKJNOwzBuepjtEFKp6e4
   Q4j8sG2Jx6XAIwUt3SOMM51xXI/4CK8UsGpVdmaE9xCiRtfaQUjEKAcYD
   H47PbIbt1/9P51xxqCJLG5TAtMZMbXG1hPIj9wvGHHzzCuBR0fItngwir
   oANSd1WQY2/CvX+N++7w4L+0bQHJD21hLGAWndbPRp+CQqX2Jomn0LY/3
   i0RVhMevXAD6nsOscoH+JIiDoa6IkPey1DTvjsqkbIzbQfj/xTN60Or9p
   T/g7IZoNGkNa2ZySIe5pvPN5SgbSOPpRV4MeeTK4iOuMA/2xiBaSrglwl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338022216"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338022216"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710444115"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710444115"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 11:37:20 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     Yian Chen <yian.chen@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 11/12] x86/cpu: Set LASS CR4 bit as pinning sensitive
Date:   Fri,  9 Jun 2023 21:36:31 +0300
Message-Id: <20230609183632.48706-12-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yian Chen <yian.chen@intel.com>

Security features such as LASS are not expected to be disabled once
initialized. Add LASS to the CR4 pinned mask.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f26c56fe9963..9ddc19c8832d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -422,7 +422,7 @@ static __always_inline void setup_lass(struct cpuinfo_x86 *c)
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
 	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
-	X86_CR4_FSGSBASE | X86_CR4_CET;
+	X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_LASS;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
-- 
2.39.2

