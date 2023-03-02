Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C337E6A79CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCBDMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBDMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:12:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A44C6F2;
        Wed,  1 Mar 2023 19:12:22 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PRx0g07dfz16P0k;
        Thu,  2 Mar 2023 11:09:38 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:12:17 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 0/3] perf : fix counting when initial delay configured
Date:   Thu, 2 Mar 2023 11:11:43 +0800
Message-ID: <20230302031146.2801588-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first one fixes the problem that counters are never enabled  when initial
delay configured.
The remaining two reuse the common field target::initial_delay for
record/ftrace/trace subcommands.

v2:
 - introduce common filed target::initial_delay

Changbin Du (3):
  perf stat: fix counting when initial delay configured
  perf record: reuse target::initial_delay
  perf: ftrace: reuse target::initial_delay

 tools/perf/builtin-ftrace.c | 10 +++++-----
 tools/perf/builtin-record.c | 12 ++++++------
 tools/perf/builtin-stat.c   | 15 +++++----------
 tools/perf/builtin-trace.c  |  8 ++++----
 tools/perf/util/evlist.c    |  6 +++---
 tools/perf/util/evsel.c     |  2 +-
 tools/perf/util/ftrace.h    |  1 -
 tools/perf/util/record.h    |  1 -
 tools/perf/util/stat.c      |  6 +-----
 tools/perf/util/stat.h      |  1 -
 tools/perf/util/target.h    | 12 ++++++++++++
 11 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.25.1

