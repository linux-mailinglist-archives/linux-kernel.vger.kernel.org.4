Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9572AA99
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjFJJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjFJJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195483C12;
        Sat, 10 Jun 2023 02:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6210760B9A;
        Sat, 10 Jun 2023 09:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96415C433D2;
        Sat, 10 Jun 2023 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686388441;
        bh=bSgiFXb7ZTjwLTsJwq+dnf6gUoYaRAfD7X61i4sz3V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hv8O9+nc+vktReYdxDm4KB3gyGRtONLjgrcTDTVxRRW85xNwf1HWmKH//k61Z+pDj
         iP7E6VsZBFfxZuKuqix+YFGkkKA2BE4bjUP4I4H3KsFHNHb4wcm44cZh+/0WGpP288
         EYpwyZm0D6mPYdWfmOOKjNzzNvJkMCuEC5D4DcbQQGs9aHsgFze0++EH+Zkh8Bi4tJ
         ulS1aYe4CZYHL5pyHU8wJB441JQveiDXFB3Ocp+8q/p26D9vRFO7IOS9aYziL3ZDG4
         C7Td6mMkaa0PUF3RncOQZ0HxczaQCffx36G3c1US88x4bFgOitvhmVepVCbeu8v+w2
         SxvM7fWV3qJvg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 10/11] modpost: show offset from symbol for section mismatch warnings
Date:   Sat, 10 Jun 2023 18:13:19 +0900
Message-Id: <20230610091320.1054554-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
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

Currently, modpost only shows the symbol names and section names, so it
repeats the same message if there are multiple relocations in the same
symbol. It is common the relocation spans across multiple instructions.

It is better to show the offset from the symbol.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 85df3f3ba9ee..40967ed816df 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1147,8 +1147,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-	     modname, fromsym, fromsec, tosym, tosec);
+	warn("%s: section mismatch in reference: %s+0x%x (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, (unsigned int)(faddr - from->st_value), fromsec, tosym, tosec);
 
 	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
-- 
2.39.2

