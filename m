Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408AA6DC914
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDJQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:09:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134CEE74
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:09:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54bfc4e0330so138692427b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681142957;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hgpNSuwaIz5SOsDrctN1Z4DgOM8CO/tlKIwgfsZ4/ck=;
        b=KbN+lzS+lcqidjAbQxa0GvXCAbmu1egDuByAETgeMWyb2/CMdMenHNWowg+xUpH1oB
         QA7VrhCCALf4FouV8PrBU3pWbFqStiTfMYthOzYL8edyh46/hFQ4CCiXDnYrR9xhc2fA
         GYKMHSIvehSvwJtxThZcxBmK2aQV3rdCDrKz678KucttKrgJyWSQ4agd+zrXFCLqRTKy
         rI3fzOdO2l8cNcKq9ZyuFKMtUULQbVBORHrIhTcta+LWtGyflnxit5D25QTuU+XUzKEu
         lZQUicrUwcjApxPLdUCbUbC+w+EWijpvTI42Y5mwbyYyb2JQFm3tqCQyHy5s5uZ2Pxad
         Wlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142957;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgpNSuwaIz5SOsDrctN1Z4DgOM8CO/tlKIwgfsZ4/ck=;
        b=kgU6jcahTmF295fEbTMA//i8SgFmEoTI5KbCzUtu4/Lxxuh+1up72kRb3TevxHdNGV
         6ig/SSDL6ylv9OEgezvehzkxpyFw+a2bE7CB3rpZQehM//UJnfJJlnwGNvTdTWDSSudV
         aQJ0LLDiu4/VvTyUMA1L+EDXtpa/bmBQjFpNPhwNKUAYtYZXCuNIiADSjzpS5vMXRSLq
         vOtAc2nZ7Mhi5HMe+zSX7fpf/mCBpGnT4Z/ouC2qKJoKzjK1lXl8focj0AE5+n0/JoLk
         jetYPxqHKewuCt4wVZPL4DvUCk/Z06hTjsMmUk81/By9jDK2Maz8D+8V/c+zkRogYhN6
         BC1w==
X-Gm-Message-State: AAQBX9eR1NcpntI4lDZgFe6gUPq/2sephJQgWGq6d8KS7uxxiNLZ4Bzh
        /GrxWrYtlt2kasSlJbgS34YWFS8sAiAC
X-Google-Smtp-Source: AKy350aqBjJi0MjweR+Koinf0C4KZg04ZAy6t8zBhmoqTxsbnU8+cn0bFgYqbOxeoJJa9GhGP7nsB2ORSjwK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a05:690c:31b:b0:54c:15ad:11e4 with SMTP id
 bg27-20020a05690c031b00b0054c15ad11e4mr7321151ywb.0.1681142957303; Mon, 10
 Apr 2023 09:09:17 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:09:05 -0700
Message-Id: <20230410160905.3052640-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2] perf build: Warn for BPF skeletons if endian mismatches
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done as a warning as I'm not fully confident of the test's robustness
of comparing the macro definition of __BYTE_ORDER__.

Signed-off-by: Ian Rogers <irogers@google.com>

v2. Is a rebase following patch 1 being merged.
---
 tools/perf/Makefile.config | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 16bea51f0bcd..71442c54c25f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -663,14 +663,17 @@ ifndef NO_BPF_SKEL
   $(call feature_check,clang-bpf-co-re)
   ifeq ($(feature-clang-bpf-co-re), 0)
     dummy := $(error: ERROR: BPF skeletons unsupported. clang too old/not installed or build with NO_BPF_SKEL=1.)
-  else
-    ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
-      dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
-    else
-      $(call detected,CONFIG_PERF_BPF_SKEL)
-      CFLAGS += -DHAVE_BPF_SKEL
-    endif
   endif
+  ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
+    dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
+  endif
+  host_byte_order=$(echo ""|$(HOSTCC) -dM -E -|grep __BYTE_ORDER__)
+  target_byte_order=$(echo ""|$(CC) -dM -E -|grep __BYTE_ORDER__)
+  ifneq ($(host_byte_order), $(target_byte_order))
+    $(warning Possibly mismatched host and target endianness may break BPF skeletons)
+  endif
+  $(call detected,CONFIG_PERF_BPF_SKEL)
+  CFLAGS += -DHAVE_BPF_SKEL
 endif
 
 dwarf-post-unwind := 1
-- 
2.40.0.577.gac1e443424-goog

