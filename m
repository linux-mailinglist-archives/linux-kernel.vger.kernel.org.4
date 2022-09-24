Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7945E8BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiIXLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiIXLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:33:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FF386AF
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:33:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jm5so2292175plb.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0DmqEWVeIfx21hMNe6tukUIZuj/O+XKYgF8Y5KtyMa4=;
        b=JPyGb0q6RLf+jbIkzwyIgs5Ss1fu4pPv6esvZIq9Qu3L5VGrPOsDFsm4MTiRI+IB6m
         MVxh7FWmdZ576ow4jtG6BBUs+2SHlJwZZShfA1ylPVqV3O3yE5wNaBiYkAck1gwfIl5n
         lKsCzJ/8jkuwM1CYsiRuJDFXvH+7V2Lpw/sMfm9UG7QC4CvaTBp7jYYTm2MAfluQJ5ky
         J3qUkt+bJPrtJSb7Z9rMYj5XHry9cxTBmhxKC0hlCDl/NnwiWAwFBzBGgKfUsYajGQ5c
         vMBKoLLHQ5vYy097/9hgUtki9gvQ/3asTjkNbkl2lw3sOgwOEvcg/y/ZBuAuP66gnbOz
         59EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0DmqEWVeIfx21hMNe6tukUIZuj/O+XKYgF8Y5KtyMa4=;
        b=fQEBUcoJ0/hV6SKNnHZiAPcoEKLLVf0JA4iwxsrZ4VOXqhNR83HF7QdQ7j7CjVl1dB
         4cZovEHc6xrSufNiorp/loPydRQcusGlqFyqAi1KtHqgzu3UImvkuQ81lLAIdWZLChPw
         Sib2PhSBOD4lWp6TnlzTTn5mtbvAwouVMtLfxPidaMLBpQwKeU7fy0+R35n00o5rnqXx
         jilBZSJ5aSLD7x0CFlEKFuzW4HZenVLYjdATej0Rai4m5eGpcAsUzmDzZbD91PMpCDYo
         DmCBN9VYxBHWW6z0g1zTdhoFLV9vj0ANSYDxsioUB0u9HHeJxnGbvCo4Pz4TYmKszPav
         q2ig==
X-Gm-Message-State: ACrzQf04zLkMKL03N8ozUvdbz9Su9JE88T977loskqgxLj17QHFliJCG
        KSr12Zyqlhp2iUzgqK2HbQJjBQ==
X-Google-Smtp-Source: AMsMyM7lZ/jA2HDaObnwd/XVY+VvWfjkRDpLlk7c4s+b8a2DrNg6bDCiWP0CZ6QPossorwONi1+w7A==
X-Received: by 2002:a17:90b:1642:b0:203:1630:c54d with SMTP id il2-20020a17090b164200b002031630c54dmr25673580pjb.122.1664019236793;
        Sat, 24 Sep 2022 04:33:56 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-52-75-203.us-west-1.compute.amazonaws.com. [13.52.75.203])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b00176acd80f69sm7654540pla.102.2022.09.24.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 04:33:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf record: Fix segmentation fault in record__read_lost_samples()
Date:   Sat, 24 Sep 2022 19:33:46 +0800
Message-Id: <20220924113346.1110909-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
causes segmentation fault when run the "perf mem record" command in
unprivileged mode, the output log is:

  $ ./perf mem record --all-user -o perf_test.data -- ./test_program
  Error:
  Access to performance monitoring and observability operations is limited.
  Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
  access to performance monitoring and observability operations for processes
  without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
  More information can be found at 'Perf events and tool security' document:
  https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
  perf_event_paranoid setting is 4:
    -1: Allow use of (almost) all events by all users
        Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
  >= 0: Disallow raw and ftrace function tracepoint access
  >= 1: Disallow CPU event access
  >= 2: Disallow kernel profiling
  To make the adjusted perf_event_paranoid setting permanent preserve it
  in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
  perf: Segmentation fault
  Obtained 16 stack frames.
  ./perf(dump_stack+0x31) [0x55b7aa1e8070]
  ./perf(sighandler_dump_stack+0x36) [0x55b7aa1e815e]
  ./perf(+0xc9120) [0x55b7aa0a9120]
  /lib/x86_64-linux-gnu/libc.so.6(+0x4251f) [0x7fd03ef8151f]
  ./perf(+0xccaca) [0x55b7aa0acaca]
  ./perf(+0xcf4ab) [0x55b7aa0af4ab]
  ./perf(cmd_record+0xd50) [0x55b7aa0b28df]
  ./perf(+0x112f77) [0x55b7aa0f2f77]
  ./perf(cmd_mem+0x53b) [0x55b7aa0f406c]
  ./perf(+0x19979c) [0x55b7aa17979c]
  ./perf(+0x199a37) [0x55b7aa179a37]
  ./perf(+0x199b95) [0x55b7aa179b95]
  ./perf(main+0x2c7) [0x55b7aa179fbd]
  /lib/x86_64-linux-gnu/libc.so.6(+0x29d8f) [0x7fd03ef68d8f]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x7f) [0x7fd03ef68e3f]
  ./perf(_start+0x24) [0x55b7aa089974]
  Segmentation fault (core dumped)

In the unprivileged mode perf fails to open PMU event, the function
record__open() returns error and "session->evlist" is NULL; this leads
to segmentation fault when iterates "session->evlist" in the function
record__read_lost_samples().

This patch checks "session->evlist" in record__read_lost_samples(), if
"session->evlist" is NULL then the function directly bails out to avoid
segmentation fault.

Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02e38f50a138..012b46dd4999 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
 	struct perf_record_lost_samples *lost;
 	struct evsel *evsel;
 
+	/* No any event is opened, directly bail out */
+	if (!session->evlist)
+		return;
+
 	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
 	if (lost == NULL) {
 		pr_debug("Memory allocation failed\n");
-- 
2.34.1

