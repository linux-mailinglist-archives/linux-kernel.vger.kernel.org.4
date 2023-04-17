Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7017B6E4B72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDQO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F01721;
        Mon, 17 Apr 2023 07:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE03625F9;
        Mon, 17 Apr 2023 14:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D8EC433EF;
        Mon, 17 Apr 2023 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681741557;
        bh=Ex/hrCKvMBExc7EXGij2hsZznnwJSrqrpsR18ZEHT+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iqx7F+dNQlywiPvNJMhhLidXroLp28Wfni816BukuFUE5BTNAlSVDkKXVKTdpPeN/
         hpGkRb+RycKc2iOmZKVNDADD+SCPDKmjVfb9dc+hpBzpx53fUi3d4oKJkQ2MjUSHEk
         l4l1YXonDB3pr752oa1d7DvDzCw3w2WfpbIQ6lwDg4QsA1vatuZP4pLniym53iOM/x
         O5+/SvCOAa53EZXzA+tgyJsmsQ4GO39kSJgUGhtJr4rjIGopI4ubRVZZPFZPrzsSb0
         +od1Ca5NfE8HtkD6pH1uGnLDsQCIAkuhHAW7Kr/n0CLHaMUUW22guLG6kxFPgU1YU5
         vx4+J/35Aazng==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Bastian Germann <bage@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] kbuild: deb-pkg: add KDEB_SOURCE_COMPRESS to specify compression type
Date:   Mon, 17 Apr 2023 23:25:48 +0900
Message-Id: <20230417142548.249610-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230417142548.249610-1-masahiroy@kernel.org>
References: <20230417142548.249610-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KDEB_SOURCE_COMPRESS to specify the compression for the orig and
debian tarballs. (The existing KDEB_COMPRESS is used to specify the
compression for binary packages.)

Supported algorithms are gzip, bzip2, lzma, and xz, all of which are
supported by dpkg-source.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index d8a36304b26e..ce3d8b4e9cb0 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -41,19 +41,25 @@ check-git:
 		false; \
 	fi
 
-git-config-tar.gz  = -c tar.tar.gz.command="$(KGZIP)"
-git-config-tar.bz2 = -c tar.tar.bz2.command="$(KBZIP2)"
-git-config-tar.xz  = -c tar.tar.xz.command="$(XZ)"
-git-config-tar.zst = -c tar.tar.zst.command="$(ZSTD)"
+git-config-tar.gz   = -c tar.tar.gz.command="$(KGZIP)"
+git-config-tar.bz2  = -c tar.tar.bz2.command="$(KBZIP2)"
+git-config-tar.lzma = -c tar.tar.lzma.command="$(LZMA)"
+git-config-tar.xz   = -c tar.tar.xz.command="$(XZ)"
+git-config-tar.zst  = -c tar.tar.zst.command="$(ZSTD)"
 
 quiet_cmd_archive = ARCHIVE $@
       cmd_archive = git -C $(srctree) $(git-config-tar$(suffix $@)) archive \
                     --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
 
+suffix-gzip  := .gz
+suffix-bzip2 := .bz2
+suffix-lzma  := .lzma
+suffix-xz    := .xz
+
 # Linux source tarball
 # ---------------------------------------------------------------------------
 
-linux-tarballs := $(addprefix linux, .tar.gz)
+linux-tarballs := $(addprefix linux, .tar.gz .tar.bz2 .tar.lzma .tar.xz)
 
 targets += $(linux-tarballs)
 $(linux-tarballs): archive-args = $$(cat $<)
@@ -88,6 +94,15 @@ binrpm-pkg:
 # deb-pkg srcdeb-pkg bindeb-pkg
 # ---------------------------------------------------------------------------
 
+KDEB_SOURCE_COMPRESS ?= gzip
+
+PHONY += linux.tar.unsupported_deb_compress
+linux.tar.unsupported_deb_compress:
+	@echo "error: $(KDEB_SOURCE_COMPRESS): unsupported debian source compression" >&2
+	@false
+
+debian-orig-suffix := $(if $(filter gzip bzip2 lzma xz, $(KDEB_SOURCE_COMPRESS)),$(suffix-$(KDEB_SOURCE_COMPRESS)),.unsupported_deb_compress)
+
 quiet_cmd_debianize = GEN     $@
       cmd_debianize = $(srctree)/scripts/package/mkdebian $(mkdebian-opts)
 
@@ -97,9 +112,9 @@ debian: FORCE
 PHONY += debian-orig
 debian-orig: private source = $(shell dpkg-parsechangelog -S Source)
 debian-orig: private version = $(shell dpkg-parsechangelog -S Version | sed 's/-[^-]*$$//')
-debian-orig: private orig-name = $(source)_$(version).orig.tar.gz
+debian-orig: private orig-name = $(source)_$(version).orig.tar$(debian-orig-suffix)
 debian-orig: mkdebian-opts = --need-source
-debian-orig: linux.tar.gz debian
+debian-orig: linux.tar$(debian-orig-suffix) debian
 	$(Q)if [ "$(df  --output=target .. 2>/dev/null)" = "$(df --output=target $< 2>/dev/null)" ]; then \
 		ln -f $< ../$(orig-name); \
 	else \
@@ -120,7 +135,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	+$(strip dpkg-buildpackage \
 	--build=$(build-type) --no-pre-clean --unsigned-changes \
 	$(if $(findstring source, $(build-type)), \
-		--unsigned-source) \
+		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
 		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
 		--no-check-builddeps) \
-- 
2.37.2

