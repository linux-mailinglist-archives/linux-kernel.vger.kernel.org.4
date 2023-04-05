Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561B6D8390
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjDEQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDEQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F1729F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A3363F67
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E2FC433D2;
        Wed,  5 Apr 2023 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711709;
        bh=ef2YepiMAXx8RjWeBXAJGEINglAm0SF9NGq0mwWfm9g=;
        h=From:To:Cc:Subject:Date:From;
        b=uNFm0cqZXj4E38P6Z6QbhfvfCrMxn81ukq7npYUC2ISHSLJaPu1SBDaOkNpCGD2fM
         nS8V17kZby73sy1Z1c2mv4hUW+l9QYX/GPKrDf2zoxhS1/Sx0ZajzFnM0JKV7rFeUc
         fsT6+BM58vkDaphGnCwbHvhADHpiBp6uwKtAZbT4wY9mHszCRTISnO4omatC+u/Uyz
         IyNTNgMThi2aEhVXHbO2CI1G/dRiUQJgDrsew3O9WN0o/yd8+EfgB4x4mtMqVEVuqp
         EGFc0ZnJdcHvJlY88A146ybIBF3n/GpwAvu5a79hLdZM1+AQAFpTrL+i/hosFJHeap
         RcjWLPnibw2UA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix to check return value of f2fs_do_truncate_blocks()
Date:   Wed,  5 Apr 2023 22:44:53 +0800
Message-Id: <20230405144453.930311-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, if truncation on cow_inode failed, remained data may
pollute current transaction of atomic write.

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 10743e864d57..39c41c7e834b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2113,7 +2113,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	} else {
 		/* Reuse the already created COW inode */
-		f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		if (ret) {
+			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			goto out;
+		}
 	}
 
 	f2fs_write_inode(inode, NULL);
-- 
2.36.1

