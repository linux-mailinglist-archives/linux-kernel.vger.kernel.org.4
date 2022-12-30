Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B60659A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiL3Pns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiL3Pnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:43:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B71B9F1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 968E5B81CC2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47014C433D2;
        Fri, 30 Dec 2022 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672415019;
        bh=MApoGiLoefSH4r+JR0/qNkucbn2OhIB8DVcH1zXvi+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=dphRm1ggz5v5Qt0dr9xZHKVqpoJYqh+TqKT0mwChf9iJ0DXpweo8sWg6BglnJC6UG
         WWx/5ujniUx/QKMwjspaDHwCG3nd0P3RGZzNYG1W5vz8zI36ncnLPRIXcpUPtigKr/
         CO43Bi/z41So2x/cU5Kd/dbcy3Rprh/oUzvEmmwxfY9VglK6Q6Swa75R/O28/gZs4L
         jASNVmrE4/tpLv4hsiV04XJZhqxK/FngemZnGvLgo9jReq34kcej0OftJ3/7WgxAE2
         byqABOKT/GhBA3BmdFzQpk5JbY+07d9I+C1zd7fJ9Yo89i8KLCz1K0OJr72wXK9LpH
         yeUCiuANGj0xg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()
Date:   Fri, 30 Dec 2022 23:43:32 +0800
Message-Id: <20221230154332.5082-1-chao@kernel.org>
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

With below two cases, it will cause NULL pointer dereference when
accessing SM_I(sbi)->fcc_info in f2fs_issue_flush().

a) If kthread_run() fails in f2fs_create_flush_cmd_control(), it will
release SM_I(sbi)->fcc_info,

- mount -o noflush_merge /dev/vda /mnt/f2fs
- mount -o remount,flush_merge /dev/vda /mnt/f2fs  -- kthread_run() fails
- dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync

b) we will never allocate memory for SM_I(sbi)->fcc_info w/ below
testcase,

- mount -o ro /dev/vda /mnt/f2fs
- mount -o rw,remount /dev/vda /mnt/f2fs
- dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync

In order to fix this issue, let change as below:
- fix error path handling in f2fs_create_flush_cmd_control().
- allocate SM_I(sbi)->fcc_info even if readonly is on.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2646575f43de..16f60c646cc2 100644
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
 
@@ -5137,11 +5136,9 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
 
 	init_f2fs_rwsem(&sm_info->curseg_lock);
 
-	if (!f2fs_readonly(sbi->sb)) {
-		err = f2fs_create_flush_cmd_control(sbi);
-		if (err)
-			return err;
-	}
+	err = f2fs_create_flush_cmd_control(sbi);
+	if (err)
+		return err;
 
 	err = create_discard_cmd_control(sbi);
 	if (err)
-- 
2.36.1

