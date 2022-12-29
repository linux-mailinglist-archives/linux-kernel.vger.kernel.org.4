Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E151658A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiL2Hn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2Hn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:43:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6A1B486;
        Wed, 28 Dec 2022 23:43:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483B161724;
        Thu, 29 Dec 2022 07:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDAEC433EF;
        Thu, 29 Dec 2022 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672299805;
        bh=ha9gPkeEMdP/2N37rSOoAud9ZwoPXuJqw+mMc7OloXw=;
        h=From:To:Cc:Subject:Date:From;
        b=eY45LjFSbjq9lFd3TuaYsVftNInFTpCnJSUPIc9G3xcl3YXH1kcMdNAtysho+QDM/
         H/fpb4/tN4jSQgqtT2H3h0HkALhoj1kT/ZV11iYMJRzmaGQHWLNCuP4Ly4bmD7iMyN
         xLgz1XJKJKdlIM29yJxHAvHn/uUYZziAegkLUP5fSZOuLWRGVp3EZCOYp4yauWVFzO
         CEbZQ3z2UJ+2KI/wPwyLGc+Xd41xDd7NNvBZEs1o1c6DDlnCY5E2/EFaq9tXoFuLJ4
         AOYGZtzCjoZJ/hoVoM8U6+Rai/QFWl4eLe0aBB3o8Ly+SNbt+IknbepTOkPd0wJRoL
         nBwY4ZOamaLfg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v3 1/2] .gitignore: update the command to check tracked files being ignored
Date:   Thu, 29 Dec 2022 16:43:09 +0900
Message-Id: <20221229074310.906556-1-masahiroy@kernel.org>
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

The -c was implied before, but we need to make it explicit since
git commit b338e9f66873 ("ls-files: error out on -i unless -o or -c
are specified").

Also, replace --exclude-standard with --exclude-per-directory=.gitignore
so that everyone will get consistent results.

git-ls-files(1) says:

  --exclude-standard
      Add the standard Git exclusions: .git/info/exclude, .gitignore in
      each directory, and the user's global exclusion file.

We cannot predict what is locally added to .git/info/exclude or the
user's global exclusion file.

We can only manage .gitignore files committed to the repository.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
---

Changes in v3:
  - Fix a typo. Update commit description per Miguel

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

