Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FC746AF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGDHor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:44:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1F910C2;
        Tue,  4 Jul 2023 00:44:24 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QwFCC3Jd3zTmR6;
        Tue,  4 Jul 2023 15:43:19 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 15:44:19 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 0/5] perf record: Tracking side-band events for all CPUs when tracing selected CPUs
Date:   Tue, 4 Jul 2023 07:42:12 +0000
Message-ID: <20230704074217.240939-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space tasks can migrate between CPUs, we need to track side-band
events for all CPUs.

The specific scenarios are as follows:

         CPU0                                 CPU1
  perf record -C 0 start
                              taskA starts to be created and executed
                                -> PERF_RECORD_COMM and PERF_RECORD_MMAP
                                   events only deliver to CPU1
                              ......
                                |
                          migrate to CPU0
                                |
  Running on CPU0    <----------/
  ...

  perf record -C 0 stop

Now perf samples the PC of taskA. However, perf does not record the
PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
Therefore, the comm and symbols of taskA cannot be parsed.

The sys_perf_event_open invoked is as follows:

  # perf --debug verbose=3 record -e cpu-clock -C 1 true
  <SNIP>
  Opening: cpu-clock
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ID|CPU|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
  Opening: dummy:HG
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             136
    config                           0x9
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ID|CPU|PERIOD
    read_format                      ID|LOST
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    task                             1
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
  <SNIP>

1. patch1 and patch2 are pre-patch and are used to provide two helpers.
   One is used to modify cpu_maps,
   and the other is used to search for dummy tracking evsel in the evlist.
2. patch3 is the main patch, track side-band events for all CPUs when
   tracing selected CPUs
3. patch4 adds the corresponding test case.
4. patch5 is code optimization.

Yang Jihong (5):
  perf evlist: Export perf_evlist__propagate_maps()
  perf evlist: Add evlist__findnew_tracking_event() helper
  perf record: Tracking side-band events for all CPUs when tracing
    selected CPUs
  perf test: Add test case for record tracking
  perf record: All config tracking are integrated into
    record__config_tracking_events()

 tools/lib/perf/evlist.c                   | 23 +++----
 tools/lib/perf/include/perf/evlist.h      |  2 +
 tools/perf/builtin-record.c               | 74 ++++++++++++++---------
 tools/perf/tests/shell/record_tracking.sh | 44 ++++++++++++++
 tools/perf/util/evlist.c                  | 17 ++++++
 tools/perf/util/evlist.h                  |  1 +
 6 files changed, 120 insertions(+), 41 deletions(-)
 create mode 100755 tools/perf/tests/shell/record_tracking.sh

-- 
2.30.GIT

