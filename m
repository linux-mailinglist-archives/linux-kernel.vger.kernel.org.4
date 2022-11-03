Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE53617F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKCOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKCOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:23:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107226DC;
        Thu,  3 Nov 2022 07:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BB9DCE2722;
        Thu,  3 Nov 2022 14:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0DDC433D6;
        Thu,  3 Nov 2022 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667485424;
        bh=1mb0UurHHrNFqj2sHmybUCJt4bkS5HY4Ovca4anNFkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XY6qTuHKDTt2JcS/mXxzCs2mTyv6ktexk/jwHBkomRWhGgdujJzF7NM/ANfK0EKGv
         u2CUjFR7jiCpEKXUUXVAckSw9ayh/tFVvscGbr2Xz/7cvywSZz87T6Ub900CRx8Upd
         FQ+sFbnhx6cCq2f/EnzTJrWNsTvsYpEIev2IrpLwroR3pI940YOoYIq2unsvG2pqFR
         DcVNhKJ5bQgA6sCCeVN0zZK/tL7yLNm/TSqQKKndGti8QmXciB28MEieQwHsLi2HTx
         zOPQgr3Ftc00LRdHzpyX2/9JS6lSVpAmt27EO1fRjSnSzxGEQJ4ngFXnXNHKv4fnz4
         2PyDKFNb9i+xQ==
Date:   Thu, 3 Nov 2022 15:23:40 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 ovl_set_acl
Message-ID: <20221103142340.6qc23fgvchtmrv6z@wittgenstein>
References: <20221103072557.qc2hsowoaatstrbh@wittgenstein>
 <0000000000002d057805ec8f6cb5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000002d057805ec8f6cb5@google.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:40:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

Unrelated failure. I've reproduced the issue manually and verified that
the patch I wanted to test fixes it. Patch is in the relevant branch an
in for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?h=fs.acl.rework&id=5b52aebef8954cadff29918bb61d7fdc7be07837

This is only relevant for the next mw so nothing in ovl in mainline.
Fwiw, this is the fix:

From 5b52aebef8954cadff29918bb61d7fdc7be07837 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 3 Nov 2022 08:18:46 +0100
Subject: [PATCH] ovl: call posix_acl_release() after error checking

The current placement of posix_acl_release() in ovl_set_or_remove_acl()
means it can be called on an error pointer instead of actual acls.
Fix this by moving the posix_acl_release() call after the error handling.

Fixes: 0e641857322f ("ovl: implement set acl method") # mainline only
Reported-by: syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 77a77fd7a77b..ee6dfa577c93 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -621,11 +621,11 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		real_acl = vfs_get_acl(mnt_user_ns(realpath.mnt), realdentry,
 				       acl_name);
 		revert_creds(old_cred);
-		posix_acl_release(real_acl);
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out_drop_write;
 		}
+		posix_acl_release(real_acl);
 	}
 
 	if (!upperdentry) {
-- 
2.34.1

