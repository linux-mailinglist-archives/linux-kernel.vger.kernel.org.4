Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDE676D83
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAVOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjAVOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FD113C5;
        Sun, 22 Jan 2023 06:14:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A36C60C35;
        Sun, 22 Jan 2023 14:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D056DC4339C;
        Sun, 22 Jan 2023 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396879;
        bh=9IUwo+QWRIianpkKIsxTKg2IUwJbi7Os01Md0K+GfMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2hHapDYpEu8VY7fMIr1T3wE/FRmZnEcrE6k/V1Vm6LVNCxC35dqXP4U8xcZ9SxMG
         uyj18Z9o8yT07+6lbYWKsDCDpg84eR4NGdoUQ/OIk71JkIHyMsPCkv0XhCxW8FK8dk
         nEIZNBTarPSWqZKHEu4E/jme0kw5oxKLOoT/ernhNbEuqGsyTqElF1fZhZci9hXXIp
         svbUQ0brQzBphYXOyCtlMA6viyAN6K9Ms1XXdEqgdavZjtcKLaczPgZp/DFliBBlXA
         wu3zrLlZqsSkXSRsrinOwo7IoL0LOy/WNFeGxih2cP9t1RPhleUAzLME10ntl1dddT
         SJIMkdiF1vjsQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 5/7] setlocalversion: absorb $(KERNELVERSION)
Date:   Sun, 22 Jan 2023 23:14:25 +0900
Message-Id: <20230122141428.115372-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
References: <20230122141428.115372-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print $(KERNELVERSION) in setlocalversion so that the callers get
simpler.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                | 5 ++---
 scripts/setlocalversion | 4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ed3294c7be97..d0a95277f08a 100644
--- a/Makefile
+++ b/Makefile
@@ -1247,8 +1247,7 @@ vmlinux: vmlinux.o $(KBUILD_LDS) modpost
 # make sure no implicit rule kicks in
 $(sort $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)): . ;
 
-filechk_kernel.release = \
-	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
+filechk_kernel.release = $(srctree)/scripts/setlocalversion $(srctree)
 
 # Store (new) KERNELRELEASE string in include/config/kernel.release
 include/config/kernel.release: FORCE
@@ -2112,7 +2111,7 @@ checkstack:
 	$(PERL) $(srctree)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
 
 kernelrelease:
-	@echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
+	@$(srctree)/scripts/setlocalversion $(srctree)
 
 kernelversion:
 	@echo $(KERNELVERSION)
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index a4c9a61b0665..7c7cbefa5aa4 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -113,8 +113,10 @@ if [ -z "${KERNELVERSION}" ]; then
 	exit 1
 fi
 
+res="${KERNELVERSION}"
+
 # localversion* files in the build and source directory
-res="$(collect_files localversion*)"
+res="${res}$(collect_files localversion*)"
 if test ! "$srctree" -ef .; then
 	res="$res$(collect_files "$srctree"/localversion*)"
 fi
-- 
2.34.1

