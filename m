Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22FF6B5921
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCKG6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCKG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354234E5EB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p79-20020a25d852000000b00b32573a21a3so3094978ybg.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517907;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhwBTfmVglAZRqsQmhfe71Rzl22nzSJC9LqarCaKaI=;
        b=fElNmip0BTpEUcUnQZTbwScWF+byjtbSTr1v+/fNKXShFigaOgNUsPUyepDifsXFRM
         GjtYEjMaWAmilGB5L+qcsVGjEjSGMd/LeJ4G4PISm/Qcr6mSeFSRGXMwIFTXlqpoDxqx
         uvOL6laMJmAF+1dp81n9lTMrmeOS29PZsukS94k2PzLInHyjjAn0Ikca29z18M4cqC9P
         pDbHtcs1qt0NwF2biwm7j/d3u91cLM2DA31ZRrxK9fk59zZkHZNyQju0Itf0+jXrviS2
         yX4IFl6BnsYqfYyCOaJ7WasvY5zSSdx4oLpfJ3YYqOWxo4POEGnix1tjSlJfAFmpqAK2
         kvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517907;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhwBTfmVglAZRqsQmhfe71Rzl22nzSJC9LqarCaKaI=;
        b=wdEKy2Hhz9iJ8vVnQSmLUFGPH79kCkgQIoBe6gqxCd752gFZlpNVRRwlYRtuyN1I0f
         nOfd+fyPT8nGSu5mqHoql2IoZOgUhWCaNemArm+xb+DBLNVLsvsEjmwIQJI/alPI/9/n
         KDrFb4dPfNBI62OqEQOr3Z1shjnnWRRXmEC6XfkS9QbZWu6wLO0h0iLkVIF/48sZ7CJQ
         o0jUEZLi/QYm5zqDwpHrL/i0xUlq/zTqgVHBghjq9YPGMm4cjm6+THRtuy0UVlhU0m3L
         HjnUMpUZEtSe/VSN26amrcfT0dYmruIm19tZW2iB2GOIDZH3QRCit/IeC2WFfWbyc47a
         OHxA==
X-Gm-Message-State: AO0yUKV8xDQCg76Lgbul5VvNuniK7/ii9yOrzuZ1HDqhzfXZ62kaHPR+
        4aoyj3dtKSlzIcTCDkJbz0Gpi2wG9y/S
X-Google-Smtp-Source: AK7set/X4UK55tnSLb9uuZbddCfKNh6XVFOEDglMCEuZ2GT7wllVSHfNLypT6L+5C1w62Dki84zNDe5aQALx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ac1a:0:b0:533:cf4e:9a80 with SMTP id
 k26-20020a81ac1a000000b00533cf4e9a80mr17706404ywh.6.1678517907341; Fri, 10
 Mar 2023 22:58:27 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:43 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-4-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 03/13] perf build: Remove unused HAVE_GLIBC_SUPPORT
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
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

HAVE_GLIBC_SUPPORT is only used in `perf version --build-options` but
doesn't control any behavior. Remove from the build to simplify it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config   | 4 ----
 tools/perf/builtin-version.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 33d62d542fd5..a68a3e9b47ae 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -476,10 +476,6 @@ else
   endif # libelf support
 endif # NO_LIBELF
 
-ifeq ($(feature-glibc), 1)
-  CFLAGS += -DHAVE_GLIBC_SUPPORT
-endif
-
 ifeq ($(feature-libaio), 1)
   ifndef NO_AIO
     CFLAGS += -DHAVE_AIO_SUPPORT
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 0d9cda238c07..c5d03a11e565 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -59,7 +59,6 @@ static void library_status(void)
 {
 	STATUS(HAVE_DWARF_SUPPORT, dwarf);
 	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
-	STATUS(HAVE_GLIBC_SUPPORT, glibc);
 #ifndef HAVE_SYSCALL_TABLE_SUPPORT
 	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
 #endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

