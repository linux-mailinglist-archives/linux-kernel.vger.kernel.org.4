Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310A67DAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjA0AUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjA0AUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:20:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460638661;
        Thu, 26 Jan 2023 16:19:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso6313847pjs.4;
        Thu, 26 Jan 2023 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egmLJ0P+nkdiEwtD39Tt2932c4Qbx1PdrWuvIbe74LM=;
        b=ie0A8zcKF9j7TIX3g9qM+PTdY7uRmKhAZxVglnX5CBztBqYSwewEz/OYuEi4robx5R
         1p1Pnm24h61+vaD8Hlpx4BzxToI05Abkb1Di3rnKD24EUlL5hzTrr7Ehl8qp2buU+OJc
         MA7qCpsl2MLSwRuFoRBdwxQaRtMzJsEWd9GljRL/xGL0nZ2ymNi6/y77nKyhrM1uf6uP
         e8AP+KVsYP4Myop9q6Ver4WM5TuJGpRedpH1iBjaXQcUvIsk36+l1jE6PyVU0zLIMOr9
         AlGnEgwlARX9JN1qnUQCOjMK+Z0NGQIR3zYuZCOVpMffkw536QFyKgcw64bRU9gv8QtW
         oZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egmLJ0P+nkdiEwtD39Tt2932c4Qbx1PdrWuvIbe74LM=;
        b=ZPcM6/go/9sGsYOMz9hPUA0AQ/6NQL9F4B67/U6gzQuMLyEqVT6hW9MYOadLIeaORp
         HDmSLoH/atRbLo9xClVfEalkRJPNne00xqhFV+X3vMRvitkiH3GE+oe2Ki1FPG5GgTe+
         qC6bMNUQ4bKT8443mmj7tA5HW+wLS+a0sCjTh0sT1b21yFkbwHwjE7VhAVAcDA/WZfBz
         9NgTLPDJMgJkAh3jFxYg0lTZfUuxtCZLuziSFORiBAVr5DddDNCL/nGKr92sfgjxipCx
         lgt58nd6Fof1Ny9Og8TuGJAlhSgSmElWMfDBS7u1pEsDYSEAgqyU94rWGaV2prWePBSb
         QXsg==
X-Gm-Message-State: AFqh2kosUeg/Yv591aM1kTyIvJbrzAOsAv+L5kSwVKqKAYdzoMpXpu9I
        AOTLSrzCGVluQ12+Teuyg5E=
X-Google-Smtp-Source: AMrXdXt9mkHJz7PniYBygy2W6ShGWQkHJ03NWwlEOckobh8UPWyxKMydEFMa+Gd+xO7b+EhaTU9eZw==
X-Received: by 2002:a17:90a:aa83:b0:226:102:2dc9 with SMTP id l3-20020a17090aaa8300b0022601022dc9mr39248610pjq.14.1674778796351;
        Thu, 26 Jan 2023 16:19:56 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b00229f7376247sm1567270pjc.57.2023.01.26.16.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:19:55 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/4] perf inject: Use perf_data__read() for auxtrace
Date:   Thu, 26 Jan 2023 16:19:48 -0800
Message-Id: <20230127001951.3432374-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230127001951.3432374-1-namhyung@kernel.org>
References: <20230127001951.3432374-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In copy_bytes(), it reads the data from the (input) fd and writes it to
the output file.  But it does with the read(2) unconditionally which
caused a problem of mixing buffered vs unbuffered I/O together.

You can see the problem when using pipes.

  $ perf record -e intel_pt// -o- true | perf inject -b > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  0x45c0 [0x30]: failed to process type: 71

It should use perf_data__read() to honor the 'use_stdio' setting.

Fixes: 601366678c93 ("perf data: Allow to use stdio functions for pipe mode")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3f4e4dd5abf3..f8182417b734 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -215,14 +215,14 @@ static int perf_event__repipe_event_update(struct perf_tool *tool,
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
+static int copy_bytes(struct perf_inject *inject, struct perf_data *data, off_t size)
 {
 	char buf[4096];
 	ssize_t ssz;
 	int ret;
 
 	while (size > 0) {
-		ssz = read(fd, buf, min(size, (off_t)sizeof(buf)));
+		ssz = perf_data__read(data, buf, min(size, (off_t)sizeof(buf)));
 		if (ssz < 0)
 			return -errno;
 		ret = output_bytes(inject, buf, ssz);
@@ -260,7 +260,7 @@ static s64 perf_event__repipe_auxtrace(struct perf_session *session,
 		ret = output_bytes(inject, event, event->header.size);
 		if (ret < 0)
 			return ret;
-		ret = copy_bytes(inject, perf_data__fd(session->data),
+		ret = copy_bytes(inject, session->data,
 				 event->auxtrace.size);
 	} else {
 		ret = output_bytes(inject, event,
-- 
2.39.1.456.gfc5497dd1b-goog

