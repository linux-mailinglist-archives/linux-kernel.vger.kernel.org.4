Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C769738F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjBOBXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjBOBXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:23:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81931E04;
        Tue, 14 Feb 2023 17:22:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3769B81F88;
        Wed, 15 Feb 2023 01:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E33BC4339E;
        Wed, 15 Feb 2023 01:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424106;
        bh=xoiM6mWes29Mf1DMrYU7f872NlsvnuFCR71OIJFjM4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKhDw9TF0XC+O2zLcgg8lApTf6z1ja4d0VaqGEyhzjIVCVWDLvgcZSHfpLlbfa919
         F6fZ1fk75YaXiVm3kLtWz6lmhQ6fCgCbH6fCNRdpZBCSVc2TP2GwITBBF5BycMF31S
         eUAKt1TI6iMR2UGSj/n9vEhoCdOGqfneO3bhzCSDhCPwvYsXJsKtvdAdcOnrMCvzTh
         2r95oiedrUwQFamW/aBYqzAcMxY6qM7AHzkdh3nkecwaGACcYeEiOAp70iJNK77NxY
         6/rzm/E/ed9j/6HWGjBckwcBB1ZV34Drkq4i2KoE1R7m4WkC5swJ/2ajHQsD9Ddkcs
         pAcRuV+S0LtMQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 08/12] kbuild: make perf-tar*-src-pkg work without relying on git
Date:   Wed, 15 Feb 2023 10:20:30 +0900
Message-Id: <20230215012034.403356-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, perf-tar*-src-pkg only uses 'git archive', but it is better
to make it work without relying on git.

The file, HEAD, which saves the commit hash, will be included in the
tarball only when the source tree is managed by git. The git tree is
more precisely checked; it has been copied from scripts/setlocalversion.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v5)

Changes in v5:
  - New patch

 scripts/Makefile.package | 97 ++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 33 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 5538deacb136..50b86b325d7a 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -50,10 +50,25 @@ quiet_cmd_tar = TAR     $@
 
 tar-rootdir := $(srctree)
 
+%.tar:
+	$(call cmd,tar)
+
 %.tar.gz: private tar-compress-opt := -I $(KGZIP)
 %.tar.gz:
 	$(call cmd,tar)
 
+%.tar.bz2: private tar-compress-opt := -I $(KBZIP2)
+%.tar.bz2:
+	$(call cmd,tar)
+
+%.tar.xz: private tar-compress-opt := -I $(XZ)
+%.tar.xz:
+	$(call cmd,tar)
+
+%.tar.zst: private tar-compress-opt := -I $(ZSTD)
+%.tar.zst:
+	$(call cmd,tar)
+
 # Linux source tarball
 # ---------------------------------------------------------------------------
 
@@ -138,36 +153,52 @@ $(tar-pkgs):
 	$(MAKE) -f $(srctree)/Makefile
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
-# perf-pkg - generate a source tarball with perf source
+# perf-tar*-src-pkg - generate a source tarball with perf source
 # ---------------------------------------------------------------------------
 
-perf-tar=perf-$(KERNELVERSION)
-
-quiet_cmd_perf_tar = TAR
-      cmd_perf_tar = \
-git --git-dir=$(srctree)/.git archive --prefix=$(perf-tar)/         \
-	HEAD^{tree} $$(cd $(srctree);                               \
-		       echo $$(cat tools/perf/MANIFEST)) \
-	-o $(perf-tar).tar;                                         \
-mkdir -p $(perf-tar);                                               \
-git --git-dir=$(srctree)/.git rev-parse HEAD > $(perf-tar)/HEAD;    \
-(cd $(srctree)/tools/perf;                                          \
-util/PERF-VERSION-GEN $(CURDIR)/$(perf-tar)/);              \
-tar rf $(perf-tar).tar $(perf-tar)/HEAD $(perf-tar)/PERF-VERSION-FILE; \
-rm -r $(perf-tar);                                                  \
-$(if $(findstring tar-src,$@),,                                     \
-$(if $(findstring bz2,$@),$(KBZIP2),                                 \
-$(if $(findstring gz,$@),$(KGZIP),                                  \
-$(if $(findstring xz,$@),$(XZ),                                     \
-$(if $(findstring zst,$@),$(ZSTD),                                  \
-$(error unknown target $@)))))                                      \
-	-f -9 $(perf-tar).tar)
-
-perf-tar-pkgs := perf-tar-src-pkg perf-targz-src-pkg perf-tarbz2-src-pkg \
-		 perf-tarxz-src-pkg perf-tarzst-src-pkg
-PHONY += $(perf-tar-pkgs)
-$(perf-tar-pkgs):
-	$(call cmd,perf_tar)
+perf-tar-src-pkg-tarball = perf-$(KERNELVERSION).$(1)
+perf-tar-src-pkg-phony   = perf-$(subst .,,$(1))-src-pkg
+
+quiet_cmd_stage_perf_src = STAGE   $@
+      cmd_stage_perf_src = \
+	rm -rf $@; \
+	mkdir -p $@; \
+	tar -c -f - --exclude-from=$<_exclude -C $(srctree) --files-from=$(srctree)/tools/perf/MANIFEST | \
+	tar -x -f - -C $@
+
+.tmp_perf: .tmp_filelist
+	$(call cmd,stage_perf_src)
+
+filechk_perf_head = \
+	if test -z "$(git -C $(srctree) rev-parse --show-cdup 2>/dev/null)" && \
+	       head=$$(git -C $(srctree) rev-parse --verify HEAD 2>/dev/null); then \
+		echo $$head; \
+	else \
+		echo "not a git tree"; \
+	fi
+
+.tmp_perf/HEAD: .tmp_perf FORCE
+	$(call filechk,perf_head)
+
+quiet_cmd_perf_version_file = GEN     $@
+      cmd_perf_version_file = cd $(srctree)/tools/perf; util/PERF-VERSION-GEN $(dir $(abspath $@))
+
+# PERF-VERSION-FILE and HEAD are independent, but this avoids updating the
+# timestamp of PERF-VERSION-FILE.
+# The best is to fix tools/perf/util/PERF-VERSION-GEN.
+.tmp_perf/PERF-VERSION-FILE: .tmp_perf/HEAD $(srctree)/tools/perf/util/PERF-VERSION-GEN
+	$(call cmd,perf_version_file)
+
+define perf-tar-src-pkg-rule
+PHONY += $(perf-tar-src-pkg-phony)
+$(perf-tar-src-pkg-phony): $(perf-tar-src-pkg-tarball)
+	@:
+
+$(perf-tar-src-pkg-tarball): private tar-rootdir := .tmp_perf
+$(perf-tar-src-pkg-tarball): .tmp_filelist .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE
+endef
+
+$(foreach x, tar tar.gz tar.bz2 tar.xz tar.zst, $(eval $(call perf-tar-src-pkg-rule,$(x))))
 
 # Help text displayed when executing 'make help'
 # ---------------------------------------------------------------------------
@@ -186,11 +217,11 @@ help:
 	@echo '  tarbz2-pkg          - Build the kernel as a bzip2 compressed tarball'
 	@echo '  tarxz-pkg           - Build the kernel as a xz compressed tarball'
 	@echo '  tarzst-pkg          - Build the kernel as a zstd compressed tarball'
-	@echo '  perf-tar-src-pkg    - Build $(perf-tar).tar source tarball'
-	@echo '  perf-targz-src-pkg  - Build $(perf-tar).tar.gz source tarball'
-	@echo '  perf-tarbz2-src-pkg - Build $(perf-tar).tar.bz2 source tarball'
-	@echo '  perf-tarxz-src-pkg  - Build $(perf-tar).tar.xz source tarball'
-	@echo '  perf-tarzst-src-pkg - Build $(perf-tar).tar.zst source tarball'
+	@echo '  perf-tar-src-pkg    - Build the perf source tarball with no compression'
+	@echo '  perf-targz-src-pkg  - Build the perf source tarball with gzip compression'
+	@echo '  perf-tarbz2-src-pkg - Build the perf source tarball with bz2 compression'
+	@echo '  perf-tarxz-src-pkg  - Build the perf source tarball with xz compression'
+	@echo '  perf-tarzst-src-pkg - Build the perf source tarball with zst compression'
 
 PHONY += FORCE
 FORCE:
-- 
2.34.1

