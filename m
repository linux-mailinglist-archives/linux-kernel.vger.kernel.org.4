Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5C682215
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAaCeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjAaCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:33:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D221958;
        Mon, 30 Jan 2023 18:33:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h9so5058226plf.9;
        Mon, 30 Jan 2023 18:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hEMIzHdLpwwG0PzQtXZ+smccu5A316Bg7CzC9BcgGQ=;
        b=aX3IGXALKXnDwSdfOKndnNKd9jKWl88rlYjbvDS85tueylN1U7/B/iuhXgYlhsfJoU
         5FsIm+zwGWYfd3RVy2E4ZzulzTPASIH0kYA7nsR1sLQzQWH4DkIAU/HuvOvOxKc/65Uk
         Kwno1gxhzTuaiOm696JJP87e8F61yEcAx8KX8aNAcXz1EwJv9T/5XVH2yyft88R6/m9l
         CC747rLGdhaTvbkP9kVRdmsG3wOJQJN9QCkpB7BwdruoldIoWVB73hcFVzr08ebAPHkK
         OivOJ91pI8B6hKZdRTnQNIA75EV/eWYPJhEVXVK2bFKse3Hf4jY4416sKmFzKb65BLtr
         /JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hEMIzHdLpwwG0PzQtXZ+smccu5A316Bg7CzC9BcgGQ=;
        b=mkQNAtCUpruVEtQp0j8iEkrGVXYRQV5ExKEaU5yiJiQYsSGO2amA/a310cJl8z7Xgt
         XfzhGy4IC2+WTOnw4Z2ABBwdQeKcqcEWsTKeMqPc8qqHv/GKQFTmMtCDRatj5aMKHSYu
         SIkC8YU+XkVCn6rMpvFVkSfiB4pCtumSeeGK0ZNC4kGjGebSzopOgHWczSCggDr+cZpJ
         SHe7IAXEkkLMUh/RDNHP1gtH8vjMAUSUMSO2fsRN8G38k2amPWRcSwb7s8C4ug9SEY6h
         R0hqWmJyhEt4JInvxq2RzcDkHavUwqMCfcscIODmd3kpIQD3HErDntT3uCufrgvEP6Fm
         +9Vw==
X-Gm-Message-State: AFqh2kqemb3krNPtKeCCHZEcmXsErRBsxnhSKIdmP/9e0bKClYQnsD27
        BKk2VEkmhp5IUCZaA3S7DdA=
X-Google-Smtp-Source: AMrXdXsM7xfZoq36GLn+Mmi+pFGvwUoE+H43qAGxB0PEy/6cf52of3NCix7kqGvRXQvT9ofKru5XNw==
X-Received: by 2002:a17:90a:4302:b0:219:9da5:40d3 with SMTP id q2-20020a17090a430200b002199da540d3mr55472724pjg.1.1675132435829;
        Mon, 30 Jan 2023 18:33:55 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3f41:4035:c56c:92cc])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a6a8d00b00228f45d589fsm7640582pjj.29.2023.01.30.18.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:33:55 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/4] perf intel-pt: Do not try to queue auxtrace data on pipe
Date:   Mon, 30 Jan 2023 18:33:48 -0800
Message-Id: <20230131023350.1903992-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230131023350.1903992-1-namhyung@kernel.org>
References: <20230131023350.1903992-1-namhyung@kernel.org>
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

When it processes AUXTRACE_INFO, it calls to auxtrace_queue_data() to
collect AUXTRACE data first.  That won't work with pipe since it needs
lseek() to read the scattered aux data.

  $ perf record -o- -e intel_pt// true | perf report -i- --itrace=i100
  # To display the perf.data header info, please use --header/--header-only options.
  #
  0x4118 [0xa0]: failed to process type: 70
  Error:
  failed to process sample

For the pipe mode, it can handle the aux data as it gets.  But there's
no guarantee it can get the aux data in time.  So the following warning
will be shown at the beginning:

  WARNING: Intel PT with pipe mode is not recommended.
           The output cannot relied upon.  In particular,
           time stamps and the order of events may be incorrect.

Fixes: dbd134322e74 ("perf intel-pt: Add support for decoding AUX area samples")
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-intel-pt.txt | 30 ++++++++++++++++++++++
 tools/perf/util/auxtrace.c                 |  3 +++
 tools/perf/util/intel-pt.c                 |  6 +++++
 3 files changed, 39 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 7b6ccd2fa3bf..9d485a9cdb19 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -1821,6 +1821,36 @@ a trace that encodes the payload data into TNT packets.  Here is an example
  $
 
 
+Pipe mode
+---------
+Pipe mode is a problem for Intel PT and possibly other auxtrace users.
+It's not recommended to use a pipe as data output with Intel PT because
+of the following reason.
+
+Essentially the auxtrace buffers do not behave like the regular perf
+event buffers.  That is because the head and tail are updated by
+software, but in the auxtrace case the data is written by hardware.
+So the head and tail do not get updated as data is written.
+
+In the Intel PT case, the head and tail are updated only when the trace
+is disabled by software, for example:
+    - full-trace, system wide : when buffer passes watermark
+    - full-trace, not system-wide : when buffer passes watermark or
+                                    context switches
+    - snapshot mode : as above but also when a snapshot is made
+    - sample mode : as above but also when a sample is made
+
+That means finished-round ordering doesn't work.  An auxtrace buffer
+can turn up that has data that extends back in time, possibly to the
+very beginning of tracing.
+
+For a perf.data file, that problem is solved by going through the trace
+and queuing up the auxtrace buffers in advance.
+
+For pipe mode, the order of events and timestamps can presumably
+be messed up.
+
+
 EXAMPLE
 -------
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c2e323cd7d49..d4b04fa07a11 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1133,6 +1133,9 @@ int auxtrace_queue_data(struct perf_session *session, bool samples, bool events)
 	if (auxtrace__dont_decode(session))
 		return 0;
 
+	if (perf_data__is_pipe(session->data))
+		return 0;
+
 	if (!session->auxtrace || !session->auxtrace->queue_data)
 		return -EINVAL;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6d3921627e33..b8b29756fbf1 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -4379,6 +4379,12 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 
 	intel_pt_setup_pebs_events(pt);
 
+	if (perf_data__is_pipe(session->data)) {
+		pr_warning("WARNING: Intel PT with pipe mode is not recommended.\n"
+			   "         The output cannot relied upon.  In particular,\n"
+			   "         timestamps and the order of events may be incorrect.\n");
+	}
+
 	if (pt->sampling_mode || list_empty(&session->auxtrace_index))
 		err = auxtrace_queue_data(session, true, true);
 	else
-- 
2.39.1.456.gfc5497dd1b-goog

