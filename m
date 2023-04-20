Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0E6E8E31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjDTJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDTJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A624218
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7D663C35
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E44C433EF;
        Thu, 20 Apr 2023 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983361;
        bh=T6uUHqivtCoda+tTBoVvWTGjZz5SG3uZZc+GgVo78i0=;
        h=From:To:Cc:Subject:Date:From;
        b=dOSFxsZ7BUpX1JZci+sRt27w+xpxRrQE9mSYjMLo9qRhCnwrFWfS/Wko8tEygwtvn
         npMuUgAaD2ifa8hJuchxYqXR5Benz4RXa+Zn+WUWXNJbNmTIsNogr0IyTV2IzvvsRE
         t9/IPZGsJOQ9HdkLiu6PiD+S+zEkp3mu7AIvO8SuYO8bUWtK/Lwwh6iE5LUHQy9f9S
         YGtjblvJhkWZloZDz0T858QlwAJF/6Xs78YNtPl2+ZqKS1lH94hCY8Ue/cdVMIshmX
         bnZ6abk2W+l7x3ufYvkLN8o73MG28+xldAnR1jVtJTx3K5GG9EKQE281kDlFFQGmJE
         oxKhwOemx4xGw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/4] tty: vt: reformat tioclinux()
Date:   Thu, 20 Apr 2023 11:35:56 +0200
Message-Id: <20230420093559.13200-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
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

Reformat tioclinux() to what we are used to. That is:
* format switch-case (one less indent level),
* format comments (the same indent level), and
* add a newline before return.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 167 ++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 83 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 40e4928eddaf..2dffee1e114a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3143,93 +3143,94 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		return -EFAULT;
 	ret = 0;
 
-	switch (type)
-	{
-		case TIOCL_SETSEL:
-			ret = set_selection_user((struct tiocl_selection
-						 __user *)(p+1), tty);
-			break;
-		case TIOCL_PASTESEL:
-			ret = paste_selection(tty);
-			break;
-		case TIOCL_UNBLANKSCREEN:
-			console_lock();
-			unblank_screen();
-			console_unlock();
-			break;
-		case TIOCL_SELLOADLUT:
-			console_lock();
-			ret = sel_loadlut(p);
-			console_unlock();
-			break;
-		case TIOCL_GETSHIFTSTATE:
-
-	/*
-	 * Make it possible to react to Shift+Mousebutton.
-	 * Note that 'shift_state' is an undocumented
-	 * kernel-internal variable; programs not closely
-	 * related to the kernel should not use this.
-	 */
-			data = vt_get_shift_state();
-			ret = put_user(data, p);
-			break;
-		case TIOCL_GETMOUSEREPORTING:
-			console_lock();	/* May be overkill */
-			data = mouse_reporting();
-			console_unlock();
-			ret = put_user(data, p);
-			break;
-		case TIOCL_SETVESABLANK:
-			console_lock();
-			ret = set_vesa_blanking(p);
-			console_unlock();
-			break;
-		case TIOCL_GETKMSGREDIRECT:
-			data = vt_get_kmsg_redirect();
-			ret = put_user(data, p);
-			break;
-		case TIOCL_SETKMSGREDIRECT:
-			if (!capable(CAP_SYS_ADMIN)) {
-				ret = -EPERM;
-			} else {
-				if (get_user(data, p+1))
-					ret = -EFAULT;
-				else
-					vt_kmsg_redirect(data);
-			}
-			break;
-		case TIOCL_GETFGCONSOLE:
-			/* No locking needed as this is a transiently
-			   correct return anyway if the caller hasn't
-			   disabled switching */
-			ret = fg_console;
-			break;
-		case TIOCL_SCROLLCONSOLE:
-			if (get_user(lines, (s32 __user *)(p+4))) {
+	switch (type) {
+	case TIOCL_SETSEL:
+		ret = set_selection_user((struct tiocl_selection
+					 __user *)(p+1), tty);
+		break;
+	case TIOCL_PASTESEL:
+		ret = paste_selection(tty);
+		break;
+	case TIOCL_UNBLANKSCREEN:
+		console_lock();
+		unblank_screen();
+		console_unlock();
+		break;
+	case TIOCL_SELLOADLUT:
+		console_lock();
+		ret = sel_loadlut(p);
+		console_unlock();
+		break;
+	case TIOCL_GETSHIFTSTATE:
+		/*
+		 * Make it possible to react to Shift+Mousebutton. Note that
+		 * 'shift_state' is an undocumented kernel-internal variable;
+		 * programs not closely related to the kernel should not use
+		 * this.
+		 */
+		data = vt_get_shift_state();
+		ret = put_user(data, p);
+		break;
+	case TIOCL_GETMOUSEREPORTING:
+		console_lock();	/* May be overkill */
+		data = mouse_reporting();
+		console_unlock();
+		ret = put_user(data, p);
+		break;
+	case TIOCL_SETVESABLANK:
+		console_lock();
+		ret = set_vesa_blanking(p);
+		console_unlock();
+		break;
+	case TIOCL_GETKMSGREDIRECT:
+		data = vt_get_kmsg_redirect();
+		ret = put_user(data, p);
+		break;
+	case TIOCL_SETKMSGREDIRECT:
+		if (!capable(CAP_SYS_ADMIN)) {
+			ret = -EPERM;
+		} else {
+			if (get_user(data, p+1))
 				ret = -EFAULT;
-			} else {
-				/* Need the console lock here. Note that lots
-				   of other calls need fixing before the lock
-				   is actually useful ! */
-				console_lock();
-				scrollfront(vc_cons[fg_console].d, lines);
-				console_unlock();
-				ret = 0;
-			}
-			break;
-		case TIOCL_BLANKSCREEN:	/* until explicitly unblanked, not only poked */
+			else
+				vt_kmsg_redirect(data);
+		}
+		break;
+	case TIOCL_GETFGCONSOLE:
+		/*
+		 * No locking needed as this is a transiently correct return
+		 * anyway if the caller hasn't disabled switching.
+		 */
+		ret = fg_console;
+		break;
+	case TIOCL_SCROLLCONSOLE:
+		if (get_user(lines, (s32 __user *)(p+4))) {
+			ret = -EFAULT;
+		} else {
+			/*
+			 * Needs the console lock here. Note that lots of other
+			 * calls need fixing before the lock is actually useful!
+			 */
 			console_lock();
-			ignore_poke = 1;
-			do_blank_screen(0);
+			scrollfront(vc_cons[fg_console].d, lines);
 			console_unlock();
-			break;
-		case TIOCL_BLANKEDSCREEN:
-			ret = console_blanked;
-			break;
-		default:
-			ret = -EINVAL;
-			break;
+			ret = 0;
+		}
+		break;
+	case TIOCL_BLANKSCREEN:	/* until explicitly unblanked, not only poked */
+		console_lock();
+		ignore_poke = 1;
+		do_blank_screen(0);
+		console_unlock();
+		break;
+	case TIOCL_BLANKEDSCREEN:
+		ret = console_blanked;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
+
 	return ret;
 }
 
-- 
2.40.0

