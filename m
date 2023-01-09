Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24045661CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjAIDr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjAIDru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:47:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A6247
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D58B80C7B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609E8C433D2;
        Mon,  9 Jan 2023 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673236066;
        bh=bVMllKVymzErfe1oVh1phFGGebLRoiDWdp3ZzO703Ts=;
        h=From:To:Cc:Subject:Date:From;
        b=J+WioKvUkcckgC2UD76uzWAjNEy9n/kAIXOBWoCOd3NS2G7/WWequuKcAo5Dqo7K/
         Opy/2V8Ajrn9dM1Jg22faM2CaHAY0UaIWKOQR8wn38wuuYoQnDmL6qieaXgPNPSgJi
         /tSxlZ1n/u9FdPSK/VUxwD4SFYk7SDXvbxSyF9Oc1MiiY3MoEpkMpGsTPgrL1uko2B
         FLi0fQ1nQDTgAo9RpyCokD/jt8TrWH+qhmAouTJZli0fTMgsj2yuMXxMCDlXUeA0KD
         3+NYa4NkrKd8nJM9PJxUTpndWjXOw6Gnl+X9So6Ruh7KAEjZIHvS9WCZkfbn8YTp61
         DGk53B1hbGBaA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: remove unneeded f2fs_cp_error() in f2fs_create_whiteout()
Date:   Mon,  9 Jan 2023 11:47:34 +0800
Message-Id: <20230109034734.491518-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

f2fs_rename() has checked CP_ERROR_FLAG, so remove redundant check
in f2fs_create_whiteout().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6032589099ce..82923273f4bb 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -926,9 +926,6 @@ static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
 				struct inode *dir, struct inode **whiteout)
 {
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
-		return -EIO;
-
 	return __f2fs_tmpfile(mnt_userns, dir, NULL,
 				S_IFCHR | WHITEOUT_MODE, true, whiteout);
 }
-- 
2.25.1

