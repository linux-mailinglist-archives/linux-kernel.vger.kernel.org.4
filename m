Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173D4664BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbjAJTEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbjAJS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:58:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835740862;
        Tue, 10 Jan 2023 10:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673377035; x=1704913035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICyLkNmPziZklwLAZSFBzXZ2ChVSeIYypwFGatdn6sI=;
  b=hBc/MLYsxQpj0zAdhUtr4DxsF5QSXQE/3yoNp2fIC5zibSQ9iBfGJOre
   77WOqg2ot/vKPQkEe/ynbYXbi5NhN0bpOK+bWVwMWiBNv1XD99dp+1bOI
   RWd08t4zHPbmCTOR/xvbn1JvR9wMRcm7IiCM+KxZJYsruNULQoHncdh0Z
   1aqhYXdeoszMOU8Uxb/Bj2wRJLjhd25xUrvtE6cUvh/4IZBkU+eT0L7sN
   WC/nvg/Jx8oMdsrWW5I71oEkMzHh2RbIn2oMMN3NScfqFRac7iixAnI2V
   f3NJgOTCvglA5LBYu7VySPdSxqRb3fLkvX4rPnOfKV0Sz39Cm7L9UQyP8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350453954"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350453954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 10:57:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687666184"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687666184"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.221.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 10:57:12 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dmitry Dolgov <9erthalion6@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf auxtrace: Fix address filter duplicate symbol selection
Date:   Tue, 10 Jan 2023 20:56:59 +0200
Message-Id: <20230110185659.15979-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a match has been made to the nth duplicate symbol, return
success not error.

Example:

  Before:

    $ cat file.c
    cat: file.c: No such file or directory
    $ cat file1.c
    #include <stdio.h>

    static void func(void)
    {
            printf("First func\n");
    }

    void other(void);

    int main()
    {
            func();
            other();
            return 0;
    }
    $ cat file2.c
    #include <stdio.h>

    static void func(void)
    {
            printf("Second func\n");
    }

    void other(void)
    {
            func();
    }

    $ gcc -Wall -Wextra -o test file1.c file2.c
    $ perf record -e intel_pt//u --filter 'filter func @ ./test' -- ./test
    Multiple symbols with name 'func'
    #1      0x1149  l       func
                    which is near           main
    #2      0x1179  l       func
                    which is near           other
    Disambiguate symbol name by inserting #n after the name e.g. func #2
    Or select a global symbol by inserting #0 or #g or #G
    Failed to parse address filter: 'filter func @ ./test'
    Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
    Where multiple filters are separated by space or comma.
    $ perf record -e intel_pt//u --filter 'filter func #2 @ ./test' -- ./test
    Failed to parse address filter: 'filter func #2 @ ./test'
    Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
    Where multiple filters are separated by space or comma.

  After:

    $ perf record -e intel_pt//u --filter 'filter func #2 @ ./test' -- ./test
    First func
    Second func
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.016 MB perf.data ]
    $ perf script --itrace=b -Ftime,flags,ip,sym,addr --ns
    1231062.526977619:   tr strt                               0 [unknown] =>     558495708179 func
    1231062.526977619:   tr end  call               558495708188 func =>     558495708050 _init
    1231062.526979286:   tr strt                               0 [unknown] =>     55849570818d func
    1231062.526979286:   tr end  return             55849570818f func =>     55849570819d other

Reported-by: Dmitry Dolgov <9erthalion6@gmail.com>
Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 265d20cc126b..c2e323cd7d49 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2611,7 +2611,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 				*size = sym->start - *start;
 			if (idx > 0) {
 				if (*size)
-					return 1;
+					return 0;
 			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
 				print_duplicate_syms(dso, sym_name);
 				return -EINVAL;
-- 
2.34.1

