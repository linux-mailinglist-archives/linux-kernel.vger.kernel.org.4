Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73D71FC2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjFBIgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjFBIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1418C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8D864D53
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BA0C433D2;
        Fri,  2 Jun 2023 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685694970;
        bh=xlo52tvORIIpAnKK0ye25x2JEs/59m3PnMQ4tQSI3ZI=;
        h=From:To:Cc:Subject:Date:From;
        b=vKm9x52pCunrUIYLGT58atc0EHT0W3vgjHDWxW1OE424s4XXxB8maeMRZHu2WzJB1
         RXAh/H3CitZcjcmlB4ufE6zV1MfdfzBIRP6rsKk/MWCBCzRKkLPWjsRALC5OY9mN9k
         mW0oNk4PlmgXL+3OZ1gfmOLbl4s3cM0wIXAWU0W4T+BNkG50xDK8N1u4hL4w8KymK6
         Nwee5wU/xAePlAXX1EhbQIxoy+MsJlL9+zRXW+yUUhs+bnt7OmNOZ3BBQ1pLhHutRe
         Sa6Jpi6VFuyO4ODb387NZ47hwAORy4H+gvwsokp1cmNHaOmAVzNBOXvBfJMwu6pkwN
         wtl6372lBcKSw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: avoid dead loop in f2fs_issue_checkpoint()
Date:   Fri,  2 Jun 2023 16:36:05 +0800
Message-Id: <20230602083605.2470674-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

generic/082 reports a bug as below:

__schedule+0x332/0xf60
schedule+0x6f/0xf0
schedule_timeout+0x23b/0x2a0
wait_for_completion+0x8f/0x140
f2fs_issue_checkpoint+0xfe/0x1b0
f2fs_sync_fs+0x9d/0xb0
sync_filesystem+0x87/0xb0
dquot_load_quota_sb+0x41b/0x460
dquot_load_quota_inode+0xa5/0x130
dquot_quota_on+0x4b/0x60
f2fs_quota_on+0xe3/0x1b0
do_quotactl+0x483/0x700
__x64_sys_quotactl+0x15c/0x310
do_syscall_64+0x3f/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

The root casue is race case as below:

Thread A			Kworker			IRQ
- write()
: write data to quota.user file

				- writepages
				 - f2fs_submit_page_write
				  - __is_cp_guaranteed return false
				  - inc_page_count(F2FS_WB_DATA)
				 - submit_bio
- quotactl(Q_QUOTAON)
 - f2fs_quota_on
  - dquot_quota_on
   - dquot_load_quota_inode
    - vfs_setup_quota_inode
    : inode->i_flags |= S_NOQUOTA
							- f2fs_write_end_io
							 - __is_cp_guaranteed return true
							 - dec_page_count(F2FS_WB_CP_DATA)
    - dquot_load_quota_sb
     - f2fs_sync_fs
      - f2fs_issue_checkpoint
       - do_checkpoint
        - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA)
        : loop due to F2FS_WB_CP_DATA count is negative

Calling filemap_fdatawrite() and filemap_fdatawait() to keep all data
clean before quota file setup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- avoid compile warning reported by lkp@intel.com.
 fs/f2fs/super.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2936bc870f5c..8fd23caa1ed9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2923,15 +2923,26 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 		return -EBUSY;
 	}
 
+	if (path->dentry->d_sb != sb)
+		return -EXDEV;
+
 	err = f2fs_quota_sync(sb, type);
 	if (err)
 		return err;
 
-	err = dquot_quota_on(sb, type, format_id, path);
+	inode = d_inode(path->dentry);
+
+	err = filemap_fdatawrite(inode->i_mapping);
 	if (err)
 		return err;
 
-	inode = d_inode(path->dentry);
+	err = filemap_fdatawait(inode->i_mapping);
+	if (err)
+		return err;
+
+	err = dquot_quota_on(sb, type, format_id, path);
+	if (err)
+		return err;
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
-- 
2.40.1

