Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306A66519D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 05:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiLTD74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLTD7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:59:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABF632B;
        Mon, 19 Dec 2022 19:59:50 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NbjVd67sbzJqV7;
        Tue, 20 Dec 2022 11:58:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 11:59:48 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <ravi.bangoria@amd.com>, <martin.lau@kernel.org>,
        <adrian.hunter@intel.com>, <ak@linux.intel.com>,
        <masami.hiramatsu.pt@hitachi.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/3] perf tools: Set debug_peo_args and redirect_to_stderr to correct values in perf_quiet_option
Date:   Tue, 20 Dec 2022 11:57:00 +0800
Message-ID: <20221220035702.188413-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20221220035702.188413-1-yangjihong1@huawei.com>
References: <20221220035702.188413-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
and display_attr incorrectly determines the value of debug_peo_args.
As a result, unexpected information is displayed.

Before:
  # perf record --quiet -- ls > /dev/null
  ------------------------------------------------------------
  perf_event_attr:
    size                             128
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  ...

After:
  # perf record --quiet -- ls > /dev/null
  #

redirect_to_stderr is a similar problem.

Fixes: f78eaef0e049 ("perf tools: Allow to force redirect pr_debug to stderr.")
Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 65e6c22f38e4..190e818a0717 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -241,6 +241,10 @@ int perf_quiet_option(void)
 		opt++;
 	}
 
+	/* For debug variables that are used as bool types, set to 0. */
+	redirect_to_stderr = 0;
+	debug_peo_args = 0;
+
 	return 0;
 }
 
-- 
2.30.GIT

