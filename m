Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8920E750259
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjGLJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGLJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874F1FD0;
        Wed, 12 Jul 2023 01:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16BE76136E;
        Wed, 12 Jul 2023 08:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1D4C433CA;
        Wed, 12 Jul 2023 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152398;
        bh=dHPCHVX5jXhsmqWKcupWpEroamx0nsRcT9eKa1LG5Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOdp4UoljHDbg7qHuVn4uvkr4vwOWaps7m1PG47MUZEhpkvgm9ERVX3CrkdZUZTwh
         7d0FyFG7Rr6vV9j+p1rfaiZNuKrflYY4Z0apHC1MXmyzh07FlV4pc/KQPkOEdCF56h
         C8LietlB8P6r2lzOnyHNpHNn6Lxy+TEB0SgrwShCI64tqK1gfUG8LuMlfKfs5J8HyK
         F5/OKUfkTi/WIJPaTJPpwrvMI0rt3ttZ0XfmhLqBiSs2Y2KRsLt+f3LWGV1iwswr5u
         xvGMx7mKof29qlzUxEbDdQQuWot3XsMNCrHVqj8pSFgT4ByLBoOGIAXdhujT5ak3EA
         y2SX1/1ver5QA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 6/7] sticon: make sticon_set_def_font() void and remove op parameter
Date:   Wed, 12 Jul 2023 10:59:41 +0200
Message-ID: <20230712085942.5064-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085942.5064-1-jirislaby@kernel.org>
References: <20230712085942.5064-1-jirislaby@kernel.org>
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

sticon_set_def_font() always returns 0, so make it void. And remove an
unused 'op' parameter.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/sticon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index d11cfd2d68b5..992a4fa431aa 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -156,7 +156,7 @@ static bool sticon_scroll(struct vc_data *conp, unsigned int t,
     return false;
 }
 
-static int sticon_set_def_font(int unit, struct console_font *op)
+static void sticon_set_def_font(int unit)
 {
 	if (font_data[unit] != STI_DEF_FONT) {
 		if (--FNTREFCOUNT(font_data[unit]) == 0) {
@@ -165,8 +165,6 @@ static int sticon_set_def_font(int unit, struct console_font *op)
 		}
 		font_data[unit] = STI_DEF_FONT;
 	}
-
-	return 0;
 }
 
 static int sticon_set_font(struct vc_data *vc, struct console_font *op,
@@ -246,7 +244,7 @@ static int sticon_set_font(struct vc_data *vc, struct console_font *op,
 		  vc->vc_video_erase_char, font_data[vc->vc_num]);
 
 	/* delete old font in case it is a user font */
-	sticon_set_def_font(unit, NULL);
+	sticon_set_def_font(unit);
 
 	FNTREFCOUNT(cooked_font)++;
 	font_data[unit] = cooked_font;
@@ -264,7 +262,9 @@ static int sticon_set_font(struct vc_data *vc, struct console_font *op,
 
 static int sticon_font_default(struct vc_data *vc, struct console_font *op, char *name)
 {
-	return sticon_set_def_font(vc->vc_num, op);
+	sticon_set_def_font(vc->vc_num);
+
+	return 0;
 }
 
 static int sticon_font_set(struct vc_data *vc, struct console_font *font,
@@ -297,7 +297,7 @@ static void sticon_deinit(struct vc_data *c)
 
     /* free memory used by user font */
     for (i = 0; i < MAX_NR_CONSOLES; i++)
-	sticon_set_def_font(i, NULL);
+	sticon_set_def_font(i);
 }
 
 static void sticon_clear(struct vc_data *conp, int sy, int sx, int height,
-- 
2.41.0

