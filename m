Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA19965E73C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAEJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjAEJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:02:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A150077
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:02:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4755eb8a57bso285854147b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3C6oUUNqAe6SouB7tmV8ak/X52sdVelkHDk9iVtEts=;
        b=WPFw1OLNMuFxaskhsLx3FPzw7/x0/K4eifGQNNWYSlsuL1S+86v33juk06zYg+uPoE
         G1GVeLQbT0/duDibET5al+ECKeQ/qi6++s2naUGTlzTYW4fUZLBCq7/Lbrj4mxLMPkr2
         cSl9uxxC9lnB7Vd18Wy98iI828Y3CeQTbpqa7JIgkjjRPv6sCn1Q59jnbsDYhC0wjXPh
         kHaZ2YxCpQt2q5rBpv8mSEQtDFoD08ulvxKb8NWz3gzWgw1hOJKkYHpi2604Yip70ewj
         DWE3sFX19lDfNmlqw0+n+c8UZzqKAXu+glEoKxTw5dxFTx27Hmrx8b4SFPVLpgO4jK9z
         M1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3C6oUUNqAe6SouB7tmV8ak/X52sdVelkHDk9iVtEts=;
        b=xb4+F6JP/BDn6jpSdEZ4Uhly2wlOXBJP1a4pHAuhZoZyFyIiRfedC7EWt5yfIUmHfz
         E80UgAdhKNr6nQd8h0SVWpyg5Gt6ISC0vGATeyx/YWlzNQF2yyJ4IQ2fYulT5UW17jV9
         uNQ1X2EVhhvzOLM+GGWndnCK5Y/7MecZZ2IK2UcxyMDt3z5IIwXb6CCBxOFXqNtwOPgD
         ftNuc1+KP52I7B0VrQumwGaWnCFmMOwc3/ec+TzhpIF7aeW9nfGIsYCTy8mcsSvWgeyz
         CA8LYUtYWr3Za6afFl3QZo7H+hQs7PisFyVMBtOfbmPNOcq+mCuK/+DQ+D/XiuT32v0R
         rTaA==
X-Gm-Message-State: AFqh2kqtMxZB/or0/5bWK+DHB4i45/seu7DRnYpLyZfKwaYv2R9ESIeP
        /6+ls5G+d2csCePGt9rYs3+KRADmZAgP
X-Google-Smtp-Source: AMrXdXtQ3oct9AuOg8tpYlHoVap9HA92AlqYosjKfxvMi1WZB5Yyg9L7G7FvwJCR6zISwzpntqalJV+Av0kk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8775:c864:37e:2f9b])
 (user=irogers job=sendgmr) by 2002:a25:c03:0:b0:716:deb3:141b with SMTP id
 3-20020a250c03000000b00716deb3141bmr5110692ybm.508.1672909343036; Thu, 05 Jan
 2023 01:02:23 -0800 (PST)
Date:   Thu,  5 Jan 2023 01:01:54 -0800
In-Reply-To: <20230105090155.357604-1-irogers@google.com>
Message-Id: <20230105090155.357604-3-irogers@google.com>
Mime-Version: 1.0
References: <20230105090155.357604-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v3 2/3] objtool: Properly support make V=1
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
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
2.39.0.314.g84b9a713c41-goog

