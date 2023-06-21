Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED6738819
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjFUO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjFUOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA6213C;
        Wed, 21 Jun 2023 07:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFF1615C3;
        Wed, 21 Jun 2023 14:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FB8C433C0;
        Wed, 21 Jun 2023 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358988;
        bh=9L7A8/A6LFjcabA1gjfSYeoHiy7VK9nCxB9xPTQPT0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mb+pna0LDACr8Gs3OHfYiWOfyO9fFLyB+1ed0LtE3cjVeob0Z64b+z1tNq3zJkQXL
         1EKb/gVprD6ec3dfcMjIYJae+Njg1eVQEWSl5Go1mVLO+v1M2+/QRs05KhFeVF6ztA
         yHu9xCiDpzJSRavYfm7uvpx4F/yxPiNGCjXRvrSg6lBgRYdmcoJOj93+EtUXFvUrqg
         gEeJXmg/eqMCx+26qe136b56eVBKAEucaBbW7Xf+9ZJ7CkVQ5u7Su+XdTjTyK6Cl0r
         SzDe1HIsCf68e2wHRAzrsFvmlwEN/f4tG+m+KDQq6eth67GIYWvFyA51t11YY4tpxa
         3716NO77xi/Zw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 76/79] apparmor: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:29 -0400
Message-ID: <20230621144735.55953-75-jlayton@kernel.org>
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
 security/apparmor/apparmorfs.c    | 6 +++---
 security/apparmor/policy_unpack.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 3d0d370d6ffd..8c72a94dd9e3 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -226,7 +226,7 @@ static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = iops ? iops : &simple_dir_inode_operations;
@@ -1557,7 +1557,7 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
 		if (new->dents[i]) {
 			struct inode *inode = d_inode(new->dents[i]);
 
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 		}
 		old->dents[i] = NULL;
 	}
@@ -2546,7 +2546,7 @@ static int aa_mk_null_file(struct dentry *parent)
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = S_IFCHR | S_IRUGO | S_IWUGO;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
 			   MKDEV(MEM_MAJOR, 3));
 	d_instantiate(dentry, inode);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 4c188a44d65c..334d69b118a9 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -89,10 +89,10 @@ void __aa_loaddata_update(struct aa_loaddata *data, long revision)
 		struct inode *inode;
 
 		inode = d_inode(data->dents[AAFS_LOADDATA_DIR]);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 
 		inode = d_inode(data->dents[AAFS_LOADDATA_REVISION]);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 	}
 }
 
-- 
2.41.0

