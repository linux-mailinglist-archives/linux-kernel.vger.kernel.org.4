Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F98673881E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjFUO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjFUOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E530FF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE5E615BA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724ACC433C8;
        Wed, 21 Jun 2023 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358930;
        bh=E0tKqEg9JsFBfaTpAiyL7hNRxFYBS0vx8QAOc1Faa+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MToGmduLV/vxb3bokuYvzQ6GhoLgfmBP+Fdv1GeIahXxgZxGgtmm/k+w7CzY/TEDl
         JaVq+byk1TpPZk7sSwfiLtfKaw6rl/Ot9MVOclNBKJLxjvHWy1ZsPsrIToOnBBv/hz
         aaIIWkUs56aTmGNJ3wYLHa0ao5puAtC3geiep5LF3Nm5QBcOY+3jui9EVv1ygK5CCN
         cY3BGN+CwcQLoxR1yZ750CJ0B8ZrcAb6PcEzvRxyxQ2iMH0KNB10+X5nv5iUlbnY70
         QYKyxIrd7qshAwDlzs0tWyLABlQPiMa99sK4sobt7XvAqrqe5ZsuVA8SjZcDUulMg8
         lpHOQ5Jt5WyYw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 43/79] kernfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:56 -0400
Message-ID: <20230621144735.55953-42-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/kernfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b22b74d1a115..781093c8acdd 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -152,7 +152,7 @@ static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
 {
 	inode->i_mode = mode;
 	inode->i_atime = inode->i_mtime =
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 }
 
 static inline void set_inode_attr(struct inode *inode,
@@ -162,7 +162,7 @@ static inline void set_inode_attr(struct inode *inode,
 	inode->i_gid = attrs->ia_gid;
 	inode->i_atime = attrs->ia_atime;
 	inode->i_mtime = attrs->ia_mtime;
-	inode->i_ctime = attrs->ia_ctime;
+	inode_ctime_set(inode, attrs->ia_ctime);
 }
 
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
-- 
2.41.0

