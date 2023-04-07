Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A76DAB54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjDGKQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376886A6;
        Fri,  7 Apr 2023 03:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1F664EEC;
        Fri,  7 Apr 2023 10:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A25C433EF;
        Fri,  7 Apr 2023 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680862596;
        bh=3xL2hEj3dYcOFlBodNMi0Lf4vCiBWs75OJihC7IKVCE=;
        h=From:To:Cc:Subject:Date:From;
        b=ggNeOfiKjjdTFkisMEjWaIGE1Vnyo6swZvXKzaNkH2zfmN21cKA20pvwhaz1UGgeD
         6kBdDMpgcy0Ei9vOTcobwx3WrRYOc2+iZ3eZGFYfMxy33dr2Kc4m/mgaQhkhkTznQv
         cbtlejcUe0rcDa43aFbISJcBW3rtMIDMOEHE573XUxrWSI3oHDzYgwt24KvTM4jod4
         heVLusarSonsdu1jqLHuFJEyLWNbTK4yJZAyzcI7r/0dei75jDnU5yfUZs49+TKU0d
         oaE5mjEZMEoP+97R1uqDXcU9O4SBvOVoAqmayZ5u4kdZKrpZmlQH7/ciFEaN8LPW3z
         pNZxHiMNVM0Eg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/3] kbuild: merge cmd_archive_linux and cmd_archive_perf
Date:   Fri,  7 Apr 2023 19:16:27 +0900
Message-Id: <20230407101629.1298051-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
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

The two commands, cmd_archive_linux and cmd_archive_perf, are similar.
Merge them to make it easier to add more changes to the git-archive
command.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 61f72eb8d9be..a205617730c6 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -57,16 +57,17 @@ check-git:
 		false; \
 	fi
 
+quiet_cmd_archive = ARCHIVE $@
+      cmd_archive = git -C $(srctree) archive \
+                    --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
+
 # Linux source tarball
 # ---------------------------------------------------------------------------
 
-quiet_cmd_archive_linux = ARCHIVE $@
-      cmd_archive_linux = \
-	git -C $(srctree) archive --output=$$(realpath $@) --prefix=$(basename $@)/ $$(cat $<)
-
 targets += linux.tar
+linux.tar: archive-args = $$(cat $<)
 linux.tar: .tmp_HEAD FORCE
-	$(call if_changed,archive_linux)
+	$(call if_changed,archive)
 
 # rpm-pkg
 # ---------------------------------------------------------------------------
@@ -180,16 +181,14 @@ quiet_cmd_perf_version_file = GEN     $@
 .tmp_perf/PERF-VERSION-FILE: .tmp_HEAD $(srctree)/tools/perf/util/PERF-VERSION-GEN | .tmp_perf
 	$(call cmd,perf_version_file)
 
-quiet_cmd_archive_perf = ARCHIVE $@
-      cmd_archive_perf = \
-	git -C $(srctree) archive --output=$$(realpath $@) --prefix=$(basename $@)/ \
-	--add-file=$$(realpath $(word 2, $^)) \
+perf-archive-args = --add-file=$$(realpath $(word 2, $^)) \
 	--add-file=$$(realpath $(word 3, $^)) \
 	$$(cat $(word 2, $^))^{tree} $$(cat $<)
 
 targets += perf-$(KERNELVERSION).tar
+perf-$(KERNELVERSION).tar: archive-args = $(perf-archive-args)
 perf-$(KERNELVERSION).tar: tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE FORCE
-	$(call if_changed,archive_perf)
+	$(call if_changed,archive)
 
 PHONY += perf-tar-src-pkg
 perf-tar-src-pkg: perf-$(KERNELVERSION).tar
-- 
2.37.2

