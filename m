Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC2E66AD08
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjANRV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjANRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:21:51 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38583CD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:21:48 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GkDwpTOYE2zC1GkDwp5Jc6; Sat, 14 Jan 2023 18:21:47 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 18:21:47 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, ddiss@suse.de, mwilck@suse.com,
        brauner@kernel.org, wuchi.zero@gmail.com, ebiederm@xmission.com,
        xupengfei@nfschina.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] initramfs: Use kstrtobool() instead of strtobool()
Date:   Sat, 14 Jan 2023 18:21:38 +0100
Message-Id: <2597e80cb7059ec6ad63a01b77d7c944dcc99195.1673716768.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch was already sent as a part of a serie ([1]) that axed all usages
of strtobool().
Most of the patches have been merged in -next.

I synch'ed with latest -next and re-send the remaining ones as individual
patches.

This patch slightly changes the existing code with an additional error
handling.

Note that the first version was sent to no-one, only mailing lists,
because "get_maintainer.pl --nogit-fallback" returns an empty list.

Changes in v2:
  - Re-write to code to be more consistent with other kstrtobool() usage
    in __setup() functions

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 init/initramfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 62321883fe61..f6c112e30bd4 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -11,6 +11,7 @@
 #include <linux/syscalls.h>
 #include <linux/utime.h>
 #include <linux/file.h>
+#include <linux/kstrtox.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
@@ -571,8 +572,7 @@ __setup("keepinitrd", keepinitrd_setup);
 static bool __initdata initramfs_async = true;
 static int __init initramfs_async_setup(char *str)
 {
-	strtobool(str, &initramfs_async);
-	return 1;
+	return kstrtobool(str, &initramfs_async) == 0;
 }
 __setup("initramfs_async=", initramfs_async_setup);
 
-- 
2.34.1

