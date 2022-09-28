Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B3A5EE08A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiI1Pdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiI1Pdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:33:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EBB2DE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379219; x=1695915219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+4n2r0+cxytrV6oFh5TCp8kz4ZPblHJc8SUVJlO+7ew=;
  b=RHhnYz1SdmKVK1p7otQjvKMMLdne4umAqNhY7VvV87ivbw8CYcZtmp+z
   2LoSe/NkJCAzvnnq2XODGPGGbRmWKhqDHKtdidGjcUoqToXzJaUI14P5N
   dT9UmjrzqpQdtxojg+9U77xlQwtOhfpnaGGZBr4Pp063JPrqmRD2CsRx7
   w1JBRMF08NaLBAIrD583h+o8kV5LFTg0QV01rp+ZIC4TSYZRcxPorvpTN
   nrbBcObHwVaOQyO6z1KRBQbR/PpwC0I6cOtxCWjsSxvgaYUsJvGEB+9iI
   utKlUicsU6Tp73tj/7NVUjnQfN+/JNtlDt2tZCsuRa5xGuEnj9wmKA0DQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302544922"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="302544922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764328120"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764328120"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 08:33:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/4] perf/x86: Add new Raptor Lake S support
Date:   Wed, 28 Sep 2022 08:33:28 -0700
Message-Id: <20220928153331.3757388-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, the new Raptor Lake S is the same as the other
of hybrid {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rebase on top of tip master branch
  9286a39427d5 ("Merge branch into tip/master: 'perf/core'")

 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5b26f902899b..a646a5f9a235 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6382,6 +6382,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ALDERLAKE_L:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
-- 
2.35.1

