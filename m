Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E05BB1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIPR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIPR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:59:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235BCB6549;
        Fri, 16 Sep 2022 10:59:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f23so5892699plr.6;
        Fri, 16 Sep 2022 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=fHUO/tTSXGwAYWJl/h0HUVhnDEOopzy02qV2Gf5LuFs=;
        b=ZK8zrdV8d0dwJcFEu5/64qRd9FaeNiefq6CFkl68lXUVMTGfBNgbTNYZOauC+hVTGb
         6y3x1XM2mryd1E+ITjTL7KfeRyHT2WSSTHx4gEomFsbrp/f5BU0OetLFSFX6dP7HIiBp
         Thhskg2kZzIJc15fkUg1C7eTdCqioUhXM/C2GcvPk8MyjRvX7gHduphw87kgv4FNWuXK
         +ZLCqZT1yhPK84NWUoTvWNR4UvEBgD3l/C58T5otxKUMPmAB+YslGUyFUZZImp6H7n5G
         KXgN9mMP3mOQGWjQtaNLzSmy7pyPDb0se+vqmWilst4S8EF73NHPDLTmJy/OVpVAuYnI
         lIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=fHUO/tTSXGwAYWJl/h0HUVhnDEOopzy02qV2Gf5LuFs=;
        b=RgleZHHXzA1QNox/OiJtmxPuMlCy1q5QA38sSMw+IUlRW5CeKrgDdL+XxXkSUtCwsc
         EndCIIy6iu6RNHdGGfNN40Zue0jLgS5DznUk+RRS9t2+luG/FOjbO0rqBR3jmWiqaIWO
         2k8VZ8ZA5m1c9BAhTopi78appO8fjbHoJVOnJHNouX/wj8lTdMAlZc6SG4UKePVck3nf
         aZTZ355cjBItgnbx0A1elqr8W02m6thoCTSV5HhATHL4G91FzRWaCD1KMn0toBT5EC+j
         olTT/LO9j1OE2ZO4Cf/rh/N6U+5uU5d4t/Wytb4Fzx9RuRiuQt/rLyKysRr5lV9WKpBi
         Fz0g==
X-Gm-Message-State: ACrzQf2zFy4hfsEbcp+pkn6/oivGhAnVu4KU7NH+dzlSZFfKFHjGty/T
        8rt8N5vBwA/4vEqynL+LeSs=
X-Google-Smtp-Source: AMsMyM4dG4hKzttcx8sac4yQPxAuCp9N3g0k99zv9hMicHD8V+S5LpjBV8yGirFLASDCHSHrpRFvYg==
X-Received: by 2002:a17:902:cec1:b0:178:cdb:8458 with SMTP id d1-20020a170902cec100b001780cdb8458mr962068plg.161.1663351147621;
        Fri, 16 Sep 2022 10:59:07 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id jo21-20020a170903055500b001767f6f04efsm15059458plb.242.2022.09.16.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:59:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf tools: Add perf_event__synthesize_{start,stop}()
Date:   Fri, 16 Sep 2022 10:59:00 -0700
Message-Id: <20220916175902.1155177-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220916175902.1155177-1-namhyung@kernel.org>
References: <20220916175902.1155177-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are to prepare and cleanup necessary work for synthesizing.
It doesn't do anything yet but later patch will add it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c        | 3 +++
 tools/perf/builtin-record.c        | 3 +++
 tools/perf/builtin-stat.c          | 2 ++
 tools/perf/builtin-top.c           | 4 ++++
 tools/perf/util/auxtrace.c         | 2 ++
 tools/perf/util/synthetic-events.c | 8 ++++++++
 tools/perf/util/synthetic-events.h | 3 +++
 7 files changed, 25 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index e254f18986f7..2e91a887919b 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2368,9 +2368,12 @@ int cmd_inject(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
+	perf_event__synthesize_start();
+
 	ret = __cmd_inject(&inject);
 
 	guest_session__exit(&inject.guest_session);
+	perf_event__synthesize_stop();
 
 out_delete:
 	strlist__delete(inject.known_build_ids);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02e38f50a138..5b7b9ad2a280 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1966,6 +1966,8 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (rec->opts.tail_synthesize != tail)
 		return 0;
 
+	perf_event__synthesize_start();
+
 	if (data->is_pipe) {
 		err = perf_event__synthesize_for_pipe(tool, session, data,
 						      process_synthesized_event);
@@ -2072,6 +2074,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 out:
+	perf_event__synthesize_stop();
 	return err;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e05fe72c1d87..f6f61e08f4c2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -962,6 +962,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
+		perf_event__synthesize_start();
 		err = perf_event__synthesize_stat_events(&stat_config, NULL, evsel_list,
 							 process_synthesized_event, is_pipe);
 		if (err < 0)
@@ -2641,6 +2642,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
+		perf_event__synthesize_stop();
 		evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e89208b4ad4b..1eff894e6b5f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1258,6 +1258,8 @@ static int __cmd_top(struct perf_top *top)
 #endif
 	}
 
+	perf_event__synthesize_start();
+
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
@@ -1273,6 +1275,8 @@ static int __cmd_top(struct perf_top *top)
 				    top->evlist->core.threads, true, false,
 				    top->nr_threads_synthesize);
 
+	perf_event__synthesize_stop();
+
 	if (top->nr_threads_synthesize > 1)
 		perf_set_singlethreaded();
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b59c278fe9ed..1bfe076c22fb 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1328,6 +1328,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	if (err)
 		return err;
 
+	perf_event__synthesize_start();
 	unleader_auxtrace(session);
 
 	return 0;
@@ -2834,6 +2835,7 @@ void auxtrace__free(struct perf_session *session)
 	if (!session->auxtrace)
 		return;
 
+	perf_event__synthesize_stop();
 	return session->auxtrace->free(session);
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0ff57ca24577..9d4f5dacd154 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -47,6 +47,14 @@
 
 unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
 
+void perf_event__synthesize_start(void)
+{
+}
+
+void perf_event__synthesize_stop(void)
+{
+}
+
 int perf_tool__process_synth_event(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct machine *machine,
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 53737d1619a4..e4414616080c 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -43,6 +43,9 @@ int parse_synth_opt(char *str);
 typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *event,
 				     struct perf_sample *sample, struct machine *machine);
 
+void perf_event__synthesize_start(void);
+void perf_event__synthesize_stop(void);
+
 int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
 int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
-- 
2.37.3.968.ga6b4b080e4-goog

