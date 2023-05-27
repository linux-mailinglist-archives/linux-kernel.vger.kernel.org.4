Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C1713235
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjE0DoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjE0Dnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:43:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA986187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56561689700so33279997b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159028; x=1687751028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX/Sd6Hz8SucmgLLqLgFnj2GhAGV//bvgD4WKofd4fE=;
        b=wq+K9+YK2q2GWtwBQagLJBPoNdupJSt8Trc6Xc2YbvtweMG3pLrGczGpkHj1qdbXEd
         lRlL/TPPGxzEilLsh6ZsHYBHUwIOWtPVFQeGVPtgKj36wPZddikWy7mVpWMogfxGyQji
         zd/5bIWv2LrrAaDp3bQiPUj5eT59sb/hl2zNXTzzpc0/ODlX2/izzmNX6jOttB5Gwvc6
         xC/f0XAHW4TaGswS4OTMY0pixe0MDGKP3sjB63mSc5h65L8m9Uq5ZtMXjFnMt7V62sUh
         AXd4mtf/NiIhG8mK5M6EjCjvV2D6c+BWbhiGC82EFDLucc//Kz6Lfof64TCnQRbVguOA
         K4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159028; x=1687751028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX/Sd6Hz8SucmgLLqLgFnj2GhAGV//bvgD4WKofd4fE=;
        b=GCOuN/pJ34qiFL2CfYybMR8j28MU+6u+9FGDo0jIDfTijg5aBD/OgtqXKy0aYR+Iem
         nhTqrZfPePDztPgQPBwZxWgAoXS6fuu+v5ZltmKFZ5jTklVAi3M28eKgPr5zGg+XGymt
         ywQKKM6MzkNrFnDNv6IJ5wJBPrfbvWoqdFuxNRacihIHyRlS9qVMR49UEH5JIMmqzMeq
         +ap/vzngrTmgaVHMBFRsKjgPRMXGP7XvRUZuC03Ma9ZYJYzdr0mtmZq1QC0Zh1lRH/Jn
         0RJ1EIxsquXF+IbXxPsVcJrCt4gUStYMn57r+RwZ+1xp0ImdSbpx5hFseR4uAbZ4vtNJ
         3jaA==
X-Gm-Message-State: AC+VfDwq73SedkZAo2xpAsYi2jUp3lvZEuM9o9R6Fw20tRrchu6COkfC
        Z+jB71mRc3M2/+70AtYxgEDzTnxsP2Wo
X-Google-Smtp-Source: ACHHUZ6oHxaq/Re3GjQR3B8rFQwiDAFpOTBD4/Os9JJh1F7fFYsEUjt4QQ/nKBe1tBvxls9SJIEZ0Mxvpzpk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ac07:0:b0:565:b269:5ef7 with SMTP id
 k7-20020a81ac07000000b00565b2695ef7mr2190130ywh.1.1685159028067; Fri, 26 May
 2023 20:43:48 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:21 -0700
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
Message-Id: <20230527034324.2597593-4-irogers@google.com>
Mime-Version: 1.0
References: <20230527034324.2597593-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 3/4] perf inject: Lazily allocate event_copy
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_copy is 64kb (PERF_SAMPLE_SIZE_MAX) and stack allocated in
struct perf_inject. It is used for aux events that may not exist in a
file. Make the array allocation lazy to cut down on the stack usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 61766eead4f4..da8c89fefa3a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -122,7 +122,7 @@ struct perf_inject {
 	u64			aux_id;
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
-	char			event_copy[PERF_SAMPLE_MAX_SIZE];
+	char			*event_copy;
 	struct perf_file_section secs[HEADER_FEAT_BITS];
 	struct guest_session	guest_session;
 	struct strlist		*known_build_ids;
@@ -320,8 +320,14 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 {
 	size_t sz1 = sample->aux_sample.data - (void *)event;
 	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
-	union perf_event *ev = (union perf_event *)inject->event_copy;
+	union perf_event *ev;
 
+	if (inject->event_copy == NULL) {
+		inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
+		if (!inject->event_copy)
+			return ERR_PTR(-ENOMEM);
+	}
+	ev = (union perf_event *)inject->event_copy;
 	if (sz1 > event->header.size || sz2 > event->header.size ||
 	    sz1 + sz2 > event->header.size ||
 	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
@@ -357,8 +363,11 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
-	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
+	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+	}
 
 	return perf_event__repipe_synth(tool, event);
 }
@@ -2389,5 +2398,6 @@ int cmd_inject(int argc, const char **argv)
 	if (!inject.in_place_update)
 		perf_data__close(&inject.output);
 	free(inject.itrace_synth_opts.vm_tm_corr_args);
+	free(inject.event_copy);
 	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

