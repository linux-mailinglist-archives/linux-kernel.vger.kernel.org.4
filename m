Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA46D4C86
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjDCPuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjDCPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:50:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE535B8;
        Mon,  3 Apr 2023 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680536991; x=1712072991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+pwottLJkhoBGrr5tQbs6DpDn3ZA4WcvxwmOO9XIis=;
  b=lGxHlYJzKwrSf6ZLiAkFPjIRCfklDSk37oyUVuNBlqOoOZmRL6uH0pua
   BOPbZBrhOlSsm1uS4RmFga17EvH4sfi8GV30FUi5eCfT0uPiacaUc4wZ6
   YWRHODs2lFLYi3YiU8JUUWip6aVXzQqzk3c/PGu+UVUIHZxtM55aGwlgQ
   F2ghQlX3HIbC7PNH5mvYERvHN2I8xrBjMm28gX0JdqpLt0Tp6TRFH6V1p
   QHIhzy5rwnSYy2KM4L2Z8RHkzbMF2xZwcODiSTobNoUoZhXHJiHCeIFcZ
   +d6F3Upvpu0Dcq8LbC1WieEsEhMpa7iOgu0TnDq6YTZrNB6txuLPbyiCb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="339430305"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="339430305"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663243329"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="663243329"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.40.243])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:48:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf auxtrace: Fix address filter entire kernel size
Date:   Mon,  3 Apr 2023 18:48:30 +0300
Message-Id: <20230403154831.8651-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403154831.8651-1-adrian.hunter@intel.com>
References: <20230403154831.8651-1-adrian.hunter@intel.com>
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

kallsyms is not completely in address order.

In find_entire_kern_cb(), calculate the kernel end from the maximum
address not the last symbol.

Example:

 Before:

    $ sudo cat /proc/kallsyms | grep ' [twTw] ' | tail -1
    ffffffffc00b8bd0 t bpf_prog_6deef7357e7b4530    [bpf]
    $ sudo cat /proc/kallsyms | grep ' [twTw] ' | sort | tail -1
    ffffffffc15e0cc0 t iwl_mvm_exit [iwlmvm]
    $ perf.d093603a05aa record -v --kcore -e intel_pt// --filter 'filter *' -- uname |& grep filter
    Address filter: filter 0xffffffff93200000/0x2ceba000

 After:

    $ perf.8fb0f7a01f8e record -v --kcore -e intel_pt// --filter 'filter *' -- uname |& grep filter
    Address filter: filter 0xffffffff93200000/0x2e3e2000

Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 498ff7f24463..b2a5e5397bad 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2449,6 +2449,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 			       char type, u64 start)
 {
 	struct sym_args *args = arg;
+	u64 size;
 
 	if (!kallsyms__is_function(type))
 		return 0;
@@ -2458,7 +2459,9 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 		args->start = start;
 	}
 	/* Don't know exactly where the kernel ends, so we add a page */
-	args->size = round_up(start, page_size) + page_size - args->start;
+	size = round_up(start, page_size) + page_size - args->start;
+	if (size > args->size)
+		args->size = size;
 
 	return 0;
 }
-- 
2.34.1

