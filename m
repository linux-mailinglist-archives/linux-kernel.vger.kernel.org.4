Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694AA750258
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjGLJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGLJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0A1FC7;
        Wed, 12 Jul 2023 01:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD6461692;
        Wed, 12 Jul 2023 08:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C65C433C8;
        Wed, 12 Jul 2023 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152396;
        bh=WoUf830Zm0iN5qyrpb30ESZNjMmnQje4FUkAR6uGtdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trQ08FqHOyD5Z1cgklZi4TfvnqReS13ncg5YYAwZCaLOlEeXiPBI/XYXff7S365oX
         /2SZOkku7ilhfoTmX2UqYDvC/9UuoyjeBjvnb6PYvZzJXv5WLMEc7cOvF8Pn/vJVgh
         J7gxKWBGqIYMb/7RmI2WQD1VYwU3uIs2NJcs9z668EqLeTA1mg/TqbTiubaDjdXlGw
         zbZ8Nxo0dzz+NrEZIfdmH4h8kvUqlB7E5ZMBK4bsGXmn8QBCLOogmmNt2SL3thCMnd
         cEHXKDTi4+2lJyLnx5XAzySUNeCfSjOKv56/kkdLX+9LSHeYk18p6ZWFlEScHz2pOE
         xL8gvvM15Pydw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/7] vgacon: cache vc_cell_height in vgacon_cursor()
Date:   Wed, 12 Jul 2023 10:59:40 +0200
Message-ID: <20230712085942.5064-6-jirislaby@kernel.org>
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

There are many places c->vc_cell_height is used in the code of
vgacon_cursor(). Caching the value to a local variable makes the code
much easier to follow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 07f6b97d9b81..7ad047bcae17 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -470,11 +470,15 @@ static void vgacon_set_cursor_size(int from, int to)
 
 static void vgacon_cursor(struct vc_data *c, int mode)
 {
+	unsigned int c_height;
+
 	if (c->vc_mode != KD_TEXT)
 		return;
 
 	vgacon_restore_screen(c);
 
+	c_height = c->vc_cell_height;
+
 	switch (mode) {
 	case CM_ERASE:
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
@@ -489,30 +493,22 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 		switch (CUR_SIZE(c->vc_cursor_type)) {
 		case CUR_UNDERLINE:
-			vgacon_set_cursor_size(c->vc_cell_height -
-					       (c->vc_cell_height <
-						10 ? 2 : 3),
-					       c->vc_cell_height -
-					       (c->vc_cell_height <
-						10 ? 1 : 2));
+			vgacon_set_cursor_size(c_height -
+					       (c_height < 10 ? 2 : 3),
+					       c_height -
+					       (c_height < 10 ? 1 : 2));
 			break;
 		case CUR_TWO_THIRDS:
-			vgacon_set_cursor_size(c->vc_cell_height / 3,
-					       c->vc_cell_height -
-					       (c->vc_cell_height <
-						10 ? 1 : 2));
+			vgacon_set_cursor_size(c_height / 3, c_height -
+					       (c_height < 10 ? 1 : 2));
 			break;
 		case CUR_LOWER_THIRD:
-			vgacon_set_cursor_size((c->vc_cell_height * 2) / 3,
-					       c->vc_cell_height -
-					       (c->vc_cell_height <
-						10 ? 1 : 2));
+			vgacon_set_cursor_size(c_height * 2 / 3, c_height -
+					       (c_height < 10 ? 1 : 2));
 			break;
 		case CUR_LOWER_HALF:
-			vgacon_set_cursor_size(c->vc_cell_height / 2,
-					       c->vc_cell_height -
-					       (c->vc_cell_height <
-						10 ? 1 : 2));
+			vgacon_set_cursor_size(c_height / 2, c_height -
+					       (c_height < 10 ? 1 : 2));
 			break;
 		case CUR_NONE:
 			if (vga_video_type >= VIDEO_TYPE_VGAC)
@@ -521,7 +517,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 				vgacon_set_cursor_size(31, 31);
 			break;
 		default:
-			vgacon_set_cursor_size(1, c->vc_cell_height);
+			vgacon_set_cursor_size(1, c_height);
 			break;
 		}
 		break;
-- 
2.41.0

