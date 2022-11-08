Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F40620A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiKHHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiKHHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE382F00E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:36:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37010fefe48so129832787b3.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=D5rnSL7fwnZjkagsZnhZ1GdO69qsrJGRorN4KrU99em/5NRO9j579+EPkMVFKodeyS
         sm1wLT1PqrTnTtXCHVlBvAZdKjpM8wS/5EyH8nA1Z9zzB6L/dNV0fQQ9pJVyixq1vza3
         s9acRiPe03RM2hsKVayAbi7thy7z89CNKDaHX4XZMjUKiKCeX3caYI/LABcb1M3lF31O
         LLTkVxZZfTYGA9YwJlepJGkApQ0KcffUe+kJ5gLez8VPPy//BO4y2qls0JQi2Li7bxDJ
         8qsfDfoXAH8KeweDpmrAVAPqL+z1B08rDsi711HzPQ2l8w2wgAn9T5llDyqNxaz2oycl
         VoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=ZILE5e8Gf2bRKLi/duFeI+2ePrEkWbZB/9vetN21tDGyCZ6NzXTNTzoFO5fcqYjhfZ
         SaB2n79HCfqyJkGet/sAYANajGwo30GwK0SJf+xPxbTzfZAY0QLEgvYOUe4yjVlHUwJq
         n7PnJCPG+py2zlJBPB7gz+abSQc8diPfgUzhIXrFd5ZY0sn+1rYUDSJDYqyI6uvIFpm8
         rw9hewm0O79MiFQNauATVXM8g7fYUgCYznMBsVO9Rb11MK0Ze7H6BUcLOl9uIeDeWdWM
         8iY+5fD2+h6EsnawnPgpNot3fy1599cRyqOtA30+Ff/om7zQS6bbVwwHhClJ0RzJGcAj
         50yg==
X-Gm-Message-State: ACrzQf1UkO3iZohWojQsKyDIpsvHis7mG2xuhcpC0/bZaBYt/m7TeRFY
        dC686fvTi4Xj5tctoBBuNwRmTIS2kfGv
X-Google-Smtp-Source: AMsMyM6U/J8aO36PwiFoLxqr1Umo20wXiES9M06+s5FWWzOGM6KPA+IDE7p+Fy5WZHovQVUTw1ww6sMgrtaN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a81:ae1a:0:b0:373:5466:d6f1 with SMTP id
 m26-20020a81ae1a000000b003735466d6f1mr32891682ywh.298.1667892993842; Mon, 07
 Nov 2022 23:36:33 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:12 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-9-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 08/14] tools lib perf: Add missing install headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

Headers necessary for the perf build. Note, internal headers are also
installed as these are necessary for the build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 21df023a2103..1badc0a04676 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -189,13 +189,21 @@ install_lib: libs
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/bpf_perf.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
+		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/internal/cpumap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/evlist.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/evsel.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/lib.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/mmap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/threadmap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/xyarray.h,$(prefix)/include/internal,644);
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-- 
2.38.1.431.g37b22c650d-goog

