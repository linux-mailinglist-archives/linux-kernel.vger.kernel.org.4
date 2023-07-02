Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B074507E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGBTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjGBTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C249D10C2;
        Sun,  2 Jul 2023 12:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0864060C7F;
        Sun,  2 Jul 2023 19:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62223C433C8;
        Sun,  2 Jul 2023 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326709;
        bh=fLk1vZb5UsLOtZdH8fzi8Dl5drZopIqCQ/HIXGNMBhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DniXM4liH5EyCwh8+QGfFxPncH9d1alwNLsWqPdXBz082LCLsvgx+AGr1pz9iPr2d
         Xj/vwCbNwS7vQyORqy28GF4rxwoZCbzw19v3NRwGAuLHZ3rZ7avq6GyYAThdCuI3jV
         xTZ63qs9phVTqfSc5YIFqz5VZ6h10hV4BUPkJ/HNlMSm35hi5qilqllHiWqsE5te4M
         XnwVA3IGFeCYC/2RG1Va5Lz6ZUpIkrSGiXRg+c5Y5sL/mQIZMEYi00U5WNrXLgD/J0
         2z9fwMV88avI0IRAQgLxEd221tbfS/ANQDRtka6p4LIHOt5Cic6VV+caC1qUod/Zj0
         ctJdDODTcb7Vg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net,
        Jeff Xu <jeffxu@chromium.org>, Sasha Levin <sashal@kernel.org>,
        mirimmad17@gmail.com, linux@treblig.org
Subject: [PATCH AUTOSEL 6.4 06/16] jfs: Use unsigned variable for length calculations
Date:   Sun,  2 Jul 2023 15:38:05 -0400
Message-Id: <20230702193815.1775684-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 820eb59da8c7ca7e705a02f37dda2be316807847 ]

To avoid confusing the compiler about possible negative sizes, switch
"ssize" which can never be negative from int to u32.  Seen with GCC 13:

../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
[-Warray-bounds=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
...
../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
  950 |                 memcpy(ip->i_link, name, ssize);
      |                 ^~~~~~

Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: jfs-discussion@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Jeff Xu <jeffxu@chromium.org>
Message-Id: <20230204183355.never.877-kees@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index b29d68b5eec53..494b9f4043cf6 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 	tid_t tid;
 	ino_t ino = 0;
 	struct component_name dname;
-	int ssize;		/* source pathname size */
+	u32 ssize;		/* source pathname size */
 	struct btstack btstack;
 	struct inode *ip = d_inode(dentry);
 	s64 xlen = 0;
@@ -957,7 +957,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 		if (ssize > sizeof (JFS_IP(ip)->i_inline))
 			JFS_IP(ip)->mode2 &= ~INLINEEA;
 
-		jfs_info("jfs_symlink: fast symlink added  ssize:%d name:%s ",
+		jfs_info("jfs_symlink: fast symlink added  ssize:%u name:%s ",
 			 ssize, name);
 	}
 	/*
@@ -987,7 +987,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 		ip->i_size = ssize - 1;
 		while (ssize) {
 			/* This is kind of silly since PATH_MAX == 4K */
-			int copy_size = min(ssize, PSIZE);
+			u32 copy_size = min_t(u32, ssize, PSIZE);
 
 			mp = get_metapage(ip, xaddr, PSIZE, 1);
 
-- 
2.39.2

