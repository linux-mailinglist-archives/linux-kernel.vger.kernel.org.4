Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2301C750251
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjGLJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjGLJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC7D1986;
        Wed, 12 Jul 2023 01:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F097615AE;
        Wed, 12 Jul 2023 08:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7850CC433CA;
        Wed, 12 Jul 2023 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152392;
        bh=y3hv9WFGlNw1n+L3OTmMN+6+YqGwW/2IDAh5UD/0MEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qe5T2rMBOLg417NRLdwwzjsIGBMzX/k6o/ISyoMrX0uLuuXnO1SomP2eRgYhc6uH4
         mGzNYeYi5EJjI7C5MipUa7iJuurwPLtEVR7w91m365rcsTQeegPZ8KJqNdJTGA/fbG
         doUUbkkLHEkb8lUGUBqxEUtuoqZR4es5Co1g1NICBOp/Sn5KoNwRPSTzoVlq1MFi/e
         UEe+hbkfsEptDpv6o8PSVjFsRVFQ+gDpkQx05EuC9w9O5zU4ZGA23gkY33+vFK3OUX
         ANyC+mZV8ABYZD+hr9GF4Y164fLwbDJwiy+stWRJc3JY56ID316t9iBux8/69R36M6
         uESumahRtoC8g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/7] vgacon: remove unused xpos from vgacon_set_cursor_size()
Date:   Wed, 12 Jul 2023 10:59:38 +0200
Message-ID: <20230712085942.5064-4-jirislaby@kernel.org>
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

xpos is unused, remove it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index a34cdfcc10c2..7cb15851ea56 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -437,7 +437,7 @@ static void vgacon_invert_region(struct vc_data *c, u16 * p, int count)
 	}
 }
 
-static void vgacon_set_cursor_size(int xpos, int from, int to)
+static void vgacon_set_cursor_size(int from, int to)
 {
 	unsigned long flags;
 	int curs, cure;
@@ -479,9 +479,9 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 	case CM_ERASE:
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
-			vgacon_set_cursor_size(c->state.x, 31, 30);
+			vgacon_set_cursor_size(31, 30);
 		else
-			vgacon_set_cursor_size(c->state.x, 31, 31);
+			vgacon_set_cursor_size(31, 31);
 		break;
 
 	case CM_MOVE:
@@ -489,8 +489,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 		switch (CUR_SIZE(c->vc_cursor_type)) {
 		case CUR_UNDERLINE:
-			vgacon_set_cursor_size(c->state.x,
-					       c->vc_cell_height -
+			vgacon_set_cursor_size(c->vc_cell_height -
 					       (c->vc_cell_height <
 						10 ? 2 : 3),
 					       c->vc_cell_height -
@@ -498,35 +497,31 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 						10 ? 1 : 2));
 			break;
 		case CUR_TWO_THIRDS:
-			vgacon_set_cursor_size(c->state.x,
-					       c->vc_cell_height / 3,
+			vgacon_set_cursor_size(c->vc_cell_height / 3,
 					       c->vc_cell_height -
 					       (c->vc_cell_height <
 						10 ? 1 : 2));
 			break;
 		case CUR_LOWER_THIRD:
-			vgacon_set_cursor_size(c->state.x,
-					       (c->vc_cell_height * 2) / 3,
+			vgacon_set_cursor_size((c->vc_cell_height * 2) / 3,
 					       c->vc_cell_height -
 					       (c->vc_cell_height <
 						10 ? 1 : 2));
 			break;
 		case CUR_LOWER_HALF:
-			vgacon_set_cursor_size(c->state.x,
-					       c->vc_cell_height / 2,
+			vgacon_set_cursor_size(c->vc_cell_height / 2,
 					       c->vc_cell_height -
 					       (c->vc_cell_height <
 						10 ? 1 : 2));
 			break;
 		case CUR_NONE:
 			if (vga_video_type >= VIDEO_TYPE_VGAC)
-				vgacon_set_cursor_size(c->state.x, 31, 30);
+				vgacon_set_cursor_size(31, 30);
 			else
-				vgacon_set_cursor_size(c->state.x, 31, 31);
+				vgacon_set_cursor_size(31, 31);
 			break;
 		default:
-			vgacon_set_cursor_size(c->state.x, 1,
-					       c->vc_cell_height);
+			vgacon_set_cursor_size(1, c->vc_cell_height);
 			break;
 		}
 		break;
-- 
2.41.0

