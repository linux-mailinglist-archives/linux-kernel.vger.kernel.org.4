Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A406A2E29
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBZEXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjBZEWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:22:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372BE13D44
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:22:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so2347174pjg.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcYnfVUhbZn9a7DJQxPts8NFnTbESI3ZdIxOG6ZSYi4=;
        b=fceagpisfJ+wn/x77XGmDDqUVFSi3OWTNsoYpFBrTZjqv2xkLCv1w5L27riERthRf8
         FIEY8T7qN+Pe7NBaP8MHQ/Y8FDJajeeSzl+LaqP1neHfuMc1a0pyiikI0DIKUMqWcPkY
         f1KpBGfri+w/ZdDYg/IDgUIpnMDUx7FfFtGip+MYx573MaGUVMhTODQ6B6rCf16A0mbQ
         uB9HpdKTdhBmUx4WD9kvKpCMuy9yVDLgg/l3LPjgd+7buFaOqE2pnSjB7ia4Dv4PqsEf
         ldvtLxiCPXLZVhkSy6+AbsNx+8QqnA4KVYu43bLYTqqWEBQd3dfbKyo5w7PCTXjjo+wF
         cJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcYnfVUhbZn9a7DJQxPts8NFnTbESI3ZdIxOG6ZSYi4=;
        b=2Uky59KA7vAtkmAO3HHyjcVC/lIhSfjcVo2/+pmUrFaGfDNZ6+GNQMSDpaOUTGYavI
         0U+LGyxEpUVSe4OgGsDGZuQGY0xVHGW1HS33HBxkhSC0YsQ/Q/KWL7aFkIem/1hFqBMJ
         eILok8rMYrqmvt+8L20C5MMLCMJANykwyrOHTWv4Layhh6+dRdTzFramHbdfF88R7ogb
         tkLcseZzzaS4BkKS84PF2rUlFg2vLf96WxbZ2i5SxrJlFT3ev4vL2DU35hGDMlUzpCBm
         xEq/YAHQE2hcnCR7bjQ6pzxVXSLbtDWULta0E324ILUmVIa16O1syUPM04KAGen295ZO
         UFMw==
X-Gm-Message-State: AO0yUKVDhiobFIl5v7oK5i99HDKCRJIM0CCgIPkj8LlO3K4kqUgrXGTt
        VIwSGlEU20IqQN3DpUYg51nLOQ==
X-Google-Smtp-Source: AK7set/wjYcidWUkA1Sa4dOdMpzYNSexL+23YhqQW9e2pz2wjJxSVS8TjvLVL2MzEF2/NDE9ul1h7A==
X-Received: by 2002:a17:903:6c5:b0:19c:c184:d211 with SMTP id kj5-20020a17090306c500b0019cc184d211mr7175760plb.37.1677385319973;
        Sat, 25 Feb 2023 20:21:59 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 14/14] perf kvm: Update documentation to reflect new changes
Date:   Sun, 26 Feb 2023 12:20:53 +0800
Message-Id: <20230226042053.1492409-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation for new sorting and option '--stdio'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-kvm.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 2ad3f5d9f72b..b66be66fe836 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -58,7 +58,7 @@ There are a couple of variants of perf kvm:
   events.
 
   'perf kvm stat report' reports statistical data which includes events
-  handled time, samples, and so on.
+  handled sample, percent_sample, time, percent_time, max_t, min_t, mean_t.
 
   'perf kvm stat live' reports statistical data in a live mode (similar to
   record + report but with statistical data updated live at a given display
@@ -82,6 +82,8 @@ OPTIONS
 :GMEXAMPLESUBCMD: top
 include::guest-files.txt[]
 
+--stdio:: Use the stdio interface.
+
 -v::
 --verbose::
 	Be more verbose (show counter open errors, etc).
@@ -97,7 +99,10 @@ STAT REPORT OPTIONS
 -k::
 --key=<value>::
        Sorting key. Possible values: sample (default, sort by samples
-       number), time (sort by average time).
+       number), percent_sample (sort by sample percentage), time
+       (sort by average time), precent_time (sort by time percentage),
+       max_t (sort by maximum time), min_t (sort by minimum time), mean_t
+       (sort by mean time).
 -p::
 --pid=::
     Analyze events only for given process ID(s) (comma separated list).
-- 
2.34.1

