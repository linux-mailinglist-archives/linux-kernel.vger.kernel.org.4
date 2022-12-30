Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4B9655A69
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiLXPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLXPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:03:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A47C5B;
        Sat, 24 Dec 2022 07:03:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3C560AB3;
        Sat, 24 Dec 2022 15:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1930C433EF;
        Sat, 24 Dec 2022 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671894227;
        bh=xykcQvAG/P4ufgL8PYGt5jbg4bFNSFnh0UvwTczdshU=;
        h=From:To:Cc:Subject:Date:From;
        b=f8Y1KA2dThkOD4efPQ+IwaQnYW3tvOD010DAFGYaxWunYt7dkPovdUpD7ViXoHc57
         ezh38a4wUPR75WIZotGJIH5kKF/FnsaeeFJ4usoDO36zmZA6Q5Gd8yL0kSH6ASWVd8
         22v1usWprkicVqzjOgmq3867Gr1eOS2rk/D35HQSbYnjO0IDPBv9ryXYC6AAPTbBHl
         nI8QgnUjcPXzM3cccJlNno4JwqRhGXilmJpfUBEtfMLQBVVjBcV1rcMoDxn/e2z/VO
         blUq0mnycKrnGczHmd5wOMlMfmqH1qsu2bJcDtYYZTv0jo7drbwmlIcQ4ixAaR8qvz
         HtaBmVrSOLxjw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH 1/2] .gitinogre: update the command to check tracked files being ignored
Date:   Sun, 25 Dec 2022 00:03:28 +0900
Message-Id: <20221224150329.394510-1-masahiroy@kernel.org>
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

