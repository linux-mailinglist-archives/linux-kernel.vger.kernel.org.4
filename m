Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6A63312D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiKVAM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiKVAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:12:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B0C4949
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:12:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s18-20020a17090aad9200b00218a1ef5c00so2440860pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAoGw6w4KlL7DQVt7ZsS6OCEJRbgq50upBPjFJ4o4ig=;
        b=BrggVwj0H1omWRQ69YMIUK21XBMjpa7HVYTK62MFY+Cb1CVXGLi4683S8vfkF0PlDM
         iakDSbG0hQ1GrjLKiYu+30WQWoGLlKWLb0p65JCmlI1aDPoMI0jiuCnzgxOflZSLS4Mo
         +D88Umt4pSij+Ntjtuvcwcw5DTxcYIBsaZnO5JLYqwEig0u1hFvA6h1s2vePSQZbhaMn
         2tPAC9dLJguoQRb9z1bn/v20WbWjqhZzy1ZSqHvEYvPvmcxzrjqilM83hKRKhTVKkAYk
         eAqcLKxHBZKEubi4UsMMBTlys38TZYdzQ1RoNwRZ7qYQqamyn6pG9gfN725/Qq4ewSwD
         AL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAoGw6w4KlL7DQVt7ZsS6OCEJRbgq50upBPjFJ4o4ig=;
        b=kwosJrpF+AZuSCF4fernJ0GvEe3qrN8AGepqzdxW6MjzYB5pHOzaoilhcE5VAGfTSa
         bts87OKxyuOIw9oqmpb4593slH/hRb4EKz4TtfB5WfApp6UctKAuS6dBuJvhvp2ROWU4
         YGI9Wy1x7Ss2zPg+4p0NOd4Luqzqb3Lgl++jK0sUUq+FIAO6FPEpzxjW7xv/5N7VFnMZ
         UC1pRrGU8P1z0WX/nUdUQm2js37pDKo7Rgxt6G1q2Rqu4O5qogaDI7I/rgwdwD4jSshl
         iiBNeabiKRXhCihTgx3V6j7LEwvfchVkKeDqCK19Ho0zZj5N9ZfRnUydTb/05qUYi/xu
         IZpg==
X-Gm-Message-State: ANoB5pljrbJmbkLLL3Vi/MiEs4VGtvJSlPdcCUxKsi6f/YKZkbKtlPQb
        VvSVCVaeQUsBcpYew7oERu1biF9VbiCc
X-Google-Smtp-Source: AA0mqf5Kgc3bsP9gBxnvcDjksJSsFLESy8wL+H9dz7KepClvv259CCM7hhm9K/74CsCQx0djpkoaoVYlMXAm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2107:a1f5:8582:5608])
 (user=irogers job=sendgmr) by 2002:a63:f4b:0:b0:46f:98cf:3bb6 with SMTP id
 11-20020a630f4b000000b0046f98cf3bb6mr1125125pgp.332.1669075924133; Mon, 21
 Nov 2022 16:12:04 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:11:24 -0800
In-Reply-To: <20221122001125.765003-1-irogers@google.com>
Message-Id: <20221122001125.765003-4-irogers@google.com>
Mime-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 3/4] objtool: Properly support make V=1
From:   Ian Rogers <irogers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
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

The Q variable was being used but never correctly set up. Add the
setting up and use in place of @.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index fd9b3e3113c6..61a00b7acae9 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -47,6 +47,12 @@ CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 AWK = awk
 MKDIR = mkdir
 
+ifeq ($(V),1)
+  Q =
+else
+  Q = @
+endif
+
 BUILD_ORC := n
 
 ifeq ($(SRCARCH),x86)
@@ -58,18 +64,18 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
-	@$(CONFIG_SHELL) ./sync-check.sh
-	@$(MAKE) $(build)=objtool
+	$(Q)$(CONFIG_SHELL) ./sync-check.sh
+	$(Q)$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
 $(LIBSUBCMD_OUTPUT):
-	@$(MKDIR) -p $@
+	$(Q)$(MKDIR) -p $@
 
 $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
-	@$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
+	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
 		$@ install_headers
 
-- 
2.38.1.584.g0f3c55d4c2-goog

