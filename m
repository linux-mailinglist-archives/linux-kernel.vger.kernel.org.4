Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602AE728BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjFHXaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjFHX3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B430DF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5651d8acfe2so16060677b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266971; x=1688858971;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YK7vivTUvVnngeLWzmeZQ8bqT/OVbRyCOXzMTcRsZMs=;
        b=h0zjH+hUAGfTVAZ7FUCUWS+twdPiVH3SkQmolEIxSW6NKYWlfbX93GzrWc0xPE87rf
         GCtKAcWHTFnmrRx0x6g+aMCnF7/smB+83LTuyDWpYDRcBrXRI/peA8iy6uqEdPuoCgj1
         mPwWGkuikA6MRqCdj7bkDOG2NI8ry+HbmvIEhZhn1iD9NXqlyOaZpSxwAplOp0GWqF7z
         h5TYTJfZ7Jeg/PmuzM79qNA7lNueWIaXYZdQqBZO3NpBdb7VYJ4HTbfCk4DNYH3QTFZW
         3PgUNJ4Hc4UT5cofyQPEGCkxVMzE1BLJp/+LuT/CPLshhnrbL8XBMMKqqmuVgW9aQ3vW
         4uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266971; x=1688858971;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK7vivTUvVnngeLWzmeZQ8bqT/OVbRyCOXzMTcRsZMs=;
        b=h8daY1fh1vckIMv9Kd+tW6fo3Tpwqj2eI7X7PnisT+qvvtrpbJsz8dht5xQMcGsSUv
         IffkUu5TJhih1CAv1A3peahcfaNP18Ecrr3Gs9y16H0HwxrlMazcXAB5fmCRej26o3iY
         +Kkc1eoYxjQTEKAfcy/ig6e1etao9lqQDh0j5AETwxR8FC78UO+j68Q3EzZ4LU7L4kuW
         uww9096R5/ipOLt8Rtn8ThljWV6X5c8zqHJHrhAhVe87f715Dw4cJflhu5ebBtuCHvmj
         txpNQcCIYaoT85eTrGAF9swKEwn5LjzwirVBlAQylLKDNRpJfPjwhpukGa4pznwgqIPB
         EFdA==
X-Gm-Message-State: AC+VfDxlkPhu4y/5npVI9xS9WSYGFHMUZfnH5aUuP7G06zYD/RnXJrNl
        ppaCBjlMpBzeVJX3vZr0FAHdJKDAcZCW
X-Google-Smtp-Source: ACHHUZ7lFo/l4NRGaS+SLLEGSLVGTsSlh5Hy8OpV3peTtU6WbuCKJ2Yl1mIVlrFEjceAhvhpmJc2Y0yNelZO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ad59:0:b0:561:c9c0:98d9 with SMTP id
 l25-20020a81ad59000000b00561c9c098d9mr673787ywk.4.1686266971518; Thu, 08 Jun
 2023 16:29:31 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:05 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-9-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 08/26] perf machine: Make delete_threads part of machine__exit
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

The code required threads to be deleted before machine__exit was
called or the threads would be leaked. This was error prone so move
the delete_threads into machine__exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c       | 1 -
 tools/perf/tests/dwarf-unwind.c       | 1 -
 tools/perf/tests/mmap-thread-lookup.c | 1 -
 tools/perf/tests/symbols.c            | 1 -
 tools/perf/util/machine.c             | 1 +
 tools/perf/util/session.c             | 6 ------
 6 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 2a7b2b6f5286..ed3815163d1b 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -721,7 +721,6 @@ static int do_test_code_reading(bool try_kcore)
 	evlist__delete(evlist);
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
-	machine__delete_threads(machine);
 	machine__delete(machine);
 
 	return err;
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index ee983b677a6a..d01aa931fe81 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -235,7 +235,6 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 	thread__put(thread);
 
  out:
-	machine__delete_threads(machine);
 	machine__delete(machine);
 	return err;
 }
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 3891a2a3b46f..ddd1da9a4ba9 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -208,7 +208,6 @@ static int mmap_events(synth_cb synth)
 		addr_location__exit(&al);
 	}
 
-	machine__delete_threads(machine);
 	machine__delete(machine);
 	return err;
 }
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 2d1aa42d36a9..16e1c5502b09 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -38,7 +38,6 @@ static int init_test_info(struct test_info *ti)
 static void exit_test_info(struct test_info *ti)
 {
 	thread__put(ti->thread);
-	machine__delete_threads(ti->machine);
 	machine__delete(ti->machine);
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 261188766307..46af5e9748c9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -256,6 +256,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
 
+	machine__delete_threads(machine);
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 65ac9f7fdf7e..00d18c74c090 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -278,11 +278,6 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	return ERR_PTR(ret);
 }
 
-static void perf_session__delete_threads(struct perf_session *session)
-{
-	machine__delete_threads(&session->machines.host);
-}
-
 static void perf_decomp__release_events(struct decomp *next)
 {
 	struct decomp *decomp;
@@ -305,7 +300,6 @@ void perf_session__delete(struct perf_session *session)
 	auxtrace__free(session);
 	auxtrace_index__free(&session->auxtrace_index);
 	perf_session__destroy_kernel_maps(session);
-	perf_session__delete_threads(session);
 	perf_decomp__release_events(session->decomp_data.decomp);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
-- 
2.41.0.162.gfafddb0af9-goog

