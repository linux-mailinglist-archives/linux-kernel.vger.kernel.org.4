Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73385F1A36
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJAGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJAGIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:08:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E811AF91C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:07:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 189-20020a2516c6000000b006bbbcc3dd9bso5639229ybw.15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sYSumwi1J3HcBN/q2DeaufGmFH3/CfQMFmLPW058Qnk=;
        b=SF/ngzdkbm+4uolPD5z9riTyqTuyEacPZPaZZoZmWLfXTZX8GDTM4f6K4luf+hX11i
         /+XLx07MkeeEy5FoWbghuD1N513UkF5fyaCR4hW/nCbqYmTb1sU6Rr+KVlFN4wbI6ZMc
         FK/WuNeCNv5sgdeXBjTZJHSbLEf+LItBBdEYr9Id/NFpLLpldG4EL9nSHL39lQrRCNJi
         ufB/gc60eaK/wh5Wk0tb9/XB9K5omyRWbUmCJjJFFTypllDdtM2qJTZ5Vu5wrg+n9YJ5
         3F5DucKWMMtTRue5K89N3rjpJU7xgZnDQRxu7gI2fmDIxf4sCEvfwhSDuLZwnbClK1TE
         Cqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sYSumwi1J3HcBN/q2DeaufGmFH3/CfQMFmLPW058Qnk=;
        b=zO8Tgp6Y6YtfqnaRLRIpWoy77PEyNjqq2AhF1R0jmQskJYWWWvSpfIy87hD94crhcZ
         fOufSH9CbC+TdHfOJaSflq3tdeV7Q6VvMyVQcKpqqWQc2hAyzgyszPs3sY6hZn6sSYFY
         r4SIH8LJXX8M/9WHvFZJTYMQsUkjiN1gEQ3IDuMNaAMvL7qc9xwUiLkKJ6nx0KrQ3iC9
         eK3l0n5Jtuf1+GqSwlmQ1/mTl6o58CL90gy56B7abxosvwA1E7ZeW0tnh+AxCcTNZyYD
         IKnnaYLBbyhKQty8sz0snPecJpjxdEdDccAeEVbXefaPIAw2VWuYZ8icSWoLGeB+kRr0
         uwkw==
X-Gm-Message-State: ACrzQf1UfeN+wKo2so4OW0o81nPjsDMWUFAdGz/O6NQzpQ3W4lQfJGoZ
        dItXGNh4pZgxl7xGDzbV/rM8zAktSxGS
X-Google-Smtp-Source: AMsMyM5speHkAvFFyH4EOcnqJEwnYmY8cZgR0lRS1x6kRJa1jeL7Duf043AaF54+gnnC3+CO2s3fgkQfldMr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a25:a445:0:b0:6af:c2a7:1eea with SMTP id
 f63-20020a25a445000000b006afc2a71eeamr11283695ybi.305.1664604453229; Fri, 30
 Sep 2022 23:07:33 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:33 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-20-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 19/22] perf vendor events: Update silvermont cpuids
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Add cpuid that was added to https://download.01.org/perfmon/mapfile.csv

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c2354e368586..5e609b876790 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.06,sapphirerapids,core
-GenuineIntel-6-(37|4C|4D),v14,silvermont,core
+GenuineIntel-6-(37|4A|4C|4D|5A),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
-- 
2.38.0.rc1.362.ged0d419d3c-goog

