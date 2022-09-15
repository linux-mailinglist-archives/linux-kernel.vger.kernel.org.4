Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5625B9AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIOM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIOM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:26:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA1785B5;
        Thu, 15 Sep 2022 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663244790; x=1694780790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haHRJRLUtGiMpejZ9zvS+1gtLxrDjI6bwRU3M7poV3I=;
  b=O1eBHE+DSptm2dkVcXLzIak1pmqG8BJDlKmntyD6cfEC3zwt6ulxsvaI
   rfZ7h0im/kAJ6QIoBgZ9VkudrXra9sb6w20O6XZd8y/G7uZGk52qMlSCH
   6x46Kx3pYys7D4cJwmWOJwWa8vVy7D9NC722i/dlh9jbpzCTtTGblVPFD
   +Z55GwtCJ4be4fX/FtYd6tGemyX5aMgU3ycOrwOzj0URMsAAGUgPKctOf
   oe/518rBNF89XCcTMgtRkYz4faUJS/xP39kqUrFg9DPzMkPSCXBtMZQIG
   IGR2VLYirQOU0j51Kb6sBXhpZAO4eaz74oMMMvWwNblojTBNQ97isOLHU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298693709"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="298693709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:26:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="685705669"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.17])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:26:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] libperf evlist: Fix polling of system-wide events
Date:   Thu, 15 Sep 2022 15:26:12 +0300
Message-Id: <20220915122612.81738-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915122612.81738-1-adrian.hunter@intel.com>
References: <20220915122612.81738-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, (refer commit f90d194a867a ("perf evlist: Do not poll events
that use the system_wide flag") there wasn't much reason to poll
system-wide events because:
 1. The mmaps get "merged" via set-output anyway (the per-cpu case)
 2. perf reads all mmaps when any event is woken
 3. system-wide mmaps do not fill up as fast as the mmaps for user
 selected events
But there was 1 reason not to poll which was that it prevented
correct termination due to POLLHUP on all user selected events.
That issue is now easily resolved by using fdarray_flag__nonfilterable.

With the advent of commit ae4f8ae16a07 ("libperf evlist: Allow mixing
per-thread and per-cpu mmaps"), system-wide mmaps can be used also in
the per-thread case where reason 1 does not apply.

Fix the omission of system-wide events from polling by using the
fdarray_flag__nonfilterable flag.

Example:

 Before:

    $ perf record --no-bpf-event -vvv -e intel_pt// --per-thread uname 2>err.txt
    Linux
    $ grep 'sys_perf_event_open.*=\|pollfd' err.txt
    sys_perf_event_open: pid 155076  cpu -1  group_fd -1  flags 0x8 = 5
    sys_perf_event_open: pid 155076  cpu -1  group_fd -1  flags 0x8 = 6
    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 9
    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 10
    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 11
    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 12
    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 13
    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 14
    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 15
    thread_data[0x55fb43c29e80]: pollfd[0] <- event_fd=5
    thread_data[0x55fb43c29e80]: pollfd[1] <- event_fd=6
    thread_data[0x55fb43c29e80]: pollfd[2] <- non_perf_event fd=4

 After:

    $ perf record --no-bpf-event -vvv -e intel_pt// --per-thread uname 2>err.txt
    Linux
    $ grep 'sys_perf_event_open.*=\|pollfd' err.txt
    sys_perf_event_open: pid 156316  cpu -1  group_fd -1  flags 0x8 = 5
    sys_perf_event_open: pid 156316  cpu -1  group_fd -1  flags 0x8 = 6
    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 9
    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 10
    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 11
    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 12
    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 13
    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 14
    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 15
    thread_data[0x55cc19e58e80]: pollfd[0] <- event_fd=5
    thread_data[0x55cc19e58e80]: pollfd[1] <- event_fd=6
    thread_data[0x55cc19e58e80]: pollfd[2] <- event_fd=7
    thread_data[0x55cc19e58e80]: pollfd[3] <- event_fd=9
    thread_data[0x55cc19e58e80]: pollfd[4] <- event_fd=10
    thread_data[0x55cc19e58e80]: pollfd[5] <- event_fd=11
    thread_data[0x55cc19e58e80]: pollfd[6] <- event_fd=12
    thread_data[0x55cc19e58e80]: pollfd[7] <- event_fd=13
    thread_data[0x55cc19e58e80]: pollfd[8] <- event_fd=14
    thread_data[0x55cc19e58e80]: pollfd[9] <- event_fd=15
    thread_data[0x55cc19e58e80]: pollfd[10] <- non_perf_event fd=4

Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 80cc810c5097..0e7347d1583d 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -441,6 +441,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 
 	perf_evlist__for_each_entry(evlist, evsel) {
 		bool overwrite = evsel->attr.write_backward;
+		enum fdarray_flags flgs;
 		struct perf_mmap *map;
 		int *output, fd, cpu;
 
@@ -506,8 +507,8 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 
 		revent = !overwrite ? POLLIN : 0;
 
-		if (!evsel->system_wide &&
-		    perf_evlist__add_pollfd(evlist, fd, map, revent, fdarray_flag__default) < 0) {
+		flgs = evsel->system_wide ? fdarray_flag__nonfilterable : fdarray_flag__default;
+		if (perf_evlist__add_pollfd(evlist, fd, map, revent, flgs) < 0) {
 			perf_mmap__put(map);
 			return -1;
 		}
-- 
2.25.1

