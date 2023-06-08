Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C28728BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjFHXbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjFHXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C35E35A3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:30:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568fa455b8fso15305717b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267008; x=1688859008;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0KYgNGPVbef0yxFQzrQIBdU6DpVCEwayIrlyOXU5ig=;
        b=2tVEOfRMr9BaVlInmIrt6A8s/2SaJVEmRq0V2ofDi/ugL0FqWxUFVaSl7oU/tIkKNr
         iyYTqNN6gaPCB6BDG4Oar1eMUgEJzu1pJfmbSSAH9QS6oDqzi3hP3T3BIaaDXdYGtylM
         fslrT25m/eatU6xm7/7y2HZJh13Mp1sDozMho5OtVtalzcgWIZ3XV36U4WJJKsgxsaJM
         zBvMGzzY+BgMcHash2dFDF0vYoz3jRmw1vSdOAGPhbOly7L0MM94sh6yjpCMMdW1LX4+
         UrgKwN0Y2LcUS3wa/aKLU2Q4oZzn3p68Qr9hudfcH23XckDQYZnScPNcvMfzPW+NzpDe
         I8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267008; x=1688859008;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0KYgNGPVbef0yxFQzrQIBdU6DpVCEwayIrlyOXU5ig=;
        b=WaO3DggsotZrjNksvgCpf11NzIpv1x+Pi7Vhk5pAujAUXiIjyDMLXfLd/y3jI0vVjq
         sr780WQ2ZhE6vLcJtZlGeo8GZW8sMRBC3PSQkWyAxISCpbIyLXarUQuvWfd23bsfdfJm
         DMOJ7bbyW9834oG+lBqLK9ep5lr0SNtM5RiyMS32j/x/sxXADxQKqTvnO+49+KQxrivc
         z171XIsAw0Qof3mEDLphENZzHikFSmXgwdVG2OUO1NGbnDnlJj3xlzzYmjvl816sj11n
         u86luNdFX3tJmAnWdBeKCguDdwT/PL894GhaM0jU/t/3Uf0r7IKmzKGBH6/OnPWJ0R5t
         VqSQ==
X-Gm-Message-State: AC+VfDwzENaksz8mK0MI3/SYsLMC7Sgbji6F8MUbIm8Bqgic9s1dcP05
        YN3+LZx/+sjLYsm8Bvqo+eYabmIO8J/y
X-Google-Smtp-Source: ACHHUZ4xbu2nLPZfhvS6QmOV47vNfVRrhKEnpGCx8uSLcUdi8ahGG+FywCSAEA5a+AEVc8L9iatZo1ygXjai
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ac43:0:b0:568:9bcc:5e16 with SMTP id
 z3-20020a81ac43000000b005689bcc5e16mr629708ywj.2.1686267008171; Thu, 08 Jun
 2023 16:30:08 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:20 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-24-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 23/26] perf header: Avoid out-of-bounds read
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel-pt tests were failing:
```
...
--- Test virtual LBR ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.126 MB /tmp/perf-test-intel-pt-sh.FW57CXnCqQ/test-perf.data ]
Failed with virtual lbr
...
```

The root cause is an out-of-bounds read in header (where maxbrstack.py
is from test_intel_pt.sh):
```
$ perf --no-pager script --itrace=L -s maxbrstack.py
=================================================================
==3907930==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000095a8 at pc 0x563c26c840bb bp 0x7fff43582710 sp 0x7fff43582708
READ of size 4 at 0x6020000095a8 thread T0
    #0 0x563c26c840ba in process_group_desc util/header.c:2847
    #1 0x563c26c8bc78 in perf_file_section__process util/header.c:4037
    #2 0x563c26c8aa9b in perf_header__process_sections util/header.c:3813
    #3 0x563c26c8d028 in perf_session__read_header util/header.c:4286
    #4 0x563c26cbab29 in perf_session__open util/session.c:113
    #5 0x563c26cbb3d0 in __perf_session__new util/session.c:221
    #6 0x563c26aacb14 in perf_session__new util/session.h:73
    #7 0x563c26acf7f1 in cmd_script tools/perf/builtin-script.c:4212
    #8 0x563c26bb58ff in run_builtin tools/perf/perf.c:323
    #9 0x563c26bb5e70 in handle_internal_command tools/perf/perf.c:377
    #10 0x563c26bb6238 in run_argv tools/perf/perf.c:421
    #11 0x563c26bb67a0 in main tools/perf/perf.c:537
    #12 0x7f34bde46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #13 0x7f34bde46244 in __libc_start_main_impl ../csu/libc-start.c:381
    #14 0x563c26a33390 in _start (/tmp/perf/perf+0x1eb390)

0x6020000095a8 is located 8 bytes to the right of 16-byte region [0x602000009590,0x6020000095a0)
allocated by thread T0 here:
    #0 0x7f34beeb83b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x563c26c83df8 in process_group_desc util/header.c:2824
    #2 0x563c26c8bc78 in perf_file_section__process util/header.c:4037
    #3 0x563c26c8aa9b in perf_header__process_sections util/header.c:3813
    #4 0x563c26c8d028 in perf_session__read_header util/header.c:4286
    #5 0x563c26cbab29 in perf_session__open util/session.c:113
    #6 0x563c26cbb3d0 in __perf_session__new util/session.c:221
    #7 0x563c26aacb14 in perf_session__new util/session.h:73
    #8 0x563c26acf7f1 in cmd_script tools/perf/builtin-script.c:4212
    #9 0x563c26bb58ff in run_builtin tools/perf/perf.c:323
    #10 0x563c26bb5e70 in handle_internal_command tools/perf/perf.c:377
    #11 0x563c26bb6238 in run_argv tools/perf/perf.c:421
    #12 0x563c26bb67a0 in main tools/perf/perf.c:537
    #13 0x7f34bde46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
```

Avoid the out-of-bounds read checking for the leader. Leave the 'nr'
check intact as nr will be 0 or the counting down and evsel be a group
member.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3db7c1fae71e..52fbf526fe74 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2844,7 +2844,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 
 	i = nr = 0;
 	evlist__for_each_entry(session->evlist, evsel) {
-		if (evsel->core.idx == (int) desc[i].leader_idx) {
+		if (i < nr_groups && evsel->core.idx == (int) desc[i].leader_idx) {
 			evsel__set_leader(evsel, evsel);
 			/* {anon_group} is a dummy name */
 			if (strcmp(desc[i].name, "{anon_group}")) {
-- 
2.41.0.162.gfafddb0af9-goog

