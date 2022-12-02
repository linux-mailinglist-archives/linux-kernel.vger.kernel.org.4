Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75B63FFA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiLBE6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiLBE63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED4CCEC6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:58:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e15-20020a5b0ccf000000b006ed1704b40cso4015551ybr.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 20:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhcm838vqRbviJVINtawNn6TNcB3z9aWYltBLm5HIxk=;
        b=PxVUhm64KsR6Mi0JEzZpmyH+ESj3GpUqdRBullEc2TxUiMuvpELl5BPD4CkqSSATx1
         aL6QaAxPJ3htK3byYaO89DGkDpFn1KRa3HgX8lWZRHnSpFb4Eb4ZQlu1Bsc7xyTIEHsI
         NOQ5J2WyixET0VOdWUYOypZJWpIZu6Q2rBfTJbftC7WMaCjfbvjIt6BwSwWzoNKVXFT1
         iEFe4fokWc/5rSyeeF0LHkHUZaAr/CLM+4B7/Jsf4BLyWytkbkPraQCiZSTjYKK4ts5S
         lOpUyFOSGaKEaT+gnY6PBMdyeS0ijyebSTbrKj6NyIoNfnMC/OT3aQZf+IMcUZsDZj+5
         xiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhcm838vqRbviJVINtawNn6TNcB3z9aWYltBLm5HIxk=;
        b=KK/RTZOK0Rf/65Y3Z1iadufqeJka9hPydPbzCJou+D2QAm2CpiZr469X3t34Tz4R7E
         Py0r+ArmbyrJtQK4oeLVfWlhek/1CdfiRPcBwODKQluJXqNdjUtKlQZ4ak+avLkk+knr
         LNizYP22YI3c3eHGWAjWTZRLn+YslNaD+RI2/YZfkFVQapAinaQSs3898J2cvHtrn8AA
         4bXO3aoQTFQCllT+CXLShvQ4VYgqajd9slp3ln+YxdHoTeY0NjZ5DxPoUde2qjHl9Zbv
         dVbYYQUwOy0wUXv3xXb+Gn/9BCdU64zAjN+GZSmJ5ASdegr9H4cJ+wep8tVOGGuiCAfD
         beCA==
X-Gm-Message-State: ANoB5plLHiDcKOZZY+cCpGKdUerjGX+jPGl/FH8qWhFgU4+TTHx2nHNE
        utKAsYKVyi3b0tmGM4MnHh+O3fPFSEw+
X-Google-Smtp-Source: AA0mqf5CfUr1ni1ydhOijcrKDrUH6Q4Z/fxX0gKX0+scEkSznJvNYmEWVgOtlPAgSNKl/d+ltip8dBgQpasK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a25:3454:0:b0:6f9:41dd:faef with SMTP id
 b81-20020a253454000000b006f941ddfaefmr14632533yba.87.1669957101240; Thu, 01
 Dec 2022 20:58:21 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:41 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-4-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 3/5] tools lib subcmd: Add dependency test to install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Compute the headers to be installed from their source headers and make
each have its own build target to install it. Using dependencies
avoids headers being reinstalled and getting a new timestamp which
then causes files that depend on the header to be rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 9a316d8b89df..b87213263a5e 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -89,10 +89,10 @@ define do_install_mkdir
 endef
 
 define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	if [ ! -d '$2' ]; then             \
+		$(INSTALL) -d -m 755 '$2'; \
 	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	$(INSTALL) $1 $(if $3,-m $3,) '$2'
 endef
 
 install_lib: $(LIBFILE)
@@ -100,13 +100,16 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libsubcmd_headers) \
-		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
+HDRS := exec-cmd.h help.h pager.h parse-options.h run-command.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/subcmd
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS)
+	$(call QUIET_INSTALL, libsubcmd_headers)
 
 install: install_lib install_headers
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

