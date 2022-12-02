Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EFA63FFA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiLBE6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiLBE6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:01 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EB2A717
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:57:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3b4eb124be5so38083017b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 20:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BZrtu6a4uY0PQiXNtiOGBfNeRj9TpPw09DbPuRe0Eg=;
        b=X4m7nIQ+QvDHeTb0ha5tBcYbrBQDFWJW2lsYSWb+uqOeXSfgqk77lGCxeuIMXLwMlT
         q/4vMEZeFJSlLF2ADUr2StBpjojZUi+QvA/YbVuEUxKO21f72Ck/EqwOMQv3YELK2UWX
         T+Z4sgXOrcSVxRTgD0iZSbG0sPIExiR3lVyDNrzH3qaj2+amwE662AQONkaie/Ww8qob
         8sqcdhZyAJj3vDbUax8l28/BdoqMKcSpSpp/aQlmUR0Lf+Uq7kP45MgqtlwvQqzdS4Je
         ++SZ5gIIaCcyDn0SiNgUSUyXoQKqNZhNWvVFoiCzjONvbiVV5lk4UTwNm+y/zuz1qLXt
         /YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BZrtu6a4uY0PQiXNtiOGBfNeRj9TpPw09DbPuRe0Eg=;
        b=AiXU8mjVlqNHzv4GuyQmhlC5DBWEY25CRddne0yylw/gc8hz4FzgV2dtP6OWDWGSje
         csi2615MVeOSgRQ4fIwKHdQbzweduCkTivbg4KPZl3D33GZ4iUqFPPzZD4qGFnNPGPE9
         9/r0oQgsvM1LfgiGP6EAa6YwcToprbaOodsdJi/uABLWpeLUvp4HJsgh6lnhjE/6LpYC
         WsuFsy69/XFvP7DH3O382F7zH/r4MDCZNVQ71qXN3KEnIPHhbaKK6PPJpp3vtPxDYN0F
         uayjjNChsZV4XfMRYNrp9+QMcWrUxiQpH0nRnVuyqbtEBlQf9TRR7ij/JVqthpk80vlH
         fnOg==
X-Gm-Message-State: ANoB5plzdhHU6iyhlyJdnEaa1+PZe0VlBe/D+pP7kJfbVqBjkqsdRDA+
        kvDzcPWBFW9Wl/p/kolcgiSGkpJKkic6
X-Google-Smtp-Source: AA0mqf5o0BmDUnUrinpRrQas0w4b7hDEpgBGbb2aeFzVqUVBfV1v1tX10UCBeoqIbKr4DRhNsSULBK0wW7Gd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a25:ba8a:0:b0:6cc:6a92:7a17 with SMTP id
 s10-20020a25ba8a000000b006cc6a927a17mr48131719ybg.282.1669957078446; Thu, 01
 Dec 2022 20:57:58 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:38 -0800
Message-Id: <20221202045743.2639466-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 0/5] Improvements to incremental builds
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

Switching to using install_headers caused incremental builds to always
rebuild most targets. This was caused by the headers always being
reinstalled and then getting new timestamps causing dependencies to be
rebuilt. Follow the convention in libbpf where the install targets are
separated and trigger when the target isn't present or is out-of-date.

Further, fix an issue in the perf build with libpython where
python/perf.so was also regenerated as the target name was incorrect.

Ian Rogers (5):
  tools lib api: Add dependency test to install_headers
  tools lib perf: Add dependency test to install_headers
  tools lib subcmd: Add dependency test to install_headers
  tools lib symbol: Add dependency test to install_headers
  perf build: Fix python/perf.so library's name

 tools/lib/api/Makefile     | 38 ++++++++++++++++++++++-----------
 tools/lib/perf/Makefile    | 43 +++++++++++++++++++-------------------
 tools/lib/subcmd/Makefile  | 23 +++++++++++---------
 tools/lib/symbol/Makefile  | 21 ++++++++++++-------
 tools/perf/Makefile.config |  4 +++-
 tools/perf/Makefile.perf   |  2 +-
 6 files changed, 79 insertions(+), 52 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

