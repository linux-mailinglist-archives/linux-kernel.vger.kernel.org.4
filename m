Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD66232FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiKISvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKISuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B51222B5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:50:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m4-20020a258004000000b006cbf32f7ed8so17326241ybk.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=J5iBygppWMyynh3fjd0h1zimuLLVXPLRICNwzhaTkhTCHnJ60j86AFaw/f1brpqElJ
         OEnHLiYHfWemhwcN5jxIbJxJOEmbZB1bZu6qV+GB3URAJAroxMSJsNboaLLx75pLWFY4
         NnLVvhzppfjD2+S4VNkt8wChsyw5+8/Bhz+kEOKVTu6SG4VAHP9zNdmUfTPO4bG1luwk
         CBFaCLcPIZfEBdeRvmSItRq/n4SZckWr3K3IX24HNN+IEsR3wCx5ZpZHzBE2sogc5wRf
         vs2/QeeLSCSvXEaexqvlkFi8GhQp2CBE/eieS1MsnzxjxRc5C6uVIQGMCmWg4Yvx/WTL
         7qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=HI+rTKoZlzBE06vpx3s4D1p51x7+T92WJj/09IiNfYBIJcsEFMXfidFpV958KI9Qt5
         Jc4UahIihibhPm2tHDnYoPFHSOSbh8T1HY01L6gPM2RUQq8NyNlp9d3HbEq8RVnSCaF+
         s8A0msoskeEv3GBNdlSvLAVuecXOH5yuSxIvcbgdGM0GjmEWqro2CR76uEJCZzHzuM8A
         aLCgpj3SwF3XiObf63NSXZKbMXioBlVB4CWniVzeHscsNjEk3uYvDAzKok6+lSt+IdK+
         CQETd+9iMomfp4JwJAEh9kIaZiFgVecMBfiTjm0+ufjH5VtsmdO3OtY/FXh6NYHWKl7G
         IpOg==
X-Gm-Message-State: ACrzQf3zqrc/5m/Qj3zZujUAQSQZ5RvMVPu8We1QAiNGtbNrhq3sbod1
        bx5c7OzVubwdwukhMbZswUZF2gn9+zxE
X-Google-Smtp-Source: AMsMyM4N/f2ycS6qQcmparzQwYVX6dleyP6/S0ma7Cd+HCsCnLDoZE6zuY8W1FFoHP1q5N61W1lqeBMzgilI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:af12:0:b0:6cb:b5d7:d64d with SMTP id
 a18-20020a25af12000000b006cbb5d7d64dmr60679393ybh.510.1668019832763; Wed, 09
 Nov 2022 10:50:32 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:08 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-9-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 08/14] tools lib perf: Add missing install headers
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

