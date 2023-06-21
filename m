Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACB738825
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjFUO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjFUOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567C3C06;
        Wed, 21 Jun 2023 07:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E308F615B8;
        Wed, 21 Jun 2023 14:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ECDC433C0;
        Wed, 21 Jun 2023 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358968;
        bh=779b5HE/gvZfyI1PxNLGg0MlvOtGaaXF4FcVZ7xYTIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Im8pjHUrm9nuFtUPKuM8vt6t+ZDLxcnatmzdgIVyfOyIM59sPWXF8qu4TWQRg3zcC
         4vTcClWgaTi9fHtCXeLeu//chHjKju8AMuFU6O/LX4AdDt8b1sAlm+Vq4CoYcCH849
         uP5lIbhLNZ2l9HfkEZVfwE52vLArtLLG8SkJ3len8vwlo+PvpZr8XDNphqy1VVPWlj
         3dCwlhwnQbpP6pOjVNX7cKTTYDga5xewV22cckb1dJDRyH2stVoX6+9/OFnBfplBuB
         4hXxLyzWAbqVoE2c3OMF/I1rxDwOftY1dKwQh+d8vtfwsPK22ffp7SxXWMAsw5SJ1Y
         VY8uxgAtkE6EQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 65/79] tracefs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:18 -0400
Message-ID: <20230621144735.55953-64-jlayton@kernel.org>
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
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a724..aae4b5645efd 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -132,7 +132,7 @@ static struct inode *tracefs_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	}
 	return inode;
 }
-- 
2.41.0

