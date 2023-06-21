Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA073879F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFUOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjFUOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA41997;
        Wed, 21 Jun 2023 07:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21AC6157E;
        Wed, 21 Jun 2023 14:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79CBC433C0;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358866;
        bh=F3dY/2KLU5GOMIGa42l18TYXTzOkj60bdKGA2MB7kkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mioKTqZYyXJZavUYjcubhAf8oDBomkt74YuPWSA09CAcJuHtjWYu58SB4Z3985pYl
         9rU5LxQy2mip8BeoycVEc8K0Y2pmMxS0Tlq+9SwjwKNf1UsqVYl9jhv4FcDRPADbKI
         491CPsalfGoUC3xZ2srE9Ot53iuzMqb4CpFDRwKPoQQlYaruIT9GF+q2EJamLI8KTB
         xBGNVi1fOZ7dtG39nR+YmVdEtg0IiQ/DBo1cOK89vpa3Jr0WXQn1fokdnQLmxlz3Is
         YyRaE/xiud5UkfOYTmAqwP8rnqRnxkH4w9BLQmRmqc2ICOWr/8PRBzs37A0SOQKudr
         H6GYBb/gkUn9g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/79] usb: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:20 -0400
Message-ID: <20230621144735.55953-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/usb/core/devio.c           | 16 ++++++++--------
 drivers/usb/gadget/function/f_fs.c |  6 +-----
 drivers/usb/gadget/legacy/inode.c  |  3 +--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 1a16a8bdea60..02f718e0deaf 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2642,21 +2642,21 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL\n", __func__);
 		ret = proc_control(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_BULK:
 		snoop(&dev->dev, "%s: BULK\n", __func__);
 		ret = proc_bulk(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_RESETEP:
 		snoop(&dev->dev, "%s: RESETEP\n", __func__);
 		ret = proc_resetep(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_RESET:
@@ -2668,7 +2668,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CLEAR_HALT\n", __func__);
 		ret = proc_clearhalt(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_GETDRIVER:
@@ -2695,7 +2695,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB\n", __func__);
 		ret = proc_submiturb(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 #ifdef CONFIG_COMPAT
@@ -2703,14 +2703,14 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL32\n", __func__);
 		ret = proc_control_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_BULK32:
 		snoop(&dev->dev, "%s: BULK32\n", __func__);
 		ret = proc_bulk_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_DISCSIGNAL32:
@@ -2722,7 +2722,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB32\n", __func__);
 		ret = proc_submiturb_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		break;
 
 	case USBDEVFS_IOCTL32:
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index f41a385a5c42..756c78043a04 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1377,16 +1377,12 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 	inode = new_inode(sb);
 
 	if (inode) {
-		struct timespec64 ts = current_time(inode);
-
 		inode->i_ino	 = get_next_ino();
 		inode->i_mode    = perms->mode;
 		inode->i_uid     = perms->uid;
 		inode->i_gid     = perms->gid;
-		inode->i_atime   = ts;
-		inode->i_mtime   = ts;
-		inode->i_ctime   = ts;
 		inode->i_private = data;
+		inode->i_atime   = inode->i_mtime = inode_ctime_set_current(inode);
 		if (fops)
 			inode->i_fop = fops;
 		if (iops)
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 28249d0bf062..b83a68feb316 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1969,8 +1969,7 @@ gadgetfs_make_inode (struct super_block *sb,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, default_uid);
 		inode->i_gid = make_kgid(&init_user_ns, default_gid);
-		inode->i_atime = inode->i_mtime = inode->i_ctime
-				= current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		inode->i_private = data;
 		inode->i_fop = fops;
 	}
-- 
2.41.0

