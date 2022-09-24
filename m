Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D115E889C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiIXFpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiIXFo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:44:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520622538;
        Fri, 23 Sep 2022 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663998279; x=1695534279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QqXva2JUu/RQnDI1kxBjde7cPAYIQfasEASf2LkrJPY=;
  b=LVmyC7Dn6PG0M2lkYuVjgdtbAxDjI3gDvlJAdJHtM4s0dJnntljWIyq4
   iimY9W4/NpBZcfj82g25oi3sJrzgl2NRv8T5KeGQB5Ft5pj/PrtHR/vLT
   6KadGRt96fPmcHIBFU+VTnPxNZ05a+AsShd5P9Zz7yIQx6phb7cKOc4ME
   meyJVy3Xu51khlyqBGF+SLGCf0Xn+ncwLv7c1ybJ0bhmqRhnGaNFLd4MK
   4pyFfrSXh0+PbrXM87JcvD0gLv3Klx8aCtGrn+OEeMNONCVH7pN3PSDb0
   dhR35FENaiFkWwn4hs0RHHLmF6ecLhhnHorhaOwJQuKe9bPScHSw/mXLP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299470286"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="299470286"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 22:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="651207763"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 22:44:36 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, len.brown@intel.com
Cc:     mingo@redhat.com, linux-pm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Subject: [PATCH 1/3] powercap: intel_rapl: Use standard Energy Unit for SPR Dram RAPL domain
Date:   Sat, 24 Sep 2022 13:47:36 +0800
Message-Id: <20220924054738.12076-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220924054738.12076-1-rui.zhang@intel.com>
References: <20220924054738.12076-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Xeon servers used to use a fixed energy resolution (15.3uj) for
Dram RAPL domain. But on SPR, Dram RAPL domain follows the standard
energy resolution as described in MSR_RAPL_POWER_UNIT.

Remove the SPR dram_domain_energy_unit quirk.

Fixes: 2d798d9f5967 ("powercap: intel_rapl: add support for Sapphire Rapids")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 949eb90f5733..d8eaa04bf2af 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1035,7 +1035,6 @@ static const struct rapl_defaults rapl_defaults_spr_server = {
 	.check_unit = rapl_check_unit_core,
 	.set_floor_freq = set_floor_freq_default,
 	.compute_time_window = rapl_compute_time_window_core,
-	.dram_domain_energy_unit = 15300,
 	.psys_domain_energy_unit = 1000000000,
 	.spr_psys_bits = true,
 };
-- 
2.25.1

