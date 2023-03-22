Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D809D6C53BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCVSbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:31:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCB05DC93
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:31:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 185-20020a250ac2000000b00b6d0cdc8e3bso9115683ybk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679509877;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=34HlRQ1gcT2PlbL5hNFUNzD09FdwupW3+W5oKaTfGaY=;
        b=O0ViQe40TcY2A2J5cOabGBkGWQFtQspdCzkuQGVKNBhk7eetQCd72+6SxKbvBrkiUa
         PwErLKNGgWnWENtj1/HFLWHB+v8wjh0J4eBFkyrirgLenO0pH/ZG+NJQvQS/PaKqUUpx
         sk2l+rNOjKtuLWW04Qi+MLUtrJXX5nJQgvGCQV08OH6uwzLnIJxaQB5y4yuslBq8u7Eu
         lAFGCUMXRucgaTcK6/79iEGD3uTUkBeCbj2pyQIcMbVn1P0kkrtp+L9VzGWeCyBCvSoZ
         FDcUQXIrhIbNl5lTCuF761xhMrlazDZ/mp/hE56rv6qkYwdDysTOnZMDtwzxw299LnUI
         WAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509877;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34HlRQ1gcT2PlbL5hNFUNzD09FdwupW3+W5oKaTfGaY=;
        b=nmEs5aVPfa6EGF8VcuqaEdhX4LRU+MzHqPTuhN2D3hMqbg2YnTTxyjgPWV98qZkHaS
         5IHXXTxj0qkknbKNKUY7olSBndPXt+rmBQqSj6ujd9LUp7KgoE2hslGwGTOcaTWlugZ4
         SrqqqNSjGbHUwN+7qgtC0F0eqCQm39HIVMVv5093bRu72LePSpj+cP+cf86xQHhZJSMh
         cCj58pa1fRPfQRlPYER8jgSg7yeNbVUn0D1gbcsR7t3Nwut8DOefnc+DQ/AlIBZSoqiC
         Ip/hGscY2nz3sth6pqxaGnMjZbcfR4bNeiIQYOcyOk1TOK1TzVbHjDFywwQgbtQw+6u9
         fKFg==
X-Gm-Message-State: AAQBX9dibg2Wtzrn0KSgg+0TmVoGZkPSgSjXLo6XOyRzXvWhhxleFyMA
        3knqYOME+cl3W0eBXbycIMxkaLguEGfZ
X-Google-Smtp-Source: AKy350YE7oxuhEOv3jwpAZPCZUoetgVOYeJAI4ABDQxnsPk4ZLX67WhN/2TPmuC7mynE2Gw1s8tvhxSJx4PB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6fe2:153b:3323:a17])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:b67:d295:d614 with SMTP
 id v3-20020a056902108300b00b67d295d614mr402792ybu.12.1679509876553; Wed, 22
 Mar 2023 11:31:16 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:31:08 -0700
Message-Id: <20230322183108.1380882-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH] perf build: Add warning for when vmlinux.h generation fails
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ian Rogers <irogers@google.com>
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

The warning advises on the NO_BPF_SKEL=1 option.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ed6b6a070f79..48aba186ceb5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1072,7 +1072,11 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || \
+	(echo "Failure to generate vmlinux.h needed for the recommended BPF skeleton support." && \
+	echo "To disable this use the build option NO_BPF_SKEL=1." && \
+	echo "Alternatively point at a pre-generated vmlinux.h with VMLINUX_H=<path>." && \
+	false)
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

