Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5446962E7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiKQWFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiKQWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:05:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800F72137
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:04:04 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-38f92b4b3f2so31674157b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zN9iF3uBflZ8Xy8LWXsRFnlUwRcK8nR9vFeAViyEg3w=;
        b=FUio/DfydfYdb4IgGKrax+IOOSEJyZUeqqiG6wojZ5ImpN1x/0VdJkeNBd0UKi596I
         lkJTMztN1RVInRqP5wrWWgeK/HJdpL5UyMv54TW2UbAO9JUuFddGEcr0dYLZzyEs6OYo
         NdCDjTvRAGryqn4n2RWdHtzGQxjNVNbNs08ihglztICussWb4blWNiHbQLTUdqax+CkF
         2hjboqb+JJd696ClfAYJ+S+6hqUkI6cn4+8ggjVeusxMPKO4b/XD06eXYLlJJRFouYAe
         flys8fyoIfzXW+Y+2YkfbkN5zhuMZ7Gd8ogck0qqWcL19iRBN1pWq58MFO7fNrwTia85
         9XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zN9iF3uBflZ8Xy8LWXsRFnlUwRcK8nR9vFeAViyEg3w=;
        b=2w8ie+4s3oPa+iQgwmfwAZagRjhVmbiT8v0txFYAQUlmtFhHd5LmzmKUaa8KptJgnx
         Q2tm3yoDc1OscISb3cNQcsYLucqnA1ViWN2CIH6pPj26rpPJynmkF7kRjh5bNAnPoiIl
         TXyUCBT/HXr5ly6c35sTRTRoae5DY4kc4lpCE7MjytnwDu3JDwlVkdvXsRBffqBil3QX
         8gGkX8BsPXeVS+fhA6r3rt9/qDvdbfkySGP6S/xQLlgN6WLcNV3AN4bDVyQR2wAKkAld
         /89hkK3Glt3Kimfay8cT7pgurj8y0xMvjrAq8zTnGAXqsya5njBzUYXMl97y6iqNFFk3
         ak7w==
X-Gm-Message-State: ACrzQf2ipE/sXdOhfLt+k9mfJtj+CbNaBHKYnWvPGLZKXLR4NCeLtrLP
        CctwaeXgNB/W9VOb8XIbizfo0Vtdm536
X-Google-Smtp-Source: AMsMyM5CTKueFGy9Qd/m53JJOFRV1XwPwIJNhVGOlS0rwF/YYeBx81ISVfmgEwv0sD0U4ytnYS9X481jA3WO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a81:79cc:0:b0:367:6127:ad8a with SMTP id
 u195-20020a8179cc000000b003676127ad8amr64703162ywc.60.1668722643602; Thu, 17
 Nov 2022 14:04:03 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:03:38 -0800
In-Reply-To: <20221117220339.341290-1-irogers@google.com>
Message-Id: <20221117220339.341290-3-irogers@google.com>
Mime-Version: 1.0
References: <20221117220339.341290-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v1 2/3] objtool: Properly support make V=1
From:   Ian Rogers <irogers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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
index a3b55c807a51..6b6c20ba5160 100644
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
 		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= \
 		$@ install_headers
 
-- 
2.38.1.584.g0f3c55d4c2-goog

