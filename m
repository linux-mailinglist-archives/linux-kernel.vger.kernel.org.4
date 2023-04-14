Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2F6E1AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDND0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDND0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:26:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2782D57;
        Thu, 13 Apr 2023 20:26:08 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PyMFc6xQVz17SJk;
        Fri, 14 Apr 2023 11:22:28 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 11:26:04 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v4 0/2] perf script: Have consistent output for symbol address
Date:   Fri, 14 Apr 2023 11:25:45 +0800
Message-ID: <20230414032547.2767909-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The goal of this change is to achieve consistent output for symbol address.
Before this, the raw ip is printed for non-callchain and dso offset for
callchain. Mostly what we expect is the raw ip.

This patch does two changes:
  - Always print raw ip for resolved symbols.
  - Add a new 'dsoff' field if we really need the dso offset, and the
    offset is appended to dso name.

v4:
  o also print 'dsoff' for brstack,brstacksym,brstackoff,etc.
v3:
  o 'dsoff' implys 'dso' field. (Namhyung)
v2:
  o split into two patches. (Adrian)
  o do not print offset for unresolved symbols. (Adrian)

Changbin Du (2):
  perf script: print raw ip instead of binary offset for callchain
  perf: script: add new output field 'dsoff' to print dso offset

 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 25 +++++++++++++++++++++++-
 tools/perf/util/evsel_fprintf.c          | 15 +++++++-------
 tools/perf/util/evsel_fprintf.h          |  1 +
 4 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.25.1

