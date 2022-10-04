Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F75F3B54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJDCUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJDCSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:18:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C83ECF7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:17:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f9-20020a25b089000000b006be298e2a8dso710618ybj.20
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sYSumwi1J3HcBN/q2DeaufGmFH3/CfQMFmLPW058Qnk=;
        b=jZPRb5u3x5JknepsPUO/8uO2rxUbgkvJzuGPTBQFXzV2AFqfwRLehso7tcVWi2VTTD
         lm5y6BgAUTnpUXDIR+SzOV8BNm8NgF6e0qP99SuIY8BF0al52B9Ay/BMkEOpjKUDRmav
         sxAmSEuNdzRS+nY9KDrmjl+j5x5JhkviXLzlQ0QvZKAq7vqb1bAyUBfhvPnOi3Abdb42
         P2PhszFHvPSyiTLW1fD7nyht8EZ0m3v+4Tht/yI8XykoOQSMIA+DyMydPqbgLfutcGAb
         5DlkFxxUuCEcamQ0PBYFUAOGFZtPrS4BnqV5ihWpvCJnCOzqm8KvOjrNTwDfmGigjR9J
         KDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sYSumwi1J3HcBN/q2DeaufGmFH3/CfQMFmLPW058Qnk=;
        b=6JauZKUA/YW98FjnxU8wwBPYeUXgy5a2kdsrTqo2V66AimyYHL0X/tVSL+hLXoTyT9
         yXpvutWOMnWPY1tkuOtawr5ZcGHeJDmmpfGCbmUuA7qkOmlN47y92FkWKDZUPW6vGZbY
         8W3+QIt0l1TQPrDNhFdlPju5KMq9VGsGyd9EztHvZ5MCTirZsGBQ5+O0JoOxCYhwSVHk
         kQBhS/Xsszca2WTwabOVw11HHLQ7l8KJzLV5IwE7J2cq6YB7jpuqRkPeZdS05SWNer/6
         XKk8fiuMF6LE+sd8wpOOsRen4PzQZzUfrRER+0kLW9UIKNOZSW75UFsurqb6CCjZdqw3
         m2eQ==
X-Gm-Message-State: ACrzQf2BXc82DDQfQjgGY/V+uyntnsmikTLeCrhPKiW5CHUgR+LF7Tha
        MN14Od9Xt65BsRgEkqWocinYl9NJahAN
X-Google-Smtp-Source: AMsMyM54A1EQxUVPPpqc9L5YVZ3S//pBH/PkCGo4OmjZIg68Ad/CB38UU3TiQO4ImFIRlwG0nUoTFBeKSQin
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:888f:0:b0:6a8:f77c:4f96 with SMTP id
 d15-20020a25888f000000b006a8f77c4f96mr22818856ybl.103.1664849834422; Mon, 03
 Oct 2022 19:17:14 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:16:09 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-21-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 20/23] perf vendor events: Update silvermont cpuids
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

