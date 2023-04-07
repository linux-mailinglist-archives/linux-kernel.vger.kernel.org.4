Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92D6DAB55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjDGKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjDGKQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1AC8A4D;
        Fri,  7 Apr 2023 03:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F6E64EFD;
        Fri,  7 Apr 2023 10:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC1FC4339B;
        Fri,  7 Apr 2023 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680862598;
        bh=ZO80oO4Qe+xdn84207QY7gzhpkvyOfUyW2wiMjCrFWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wz7AldFC5GKIVQBzLQsWl/gys3SNoK6K/x0zXY+xuvMqVfDDWYtXU+WUN07JkNDeF
         s8xjtLZ8hejRvNk0x8NbQEqOn0esCFSzWv8sZhTyzlepw4GuonhPfrxKvkMBjt1NgZ
         fIYlBNHcmlIVApwCdatcZmvoUmThwYyNdDUUCKkuEZg/ABN84/y5L3q5bzrvJV98yX
         Ph5zK1OwqB+upZqCWAXebbmQMpl5zuoLnJjLdleJWA9z2eUns691dq+9K/lpYroFRn
         v7/Ad8uIq/M48YoPCmiBOwAI8HjebMRvCzL69fpnfxLSTK2jTrY51uCHowYLqkgg90
         qaToHzC+bbQrA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/3] kbuild: do not create intermediate *.tar for source tarballs
Date:   Fri,  7 Apr 2023 19:16:28 +0900
Message-Id: <20230407101629.1298051-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230407101629.1298051-1-masahiroy@kernel.org>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 05e96e96a315 ("kbuild: use git-archive for source package
creation"), source tarballs are created in two steps; create *.tar file
then compress it. I split the compression as a separate rule because I
just thought 'git archive' supported only gzip for compression. I admit
the unneeded *.tar file is annoying.

For other compression algorithms, I could pipe the two commands:

  $ git archive HEAD | xz > linux.tar.xz

I read git-archive(1) carefully, and I realized GIT had provided a
more elegant way:

  $ git -c tar.tar.xz.command=xz archive -o linux.tar.xz HEAD

This commit uses 'tar.tar.*.command' configuration to specify the
compression backend so we can create a compressed tarball directly.

GIT commit 767cf4579f0e ("archive: implement configurable tar filters")
is more than a decade old, so it should be available on almost all build
environments.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index a205617730c6..7707975f729b 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -57,16 +57,23 @@ check-git:
 		false; \
 	fi
 
+archive-config-tar.gz  = -c tar.tar.gz.command="$(KGZIP)"
+archive-config-tar.bz2 = -c tar.tar.bz2.command="$(KBZIP2)"
+archive-config-tar.xz  = -c tar.tar.xz.command="$(XZ)"
+archive-config-tar.zst = -c tar.tar.zst.command="$(ZSTD)"
+
 quiet_cmd_archive = ARCHIVE $@
-      cmd_archive = git -C $(srctree) archive \
+      cmd_archive = git -C $(srctree) $(archive-config-tar$(suffix $@)) archive \
                     --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
 
 # Linux source tarball
 # ---------------------------------------------------------------------------
 
-targets += linux.tar
-linux.tar: archive-args = $$(cat $<)
-linux.tar: .tmp_HEAD FORCE
+linux-tarballs := $(addprefix linux, .tar.gz)
+
+targets += $(linux-tarballs)
+$(linux-tarballs): archive-args = $$(cat $<)
+$(linux-tarballs): .tmp_HEAD FORCE
 	$(call if_changed,archive)
 
 # rpm-pkg
@@ -185,9 +192,12 @@ perf-archive-args = --add-file=$$(realpath $(word 2, $^)) \
 	--add-file=$$(realpath $(word 3, $^)) \
 	$$(cat $(word 2, $^))^{tree} $$(cat $<)
 
-targets += perf-$(KERNELVERSION).tar
-perf-$(KERNELVERSION).tar: archive-args = $(perf-archive-args)
-perf-$(KERNELVERSION).tar: tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE FORCE
+
+perf-tarballs := $(addprefix perf-$(KERNELVERSION), .tar .tar.gz .tar.bz2 .tar.xz .tar.zst)
+
+targets += $(perf-tarballs)
+$(perf-tarballs): archive-args = $(perf-archive-args)
+$(perf-tarballs): tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE FORCE
 	$(call if_changed,archive)
 
 PHONY += perf-tar-src-pkg
-- 
2.37.2

