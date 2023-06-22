Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46AF73AD7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFVXyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:54:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77086E2;
        Thu, 22 Jun 2023 16:54:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55380677566so87473a12.3;
        Thu, 22 Jun 2023 16:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687478041; x=1690070041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ksBLqNKBO4J8kF2eXugFQJe+kLzvp++pK53UdvfHMJY=;
        b=ejYDdRlY75DQN8zpjRKoeSUlTSQ4SifCw4p1CQSfTptXaIX767i+i7Xl2fqJIuhTn6
         uHNaT8AUX0e3J9GWJ+vDCnlIhIfbd2Guxgt8jPQzkuGIOfyvoxiYGNqQaJBofXF7xx0Z
         tjHKPV7A5xB8NcdBktRbjdRmjzu0vvJUKWlQQ8pL8R3oM+sFdea7xTHOA71XaNyptcMk
         sYbt2C+GxLjfc3PP2dbRTyqXhdrjpu4Z+T4xsTFNcpvMun5pjj4fqDh+M1RKTuPqOl9h
         ewSKxcs4RveEOTNm5pHLhINBfp3bUfzX9ZIZrsx/XcJXffTFgGzaMHBHal51Vt606uxN
         ovgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687478041; x=1690070041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksBLqNKBO4J8kF2eXugFQJe+kLzvp++pK53UdvfHMJY=;
        b=ehKX6tXgiUUDU9eCTR636OYXTfAaqorgqzXX+6buVU26XE0x+fDE9SaNyDUF5qMFTf
         CPa+hdeQrA2Vu9/xSuVRlkDfSFLp8SLcyheiTxIWCF2Knv8JskdAi8YQ3qjQmekOUYEG
         6Icr/0nBnOP7+jpqKqlUQhoolkEteg37sRtWsLWUkS6KUEt0Cukm1UQ1WjL6b9DkRqUd
         gSlUhalMnCYPo5MYBMsB8wbPtoMAtWjBpIYhy2d53Fcom9btjEknCkSgYF/aIF5fXMx6
         dQ9cnJfIzAhPmbDIll9sXcvLDOyzTptEEb56YVcN1wjy+bd17nGMMsJCvwUqQzlgaEXr
         7APw==
X-Gm-Message-State: AC+VfDzQgbimEeLfOZrDKnYOXLXjkx5Je513khxYEbkvK+Az1pE/DWlV
        rG0D/fkQp8awf/rDFqf37lU=
X-Google-Smtp-Source: ACHHUZ7GwDQa1PoYGzYhSI8I6TvhSV+qEC8DhGAbowgi+cvMqf3XAiJFmXRaoukKGY+pWol04DAdsw==
X-Received: by 2002:a05:6a20:2447:b0:125:11da:f8f6 with SMTP id t7-20020a056a20244700b0012511daf8f6mr3373524pzc.13.1687478040701;
        Thu, 22 Jun 2023 16:54:00 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ad24:b28c:6f03:5b78])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b001ab12ccc2a7sm5960656plb.98.2023.06.22.16.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 16:54:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH 1/2] perf script: Initialize buffer for regs_map()
Date:   Thu, 22 Jun 2023 16:53:56 -0700
Message-ID: <20230622235357.225190-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

The buffer is used to save register mapping in a sample.  Normally
perf samples don't have any register so the string should be empty.
But it missed to initialize the buffer when the size is 0.  And it's
passed to PyUnicode_FromString() with a garbage data.

So it returns NULL due to invalid input (instead of an empty unicode
string object) which causes a segfault like below:

  Thread 2.1 "perf" received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x7ffff7c83780 (LWP 193775)]
  0x00007ffff6dbca2e in PyDict_SetItem () from /lib/x86_64-linux-gnu/libpython3.11.so.1.0
  (gdb) bt
  #0  0x00007ffff6dbca2e in PyDict_SetItem () from /lib/x86_64-linux-gnu/libpython3.11.so.1.0
  #1  0x00007ffff6dbf848 in PyDict_SetItemString () from /lib/x86_64-linux-gnu/libpython3.11.so.1.0
  #2  0x000055555575824d in pydict_set_item_string_decref (val=0x0, key=0x5555557f96e3 "iregs", dict=0x7ffff5f7f780)
      at util/scripting-engines/trace-event-python.c:145
  #3  set_regs_in_dict (evsel=0x555555efc370, sample=0x7fffffffb870, dict=0x7ffff5f7f780)
      at util/scripting-engines/trace-event-python.c:776
  #4  get_perf_sample_dict (sample=sample@entry=0x7fffffffb870, evsel=evsel@entry=0x555555efc370, al=al@entry=0x7fffffffb2e0,
      addr_al=addr_al@entry=0x0, callchain=callchain@entry=0x7ffff63ef440) at util/scripting-engines/trace-event-python.c:923
  #5  0x0000555555758ec1 in python_process_tracepoint (sample=0x7fffffffb870, evsel=0x555555efc370, al=0x7fffffffb2e0, addr_al=0x0)
      at util/scripting-engines/trace-event-python.c:1044
  #6  0x00005555555c5db8 in process_sample_event (tool=<optimized out>, event=<optimized out>, sample=<optimized out>,
      evsel=0x555555efc370, machine=0x555555ef4d68) at builtin-script.c:2421
  #7  0x00005555556b7793 in perf_session__deliver_event (session=0x555555ef4b60, event=0x7ffff62ff7d0, tool=0x7fffffffc150,
      file_offset=30672, file_path=0x555555efb8a0 "perf.data") at util/session.c:1639
  #8  0x00005555556bc864 in do_flush (show_progress=true, oe=0x555555efb700) at util/ordered-events.c:245
  #9  __ordered_events__flush (oe=oe@entry=0x555555efb700, how=how@entry=OE_FLUSH__FINAL, timestamp=timestamp@entry=0)
      at util/ordered-events.c:324
  #10 0x00005555556bd06e in ordered_events__flush (oe=oe@entry=0x555555efb700, how=how@entry=OE_FLUSH__FINAL)
      at util/ordered-events.c:342
  #11 0x00005555556b9d63 in __perf_session__process_events (session=0x555555ef4b60) at util/session.c:2465
  #12 perf_session__process_events (session=0x555555ef4b60) at util/session.c:2627
  #13 0x00005555555cb1d0 in __cmd_script (script=0x7fffffffc150) at builtin-script.c:2839
  #14 cmd_script (argc=<optimized out>, argv=<optimized out>) at builtin-script.c:4365
  #15 0x0000555555650811 in run_builtin (p=p@entry=0x555555ed8948 <commands+456>, argc=argc@entry=4, argv=argv@entry=0x7fffffffe240)
      at perf.c:323
  #16 0x0000555555597eb3 in handle_internal_command (argv=0x7fffffffe240, argc=4) at perf.c:377
  #17 run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:421
  #18 main (argc=4, argv=0x7fffffffe240) at perf.c:537

Fixes: 51cfe7a3e87e ("perf python: Avoid 2 leak sanitizer issues")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 25fcd6630a4d..94312741443a 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -737,11 +737,11 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 	unsigned int i = 0, r;
 	int printed = 0;
 
+	bf[0] = 0;
+
 	if (size <= 0)
 		return;
 
-	bf[0] = 0;
-
 	if (!regs || !regs->regs)
 		return;
 
-- 
2.41.0.162.gfafddb0af9-goog

