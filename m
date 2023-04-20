Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4F6E8E35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjDTJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjDTJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0283583
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E193E6467C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5EDC4339B;
        Thu, 20 Apr 2023 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983363;
        bh=DwRmO6sLd6DSu4XerymlPu6AGVA9EjZmTO/MB0fPMzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IT9A8vuPndkw9kqw/yd9xu45HHRuiDK2r/m6ljSIn9evAp/QD5iM4wTwAbdDn4WuY
         SKYEF75LKDxZj6pV9i0sVFa9z5m3Z6lUWEY5NWPozipbFU6vMEZ+u2cqXH5F3hS9uC
         GB770KTeptnPe1jyrPfwdtwASqmQWE9yKp32IJModz01SOy8VzztkTsKTyrgZQF1So
         wPCQv6XC+ljESk33rBTReGg+vBUn1ucyihFmfP81Os+xvfcLwD4RgGkK885c+7KgsY
         yp8/06uNcRpEChwQJGCZXw7OVsRvOXFBSHMBT2ps6lJdMdgeKRmXgyC4biJ1LQ55yc
         gER/Wu2voExyg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/4] tty: vt: simplify some cases in tioclinux()
Date:   Thu, 20 Apr 2023 11:35:57 +0200
Message-Id: <20230420093559.13200-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420093559.13200-1-jirislaby@kernel.org>
References: <20230420093559.13200-1-jirislaby@kernel.org>
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

There is no need to set "ret" variable and break. We can simply return
from the cases. This makes the code much easier to follow, as many else
branches are redundant.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 62 +++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2dffee1e114a..f44d5b8a102c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3145,12 +3145,10 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 
 	switch (type) {
 	case TIOCL_SETSEL:
-		ret = set_selection_user((struct tiocl_selection
+		return set_selection_user((struct tiocl_selection
 					 __user *)(p+1), tty);
-		break;
 	case TIOCL_PASTESEL:
-		ret = paste_selection(tty);
-		break;
+		return paste_selection(tty);
 	case TIOCL_UNBLANKSCREEN:
 		console_lock();
 		unblank_screen();
@@ -3169,14 +3167,12 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		 * this.
 		 */
 		data = vt_get_shift_state();
-		ret = put_user(data, p);
-		break;
+		return put_user(data, p);
 	case TIOCL_GETMOUSEREPORTING:
 		console_lock();	/* May be overkill */
 		data = mouse_reporting();
 		console_unlock();
-		ret = put_user(data, p);
-		break;
+		return put_user(data, p);
 	case TIOCL_SETVESABLANK:
 		console_lock();
 		ret = set_vesa_blanking(p);
@@ -3184,38 +3180,34 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		break;
 	case TIOCL_GETKMSGREDIRECT:
 		data = vt_get_kmsg_redirect();
-		ret = put_user(data, p);
-		break;
+		return put_user(data, p);
 	case TIOCL_SETKMSGREDIRECT:
-		if (!capable(CAP_SYS_ADMIN)) {
-			ret = -EPERM;
-		} else {
-			if (get_user(data, p+1))
-				ret = -EFAULT;
-			else
-				vt_kmsg_redirect(data);
-		}
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		if (get_user(data, p+1))
+			return -EFAULT;
+
+		vt_kmsg_redirect(data);
+
 		break;
 	case TIOCL_GETFGCONSOLE:
 		/*
 		 * No locking needed as this is a transiently correct return
 		 * anyway if the caller hasn't disabled switching.
 		 */
-		ret = fg_console;
-		break;
+		return fg_console;
 	case TIOCL_SCROLLCONSOLE:
-		if (get_user(lines, (s32 __user *)(p+4))) {
-			ret = -EFAULT;
-		} else {
-			/*
-			 * Needs the console lock here. Note that lots of other
-			 * calls need fixing before the lock is actually useful!
-			 */
-			console_lock();
-			scrollfront(vc_cons[fg_console].d, lines);
-			console_unlock();
-			ret = 0;
-		}
+		if (get_user(lines, (s32 __user *)(p+4)))
+			return -EFAULT;
+
+		/*
+		 * Needs the console lock here. Note that lots of other calls
+		 * need fixing before the lock is actually useful!
+		 */
+		console_lock();
+		scrollfront(vc_cons[fg_console].d, lines);
+		console_unlock();
 		break;
 	case TIOCL_BLANKSCREEN:	/* until explicitly unblanked, not only poked */
 		console_lock();
@@ -3224,11 +3216,9 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		console_unlock();
 		break;
 	case TIOCL_BLANKEDSCREEN:
-		ret = console_blanked;
-		break;
+		return console_blanked;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
 	return ret;
-- 
2.40.0

