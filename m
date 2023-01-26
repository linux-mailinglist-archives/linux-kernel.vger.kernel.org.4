Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281F367C2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjAZC0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjAZC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:26:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408035DC15;
        Wed, 25 Jan 2023 18:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E1636172E;
        Thu, 26 Jan 2023 02:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86E7C433D2;
        Thu, 26 Jan 2023 02:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674700009;
        bh=dz6neTM68q1EPG3wS9QXzfM+G+PCxQio2ZcXb2gyA3w=;
        h=From:To:Cc:Subject:Date:From;
        b=cfKVFUDRsS/BVTgAhpN4g/FCqPeD5NLbb/NLfVyQbc9IRPMNOGfJaDsvJ/bCdMX02
         x5r7mgGsY/alUiWneYA+hZ3w/uP5mTqrYiqbH46nbVnl82f1Q6SeWBht8mmKVVZqOD
         ws3eOVxYcaNACpf4rcHyfVmZj/JPXA7vVFclsn6O9gbKIqjhQjx+HwgMA4GuRmMCcn
         YJTVkI8OhUpLfjhIV1ULTrPxVrUvowN4FX4r7TfXeGc9OlQrS2NbISGzWTFIJ3u8AL
         3JVFNVEHASjAidKXs3YUL74n+lh+xeaVKndqPvmS5+SG/ay2wc23e+W0bX0UqaTjcE
         TJMuB6Uc4RFNA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        William McVicker <willmcvicker@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2] kbuild: do not automatically add -w option to modpost
Date:   Thu, 26 Jan 2023 11:26:43 +0900
Message-Id: <20230126022643.3664548-1-masahiroy@kernel.org>
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

When there is a missing input file (vmlinux.o or Module.symvers), you
are likely to get a ton of unresolved symbols.

Currently, Kbuild automatically adds the -w option to allow module builds
to continue with warnings instead of errors.

This may not be what the user expects because it is generally more useful
to catch all possible issues at build time instead of at run time.

Let's not do what the user did not ask.

If you still want to build modules anyway, you can proceed by explicitly
setting KBUILD_MODPOST_WARN=1. Since you may miss a real issue, you need
to be aware of what you are doing.

Suggested-by: William McVicker <willmcvicker@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix the closing parenthesis

 scripts/Makefile.modpost | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 43343e13c542..0980c58d8afc 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -121,16 +121,14 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
 
 endif # ($(KBUILD_EXTMOD),)
 
-ifneq ($(missing-input),)
-modpost-args += -w
-endif
-
 quiet_cmd_modpost = MODPOST $@
       cmd_modpost = \
 	$(if $(missing-input), \
 		echo >&2 "WARNING: $(missing-input) is missing."; \
 		echo >&2 "         Modules may not have dependencies or modversions."; \
-		echo >&2 "         You may get many unresolved symbol warnings.";) \
+		echo >&2 "         You may get many unresolved symbol errors."; \
+		echo >&2 "         You can set KBUILD_MODPOST_WARN=1 to turn errors into warning"; \
+		echo >&2 "         if you want to proceed at your own risk.";) \
 	$(MODPOST) $(modpost-args)
 
 targets += $(output-symdump)
-- 
2.34.1

