Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B55E889E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiIXFpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiIXFo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:44:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3D303EE;
        Fri, 23 Sep 2022 22:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663998282; x=1695534282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QrNQIZ0qq8HRIyiV/4AC87Fjnz2QKG8N162m/6PAQCA=;
  b=cvzLKvIOGrlqVaYiV3nvqNbVFk3PS0gdm2MCFB6KLKNWpPRtzpRQWZ0K
   p2x0dBz5HABJ/X8aSAMKzPYolEPQ72Q30YxGCOsEohJvl85RnVr5iNG6I
   ECwwsgLXiCe2gQeGk/wIwMlXJGN83Zb7RyN31wo4VI3lJyeyZBtp4SsCK
   KgruK2lwOUQsyr44I6JL7cEtIdxlTd4t3jd5fZMRWrkyjCK9BPrKZlMtp
   pjKHi868X70rX3/16odWMxse0QC3EaanR97vTJlaDw0kx7R90C0sMZX9t
   hBiHPGSeD5kdaestRtyv7LorMica5gmgRBPGYUVxcY9aeC9TCUr6Wj4aC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299470291"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="299470291"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 22:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="651207770"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 22:44:39 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, len.brown@intel.com
Cc:     mingo@redhat.com, linux-pm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Subject: [PATCH 2/3] perf/x86/rapl: Use standard Energy Unit for SPR Dram RAPL domain
Date:   Sat, 24 Sep 2022 13:47:37 +0800
Message-Id: <20220924054738.12076-3-rui.zhang@intel.com>
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

Remove the SPR Dram energy unit quirk.

Fixes: bcfd218b6679 ("perf/x86/rapl: Add support for Intel SPR platform")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/rapl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5ad..7d8db681880d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -619,12 +619,8 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
-	/*
-	 * SPR shares the same DRAM domain energy unit as HSW, plus it
-	 * also has a fixed energy unit for Psys domain.
-	 */
+	/* SPR uses a fixed energy unit for Psys domain. */
 	case RAPL_UNIT_QUIRK_INTEL_SPR:
-		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
 		break;
 	default:
-- 
2.25.1

