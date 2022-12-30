Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55B36598B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiL3N3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3N3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:29:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2EDFC3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:29:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9EB9CE184C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFDAC433EF;
        Fri, 30 Dec 2022 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672406944;
        bh=niN4//FFQLqT+lccFSrIwvGHtpHQO5j4UdQf+dAxTnM=;
        h=From:To:Cc:Subject:Date:From;
        b=Q8Z9F1TdYSn+DHTUxC0tV6CvgAHrJOkO5FS+1xoIU/hT+CkbagXRWd+nGcoQ7G+oY
         1QABx5QNGJ4MojljBreW7J6SqybB4ua+Z7K/CoVuZXX9uC0n4P0zo+X55yDOKvUubL
         PHLVndJhdf+zQxLjSDF/wkNWw59kBNSelibr8zmXgfAVw08xcUNSyG/GDra/lIqWo/
         SuMuf7ysAJlpw/vWb/dcZtItBAIsyY7oSAo8iebf5fgaHZN7thPjdHC3MX/i4cLQIL
         RbU4b4wNyOxl1QazZf9GFWYdu5inJ3fR5cYJa4YloshTyH+R5KZf9wDXHMRlAQuOdk
         UI6VDL+WnXmeg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix error path of f2fs_create_flush_cmd_control()
Date:   Fri, 30 Dec 2022 21:28:56 +0800
Message-Id: <20221230132856.4248-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kthread_run() fails in f2fs_create_flush_cmd_control(), it should
not release SM_I(sbi)->fcc_info, otherwise, w/ below testcase, it will
cause NULL pointer dereference when accessing SM_I(sbi)->fcc_info
in f2fs_issue_flush().

- mount -o noflush_merge /dev/vda /mnt/f2fs
- mount -o remount,flush_merge /dev/vda /mnt/f2fs  -- kthread_run() fails
- dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2646575f43de..7b18e8c02f5d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -663,8 +663,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		int err = PTR_ERR(fcc->f2fs_issue_flush);
 
-		kfree(fcc);
-		SM_I(sbi)->fcc_info = NULL;
+		fcc->f2fs_issue_flush = NULL;
 		return err;
 	}
 
-- 
2.36.1

