Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B949C723E08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjFFJnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbjFFJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A710E5;
        Tue,  6 Jun 2023 02:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015636264C;
        Tue,  6 Jun 2023 09:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F31C4339B;
        Tue,  6 Jun 2023 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686044568;
        bh=veE+fl10BprFYlWZLZVVUUJiYrObzEPENxfuVNrEcOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GBNobWZy7SwC/cebnMZSenZBwru9FKLP8XS5e4rq87U4wSZBeSXh2EVetUVt2A3gs
         W9arwvDlhlSEPwyW+l/9aineUDMqr7j+t9AiCFlKb6X0NrKJ8VfbqX5xnZukq5j03x
         vn8Mq+8qAwr6Sj6pBvycfG2luJx1/M3UG0MbEHD76QMjUm8ykMo6WlOd82qRt+vgP0
         /1d+02nzwUd1uqEXi/7Wgr8H9XRYv1fBudnjf5Dssfak6+ipF0oxODLuzDOSIQv0ix
         Jl+ZbWiZRFEHL16A7j4Ujk7nTHYQYNQts9qd07uYlQyufhn15jb+XpzI/7nlDKAxMG
         xRXrcQ3MFitJw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] modpost: propagate W=1 build option to modpost
Date:   Tue,  6 Jun 2023 18:41:59 +0900
Message-Id: <20230606094159.1910369-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"No build warning" is a strong requirement these days, so you must fix
all issues before enabling a new warning flag.

We often add a new warning to W=1 first so that the kbuild test robot
blocks new breakages.

This commit allows modpost to show extra warnings only when W=1
(or KBUILD_EXTRA_WARN=1) is given.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 1 +
 scripts/mod/modpost.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 0980c58d8afc..074e27c0c140 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -47,6 +47,7 @@ modpost-args =										\
 	$(if $(KBUILD_MODPOST_WARN),-w)							\
 	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))					\
 	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)	\
+	$(if $(findstring 1, $(KBUILD_EXTRA_WARN)),-W)					\
 	-o $@
 
 modpost-deps := $(MODPOST)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d10f5bdcb753..3ea5eb2b1029 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -42,6 +42,8 @@ static bool allow_missing_ns_imports;
 
 static bool error_occurred;
 
+static bool extra_warn;
+
 /*
  * Cut off the warnings when there are too many. This typically occurs when
  * vmlinux is missing. ('make modules' without building vmlinux.)
@@ -2199,7 +2201,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:mnT:o:aWwENd:")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2224,6 +2226,9 @@ int main(int argc, char **argv)
 		case 'T':
 			files_source = optarg;
 			break;
+		case 'W':
+			extra_warn = true;
+			break;
 		case 'w':
 			warn_unresolved = true;
 			break;
-- 
2.39.2

