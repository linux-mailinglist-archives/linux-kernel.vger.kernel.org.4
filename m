Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6561B65D694
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbjADOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbjADOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:52:04 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38F2BD9;
        Wed,  4 Jan 2023 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672843922; x=1704379922;
  h=from:to:cc:subject:date:message-id;
  bh=IVgAP0seJkcpaaiACVAxhGwC/VqyuQOB1oJYl2epNdU=;
  b=gVkd1pFhtM8uVIxGKWYaGB5l7jCQT+KcUzZHUoIyZI17jtqSQ4DZQKvY
   Y+EV1PAJwPqIRiGUV0URbkpXXHfh+OR36+ke/S4Mr4qc+tR/P4iFRVYhs
   mV0AE7xcFa6ipGdgHb4/gar9PQHyYMhI9zeRMlbjYjwu0cKiWXPoJkNXt
   oU0k1fQwWwd7zTPf5yVnstEAuIU3hHKWAsLwLFesLZk6ECtCKxChzJDmd
   vE6WDsQ+KbsT1E0vc7dw7xj7P8VNp+u9LQbvwjXbTxfquRRaI4BUhplUk
   Y1R1rmJoXHYVmppFuutC+6FOyejnY0E3P7zpscuS4n0SwyBnA2DdB1xjA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384240207"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="384240207"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:51:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900575818"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="900575818"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2023 06:51:35 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com
Subject: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Date:   Wed,  4 Jan 2023 22:58:30 +0800
Message-Id: <20230104145831.25498-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meteor Lake RAPL support is the same as previous Sky Lake.
Add Meteor Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a829492bca4c..0ef255602aa8 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -807,6 +807,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.25.1

