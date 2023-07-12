Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BFF750249
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjGLJBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGLJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C5269A;
        Wed, 12 Jul 2023 01:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92541616E6;
        Wed, 12 Jul 2023 08:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699AAC433CA;
        Wed, 12 Jul 2023 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152388;
        bh=ZrJHzT2K9435cGUOZjdcu1RL4XkwF5n9Ynfmc/OI09Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHMz1RajGGyT8QAgPhNYUibwugiKRyBupzLguqjKvMqzVnEj4uap14DzDwsl7xEhk
         IhNjzK7h+yaZuqJGS75WXsePAnLedFsRFi6LtzkWK2BeYhGHdq2DXuEaeulC+TmBZ8
         Tf1KHe1DXobmTlW965juIlOyZFmBmtMlSC03TxK2wWGMMMPUGDEGFImqFb1s/hd4zQ
         xp8RhOiPyJqjQeRnPKbedtQA/4/r/PiQsPKsLjSb88pZTiQtOLCVeOx9+GSOiVJWBv
         7PHaMMAYgdTDuUGMMOu6m1Vv/E2RUJE5xGeNJCjMOB7Xr3pnRu995sZWDCBSu80iRU
         P8LR9M37ACinA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/7] vgacon: switch vgacon_scrolldelta() and vgacon_restore_screen()
Date:   Wed, 12 Jul 2023 10:59:36 +0200
Message-ID: <20230712085942.5064-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085942.5064-1-jirislaby@kernel.org>
References: <20230712085942.5064-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch vgacon_scrolldelta() and vgacon_restore_screen() positions, so
that the former is not needed to be forward-declared.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e25ba523892e..fbed2862c317 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -142,12 +142,6 @@ static inline void vga_set_mem_top(struct vc_data *c)
 	write_vga(12, (c->vc_visible_origin - vga_vram_base) / 2);
 }
 
-static void vgacon_restore_screen(struct vc_data *c)
-{
-	if (c->vc_origin != c->vc_visible_origin)
-		vgacon_scrolldelta(c, 0);
-}
-
 static void vgacon_scrolldelta(struct vc_data *c, int lines)
 {
 	vc_scrolldelta_helper(c, lines, vga_rolled_over, (void *)vga_vram_base,
@@ -155,6 +149,12 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	vga_set_mem_top(c);
 }
 
+static void vgacon_restore_screen(struct vc_data *c)
+{
+	if (c->vc_origin != c->vc_visible_origin)
+		vgacon_scrolldelta(c, 0);
+}
+
 static const char *vgacon_startup(void)
 {
 	const char *display_desc = NULL;
-- 
2.41.0

