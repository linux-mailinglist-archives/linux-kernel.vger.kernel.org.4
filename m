Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA724728EF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbjFIEdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjFIEdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:33:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669D30F8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:32:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5655d99da53so30888517b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285175; x=1688877175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASHCbqrtMwwghLa6ldqtFIr9DVtYxGlsru2IeiO0chg=;
        b=zI3WfmrJTWofT6Q5ncQ6jKrXFR1E3mo9Hit36AdOzyBeM6PnVVNbAQ0WNi65k/+zcA
         pR2aXpJwJaskgwdpY+kRv/hyUfkVL91tivrmkolRVBjmQdoGjBGJK8oZSBVLsoqMge2S
         m/lWXRXuPDMh/9dfkqwUN7EO5npxmr1P+sWYJUgYfC7vyvYirx7VbhA7HDJw1f+GYZ1K
         URTRPQTOWSQMbs0l9jWvaD1fHKYrDJLDjBvCQUkYBykXnnQniZAFVt+rref9n3kl/MF0
         jAgELj+szWLc9gT7BHTUJeXYu9loowgmmr1rSX6Hfxtz8VUyMus1WO5K8VcaKT/GzcZQ
         nf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285175; x=1688877175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASHCbqrtMwwghLa6ldqtFIr9DVtYxGlsru2IeiO0chg=;
        b=helGB/met+1vk5tGhtklVfFZ/WLiVsRP26Bla/BuyLdGLu5hDqcVE5XKZc19eMfMeW
         xmOYsVQl3RUO8r1Z0dTK06T81km63Hc/onUxhfUeJXqWNmRKb7fRhBOYcMPSG9y2n1sX
         ufBDwKggbj19CMOkdtqFoOOMizSImANI9/+aTUhl0yHdjdl3bcEvj84UFwVgyqWsL7s/
         q1deLywfp7Ou96NmVMdB5rboVYRt7IclU56bq04TmCo3Kk//ZJQEgNEuCiylEzBld1YH
         aJ1NdKrN/Y2tR9esfWYPXsBn9JZMYQz8IuIaO+V9YtjQ1uy80iu5JfLyVANGlQ9BAkkQ
         ORew==
X-Gm-Message-State: AC+VfDzDJIKNfjBbBq/xovE3bHMbpCsr9ci63EOTw8VqBVbVwyKqv8Wq
        6bE5JfFvfPHtSDXJPOHJ94Y3MIS8WZKM
X-Google-Smtp-Source: ACHHUZ4iB6nP+HsqtQdFaFGqIVReKInr9ZAzZ0P6gBKiMmd7L9cSwiggbWzNxk1AoADQfIFADF2Se2xAo5yp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ae59:0:b0:557:616:7d63 with SMTP id
 g25-20020a81ae59000000b0055706167d63mr538367ywk.1.1686285175731; Thu, 08 Jun
 2023 21:32:55 -0700 (PDT)
Date:   Thu,  8 Jun 2023 21:32:40 -0700
In-Reply-To: <20230609043240.43890-1-irogers@google.com>
Message-Id: <20230609043240.43890-5-irogers@google.com>
Mime-Version: 1.0
References: <20230609043240.43890-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 4/4] perf build: Filter out BTF sources without a .BTF section
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

If generating vmlinux.h, make the code to generate it more tolerant by
filtering out paths to kernels that lack a .BTF section.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f1840af195c0..e440793fc6ca 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -193,6 +193,7 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
+READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
@@ -1080,12 +1081,34 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+# Paths to search for a kernel to generate vmlinux.h from.
+VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../vmlinux					\
-		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+# Paths to BTF information.
+VMLINUX_BTF_BTF_PATHS ?= /sys/kernel/btf/vmlinux
+
+# Filter out kernels that don't exist or without a BTF section.
+VMLINUX_BTF_ELF_ABSPATHS ?= $(abspath $(wildcard $(VMLINUX_BTF_ELF_PATHS)))
+VMLINUX_BTF_PATHS ?= $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); \
+			do \
+				if [ -f $$file ] && ($(READELF) -S "$$file" | grep -q .BTF); \
+				then \
+					echo "$$file"; \
+				fi; \
+			done) \
+			$(wildcard $(VMLINUX_BTF_BTF_PATHS))
+
+# Select the first as the source of vmlinux.h.
+VMLINUX_BTF ?= $(firstword $(VMLINUX_BTF_PATHS))
+
+ifeq ($(VMLINUX_H),)
+  ifeq ($(VMLINUX_BTF),)
+    $(error Missing bpftool input for generating vmlinux.h)
+  endif
+endif
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-- 
2.41.0.162.gfafddb0af9-goog

