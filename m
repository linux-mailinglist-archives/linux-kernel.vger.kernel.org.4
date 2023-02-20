Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C469C56A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 07:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjBTGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 01:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjBTGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:46:34 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCF1043E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 22:46:29 -0800 (PST)
From:   linux@weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676875587;
        bh=xQb/DvmoWVBwwvH3xJlj7iYXj+76Lll/6wreW578Wyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/vHNH1LaXzmV0CvMyBePgDpuHWDccS0dtuGWLiCmdmVOvMAxDA1gWW0fQWlOAHjf
         LNrTGRmkS/yaOyudiIyrUCkNRaW+sfI/jm4xtXOw7Xadj2QVN3qVjhG5azTnZOY3fw
         Umy+WYVYLGMeFiZYg0T4uxHMyW8wYXKzbk/F6tZ0=
To:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Storm Dragon <stormdragon2976@gmail.com>
Subject: [PATCH] vc_screen: don't clobber return value in vcs_read
Date:   Mon, 20 Feb 2023 06:46:12 +0000
Message-Id: <20230220064612.1783-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <Y/KtG9vK0oz0nQrN@hotmail.com>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Commit 226fae124b2d
("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
moved the call to vcs_vc() into the loop.
While doing this it also moved the unconditional assignment of
"ret = -ENXIO".
This unconditional assignment was valid outside the loop but within it
it clobbers the actual value of ret.

To avoid this only assign "ret = -ENXIO" when actually needed.

Reported-by: Storm Dragon <stormdragon2976@gmail.com>
Link: https://lore.kernel.org/lkml/Y%2FKS6vdql2pIsCiI@hotmail.com/
Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

@Storm Could you validate this patch?
---
 drivers/tty/vt/vc_screen.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index f566eb1839dc..2ef519a40a87 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		unsigned int this_round, skip = 0;
 		int size;
 
-		ret = -ENXIO;
 		vc = vcs_vc(inode, &viewed);
-		if (!vc)
+		if (!vc) {
+			ret = -ENXIO;
 			goto unlock_out;
+		}
 
 		/* Check whether we are above size each round,
 		 * as copy_to_user at the end of this loop

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.39.2

