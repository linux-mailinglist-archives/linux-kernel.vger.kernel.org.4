Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA86DC28F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDJCLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJCLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2992D58
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C6761720
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D6DC433EF;
        Mon, 10 Apr 2023 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681092709;
        bh=FCFxu4X+5woHhI20a2ADjfDUIjQHOiUKAW2OcY/taSU=;
        h=From:To:Cc:Subject:Date:From;
        b=GVo5eO0r5KNTpseagjx5UOIXexQSj7cY1aYA70unARObaF3Vy2Gg5RHgGBS7M8ykA
         ZkN7zgxHJo6XXjKz/WM67RpcFqVoXxuZ2GMVr8db0ktArAsCdmCsWcBi0kJ194aker
         qQMdTFlXNlzefSChOx47n0bOIsIm12vlB5VNyVKfrpPknMC6tHkDsFaP06rrTTsqQA
         3odseNBjD2flrUMYpaC5p0JWfPgQnE+aN7DovQjCjP8HLQL3yKy0t4i5s4A526G81k
         y++VA4kZ0VSgQB2Gx2SQWyCaZHLcXERiXWu9PjrDVfHLQD7pH4U+l/hYNj8+wxVVkT
         NSTFx2YqgLiCA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to keep consistent i_gc_rwsem lock order
Date:   Mon, 10 Apr 2023 10:11:40 +0800
Message-Id: <20230410021140.1825781-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i_gc_rwsem[WRITE] and i_gc_rwsem[READ] lock order is reversed
in gc_data_segment() and f2fs_dio_write_iter(), fix to keep
consistent lock order as below:
1. lock i_gc_rwsem[WRITE]
2. lock i_gc_rwsem[READ]

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6dc2bc710ba8..91841b0057ba 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1616,14 +1616,14 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			int err;
 
 			if (S_ISREG(inode->i_mode)) {
-				if (!f2fs_down_write_trylock(&fi->i_gc_rwsem[READ])) {
+				if (!f2fs_down_write_trylock(&fi->i_gc_rwsem[WRITE])) {
 					sbi->skipped_gc_rwsem++;
 					continue;
 				}
 				if (!f2fs_down_write_trylock(
-						&fi->i_gc_rwsem[WRITE])) {
+						&fi->i_gc_rwsem[READ])) {
 					sbi->skipped_gc_rwsem++;
-					f2fs_up_write(&fi->i_gc_rwsem[READ]);
+					f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 					continue;
 				}
 				locked = true;
@@ -1646,8 +1646,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				submitted++;
 
 			if (locked) {
-				f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 				f2fs_up_write(&fi->i_gc_rwsem[READ]);
+				f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			}
 
 			stat_inc_data_blk_count(sbi, 1, gc_type);
-- 
2.25.1

