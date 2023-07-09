Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5F74C85C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGIVSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:18:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7BD118;
        Sun,  9 Jul 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688937483;
        bh=WXEkw13RV61a6X752/mXvKkvA9bWqyILNC1f+dwJRBk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FLoAhU8/CEkJZE6yW4YBbhWeRgct9Nw4/c6y7zJvf5G6iTIwA1ee92P0qarFx7pAE
         5uwXFvaf6Lm71n+QosRp/H2XYWEBrOZVUKFdDbDTcdzC5eftfU1PJ/lcUok4MNvTTN
         BQeMEXZ/Pjgrzgj2zqXkeTqGpzQqym9vnRO8SEk4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 09 Jul 2023 23:17:58 +0200
Subject: [PATCH v2 1/3] dyndbg: constify opt_array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230709-dyndbg-filename-v2-1-fd83beef0925@weissschuh.net>
References: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
In-Reply-To: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688937480; l=714;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WXEkw13RV61a6X752/mXvKkvA9bWqyILNC1f+dwJRBk=;
 b=1EveoNxSWocT/JvcCYMCkWLZELFPlTyvQJh/Gptn44acX2ghh09fk62hWml+DdBPa89Nq+4tM
 +Wqmripd92OADMsO+8xdaW2M7B2OG2A/4SbBWZi5b11pYoZ9zidgdbY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so mark it const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fdd6d9800a70..71b22d206a1b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -88,7 +88,7 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static struct { unsigned flag:8; char opt_char; } opt_array[] = {
+static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },

-- 
2.41.0

