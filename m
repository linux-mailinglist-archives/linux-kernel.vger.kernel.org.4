Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187156092FB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJWMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJWMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:49:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DDF7538D;
        Sun, 23 Oct 2022 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666529335; x=1698065335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Wr1wExNIpkZXMw8IkZIKKVQFVsJkOI8UO9dU31zeISw=;
  b=PqUBTylKQfMX6PM+/LBBI8ckXMPilMyy2UmEBSEPNkwgaL+FeoU/yHRD
   J02U2e89mjCWAaSqs+8P449uL/MtX2z84F3kq6eY6hx0Vx1RV6Bqi9z7w
   LO9CIFxw8ce5+kNmBcbHdYtgtJRmbbQOOxDxQ3pReK5hP676Ufu/wKeCX
   ROqHzjgJZVqv4zD6/sfcaBSgtS1lA4t+mwiC57BAJxoMhPD0WnXrnfb5t
   S7hh36WjAJSWlfQrYQXXyVtUPRocJ1+lRvstFuZWTqcyZ4ED4xp+jpMlZ
   IT6DMCp9eKsJkGq3b0ZaoFX7q6ABIHFdq9ccwKpAjY4Td7J5J6wAVw7f+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="308944506"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="308944506"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 05:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="756303924"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="756303924"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2022 05:48:51 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com
Subject: [PATCH 2/2] perf/x86/rapl: Add support for Intel Raptor Lake
Date:   Sun, 23 Oct 2022 20:51:20 +0800
Message-Id: <20221023125120.2727-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221023125120.2727-1-rui.zhang@intel.com>
References: <20221023125120.2727-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raptor Lake RAPL support is the same as previous Sky Lake.
Add Raptor Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 arch/x86/events/rapl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 165c506cd37c..fea544e5842a 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -808,6 +808,9 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.25.1

