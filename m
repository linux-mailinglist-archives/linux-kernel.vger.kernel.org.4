Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2762CFED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiKQAoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiKQAoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D830F6C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:44:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so99901ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNMS71QGgMyiDDcWnBqT0Vm7b+FlfXyIrhX2KKNl5vU=;
        b=WRkngDm1nYoGTot/sMk//vv3KXsXqd/uIWKtg/grIq0H+xPrEXDqaBUe0J/gYuNXY8
         epZ7tmWH6ueR2brySRXtPAZdekjSznygksUy9A4cJ/Y+gX+zovyXvzrHqOInNyxhEkHA
         U5yHRo3Fzo9qN7OnPnsipbq9Z3lbjaF+tnmIemeCfFB/QoQUYHby4EgxScXo+gTOU+pK
         SnE2mwS96obcbXoaAFyuSktQ35I2qoCcfnjJTwaxjBXXiXMJSljr97YgCMAHwZ9M2AhW
         x8kBYiUxDUBxKxnjEX22HwDbcFZWbs2EM0AT2sQk/hkURh4GmKZv6I9AE6JKKiEkB1ke
         8zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNMS71QGgMyiDDcWnBqT0Vm7b+FlfXyIrhX2KKNl5vU=;
        b=EO7IDeiprSW0oc/916kGKC6kYKG7lcIi+KWvcQB238WZBQlO31MPV7DELmGnGsEeLs
         eoZCr/qywCVvN8NSYWBvFjTJImtPG0lXmcKiGoVGh6lsKyiF7fdc8kl+LmLniMyxdqDJ
         X9IXldsmT+Jd9sOIuoAvsOtc0HB+V5oj26Tlt6FmpIfkiKygn9939Hr9PARB5XM4romB
         M7kXuoTj5GwxhxKcf62XQYKomhVTWeDriFWee8zrcDCBdN/WmP5m7mFkLRpUr7o1CdXo
         t5uERtIMLGYTZyRxPcPp7wc2Cmyh5c9vVaaBvtv8bhgpGORsEf+EHMkwCGESauUCZsRo
         heHQ==
X-Gm-Message-State: ANoB5pkfGyV0sIr//vAOsaMUCqqUaQR7/jGQ9fT+lLJq8b5u/mRObM4E
        Qkm1DDCZrrpI/9l8s2zt1KLzpj9vdIky
X-Google-Smtp-Source: AA0mqf4+Le8z4l+/dOM/XNbLjn6WfB0Io92l349YHxi1tHD+Bh9fprUmk8VeKaN6lsaI7QOT9S/8LvO3GIJ5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a0d:e743:0:b0:378:5f13:25d1 with SMTP id
 q64-20020a0de743000000b003785f1325d1mr4585850ywe.192.1668645854440; Wed, 16
 Nov 2022 16:44:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:51 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-2-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 1/6] tools lib api: clean up install_headers
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

Add missing backslash that caused an install command to always appear
in build output. Make the install headers more specific.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 3e5ef1e0e890..3649c7f7ea65 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -100,12 +100,12 @@ install_lib: $(LIBFILE)
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libapi_headers) \
 		$(call do_install,cpu.h,$(prefix)/include/api,644); \
 		$(call do_install,debug.h,$(prefix)/include/api,644); \
 		$(call do_install,io.h,$(prefix)/include/api,644); \
 		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
-		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644);
+		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644); \
 		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
 
 install: install_lib install_headers
-- 
2.38.1.431.g37b22c650d-goog

