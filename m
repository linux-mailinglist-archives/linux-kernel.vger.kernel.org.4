Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01F5B6436
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiILXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:33:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE2D50715;
        Mon, 12 Sep 2022 16:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663025605; x=1694561605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hHCtBCKGNzvcZrz0ungc2TPqvTn8smUwmTtUYKPT4c=;
  b=OuEUUu/Whnd3/ZjA3dnir4QWmUt+WRrLAjKlb+4zdZDhXaCX0bOWsDnX
   gOPoTkT/fGVJw6XII6IWVeSFmEISJboL3/s/SXrv8ao3RB7lqd/TpJ1zc
   l6gPIYI7f8rEs5jIhEYnjEds5PpXELknV6/PRzjG/pl8M0QD6NEl9rV2A
   D3/vqO5oFzrJuhyEWbJgxr0yCf0ogPZByPhjFG0f+YqkHEC0pZEwTJufM
   4UnihJzGoO7SPU+PKgG9J3nYGPr0NAcwAoEn++ZjSECvT7qMt3on8a7wA
   9P5Klm0058D2B4LYT/ZXlmzQRKFKAM94/ap1de9KxN/JaxVLGHN8pyWO0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299333169"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="299333169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="758574265"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 16:33:24 -0700
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.24])
        by linux.intel.com (Postfix) with ESMTP id 948CA580BF8;
        Mon, 12 Sep 2022 16:33:24 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v2 2/2] platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver
Date:   Mon, 12 Sep 2022 16:33:07 -0700
Message-Id: <20220912233307.409954-2-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
References: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
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

Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
Changes since v1:
1) Added a dependency patch- ea902bcc1943f7539200ec464de3f54335588774 :
 "x86/cpu: Add new Raptor Lake CPU model number".
2) Rebased the above patch on v6.0-rc1 with "Acked-by" from Hans and
 Rajneesh.

 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index a1fe1e0dcf4a..17ec5825d13d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_reg_map),
 	{}
 };
 
-- 
2.25.1

