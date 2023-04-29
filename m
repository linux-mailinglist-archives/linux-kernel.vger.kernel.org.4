Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824E66F2671
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjD2Ufe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2Ufd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DFC10E5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8FD560EDE
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 20:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8ACC433EF;
        Sat, 29 Apr 2023 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682800531;
        bh=pqdkn51QhwGmoLD6P4ZiJu49T/u+1bdaUjXi3014pjo=;
        h=From:To:Cc:Subject:Date:From;
        b=HgJprMYlBdRmLffAD8hB6CIIYmBIbkl6cSCr5/nlUQJZSbhww3nFibTlECwFp1s2+
         iTiUFWTps7qGnvO0t4KTh28nbWNiclYGOUCOErcYbhw3RFUbRCB662N1YB7p1dk3bV
         k43imjaYj48C7GFnXRTcVUZX9IgufZTjW8sUxzAiJVoWmoJJ0xbxZhuU84LU3991u6
         X2dzp9JQuT0oeFJnpd2qebK8v082T2ZlngKfgEVcIbHAKiF/GTIOa5HnbPxUdM+lYm
         rK0q4RbYn6Bsucd1z8m+trWwM1OI2GrgjnubKzj3s6zYecpN2w3fCfLQBpnHpeztBd
         BO73+00GgZ7zA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: remove duplicate hung_up_tty_compat_ioctl()
Date:   Sat, 29 Apr 2023 22:34:31 +0200
Message-Id: <20230429203523.538756-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The hung_up_tty_compat_ioctl() has been identical to hung_up_tty_ioctl()
for a very long time, but now the only caller is inside of an #ifdef,
causing a harmless warning:

drivers/tty/tty_io.c:446:13: error: 'hung_up_tty_compat_ioctl' defined but not used [-Werror=unused-function]
  446 | static long hung_up_tty_compat_ioctl(struct file *file,

Avoid this by removing the function entirely and just using the native
one in its place.

Fixes: 04f378b198da ("tty: BKL pushdown")
Fixes: 4c87e9e5479b ("tty: tty_io: remove hung_up_tty_fops")
Link: https://lore.kernel.org/all/2a07bded-25e5-fd27-a2de-8b606e4d1d2c@I-love.SAKURA.ne.jp/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I did this patch to fix the build failure locally before I saw it
was already under discussion. Sending it anyway in case nobody
else has done a formal fix yet.
---
 drivers/tty/tty_io.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 553182753098..31d465279b6c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -443,12 +443,6 @@ static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static long hung_up_tty_compat_ioctl(struct file *file,
-				     unsigned int cmd, unsigned long arg)
-{
-	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
-}
-
 static int hung_up_tty_fasync(int fd, struct file *file, int on)
 {
 	return -ENOTTY;
@@ -2941,7 +2935,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	}
 
 	if (tty_hung_up_p(file))
-		return hung_up_tty_compat_ioctl(file, cmd, arg);
+		return hung_up_tty_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
@@ -2959,7 +2953,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
-		return hung_up_tty_compat_ioctl(file, cmd, arg);
+		return hung_up_tty_ioctl(file, cmd, arg);
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, cmd, arg);
 	if (retval == -ENOIOCTLCMD && ld->ops->ioctl)
-- 
2.39.2

