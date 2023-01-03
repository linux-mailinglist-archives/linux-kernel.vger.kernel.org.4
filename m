Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B165BB19
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjACHKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjACHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:10:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08D62C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:10:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k18-20020a25e812000000b0077cc9ab9dd9so20567898ybd.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAhXO16DITu5mVlsm2RSqQmMHjgDMp5kRheUZ35G9jk=;
        b=HpJzc1mBXMW9s7eW4d43H/CoP2bHxQSjeRu6iAjRL2bVDxTRdZHlKlmxsm3m9+nS6s
         g1rK15i0sLEUWswaOs6aqiVDfAk9DFK6g3kEMyDb2rL0KygrBX56Zjoa0xdbCMPqCGYt
         I6h0XTv7A5w8uOvJf/V8mhXT7DhbVYbhmedQmzpiE+IsShforBpBiKjzwl6l9KrOUIWO
         O1zUaCG2yFX0+yMU0CV9UVsfD+jiPz0SJBGfzAfRHZzDvLV0KlD6O0dCo/mHioDdBJCP
         4S6Pg1kBI1qd1+SHuYAzVKdV94/Wnmatf5/+egilXwkSlApOi2xWddr1CiQ2aTJnM/0S
         frgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAhXO16DITu5mVlsm2RSqQmMHjgDMp5kRheUZ35G9jk=;
        b=Z4wQg18OcD3QOuD7iCquPU4ArQX7qe4ZSttqI8XLvzOyFRoitX/p9rBq7ZtsoAi3I6
         8Y+wtQzip95x+lSrIaz47y4Tu6Kp1ACtCGw5R3OUC2DsPz6cc/oX7uDxT0CtBISS67g7
         DSsJEAgr7ligP1JSM+qSKe5K9YnRwEr+UmWpyffPd3J7cH2IuAi1nRTvarCGvxO+ovt+
         rvJwf8InUnqnGLTP9hSh0ltO3ibYV9GRrEnfyCZQRS49gc50YMPdGOI4ARpL5ONH7rDL
         M/x770n9095+5K6z8LKUXSfCcB8Xp/kyszgWJakmQA0Bexi9K32bFUBqY243ttXwCJ3N
         v7ug==
X-Gm-Message-State: AFqh2krYbkmJ4bPcayXlf0I2zlWFE88lc2yi72CS61UhplCSa5pijxaa
        SK9zMAwzxXhMvLbZRVb362JFAUT+LEFu
X-Google-Smtp-Source: AMrXdXtoqLVerlgldhQbNBwl7YtcbVFvDns1cF/xd/TR6Zl1sPVsVh/nCZ8+/8XGaQrbdK2p+bIOzqfjwn/q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ce36:aa68:4ca6:590b])
 (user=irogers job=sendgmr) by 2002:a81:9944:0:b0:410:b7cd:52f7 with SMTP id
 q65-20020a819944000000b00410b7cd52f7mr5895383ywg.520.1672729816858; Mon, 02
 Jan 2023 23:10:16 -0800 (PST)
Date:   Mon,  2 Jan 2023 23:09:16 -0800
Message-Id: <20230103070916.2407873-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH] perf build: Don't propagate subdir to submakes for install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
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

subdir is added to the OUTPUT which fails as part of building
install_headers when passed from "make -C tools perf_install".

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..1e32c93b8042 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -819,7 +819,7 @@ $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
 $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
-		DESTDIR=$(LIBAPI_DESTDIR) prefix= \
+		DESTDIR=$(LIBAPI_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBAPI)-clean:
@@ -828,7 +828,7 @@ $(LIBAPI)-clean:
 
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
-		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
+		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBBPF)-clean:
@@ -837,7 +837,7 @@ $(LIBBPF)-clean:
 
 $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
-		DESTDIR=$(LIBPERF_DESTDIR) prefix= \
+		DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBPERF)-clean:
@@ -846,7 +846,7 @@ $(LIBPERF)-clean:
 
 $(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
-		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= \
+		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBSUBCMD)-clean:
@@ -855,7 +855,7 @@ $(LIBSUBCMD)-clean:
 
 $(LIBSYMBOL): FORCE | $(LIBSYMBOL_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBSYMBOL_DIR) O=$(LIBSYMBOL_OUTPUT) \
-		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= \
+		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
 $(LIBSYMBOL)-clean:
-- 
2.39.0.314.g84b9a713c41-goog

