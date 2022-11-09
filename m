Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316E6232F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiKISu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiKISud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E951BEB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:50:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so17452034ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=HAbhjun7P8t/79/dqBqP+rj7CyYnqpzlHYOYz8g1nvpWXxuQZYlbqRh9LHbV8RqgbL
         uHS/oLrLpvr+aQyl134bv9P6wJamiQBmge0w+xR1tvbKtSbUiEl/4P5xNGSy9WgNLmOu
         e0GS5qQ8N9KNKNIeQn/LxUMprUnZkwBEnLjNUfxMnxm/kL6MCYkN3M0NKRK0NBPfuZoG
         D7MQqsgGpWM3iNH3CmKU/JibAvi23pTxMjWaKuLGHvOiZPJAQ8qAZaaFgKc1RHunC6od
         EdQdtmjfGgzZjdrFGBzbvDoaU+hH6HIcL1nb10UsK5Oy6++UaslT+MVj06OpPYiDjF4b
         gPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=Utjz9kpFbbMYAc0Vz/tzSi2HqLAFQ0aK+MILreQPs5Qfzh/ep/bO9BzKm4DxOUQ5Li
         eMn7D2vEvdvhUiiA0aFtnLPDWZoXxFh8YEX4DKXmZmLwuPalg250DLNuPm56WYAe/T96
         Lam1r5Waa06G4SFspPnGH/j3CSZvklL3EHpBKqO0HoYKqCsUcOFfMTdIGMmTUaLEZZ15
         qEZ3Rk7Q4cTkgU+oDOs50WIR5X6FiNlOMtr/88nRhV4i2xwcPlZlnqCEJiJSLrM977BS
         ylCQdKAHd3C8sQ3HTtMJsqsrNTpA2a9OPzWOWwwJ4wrRC30bQ/IaQ8HVecuAB+8c6wCI
         wp2Q==
X-Gm-Message-State: ACrzQf0RXrj/LNXRRB9jdkDsT/dTPv4Vzl6WLelT9yvocUKUE59rbEcl
        /E/unfCVVNGX/2EofdtBsaUEAxuZDhTf
X-Google-Smtp-Source: AMsMyM7tKim5J0Fz3dpcQcx/D4llXsXbixQRKNPsvCvSgNnuoFw4d8N8sIGcMW/o/deoohzIfFLpecviFfba
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:dc87:0:b0:6cc:7352:b4dc with SMTP id
 y129-20020a25dc87000000b006cc7352b4dcmr1156840ybe.480.1668019824272; Wed, 09
 Nov 2022 10:50:24 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:07 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-8-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 07/14] tools lib api: Add missing install headers
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headers necessary for the perf build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 6629d0fd0130..3e5ef1e0e890 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -103,7 +103,10 @@ install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,cpu.h,$(prefix)/include/api,644); \
 		$(call do_install,debug.h,$(prefix)/include/api,644); \
-		$(call do_install,io.h,$(prefix)/include/api,644);
+		$(call do_install,io.h,$(prefix)/include/api,644); \
+		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
+		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644);
+		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
 
 install: install_lib install_headers
 
-- 
2.38.1.431.g37b22c650d-goog

