Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4948D65FB57
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjAFGRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjAFGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:16:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E46CFDA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:16:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so972151ybh.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=FD+9b2BC7G6wp1RX4Zlmmp4Hb9G65TpW7cDfR3jRy7lIv397XuI2wMBzLeKhNfG3ie
         gaLrkjp+GuVOyruOeqib5Bk7mY6Lhau5XAg/K55bSJx177ozgbSwJPOPoBAlh6iGM1Kc
         0YuuJ7jeGD3vuqwkLJ97g5cfsbkrg2VoyYi4AxI/sFez/XUp+5lmOTIjDOLeNFxTMNBB
         40w2dm1yuZ8CEPgEtqNtT1Tjw6uPXmh/XkkYT/VMEHUGEyqZ1/YSr+V2qfljgx74gUXn
         RtOY7j2U/cYd9F+nAy3ouNrOkRNNC4Q/EZ6/j+/k5HQRy2zM7bx84B7qMwbyxUl8QZps
         N6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ELKsvqp/CVQlQh6V4i31lh01VunlKiC/zGB5BPQtSo=;
        b=RPYRFNLWd/pvlCjYh5UXWgj5ABTUuY1m1xBLQXyzETpIsHJ+hje7JKDJP++QFFuQh0
         r8w3LNqyMaUInADvHcLU5j3CrcY0j5ofjwhcnLpalzJmoYDKDch/CoP7wv4mnINY7m1r
         mmf6Z9wfePWUBGafxGg1gNQQ92xC3JEZCnSS2PL9dugcvxcXgZ5WSdwoyUHAlmHDqd+k
         v7N+JrXqeQh8v74B0g5gZI0ejuNK3vUrGIpVS9H7Sa+bc/6sX7CMQI8Hjv6rCwaMhTPg
         Erd2KpzRaOoxAaGmsR3WeWI81NN95glvdQU8XIP75WDaF42VS4XnRyAvb+XbcKRbOI3g
         iFcQ==
X-Gm-Message-State: AFqh2koYO6rYzYfug3/twQUynobsCELgW9lNCbb7u+Hax1jrZYTDriap
        mZGGadkXu+sxk8E8FwGKhOBabMrWvqJ2
X-Google-Smtp-Source: AMrXdXuEa+hE8IGo8QRTwe0GaP5vmgi2S5IZ46ckdBfVNuEnI5WR/9UKlq3NfjLxAuttGhumPk5/Ks0kVfSA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a05:690c:841:b0:480:274c:bfac with SMTP id
 bz1-20020a05690c084100b00480274cbfacmr4305130ywb.104.1672985803154; Thu, 05
 Jan 2023 22:16:43 -0800 (PST)
Date:   Thu,  5 Jan 2023 22:16:31 -0800
Message-Id: <20230106061631.571659-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf build: Fix build error when NO_LIBBPF=1
From:   Ian Rogers <irogers@google.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
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

The $(LIBBPF) target should only be a dependency of prepare if the
static version of libbpf is needed. Add a new LIBBPF_STATIC variable
that is set by Makefile.config. Use LIBBPF_STATIC to determine whether
the CFLAGS, etc. need updating and for adding $(LIBBPF) as a prepare
dependency.

As Makefile.config isn't loaded for "clean" as a target, always set
LIBBPF_OUTPUT regardless of whether it is needed for $(LIBBPF). This
is done to minimize conditional logic for $(LIBBPF)-clean.

This issue and an original fix was reported by Mike Leach in:
https://lore.kernel.org/lkml/20230105172243.7238-1-mike.leach@linaro.org/

Fixes: 746bd29e348f ("perf build: Use tools/lib headers from install path")
Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |  2 ++
 tools/perf/Makefile.perf   | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c2504c39bdcb..7c00ce0a7464 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -602,6 +602,8 @@ ifndef NO_LIBELF
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
       else
+        # Libbpf will be built as a static library from tools/lib/bpf.
+	LIBBPF_STATIC := 1
 	CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
         CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
         CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 13e7d26e77f0..4e370462e7e1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -303,10 +303,12 @@ ifneq ($(OUTPUT),)
 else
   LIBBPF_OUTPUT = $(CURDIR)/libbpf
 endif
-LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
-LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
-LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
-CFLAGS += -I$(LIBBPF_OUTPUT)/include
+ifdef LIBBPF_STATIC
+  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
+  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
+  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+  CFLAGS += -I$(LIBBPF_OUTPUT)/include
+endif
 
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -393,10 +395,8 @@ endif
 export PERL_PATH
 
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
-ifndef NO_LIBBPF
-  ifndef LIBBPF_DYNAMIC
-    PERFLIBS += $(LIBBPF)
-  endif
+ifdef LIBBPF_STATIC
+  PERFLIBS += $(LIBBPF)
 endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
@@ -756,12 +756,15 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(arch_errno_name_array) \
 	$(sync_file_range_arrays) \
 	$(LIBAPI) \
-	$(LIBBPF) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL) \
 	bpf-skel
 
+ifdef LIBBPF_STATIC
+prepare: $(LIBBPF)
+endif
+
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
-- 
2.39.0.314.g84b9a713c41-goog

