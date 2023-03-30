Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF46D0659
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC3NS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjC3NS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:18:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BDAD0C;
        Thu, 30 Mar 2023 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680182335; x=1711718335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LAHpVWG1ZoEYTct3DHbov1hRSNYq+xCwxAPTjJFwgB8=;
  b=MOYLk0hbYQATUYVamx/5/IOP9vSmEwuTU/tl7bIuRDrd06W4fzFdPjnX
   7YloDoGIaMNbW85i0Uy3J+raXsg6PwNb0o55TIe2BWH2zYEE3A4HuPwtH
   TvPuSdgi3DbKk6vGkqHVcZILKuAKUCj3IlYfLbJCjazrqca5kEUXyCkmK
   74Oxkiev9MTcRvyOb/N61DEzhnAFJxuBZbCmIu485skeXm80PiWagYqWA
   yBxWcwa79T4Y+ljufuk+QxYosHM9ySdVZzsChc42Z1PpAc8Sf4B3Z9X5L
   Qo9N6kG02OvcZDPPc2sShnNkyR9Q0YxieqHq8/hZmMMSsZNRq1Hfvbsrs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427440771"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427440771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="678185597"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="678185597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.32.122])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:18:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf symbol: Remove unused branch_callstack
Date:   Thu, 30 Mar 2023 16:18:33 +0300
Message-Id: <20230330131833.12864-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330131833.12864-1-adrian.hunter@intel.com>
References: <20230330131833.12864-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

branch_callstack was added by commit 8b7bad58efb7 ("perf callchain: Support
handling complete branch stacks as histograms") but never used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol_conf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 5accd8e69ad2..f26f81eb8252 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -33,7 +33,6 @@ struct symbol_conf {
 			demangle_kernel,
 			filter_relative,
 			show_hist_headers,
-			branch_callstack,
 			has_filter,
 			show_ref_callgraph,
 			hide_unresolved,
-- 
2.34.1

