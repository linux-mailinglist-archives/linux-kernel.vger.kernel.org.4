Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941F6774E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 06:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjAWF1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 00:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAWF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 00:27:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C854C22;
        Sun, 22 Jan 2023 21:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22145CE09E5;
        Mon, 23 Jan 2023 05:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C27AC433D2;
        Mon, 23 Jan 2023 05:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674451624;
        bh=yynphTf6Y0jKiK1WTidS6B6p4zKQd9mPx6Rft7mEXeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=E5TbpuaXhEvg/Z7Z3NqXMjvrIAk3Va3jdsNFySiaLAJzHjSR3wMLVs5tz1lVe/fqe
         lTt0/u/5J5q7k5xgP6wLt1lEA87iT7RXGnE/RF9l3qqfqvhacd9ZXzGleW+PHdzq6I
         pctEqflGeJ6vGdH+GakYhIz+gMiJENHG02gJ7/K7azFREgPaXyL1Z6ugWflda+TzVz
         Ylj63T6j2bov5Nugk7fD+m8uMCotDCtBu9B3ggf3rqb+pLRTd+8pFISFhjPpkEm7DT
         TTcyeR1sAElDH5ULuQxXgMOcu9r1jTqN/x1PQmylD1hgFOyDDyvZazvCtFiyoxj9Fn
         67zctJ4u0RM9g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        William McVicker <willmcvicker@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: do not automatically add -w option to modpost
Date:   Mon, 23 Jan 2023 14:26:53 +0900
Message-Id: <20230123052653.711899-1-masahiroy@kernel.org>
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

 scripts/Makefile.modpost | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 43343e13c542..9254ed811ddd 100644
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
+		echo >&2 "         You may get many unresolved symbol errors.";) \
+		echo >&2 "         You can set KBUILD_MODPOST_WARN=1 to turn errors into warning"; \
+		echo >&2 "         if you want to proceed at your own risk."; \
 	$(MODPOST) $(modpost-args)
 
 targets += $(output-symdump)
-- 
2.34.1

