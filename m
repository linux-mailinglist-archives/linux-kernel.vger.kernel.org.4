Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88970AEE1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjEUQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjEUQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ACC10C9;
        Sun, 21 May 2023 09:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DAB6150E;
        Sun, 21 May 2023 16:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F73C4339C;
        Sun, 21 May 2023 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685150;
        bh=yLNmLqnZjiVDJ1+11bIdJ/9gglrLgGpnva7MS4wZCMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuQmkKOb2ikon5r/q2qXFOV5oTZZS8XMuVYB/PsHRLP7PCSsjM0E+NeEa8UivuKmQ
         CnAxtt76X6Q5icdBf97JfxWVKmhiQro5JfTBzKP2CRasqalW6XLq3aR9SYOWg4cyX6
         yrBimkCoAp3F31cJyfcQ+jW4ODLwBsH3e3VtpModseDbwsb5tjVLF2tZH6tk1v/b0q
         TqBVYxIe8uD5mbHSSv4cGsuFW1HaskwvAayHj8FTZPINe9MpmF30qq6HqhG04xuRUd
         pT58HZ9HRiqwxb5t/9a8cKQC4OHDk0uZRAhfja7MaFwYQyea7MhCcvO9/XTL78tzU7
         p/ar05SiIS3tw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 20/20] modpost: show offset from symbol for section mismatch warnings
Date:   Mon, 22 May 2023 01:04:25 +0900
Message-Id: <20230521160426.1881124-21-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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
---

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e7561fa57478..4da96746a03b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1135,8 +1135,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-	     modname, fromsym, fromsec, tosym, tosec);
+	warn("%s: section mismatch in reference: %s+0x%x (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, (unsigned int)(faddr - from->st_value), fromsec, tosym, tosec);
 
 	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
-- 
2.39.2

