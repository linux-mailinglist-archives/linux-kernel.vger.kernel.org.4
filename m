Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3D57251C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbjFGBrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbjFGBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D91BF9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c3186735so9778698276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102268; x=1688694268;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJ2OPYAP9pB8vrb9qIB3sLOwmfkcGiNuw8r6PERGS84=;
        b=B8I9I+yDKZTdJ8gUrIclhwWGzn5LBWsOvjHWgvVuS1mvSquoEfaeNS+jzHqvDB75R/
         UtBm4yxw9/eQCV7zn/6hxNer6efifcoUmb+gfVXT/1o5m246qkKGWNCNnKtgE5j7Pkj5
         4bqupEMTlqIvbbyVdZJhsSHMaPCWoZ/KbZEtgH6wRPlBDB4w26AWCf0wBB1DRNGJzN/i
         yBcRC5G7JTHsvWVYITou6ggyhvplc1S53GK7szEviN2cSQutpD55u10619PfGbj1cx5e
         3O1N99fmBZWpHp4hiHu7lTX/HggzynVc3aCm6WKdJZJH7Hov95MYgolhMtm2Rm/hlw3p
         1KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102268; x=1688694268;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ2OPYAP9pB8vrb9qIB3sLOwmfkcGiNuw8r6PERGS84=;
        b=VPpekpxhp40fc0Qyphg2Mribja0aLm5eWFlQyqbJIE12LSGmHnU3vLb5wsdZl/czdh
         2XVWcw00I2f7rtr7QgiWohtundo3zhAS3/McW9+buntfaz93LZ3LwZS5PeCxTcf5Ep+j
         td2j+1j4e+YkO4V84l6x7p+GZJV6Q0krgg3McaGwuaT2E81ZjG8XDAh/kcn5iZ7HKSPA
         AqiegZaE0rH/Ru2B7cT5BFRNARCl0PlCvWa5z8KYEfZkjNTxvy8Myl7zdFB8w8Ch2x+k
         d4uvYEn3HSMxPjZYWtIEYtm4u1v54sFwu3TwjFh6v6gY65bo+xAj5VbywL+0FCtiOiJd
         +Hww==
X-Gm-Message-State: AC+VfDyPVqHv0+GAD+6+66RyyWTmv6cPGlXJtCytQaNTutCKzgZKcCLw
        kGGYVmK52444zkfZwALvMOSXUuFRWW7G
X-Google-Smtp-Source: ACHHUZ4gYNpXehdhphTvvFWdPzFHp4aVmEg/KShdENcqgQVXycnkcHBLGPhJM/tCXdSAjDj9AtNa07VJSAxl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:ba7:5bec:7772 with SMTP
 id s6-20020a056902120600b00ba75bec7772mr1435280ybu.5.1686102268654; Tue, 06
 Jun 2023 18:44:28 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:41 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-9-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 08/20] perf machine: Make delete_threads part of machine__exit
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
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
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
2.41.0.rc0.172.g3f132b7071-goog

