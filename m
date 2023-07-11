Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04974E6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGKF7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGKF7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:59:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3480E4D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704aace46so57156717b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689055157; x=1691647157;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0QK7UrJCCNlVV6qfLvDD+ydWVpwOAsvAu1MiLJXtI7I=;
        b=d1hv7Zq1YfGVbj90PHFNpTAlUIx72fd4dtT90cyuswtwZBXgJlrDtmqISMB3756+zm
         QkVkESlyU70LfevKySbmv9xEibCLu2gzwFqlyXYjIYD1nQ1ysaN08Q/dvYb4FbJPIU23
         4iYKlRN6dlUjJ7DACnF2Bl4CTWC29eDrBoL0EhLej75caYNiFAxNvpkdU11B230zM97E
         NBRaMOMxsKbup+9LWKhGURXUrfDsUhSuyQbR1s+36VDr/TQYxgVA2qMHbDb2is7m7eIP
         JUBFoGc/xFhRHO+XqYQ1K0SJqkRORF4tSZE2f7aGM0hwQh9mYofZVEYBBUAh1XLW8/Tw
         fRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055157; x=1691647157;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QK7UrJCCNlVV6qfLvDD+ydWVpwOAsvAu1MiLJXtI7I=;
        b=ZvD0pKB+t3CmT3LRsdrEp+udUaC8NQvkHLPCL0J2O4kAxjt9AQJI4Yz4nyGeSFvIjO
         mpN5cXlOAWbPTCubbAjumnbjxFM/uVYQPBAooD85aERfwr/U8W9XcEUOEQYq6HU3sej8
         AV+y6qG92A5OGe4i+K6viUhj0It7TFqQ8FU0GdDTI4f3HvXQT7hTLCif5/P6ZoyPsvlC
         T4v/XbuDGp1ZlKXDr1cONsi4hvRkzkoNXJNnKZbYgC9RA6TcNa20KImTG2YBvbRcuDxo
         ulcka3GmIfChzAsK1sJlgt1C+PeLmQ43rp4cVHsp94lcxYro+rIbq91OTATdXIuJXX3n
         bNxQ==
X-Gm-Message-State: ABy/qLbQNan3LNlYzCBhSr6rS7w6Q+AWbVMjsDVVPWcTlwbkGgTSGEve
        WBPsONr/+SoQtd5kwylAkkRagnjdhn21
X-Google-Smtp-Source: APBJJlHPO+tWvTd6ygr4rxGnVr1FgxWxxR7YH0ay9NmUdOQaeDgtzVsRC96usmPKXQwQ8faDvKYH5ImpCR7c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2efd:fc0f:9eaa:3bd5])
 (user=irogers job=sendgmr) by 2002:a81:b614:0:b0:577:3712:125d with SMTP id
 u20-20020a81b614000000b005773712125dmr121154ywh.4.1689055157210; Mon, 10 Jul
 2023 22:59:17 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:58:56 -0700
Message-Id: <20230711055859.1242497-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 0/3] perf list: Remove duplicate PMUs
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple PMUs differing by ordered suffixes only
display one. This avoids repeated listing of events, in particular
when there are 10s of uncore PMUs. This also helps speed the all PMU
event tests.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
  uncore_imc_free_running/data_read/                 [Kernel PMU event]
  uncore_imc_free_running/data_total/                [Kernel PMU event]
  uncore_imc_free_running/data_write/                [Kernel PMU event]
```

The PMUs are sorted by name then suffix as a part of this change.

Ian Rogers (3):
  perf pmus: Sort pmus by name then suffix
  perf pmus: Add scan that ignores duplicates, use for perf list
  perf pmus: Don't print PMU suffix in list

 tools/perf/util/pmus.c | 107 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 5 deletions(-)

-- 
2.41.0.390.g38632f3daf-goog

