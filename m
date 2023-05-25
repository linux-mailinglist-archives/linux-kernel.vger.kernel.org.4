Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69910710745
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbjEYIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEYIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9394F18C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208F363C3E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6DDC433EF;
        Thu, 25 May 2023 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685003113;
        bh=wdwLIYaRnnHNZrYI8ePzismwEYz5I7HXxffbJWvgnJM=;
        h=From:To:Cc:Subject:Date:From;
        b=fGHFzqJYUhsyMhG5K89rik+THLbemTJ2u5RuPhWjXMTqcPz6qYmXNegWOUOUO1/PK
         6FLBlJB5y4djFMDRJjCZLbnrEqDkBNNTnwzQBrcmMWqt6cFnTmesOoujqgF2RLCLXd
         bJuRudkQKJ0oofi4hO4icVn9i8fByIIpCqzxegy96cy52af/skg8PlkfWpL1aeYkwp
         h5/KKyB0d0F6gpBWGXpiiemVuL+0LFrGjj1E1D6DldB+Kd4aJG22NYrtjxUsOGxc8R
         J5elbpZrjhM8FLb4W4IIQL0yjAQQny/XyKXikblFtSn2a4WAgZ5SEof6rnTy3271jG
         hZRchio1OJ8QQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to set noatime and immutable flag for quota file
Date:   Thu, 25 May 2023 16:25:08 +0800
Message-Id: <20230525082508.2320763-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

We should set noatime bit for quota files, since no one cares about
atime of quota file, and we should set immutalbe bit as well, due to
nobody should write to the file through exported interfaces.

Meanwhile this patch use inode_lock to avoid race condition during
inode->i_flags, f2fs_inode->i_flags update.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to detect i_flags status correctly.
 fs/f2fs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..1cf84c993d7c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2763,7 +2763,17 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 	}
 
 	/* Don't account quota for quota files to avoid recursion */
+	inode_lock(qf_inode);
 	qf_inode->i_flags |= S_NOQUOTA;
+
+	if (!(F2FS_I(qf_inode)->i_flags & F2FS_NOATIME_FL) ||
+		!(F2FS_I(qf_inode)->i_flags & F2FS_IMMUTABLE_FL)) {
+		F2FS_I(qf_inode)->i_flags |=
+				F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+		f2fs_set_inode_flags(qf_inode);
+	}
+	inode_unlock(qf_inode);
+
 	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
 	iput(qf_inode);
 	return err;
-- 
2.40.1

