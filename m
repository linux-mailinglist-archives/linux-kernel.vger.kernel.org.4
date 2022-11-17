Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9762CFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiKQApb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiKQAo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:58 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD76B237
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:44:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-352e29ff8c2so3586697b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXZGloJLo63EGaJ/mj4DMj71nEKbleTTzHSaXj91R5I=;
        b=PdaVdTssRALELmv12cnJ+28wAmx/jCb6l++NOd+1kqRP+3zlkIEyt2UDxxS8WY/fpr
         QVF1flCSaAr8RHKgMiDC1O7UDYlprAW2K65xrWtDZZ3qrcvRdKXV0IAWyAY4sdDRgoDj
         U18qsdqIAdO+pisl+WpUEi/shMDhsMpAgUZ6TgU+13PDtLX3M3TKqPQ8CQonnv6OssIh
         AFpo7AUS7Acci7Yvz5ZWL3yMVySQ2xR/uiuuIdROigp8MkNwg3+4WxGCyXe8XiHGnLw7
         aJxigxfAaHDh3FtrLO+Nvu+YnvrSEsr1tCurh1jwYm43a7UYuPasV1nSqpnecFdrxpC6
         791Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXZGloJLo63EGaJ/mj4DMj71nEKbleTTzHSaXj91R5I=;
        b=vtSpEgAwj1Tds8NlWOFx0HkpjlzwpsY5HdsPV8tAf0PHXkTJH9YaJuatxt/HN88U6U
         bvLKAr3RNgBUteJOIaPR5apdQjKm+bDJDN0rsyLdCUIA+J+6j28tqxsNDn9Muu+vRX4N
         KqJ9Shws31pvIDRn0yUcoPfZfuOrENjWlu8srOpE7zyRaovtxd6BmmjAV8BJw7hh5BeV
         1N5JEvqh7Q+LY/pZCPY6uW4YAWScA/7LCiXdqA+w2o2ssI/ay+fCOP6ZjomkHDEj0dgC
         d5yymltR3KXeLwfcv3N7mXqaUxioA1veAcCBnwTHl7Zp6VA0U8FGF+GfDC5fLaB4zNlu
         V0bA==
X-Gm-Message-State: ANoB5pkSXLE0d5TWHb9VP3r/wiWp3B+cBuaFvQXSB9NpeaW/w+Lo6InL
        6JHQDZ8fvyFBLM5uQSfBG7PbcRaFwhZv
X-Google-Smtp-Source: AA0mqf5fnncVZW1khFmDmYg++DUvRPG2nDUZ0Ddy3PKN1WNh2y9GXdzQJtAm7i4RSwY8oXq4UeMFoNVAJonJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a81:1317:0:b0:38d:c597:474f with SMTP id
 23-20020a811317000000b0038dc597474fmr16278ywt.183.1668645878185; Wed, 16 Nov
 2022 16:44:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:54 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-5-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 4/6] tools lib perf: Make install_headers clearer
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

Add libperf to the name so that this install_headers build appears
different to similar targets in different libraries.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 1badc0a04676..a90fb8c6bed4 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -188,7 +188,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libperf_headers) \
 		$(call do_install,include/perf/bpf_perf.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
-- 
2.38.1.431.g37b22c650d-goog

