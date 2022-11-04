Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7594961960A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiKDMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKDMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:18:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC71B1D2;
        Fri,  4 Nov 2022 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667564309; x=1699100309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZI6xHWvYb5hUllWV2LLxfu1xhaF/lLjF9tYZjHPtVU=;
  b=ASTgwO1m6MKDO8q6knVwix5I5PV83KClc2LyPaV3vnTiy9IqmAgofYG4
   gKoPLAvSU+uESlZnlE8KZBFQCArurEwIMP+zsWJjIFms6mzyhVC0BP3NZ
   l3/PO4iFhHsg85bJQdBiBFiC9xkdGsS9DFkFtuQ4kR7qGO7slVM2TYhCv
   EsGvdkLHSSMJI8NYDBg92Y5x794JKmosvNvMXCHV+2XrrLMqhSXpFJQej
   88J94A1XhSpN43eLsHN3t+2Ds+7md0LoMlN0qttSL5CPmRDhtKGhGLZqg
   v+U8EFMOt6nxiMsPqFi1Gk0mEijsDQZ+a6XbboBgGM97pCOfdrQBDOutS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290341717"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="290341717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="760309119"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="760309119"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.118])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf: intel-pt: Redefine test_suite
Date:   Fri,  4 Nov 2022 14:18:04 +0200
Message-Id: <20221104121805.5264-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104121805.5264-1-adrian.hunter@intel.com>
References: <20221104121805.5264-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding more Intel PT testing, redefine the test_suite
to allow for adding more subtests.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/tests/arch-tests.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 04018b8aa85b..8d5e4a0831d5 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -5,7 +5,17 @@
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
-DEFINE_SUITE("Intel PT packet decoder", intel_pt_pkt_decoder);
+
+static struct test_case intel_pt_tests[] = {
+	TEST_CASE("Intel PT packet decoder", intel_pt_pkt_decoder),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__intel_pt = {
+	.desc = "Intel PT packet decoder",
+	.test_cases = intel_pt_tests,
+};
+
 #endif
 #if defined(__x86_64__)
 DEFINE_SUITE("x86 bp modify", bp_modify);
@@ -18,7 +28,7 @@ struct test_suite *arch_tests[] = {
 #endif
 #ifdef HAVE_AUXTRACE_SUPPORT
 	&suite__insn_x86,
-	&suite__intel_pt_pkt_decoder,
+	&suite__intel_pt,
 #endif
 #if defined(__x86_64__)
 	&suite__bp_modify,
-- 
2.34.1

