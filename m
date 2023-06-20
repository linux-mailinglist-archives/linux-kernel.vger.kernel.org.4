Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48C7375F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFTUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFTUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6E1BDA;
        Tue, 20 Jun 2023 13:18:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b52bf6e669so41270815ad.2;
        Tue, 20 Jun 2023 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292302; x=1689884302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d5/yApfhsMQixM8RWfKiFMt1LEPDQuyjPU1y1ZmVQw=;
        b=J0izd5y9xfFGM+eE/ia0pKix6/OZlMR3fuhavOMI2YEVGxpjkbUTkmGSmo271MaVca
         HRW/lwoq+IyuD33urtnvtYaDcCe2bYxlkDDotb6ystrdC++mzTEwnqvazYGZUtQ3ZdUn
         W+fPxuuSgQXMtx/5gr1Nuoc6MUdxbCGpdPbf0XUhNPL4/gfmwkvfjlmeqaNF8fKV/Zwr
         EHPEiB8f6z1jmvxeX0ECy5cGOmyORzUb+MApJxpju2TRUt6eAs86Tfv5ZQV+TbQnKnLg
         VUDtm+F0v56ClSpXcLPrJJlrcMG61uTVJCpHLl0CvZk9ZCQKkcVTNgrSVR0FQRbx4rdT
         6ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292302; x=1689884302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0d5/yApfhsMQixM8RWfKiFMt1LEPDQuyjPU1y1ZmVQw=;
        b=Va+Wrv5/vxzNTu731uq9CFDwQz8DiA9a7eiEOJ+3eGH4AP57k8RGET70maLYTNZEsd
         WXKeO9THirhQ9JqbVKqdfwEyPZFRjW87t5FR0yxMcG+s6uH+oupo1wtIcEQd2+jtiGrC
         v9R8t4jQPCmfuc4Wleo9a944K1tjMLVkCP8O+rs4cjaQnT10dzTK7grKlAItPuFSCrAZ
         UsHuGSmibK5MrVPPFIfFRx8+Jham5ypsxjSj4omQ2eOmWZ8KEnxzZIp6sqsZMtaSR+LF
         OwoW2OscCXDoE/pV+lbktSp0ygZmJf7jAwVaFZwFzFuuDJNFTrexvSzqbd2BYy9SWztE
         Ufvw==
X-Gm-Message-State: AC+VfDxCaPCklO/CorVCP+ok+3demssDn1TP2AZMQRx6UQ9EjfQJ6YYX
        rc4R5gcGeW+/kNS/3LJ1Z/O2Oz3AfAI=
X-Google-Smtp-Source: ACHHUZ5uH9YTS7+ks0EfKy8zZV56m6oFNmMCp/FeSLcbSM80WbhjQh4FNsfTak7/L0YwpsZdUqPimw==
X-Received: by 2002:a17:90b:3590:b0:25c:2dc:361f with SMTP id mm16-20020a17090b359000b0025c02dc361fmr13109933pjb.31.1687292302283;
        Tue, 20 Jun 2023 13:18:22 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:2824:dc1c:af73:dbd8])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a01db00b0025c23bb7fdasm8191774pjd.16.2023.06.20.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:18:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf tools: Add kallsyms__get_symbol_start()
Date:   Tue, 20 Jun 2023 13:18:17 -0700
Message-ID: <20230620201818.1670753-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
In-Reply-To: <20230620201818.1670753-1-namhyung@kernel.org>
References: <20230620201818.1670753-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kallsyms__get_symbol_start() to get any symbol address from
kallsyms.  The existing kallsyms__get_function_start() only allows text
symbols so create this to allow data symbols too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/event.c | 30 +++++++++++++++++++++++++++---
 tools/perf/util/event.h |  2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3860b0c74829..6fdda0eb3854 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -93,8 +93,8 @@ struct process_symbol_args {
 	u64	   start;
 };
 
-static int find_symbol_cb(void *arg, const char *name, char type,
-			  u64 start)
+static int find_func_symbol_cb(void *arg, const char *name, char type,
+			       u64 start)
 {
 	struct process_symbol_args *args = arg;
 
@@ -110,12 +110,36 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 	return 1;
 }
 
+static int find_any_symbol_cb(void *arg, const char *name,
+			      char type __maybe_unused, u64 start)
+{
+	struct process_symbol_args *args = arg;
+
+	if (strcmp(name, args->name))
+		return 0;
+
+	args->start = start;
+	return 1;
+}
+
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr)
 {
 	struct process_symbol_args args = { .name = symbol_name, };
 
-	if (kallsyms__parse(kallsyms_filename, &args, find_symbol_cb) <= 0)
+	if (kallsyms__parse(kallsyms_filename, &args, find_func_symbol_cb) <= 0)
+		return -1;
+
+	*addr = args.start;
+	return 0;
+}
+
+int kallsyms__get_symbol_start(const char *kallsyms_filename,
+			       const char *symbol_name, u64 *addr)
+{
+	struct process_symbol_args args = { .name = symbol_name, };
+
+	if (kallsyms__parse(kallsyms_filename, &args, find_any_symbol_cb) <= 0)
 		return -1;
 
 	*addr = args.start;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index de20e01c9d72..d8bcee2e9b93 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -360,6 +360,8 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr);
+int kallsyms__get_symbol_start(const char *kallsyms_filename,
+			       const char *symbol_name, u64 *addr);
 
 void event_attr_init(struct perf_event_attr *attr);
 
-- 
2.41.0.185.g7c58973941-goog

