Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02F766A26B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAMS5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjAMS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:57:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65411CE32
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:57:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-434eb7c6fa5so238713997b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0i2zZBdrCWRI9lmKA/36c64wVimSwf1CiL2+om4mgI=;
        b=e6pfazQiYivaHP9XqMCP5fL6vnwPvriEHQad3NVSdxFMeQuXIIff+6pWflu0WlYXdC
         QSJgNpOHrcy2L8irdpn2EEuVQOOZcA7dXwJzAFkLPCKJaDSdw9yU64m5hu3zqlX79ZDt
         wEJ1B3RaFiU+7nsE57mp1uu/psdWgbR+JAoxPekkl0pishgP5Y2rD7ajxh5VZpC6fc8N
         XI9lzEk+uKqwbSqSUE/aN9LI4a92Vaw51ACQQjTd1r8/Z94PCWvKZXPn95CupEv1GTyL
         LqpE41JbjiwNh+sOCn4MCi4IbTXXv9aXkhuzaqxEmbWytJZNEhJJ8HZQlxdbQBCeBN05
         6cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0i2zZBdrCWRI9lmKA/36c64wVimSwf1CiL2+om4mgI=;
        b=zpPxwlyxjePPIMNMxySG1MBcXQCDoWx93h/bbOk7Cf3njQcZ8p8MqXDZ5ekRCXabgh
         Jyf5zHmFUbft9DMpuqy9GFB98krPewMmoAm6Oet12Spdz287JEAtG5xlc3u89EoHwRxy
         AS4bWodHbtVfcDm7KjjyFNhEpj4OlOFuaH1N+pJCpNpBGS6FXOttWsCqm4lScW5z8OLs
         W/zJH8tzsfQuUImAR8nUMeaxqxz/e3ABODE6F38Vch3tKqQSLL7TvWAJa/a8oWjtyJ+p
         C6p2bJhEOVFl0qovaP6aoCmsV8C/HGP8E1oo0KE3OXic+VQEvoB1/Y1xjaJwAEQCBypz
         Zq7A==
X-Gm-Message-State: AFqh2kqOk07sUpzJeU/XNADzebjYOWWCIJvIfj0FMiVLaSP8CcSJHzOD
        caCMwI8oSiQGmKr0f8y3kEjxWKNZc09W
X-Google-Smtp-Source: AMrXdXuIfeiMj4FfTSA3IXDlo2QLb1EWzOITknF00Kz9b9grv9RndDgACvilj1UWEWIPTzvvj7mN5CvRe4Ft
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fa4e:1fbc:95a:3ea6])
 (user=irogers job=sendgmr) by 2002:a25:dd84:0:b0:756:35b9:e2de with SMTP id
 u126-20020a25dd84000000b0075635b9e2demr9383227ybg.117.1673636269620; Fri, 13
 Jan 2023 10:57:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 10:57:32 -0800
Message-Id: <20230113185732.134861-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH] perf buildid: Avoid copy of uninitialized memory
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_id__init only copies the buildid data up to size leaving the
rest of the data array uninitialized. Copying the full array during
synthesis means the written event contains uninitialized memory.  This
was detected by the Clang/LLVM memory sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3ab6a92b1a6d..348d05e4ec03 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2219,7 +2219,7 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 
 	len = pos->long_name_len + 1;
 	len = PERF_ALIGN(len, NAME_ALIGN);
-	memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
+	memcpy(&ev.build_id.build_id, pos->bid.data, pos->bid.size);
 	ev.build_id.size = pos->bid.size;
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
-- 
2.39.0.314.g84b9a713c41-goog

