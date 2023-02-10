Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6969253A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjBJSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjBJSS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC646F22C;
        Fri, 10 Feb 2023 10:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 778AEB80C8B;
        Fri, 10 Feb 2023 18:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC0DC4339E;
        Fri, 10 Feb 2023 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676053128;
        bh=fhbDbBrH4mf4Re3SJLCSFDHbs63IuiydRRp3WHTmHEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ou+H9jRTWeKPlIqO+aRnnrKWsqXNrzAEbaFgslSmdUmkuPhfkKUc3/oktTS3yLMnQ
         vxtfo9MUzckjZFxThqwLTZUrnW0kPafvX6AJ6ihqvu0NGT10ZHzDd+xto+ulqnFYOC
         LLX00JcPf3WlFUFg6rYth2cBR7ABCPGBXuff9izRjsAb7arE+i+K1n6+GThvZmxjaS
         cP6OLmUglcnaSjPQLZ0VQQvmggth55bxWmKtkZ7GuBl1DZEXq9Qwz5Mum6cKGANHQ/
         vLDhkzGN9EkwOaHRNC/cetIc/uL6ueBJ2bdTjOSRGlnkMY+0fElMhemK6Yj4R+jA/e
         EotUqLWd1kSDA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 7/7] kbuild: make perf-tar*-src-pkg work without relying on git
Date:   Sat, 11 Feb 2023 03:18:28 +0900
Message-Id: <20230210181828.124765-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210181828.124765-1-masahiroy@kernel.org>
References: <20230210181828.124765-1-masahiroy@kernel.org>
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

Changes in v5:
  - New patch

 scripts/Makefile.package | 67 ++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 55be31d0e040..e676d14fef23 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -122,40 +122,53 @@ quiet_cmd_tar = TAR     $@
 
 tar-rootdir := $(srctree)
 
+%.tar: compress-opt :=
+%.tar: .tmp_filelist
+	$(call cmd,tar)
+
 %.tar.gz: compress-opt := -I $(KGZIP)
 %.tar.gz: .tmp_filelist
 	$(call cmd,tar)
 
+%.tar.bz2: compress-opt := -I $(KBZIP2)
+%.tar.bz2: .tmp_filelist
+	$(call cmd,tar)
+
+%.tar.xz: compress-opt := -I $(XZ)
+%.tar.xz: .tmp_filelist
+	$(call cmd,tar)
+
+%.tar.zst: compress-opt := -I $(ZSTD)
+%.tar.zst: .tmp_filelist
+	$(call cmd,tar)
+
 # perf-pkg - generate a source tarball with perf source
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
+perf-tar = perf-$(KERNELVERSION)
+
+perf-tar-phony = perf-$(subst .,,$(1))-src-pkg
+
+.tmp_perf: FORCE
+	$(Q)rm -rf $@
+	$(Q)mkdir $@
+	$(Q)tar -c -f - -C $(srctree) --files-from=$(srctree)/tools/perf/MANIFEST | tar -x -f - -C $@
+	$(Q)if test -z "$(git -C $(srctree) rev-parse --show-cdup 2>/dev/null)" && \
+	       head=$$(git -C $(srctree) rev-parse --verify HEAD 2>/dev/null); then \
+		echo $$head > $@/HEAD; \
+	fi
+	$(Q)cd $(srctree)/tools/perf; util/PERF-VERSION-GEN $(abspath $@)/
+
+define perf-pkg-rule
+PHONY += $(perf-tar-phony)
+$(perf-tar-phony): $(perf-tar).$(1)
+	@:
+
+$(perf-tar).$(1): private tar-rootdir := .tmp_perf
+$(perf-tar).$(1): | .tmp_perf
+endef
+
+$(foreach x, tar tar.gz tar.bz2 tar.xz tar.zst, $(eval $(call perf-pkg-rule,$(x))))
 
 # Help text displayed when executing 'make help'
 # ---------------------------------------------------------------------------
-- 
2.34.1

