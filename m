Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5D679135
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjAXGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjAXGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:43:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7EB2F790
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:43:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so15394017ybc.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLiUgRxZdGZYiSZ165eOITlDJVlV/uBeiaL/Kxqq0V4=;
        b=h4r10sLT6WJizWZ+32PeDetMXPWTz99wn6R7iFGww0SiNm090G+NeKJDT8q5hS4+oa
         MBt+/GP91cHfBkeoC29TmUCY1S+dQw2uxBmTPExdWUqJZdO847By0DAel3BiIpnhzYIk
         jJjlZDQ4rRz1zPlm5xXLrv0Amrm9f3q3OpsZeMRxxOYp517q1cN7LTyZN+/Yuci5LOTI
         ENH9DsWcU29i2WQc1u0zrEsqZcULwV0WvWA/llAUjaM3xZemrt1qQQxjoF4OFYJtAcqy
         4mhOXN35TujDOHNma1zSxlwKHK4zKwmb8+HIG1vIspDdLQsYdaKlloX20QO1AcbRWg2f
         0sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLiUgRxZdGZYiSZ165eOITlDJVlV/uBeiaL/Kxqq0V4=;
        b=dvRBEsKKEWmyFKuiynqCsUDwaIPIvHFWc+8O1ZOcnkS5w5o6/Q+Npa/Ngahk0nRXZt
         Lti8pHkvxNWB786hQqqXNMvu96/i6G/S9Rd2vQrIi4vYMh/Q427EV8kQ3CkrzKgySgmN
         d2dervtZY9+LB6rnhQLyKdAGDk3VslsfjdYyPyt2EenxLr421zdKyh+G/jxgY0KAiB8t
         LIGK2N86nTsJhXvCQv2ygL8oaBQ5LYrWPHWibhn8YTQnhWjprTZsQMKBjWjTrQTBO1eu
         R6UFgKKtGVHb/lx3AsUVxyjKmUF84AHHzf1h1H5isAoK2ToWmcSDZZi7imE7KPoTtEhs
         7SGw==
X-Gm-Message-State: AFqh2krh2jtF2gAby8zrFzckaZzXcaCg2c/TJr0ZbHRxiGc1uiZd3XgR
        179r98F+gNcBgz62kGNxD8vLVA9TfotQ
X-Google-Smtp-Source: AMrXdXvtX2I4+lt/8rLhBMR4IekNQ+k1qyzSvt9aX0PsiKs7kYU3VK6P19HOMsLyI+M44ZMbHzXKc/FkMjXh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a0d:ce07:0:b0:473:45b8:39d6 with SMTP id
 q7-20020a0dce07000000b0047345b839d6mr2850569ywd.181.1674542623811; Mon, 23
 Jan 2023 22:43:43 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:43:24 -0800
In-Reply-To: <20230124064324.672022-1-irogers@google.com>
Message-Id: <20230124064324.672022-2-irogers@google.com>
Mime-Version: 1.0
References: <20230124064324.672022-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v4 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
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
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

HOSTCC is always wanted when building. Setting CC to HOSTCC happens
after tools/scripts/Makefile.include is included, meaning flags are
set assuming say CC is gcc, but then it can be later set to HOSTCC
which may be clang. tools/scripts/Makefile.include is needed for host
set up and common macros in objtool's Makefile. Rather than override
CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
builds and the linkage step. This means the Makefiles don't see things
like CC changing and tool flag determination, and similar, work
properly.

Also, clear the passed subdir as otherwise an outer build may break by
inadvertently passing an inappropriate value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 1fe0082b2ecc..daed388aa5d7 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -18,14 +18,11 @@ else
 endif
 
 # always use the host compiler
-AR       = $(HOSTAR)
-CC       = $(HOSTCC)
-LD       = $(HOSTLD)
-ARCH     = $(HOSTARCH)
+HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
+		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+
 RM      ?= rm
 CROSS_COMPILE =
-CFLAGS  := $(KBUILD_HOSTCFLAGS)
-LDFLAGS := $(KBUILD_HOSTLDFLAGS)
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
-		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
+		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
+		    DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
 		    $(abspath $@) install_headers
 
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
@@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-	$(Q)$(MAKE) $(build)=resolve_btfids
+	$(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-	$(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
+	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
 
 clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.cmd           \
-- 
2.39.0.246.g2a6d74b583-goog

