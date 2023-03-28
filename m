Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED36CCE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjC1X4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjC1X42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15B30D8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso13510406ybj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047769;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwhWDPXvx6cfkb5reLksh9jCAury04O7LzcSvRbB8Zs=;
        b=Ltgu8Ff4auNliuT5UliaEkAuq9i2Tzu+5U2BQzip1AZokzyNRdwHBLrr0A1q1TCteh
         6HA8rQWn2amyDpZCOcWkijg0aV3wa7oBLO7ki4rM6Xzr9cqFtUVrftkblee0rzPjMb+L
         wJ4eW8t3SAEsbCXRcXZGpnQH05BULFCsjjs0PkcoeeHAo5P4f+L0tmwiyGtOxdqtUqwk
         lRhAg5051knYmNhbu0rixPc04ElVILRM6fmL1sequabHkJhfYFow2m9eE4OC/NNGI7D5
         M1zB/Iu+BE5dCWofkvweIXTenU0zYzPftguEROrDBdX8QE4rvu1TaHyUsk4TFKeXBN50
         OHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047769;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwhWDPXvx6cfkb5reLksh9jCAury04O7LzcSvRbB8Zs=;
        b=amebcJLe8EpVD0kjwtN8NU00psWmBuJSztsC9kRDMFK3hyrtydifbsU9HcaXMmCDkS
         eg2U6vP+CDDgwLYSTShKmRohxz0TZLq0f0YvX8562/p8eEDt6M6ELBE475+3M+/eldUY
         bv34ebymglSAGVooVejEFaWXxalbBD9NQykn5v86pXl167/5s/Hwwuo+kh4JgjMDlWHj
         KzQ7iPRZDcrDADRpOgJ5r+IvC9qGif9H2D7dbZonG8MawvNCsh6AGfjKwtUA9KH+g4+z
         9mJvZZDuVPVNCcQdGUs0XwyeiPkJKP/Ff38LX6DaCyfeWnyZwm+DjwOy1wCE6khcYjlK
         mTvw==
X-Gm-Message-State: AAQBX9ebCnOQrYCdnx5+AXY+PgileqyUaxJCYNnhu5TeG1SLL2iEPbgs
        w54hm0mgdA5gAYqN9/ggfIb5PgHe//i0
X-Google-Smtp-Source: AKy350bPHWqR7CBnjrbpMPu6sWr+4djUlu6CbJ9r9CJVXCNAz4PB6GrJeq1BsxI9gq7g43uy2Tw/VjdqKiJY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr11705976ybt.6.1680047769358; Tue, 28
 Mar 2023 16:56:09 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:38 -0700
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
Message-Id: <20230328235543.1082207-2-irogers@google.com>
Mime-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 1/6] perf annotate: Delete session for debug builds
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the debug build indicator as the guide to free the session. This
implements a behavior described in a comment, which is consequentially
removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4750fac7bf93..98d1b6379230 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -692,16 +692,12 @@ int cmd_annotate(int argc, const char **argv)
 
 out_delete:
 	/*
-	 * Speed up the exit process, for large files this can
-	 * take quite a while.
-	 *
-	 * XXX Enable this when using valgrind or if we ever
-	 * librarize this command.
-	 *
-	 * Also experiment with obstacks to see how much speed
-	 * up we'll get here.
-	 *
-	 * perf_session__delete(session);
+	 * Speed up the exit process by only deleting for debug builds. For
+	 * large files this can save time.
 	 */
+#ifndef NDEBUG
+	perf_session__delete(annotate.session);
+#endif
+
 	return ret;
 }
-- 
2.40.0.348.gf938b09366-goog

