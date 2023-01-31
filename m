Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083B682214
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjAaCeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjAaCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:33:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC6233E6;
        Mon, 30 Jan 2023 18:33:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so13073141pjl.0;
        Mon, 30 Jan 2023 18:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYmg7u8BuMXGs5kfhUOaWTWsCts8KrLu3C1CWq/3WHM=;
        b=RTGJbkgf23Vqp0k6oNVwNP/dnObdTu5cDug2Sy9PX/05iTauQBtYdWbumFoFberAEJ
         Dva/GD2vHJSRgljKfENSIfM8h0Ht4NDON0CbdHpojXxjASUdBbH8G1JGVovp0BSRYmPW
         Yr+BvfOk6WX3zHhFlUx9pkeOOFBkxXKQ9nOApt0hL05Gzmt/CqWiiHxjteRVQiwaxr2U
         WVwoXYqQ7T7sSE48/nnBgEbR4pyV7v9ff8ms15oT1XiwLrot3c08/jkj4+tLVVKEq+gx
         Mg92A4LsBW3tNhq+9a3vyV9le0NI8aYz9ysgY+ih8B4c3QUJejnIweno94hxpruKYWge
         v0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYmg7u8BuMXGs5kfhUOaWTWsCts8KrLu3C1CWq/3WHM=;
        b=JHABnFZ6DsiSfDmqPP6AU+ztYdG2QzoOiDGIoX4K91eiSpe10QaSdf0cNWdIhrYnRX
         sqqzeZllDo8MNj4e8gObHZNEgpQAhZT3gmCmyGCxHRaAnEih6HWY48xplcVuLDRCEXHU
         HBUDvlKQrfeIgGgxHCUK3v+iYsW8PgP06+Q74ijhxH9+zUHtUwtsqY9xvQwQGGRjXMwB
         ebU+hb7qQNdjifWUcBy3zflsTuJt8llSExJ7vXuOwtKaqzDovDOcfxx7I4d1Q8PoORS2
         j038aLYYbG28sUXjOt93gnDQ7Mxv8IYQ7NxVauI5lwXRb5UkYgxk6fcBDPeKrluL1cJ1
         MO4g==
X-Gm-Message-State: AO0yUKVHq26QGaHmAfW9T3tqqpR9gT1j/cmmv+LOhUdbcJx2JYD/acYT
        ogriZxqF7tq9URZdDK6MTd4=
X-Google-Smtp-Source: AK7set/lWLutoeAUTu0N8F5wNDvxjTUwGDbFJz52BD/gx7r8FGnNl3kGcTrB8SUaoJOZOkGJKB07Ag==
X-Received: by 2002:a17:90a:1952:b0:22c:3edd:7e48 with SMTP id 18-20020a17090a195200b0022c3edd7e48mr16423999pjh.32.1675132434199;
        Mon, 30 Jan 2023 18:33:54 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3f41:4035:c56c:92cc])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a6a8d00b00228f45d589fsm7640582pjj.29.2023.01.30.18.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:33:53 -0800 (PST)
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
Subject: [PATCH 1/4] perf inject: Use perf_data__read() for auxtrace
Date:   Mon, 30 Jan 2023 18:33:47 -0800
Message-Id: <20230131023350.1903992-2-namhyung@kernel.org>
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
Reviewed-by: James Clark <james.clark@arm.com>
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

