Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5236F8DDF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjEFCPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjEFCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:15:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102C5FF2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:15:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so3048254276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683339305; x=1685931305;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJf4bwuwk+xW5YFYNv2ihAkRZ7CiJDxHsIhFi1q/46E=;
        b=Ti63042aDcnZkRbwB60td25AhQmPK47NkWC4qIEwqnfJdGnj0R04pdJ2Hmgfnm0P9x
         pnr53iBTBqHhMz2a1cjdh1lJqGEd5NO4jdoPES1QWLOzDszwUDRuyE4gKQQMKrzAdbQT
         GWNLK3lHqXnKx1gm7p/uEzOZnR6dbIOScU4gUUyzFaULBVNQLD01x1ht1EjMgDk3zer0
         CrIFaKj0/OeOYRjv2KXodKeX6aLlthx7d9iJuEd8xAbtDgONnObWblpk0L8UPOopVPgi
         tU5oRk2o8taGUXAsOx5REh74Eus7puNDh4VdSRLZvmaZKJKRfnaUz0JG52z6+kCQYJVk
         g+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683339305; x=1685931305;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJf4bwuwk+xW5YFYNv2ihAkRZ7CiJDxHsIhFi1q/46E=;
        b=kVRXdIIs6ddtr4s1Q8uW3wQikAYrGqqjFKFJixLdjLhb6qqcr5bBhjRKsP+m94Fqqw
         VGqdmR8vjk+HVBRXl/+9coGu3CWlTelSe3Yn6aQy+04gscOlT5mkK6HESF2TBgLNQI6r
         /zmXQJuANxdkNPNLUbekxRZbmSWkby2gSQ0H8c8O0Mc4wewzTI+jmN06g8HJC9qPGSqE
         B3eKufAhucFnH5VUTLf+HfpYfaGsy4IfTKKf+R1j6LZPVjoaQkCMimo1b3gquvQZT/eM
         efkoPnuV1JAm8Hk1IwHyG0JvRuSwjtaAcxQpRX173CBWjnkhR7GoomyvSkoonxGZMKKX
         mDOQ==
X-Gm-Message-State: AC+VfDx2dZmea55+2+0Wt+VXIVqNpswhdCJvGsTLVLtpbcd6ZXC2daJV
        V34hX05layHNckam1f+PBJeLm1ni86qt
X-Google-Smtp-Source: ACHHUZ7fCEmGVZcSm742KT0Xx/0ZWwbb5eOxYd/8GGeWHCsrV/oXhwWrE0VcUJkh0NBstgJVs6bMKgnnycng
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:4715:8e64:29b7:6c4])
 (user=irogers job=sendgmr) by 2002:a81:e206:0:b0:55a:3532:2fd5 with SMTP id
 p6-20020a81e206000000b0055a35322fd5mr2078640ywl.8.1683339305504; Fri, 05 May
 2023 19:15:05 -0700 (PDT)
Date:   Fri,  5 May 2023 19:14:50 -0700
Message-Id: <20230506021450.3499232-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1] perf build: Add system include paths to BPF builds
From:   Ian Rogers <irogers@google.com>
To:     Song Liu <songliubraving@meta.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are insufficient headers in tools/include to satisfy building
BPF programs and their header dependencies. Add the system include
paths from the non-BPF clang compile so that these headers can be
found.

This code was taken from:
tools/testing/selftests/bpf/Makefile

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 61c33d100b2b..37befdfa8ac8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1057,7 +1057,25 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_
 
 ifndef NO_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
 
 $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
-- 
2.40.1.521.gf1e218fcd8-goog

