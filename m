Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F96175D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKCEz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCEzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD51834D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:55:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-373582569edso8830227b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWeuHCyi2W7A7vKA2mK0hGlw9T43n/AucDVWw/mFz6E=;
        b=P1Jxogm9RvZph3NQWg4N6/h1Y/mZIWrj+g77FotIrZCa8+JenokyCQfQpdHpDLY7Lb
         VFpPcL8i5orSFxw3pkruzwtE6rdGctGJ1m0ZlcAd+0GBeJzDWX0c0hjxd0wKvCjpkvlf
         G4v/ezWLfG6VlTd4Pmyu1x6tFgUOR32sNwRC5zAbyRg+1PZOubpiC8w3/XoqxymRg2Ii
         TSYdvpULIm3Xd0Q0LuLq/uz+MmriAjwvN5woDj3Gt5C/r4eOd98BkabLSVwDECZMV3GB
         1Fobn42CcrEo23uNYfOl1UZZ3DLlFR66PJmYRKMXK8RckNB1pTw2XLm9Mg/SkODwA27d
         aTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWeuHCyi2W7A7vKA2mK0hGlw9T43n/AucDVWw/mFz6E=;
        b=lsrIcTe1nbrwcQgBTmN+STqnSap6D7G3iCDPTVGX0E0lkpwpYiHqiJlPJtcLOtUINu
         AxIdu3DBK+bCkyyNYYW79j7p0nghsKkAYP1ot+7nYWK/nYK9DfpaYFEojd4pW6Szqdlk
         hqZFIeAAQQ+Z/3kQhgG6cBtuk6+zSYMamr8YKYhAAKXhzKG+EFsJS3gxQm2v1qTcONQA
         EFzasrOpvipsjC/jtxh/G/utf2XjRiAdTydsEs67Ano9NOw6XlQIL8G25+Zy0FcNxhy8
         1yRoRV4mUqjDOYHXfCYMewTze4SEuvjpxf1tCb9ciBsblHdNyf2MspQ7pcq06CRomEG5
         njIA==
X-Gm-Message-State: ACrzQf03clTejJKVtu+eR0pojzYW0yXd+rp/H2H+IzX31Lwnboj0pWMV
        sXKXBZERmBZLVMTZsOfwrsM1YUbWta94
X-Google-Smtp-Source: AMsMyM6e3YYgDcDAJlHUlyP1vHoJhULWU9k7/qIDFNy5Toxr7gPbdwAuaH6iWqfhnYFnmF22uoax4BUak5No
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a0d:ccc6:0:b0:369:230:438c with SMTP id
 o189-20020a0dccc6000000b003690230438cmr26964342ywd.45.1667451335254; Wed, 02
 Nov 2022 21:55:35 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:36 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-7-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 6/7] perf trace: 5sec fix libbpf 1.0+ compatibility
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
headers.

Note, on testing the probe was unable to attach and the program failed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/5sec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index e6b6181c6dc6..f22312c64713 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -39,13 +39,15 @@
    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
 */
 
-#include <bpf.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 
 #define NSEC_PER_SEC	1000000000L
 
-int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
+SEC("hrtimer_nanosleep=hrtimer_nanosleep rqtp")
+int hrtimer_nanosleep(void *ctx, int err, long long sec)
 {
 	return sec / NSEC_PER_SEC == 5ULL;
 }
+char _license[] SEC("license") = "GPL";
 
-license(GPL);
-- 
2.38.1.273.g43a17bfeac-goog

