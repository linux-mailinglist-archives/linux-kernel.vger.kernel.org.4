Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38245FC1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJLIXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJLIXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:23:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD3FAE8;
        Wed, 12 Oct 2022 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665562994; x=1697098994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z+DS0CTSK6wge4QeiB2tKJuCydLccz47w+YEbJAbQpY=;
  b=Nac/kHOneDprdwBaWsXSYTwW5JX4P/mMN0rJ5UIG0Wc8GW4GQSRJWICH
   bj1ChtL3bAGp3G4/hUEZNKMMkszaOejYuBP1ygHae2Xj7DUqverWo/rel
   4Br8UyJsKrFni5ECaTesJr9//2OyXpI/aCrlLce3dElFg1Y+b+9p1XAwb
   aG/ZgrEcoEvel1gPRthlbwbAQ3sM1av2MQB7aertqT8+/xlK2xBKVf7pq
   iqqO9OgHMP36CYJJF2Fj7q71oA7b+gsVgZgDHw/xOQSrVq0N/5kDHWtT1
   tpI2uWhUaVMj1U64lWlm2MP3hP1plqW1wFpUDP4Cmc2LEnWcQAA1QiRaK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="303472962"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="303472962"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 01:23:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="955665516"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="955665516"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.132])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 01:23:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf intel-pt: Fix system_wide dummy event for hybrid
Date:   Wed, 12 Oct 2022 11:22:59 +0300
Message-Id: <20221012082259.22394-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012082259.22394-1-adrian.hunter@intel.com>
References: <20221012082259.22394-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space tasks can migrate between CPUs, so when tracing selected CPUs,
system-wide sideband is still needed, however evlist->core.has_user_cpus
is not set in the hybrid case, so check the target cpu_list instead.

Fixes: 7d189cadbeeb ("perf intel-pt: Track sideband system-wide when needed")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 793b35f2221a..af102f471e9f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -866,7 +866,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
 		 */
-		need_system_wide_tracking = evlist->core.has_user_cpus &&
+		need_system_wide_tracking = opts->target.cpu_list &&
 					    !intel_pt_evsel->core.attr.exclude_user;
 
 		tracking_evsel = evlist__add_aux_dummy(evlist, need_system_wide_tracking);
-- 
2.25.1

