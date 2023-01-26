Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AB67D514
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjAZTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjAZTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:07:37 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E162468102
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4d4b54d0731so30260657b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qJcEY+ZX+KD+dakVj5PWdl1/U84NI1vMkfserB11IU=;
        b=VBuKku8BGWTkhWFizWHyyhUjws2wNvltFz3NGcXto9JQYc64mPSLQpHRQmInfxQdrH
         /iK978K8qVY2ui7retQHnfBzrH+rwZ+XmdnBZJmd2iEEazJPCaze9LWAlMqR2++yJLUO
         bz5PujbGBMPAklGyFoIr73HThaY118yfD3kcQkFHL1Rcrs9feLoyXDaQLGokfVRXcwN6
         dxrAZIcpPuFgzX05bfzbZ4xXomN7k1XtTSICMep8lQ132PPjbZVv+6cxC7BsEAZ3B0nx
         7GAENPXEyyOirEF0yLNNsewj/5geTHVosmTTISsuLGCYokw5E+jmI/PGOcXm8/ebM1BB
         Pz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qJcEY+ZX+KD+dakVj5PWdl1/U84NI1vMkfserB11IU=;
        b=v9NJFv9Aos26HcPa08ElpnsdiMTJGlqmyXvCuY9kLTuWcAyFTJjs/9VgiyKr13O2OH
         RF2DsS7jJx+X9sQuuOUj8qXojUIGCkuWaEUUum/N34VG3b7dqS5E1EGL2u3fKHtCl8iK
         dtRS88y4BbYAM7eU5FuRxy7dq7xsfcqMI0wZgPukLWBLgp/llfe7xOXy8Ab2bBZqaQQQ
         CQvUxDoue1Mr2gYRTHpJySybAXum1tw/XIQDhBc87iLAkFWKvHsZt/Ew98YBUomrNjUk
         VZb/rWHKaKcoVDCTT3jdGiVXSB1NoXQxgbKT3drMWLvwbcMg8ONRM4UfYMi8hwHjBT8V
         yvxQ==
X-Gm-Message-State: AFqh2kpDMG+dAnstHo2Xtk1sYoPstRgPqGD7X7+5FMx5NMEF4IBUuTKp
        LWc5c+7lNn/UTtcsCzItXoYuDfYJ/hbV
X-Google-Smtp-Source: AMrXdXv8TJ3rPCwa3wVZ7YApAJ0g0saNF9wIGtAze1pHV7rFkK09vJ616P0Gbuqe3EVoKsGLKVVOIs3kXdA8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a0d:eec6:0:b0:4d6:5735:dbfd with SMTP id
 x189-20020a0deec6000000b004d65735dbfdmr4440830ywe.157.1674760041142; Thu, 26
 Jan 2023 11:07:21 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:06:05 -0800
In-Reply-To: <20230126190606.40739-1-irogers@google.com>
Message-Id: <20230126190606.40739-3-irogers@google.com>
Mime-Version: 1.0
References: <20230126190606.40739-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 2/3] objtool: Properly support make V=1
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
index 0bfdb9da8729..f0651eac06e6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -45,6 +45,12 @@ CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
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
@@ -56,18 +62,18 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
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
 		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
 		$@ install_headers
 
-- 
2.39.1.456.gfc5497dd1b-goog

