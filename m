Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA56B8A69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCNFdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCNFdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:33:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE14ECCF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e11-20020a5b004b000000b00b37118ce5a7so8455912ybp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678772003;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MwzV/vcYr5Zry5C9s84roUhY+PWVjIVRmjU3ee9SQpE=;
        b=HDIj3nfkgsOUYQZ5qw8ur+gCJGp/io4tqQ6Q4ow58uYXi9Il6j9+XoKvtLBUBz7x41
         /xmyqdDfPxnRy27tmMapbClnCpZ941zD8zzoITxKTVOWJw8vGolSiiZnwl37GInl37PT
         TJxLJee9FdEj2d3feSGSYxP1ZaxG7umrkXU1/3rv0Afmnp/ss1vxjXZ+ekwbCGgBlz9w
         4okVWdKplWCllBtcVpbNQbwCfUA/RMqU1QgVXmibbGIp9esEIEXIUthPRi4/bznT91Uc
         NruYASFLIO+OvRzDKeBMO/O7PLlVdnvYJiAt06GD8+WIRswLUwWwJHKCwpCk5R4Mrvdv
         GkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772003;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwzV/vcYr5Zry5C9s84roUhY+PWVjIVRmjU3ee9SQpE=;
        b=xRj0OlN9n2NQK/zhGxdSD9kRJA/eZODrd7cQkPnMNFWfBWzK9Lag9v/PcT0Jhm/rlO
         qS9FxNRJIUm6dsWJGo9Tylsq1bdk0nfymi0kYyCgeturwR942HfSZoG6lLsqW1WC+YqC
         j37fO/wcXW0Rpbh/CV7nsZ9FJRNqVqH8zMhvtWZd0AzUsXstjKSJ3Uz9g4hq1LDcnnrp
         i0o9B9YkDNZAc1+d/cx9go6IcmQl8w+R94MpH2ivxwBTm8y8M+PMnsRqB+rtxUQwhk2A
         h70/yJBA+nfkKwLtL/8DtiRU3tBZDJlY32sn4MzivRMnrBWNNL4D1Q+NjMTVYZ8auqkR
         f+xw==
X-Gm-Message-State: AO0yUKUqKlgiWwZdKUIZKuz7n4iYFXTraaYHW26CfSu3+QEd2JpjOwkz
        jqVMOUkecDBoRFRW47u/0i9A/l9/PXBU
X-Google-Smtp-Source: AK7set+2hAm+eZDUuLi0segr54jwahN7es2PMtB0X7hrmupVnXjBwjMOqvqSP7MOkOY2cm+giM20Z7pBNRif
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:adc3:d11e:dcd7:fd4e])
 (user=irogers job=sendgmr) by 2002:a05:690c:798:b0:533:a15a:d33e with SMTP id
 bw24-20020a05690c079800b00533a15ad33emr10114724ywb.5.1678772003054; Mon, 13
 Mar 2023 22:33:23 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:33:09 -0700
Message-Id: <20230314053312.3237390-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 0/3] Event updates for GNR, MTL and SKL
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update events for graniterapids and meteorlake, v1.00 to v1.01, as
well as skylake v54 to v55. All patches generated from:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Ian Rogers (3):
  perf vendor events intel: Update graniterapids events
  perf vendor events intel: Update meteorlake events
  perf vendor events intel: Update skylake events

 .../arch/x86/graniterapids/frontend.json      |  2 +-
 .../arch/x86/graniterapids/pipeline.json      |  4 +--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  6 ++--
 .../pmu-events/arch/x86/meteorlake/cache.json |  8 +++++
 .../arch/x86/meteorlake/frontend.json         |  9 +++++
 .../arch/x86/meteorlake/memory.json           | 13 +++++--
 .../pmu-events/arch/x86/meteorlake/other.json |  4 +--
 .../arch/x86/meteorlake/pipeline.json         | 36 +++++++++++++++++--
 .../arch/x86/meteorlake/virtual-memory.json   |  4 +++
 .../pmu-events/arch/x86/skylake/cache.json    |  8 +++++
 .../arch/x86/skylake/floating-point.json      | 15 ++++++++
 .../pmu-events/arch/x86/skylake/pipeline.json | 10 ++++++
 12 files changed, 107 insertions(+), 12 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

