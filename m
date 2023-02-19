Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2169BFBB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBSJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBSJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:37:24 -0500
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF412580
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:36:33 -0800 (PST)
Received: by mail-yb1-f202.google.com with SMTP id k131-20020a256f89000000b0074747131938so222653ybc.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJq6auQeIidM24mfR/8eo3ksFWhAxhvnpDKY7OwBaGQ=;
        b=I7CnQOuWj57M+eY5KPLUsxlKb0JE3mtO9u5wKbbUpyvJmy+FSZG+GD25OOiBvunIGK
         Q2dHAsWmeS/qQ2obRvPvqxghBPvmo9xgjx5OjGAKmTc0mkIK9Y/AldxC7enwDlI4MWTt
         nR/l/y/IJF+yvccRElbcBsPK+/7hGdcJeqKbmIc9JCFFuv9oTrEoI0/ujyZ5AvH92wC/
         EWoa3QlfPbYhWYZYHRA9iDFVl9xjc2KK7BL4RV4MYYfzreMAZCNLDg6ZS77C3hgZ8snp
         OZaDgveoVLXlEl2+8JzeckNGBVk4n0JGZzDd/DNEEguY7CzJddiyOUYqxZVM54HziTNG
         FPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJq6auQeIidM24mfR/8eo3ksFWhAxhvnpDKY7OwBaGQ=;
        b=BI6py0GpJnjVHsl2f/RyQetCwqaf4jNUhad65of9wfugO9C1ZgLTnAzh2A+lGAzx/5
         GkJu3sHo+JMHU/NchorAkkOSO6uwD9RLKE79f8993s1LZrW5PaKgF7dhgaxK4EbqpHmo
         Ce6V+qyjg7J/VquwtxfwFkpHkWhDSgS+diZIeuDIVrMNHnGx6eQ88Z7GrWqcwqbf/vY/
         GJKg9L11pyesFlW/MIjAsPS5Ay1Bpi0xkSTK1Lv1wsRTJYyu48NUSTnTAjIvFlPmi9AG
         gt+inEh8EX85SUzURX603XiZ7fvrQ+PzcsdMMRmU1F/vkgbDB3ClLDusjUy3ErWwcWSc
         bVew==
X-Gm-Message-State: AO0yUKWwKZ2IBCRJo9JwX5qZDhw3F+rIrBuci33GeeLInk6FVh8G1aHH
        5YjT4zVi8sFYfWz6O0CNj8kLpqT08rmN
X-Google-Smtp-Source: AK7set+GnZ9gFfxc43R+jNIxKixL5ZeQEmGo9LILMyNpwr7wkrR1rWIpoCob76eZaJRDrU/m7/FQ6z5YBgsq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a81:af07:0:b0:534:2d49:790a with SMTP id
 n7-20020a81af07000000b005342d49790amr113313ywh.0.1676799199716; Sun, 19 Feb
 2023 01:33:19 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:28 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-32-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 31/51] perf vendor events intel: Refresh westmereep-dp events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the westmereep-dp events from 3 to 4. Generation was done
using https://github.com/intel/perfmon.

The most notable change is in corrections to event descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json         | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index bc2c4e756f44..1c6eef118e61 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -28,7 +28,7 @@ GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v54,skylake,core
 GenuineIntel-6-55-[01234],v1.29,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.10,tigerlake,core
-GenuineIntel-6-2C,v3,westmereep-dp,core
+GenuineIntel-6-2C,v4,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 5c897da3cd6b..4dae735fb636 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
@@ -182,7 +182,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "L2 lines alloacated",
+        "BriefDescription": "L2 lines allocated",
         "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index ef635bff1522..f75084309041 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -56,7 +56,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "DTLB misses casued by low part of address",
+        "BriefDescription": "DTLB misses caused by low part of address",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
-- 
2.39.2.637.g21b0678d19-goog

