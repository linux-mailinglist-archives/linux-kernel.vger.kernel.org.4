Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96072B2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjFKPwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjFKPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A63273D;
        Sun, 11 Jun 2023 08:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 223CA61C12;
        Sun, 11 Jun 2023 15:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31222C433EF;
        Sun, 11 Jun 2023 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686498687;
        bh=6BfvdfkpzilXQh7Twa7D0t4Xdd7OIdDDNqJCJ31RxEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muffq5Uz8VAmufgQ5ev31AyDN0HI/J9VuDzigM9QOi8MWiDZqAvtkY0eu2ouCT3SG
         9O3edtUNX/dTYRarrI7pJ3i3sIpAMhPr3426eq1uso34+yWtFAc1I5yI3YV1I0hQXk
         Mf2RxE6kjfHEfBfMwgd05WDbYqRJM9IntdDETlBhcINfjPZtWmE32XR27lAOZRW7VV
         FN1AV1Ajh7d1bbu154nAJWXobki1X3tWHk849bj2pH+cOwlWAuJv7U9x/0eZNpVe7/
         ICalL1vzDxhVHYwQ7alW7fRaeU6bYf1rlUEt0Jws8oZ1MZ9kHTeIV8jGt8IjWK6TuS
         QfjCzQmWrdjNQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v9 10/11] modpost: show offset from symbol for section mismatch warnings
Date:   Mon, 12 Jun 2023 00:50:59 +0900
Message-Id: <20230611155100.2553804-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611155100.2553804-1-masahiroy@kernel.org>
References: <20230611155100.2553804-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 0adda14451fa..f26d5050e6da 100644
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

