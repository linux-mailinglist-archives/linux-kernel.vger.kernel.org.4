Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D725FD26A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJMBOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJMBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:13:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1099EE896
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:12:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3584be56efbso4351347b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xB/fjxCIuEPVddXhgzv03MPEwlnMB5S9ZmYcU1XmGCs=;
        b=KUw9ui6TnrX56TpGS2Iv2mQN2cchBGSjKmxfguEygqPxptwa6i+n8QyS3i4j77YBKt
         2JQoSPGujOEs/sIABcUgMCpYULW5qIXshnDd43bM81LET3CcCFd9Vjym1M3RyIb8M/TU
         q6uLyoxOgPLBBxGL39Mpy8f+cz90HpaTO3etsQw0Fmo3Pzrw/DB5PbXlc6cv2VfzH8Qu
         urG94jRJiE4i3UWVfR8n55vz4KEI5AwuS5BjJNievyzmYtz596gdWFzkm2I7Lysu0ps5
         XJmIoqYrEIlbXqjw74nXVPRAfnFKi1ldvbbP8W53siPHZGHDI0fmj/n7eyeP801T7Q+K
         Hj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB/fjxCIuEPVddXhgzv03MPEwlnMB5S9ZmYcU1XmGCs=;
        b=fHjsfC/dRx+S3n1ZbxQ8bsk5W+ywmMrAcyw3I5v5gbv2mQoDFKhHAa6957Ez/g28vD
         JFnFOWIiKkd2bNhViUzCArIvqLGmbXI4/iiNn2H7txLQvWPA8lcQWZkwJ2bG5duO87T5
         LABFGzfNgnqr4WFimoW4tqqCLgfBjtAi9Z8VLM2ANSaw67uZR9vUb3olgXoUw8h1kGA8
         KEdlgFq9NYW8RncP6/p/RbgtsxRDxA9dNZGvGpG2ikKIBAeZ8+H41VSvdVf1qUTLDEuE
         M2XhIZ4pVMzSYw0oMHgl1uAqN7TGHzEkXGoU1WoEnadl2cHAvZSvYsrypkLdI3v/vAfI
         tO+w==
X-Gm-Message-State: ACrzQf3Jz0usbrBnaI0rpePH5zsIfKxdSmAsCAXrrv5nx/r+CALbyJG1
        f1y3GrZfU/mFPHrlHje2mOANJUCTARNz
X-Google-Smtp-Source: AMsMyM57YbpRje9UeRlApfmYiHxHD90M/b6u7xr2uoI1gvqHSJDbLet+EBTWvQta88ANjIM0fHSteBzHZyHE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7556:8a83:fe48:3afe])
 (user=irogers job=sendgmr) by 2002:a0d:ddc6:0:b0:35b:fdb5:ce7a with SMTP id
 g189-20020a0dddc6000000b0035bfdb5ce7amr29077443ywe.360.1665623530409; Wed, 12
 Oct 2022 18:12:10 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:12:05 -0700
Message-Id: <20221013011205.3151391-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v1] perf test: Parse events workaround for dash/minus
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>
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

Skip an event configuration for event names with a dash/minus in them.
Events with a dash/minus in their name cause parsing issues as legacy
encoding of events would use a dash/minus as a separator. The parser
separates events with dashes into prefixes and suffixes and then
recombines them. Unfortunately if an event has part of its name that
matches a legacy token then the recombining fails. This is seen for
branch-brs where branch is a legacy token. branch-brs was introduced
to sysfs in:
https://lore.kernel.org/all/20220322221517.2510440-5-eranian@google.com/
The failure is shown below as well as the workaround to use a config
where the dash/minus isn't treated specially:

```
$ perf stat -e branch-brs true
event syntax error: 'branch-brs'
                           \___ parser error

$ perf stat -e cpu/branch-brs/ true

 Performance counter stats for 'true':

            46,179      cpu/branch-brs/
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 459afdb256a1..3440dd2616b0 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2237,6 +2237,19 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 			pr_debug("Test PMU event failed for '%s'", name);
 			ret = combine_test_results(ret, test_ret);
 		}
+		/*
+		 * Names containing '-' are recognized as prefixes and suffixes
+		 * due to '-' being a legacy PMU separator. This fails when the
+		 * prefix or suffix collides with an existing legacy token. For
+		 * example, branch-brs has a prefix (branch) that collides with
+		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
+		 * isn't expected after this. As event names in the config
+		 * slashes are allowed a '-' in the name we check this works
+		 * above.
+		 */
+		if (strchr(ent->d_name, '-'))
+			continue;
+
 		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
 		e.name  = name;
 		e.check = test__checkevent_pmu_events_mix;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

