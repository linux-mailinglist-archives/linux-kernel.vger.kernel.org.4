Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD55655AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiLXPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:51:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814AFA474;
        Sat, 24 Dec 2022 07:51:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC81A60AB6;
        Sat, 24 Dec 2022 15:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE4CC433D2;
        Sat, 24 Dec 2022 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671897103;
        bh=0a2bOzY1EIi875Y2csR7N5qCzb/EoHegIpJSUFHH3m0=;
        h=From:To:Cc:Subject:Date:From;
        b=OcsQ0Te6oExjar/Ur0kFE885A3wVRnq4AYq6N7Goz95vd2Wjg79hgoGNJnzasymQH
         nhJlThUdScxPxY3zvSZmicxAZgmHr0GvnUM2+NcGwSP7B3gIt9UOXi7vjbG055UDH4
         UUM2Crjepl0hAqqmEiilNcESKGN06rncHeqQbQYHviH6V/AP4qKHQUUsrFT7RKLdrR
         jZXL6cgoFJMHfrGqAEgUBAeEPNkMoedFt157ZPGGNszUlntKBiP+jJ+9J30FYOSIkC
         3CPABwvOCto4jPXUmZPMeQHiYKKmYiLKT8pERo/polCCaUh6PehvP9g70+3rUm1fKc
         zhNJNVAtX5/sQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v2 1/2] .gitinogre: update the command to check tracked files being ignored
Date:   Sun, 25 Dec 2022 00:51:37 +0900
Message-Id: <20221224155138.447912-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent git versions do not accept the noted command.

  $ git ls-files -i --exclude-standard
  fatal: ls-files -i must be used with either -o or -c

The -c was implied for older git versions, but we need to make it
explicit now.

Also, replace --exclude-standard with --exclude-per-directory=.gitignore
so that everyone will get consistent results.

git-ls-files(1) says:

  --exclude-standard
      Add the standard Git exclusions: .git/info/exclude, .gitignore in
      each directory, and the user's global exclusion file.

We never know what are locally added to $GIT_DIR/info/exclude or
$XDG_CONFIG_HOME/git/ignore.

We can only manage .gitignore files committed in the repository.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 3ec73ead6757..2e2e3d1eeaee 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,7 +4,7 @@
 # subdirectories here. Add them in the ".gitignore" file
 # in that subdirectory instead.
 #
-# NOTE! Please use 'git ls-files -i --exclude-standard'
+# NOTE! Please use 'git ls-files -i -c --exclude-per-directory=.gitignore'
 # command after changing this file, to see if there are
 # any tracked files which get ignored after the change.
 #
-- 
2.34.1

