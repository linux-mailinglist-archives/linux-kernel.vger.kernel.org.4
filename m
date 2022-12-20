Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208CC651FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiLTL4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiLTL4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:56:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A413E0B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83621B8120C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEEDC433EF;
        Tue, 20 Dec 2022 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671537372;
        bh=N/tS7ZErAu/Z3EKySakrgdgcw7FVnibMu9luI9kwOMI=;
        h=From:To:Cc:Subject:Date:From;
        b=o9boFgKZTJXmZjV6eSzzBN43HKxFfBzF6U4SsO//iKCgfiqu/KMbzw9hhlyf47V37
         bEE3ENco0W+dVhNuuY49eEOn4zUDak7PPtD+7kuY88lhbLvA87ySWxzrlRNubHm44l
         UmKw64Sv+GnfVBAOwwCxsWEKmYmnGbve2ALv4amKgOBEPqXbA5FxnEUT4Wl6vr0CnP
         S3EeLsCuUpijVXRLHcYpr5M23hc192SpBPYRB4zzkInsW9ocJVhVGzjo7N5YDEmNYZ
         Kt25jynNiBZvy0GBfacP6uUcPFuW86WjGqgfKeSimSvpWGz1rU3tvLAjJjyAtQ5RXW
         NGuFeKksXJaBQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: remove unused PAGE_PRIVATE_ATOMIC_WRITE
Date:   Tue, 20 Dec 2022 19:56:02 +0800
Message-Id: <20221220115602.6715-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3db1de0e582c ("f2fs: change the current atomic write way")
has removed all users of PAGE_PRIVATE_ATOMIC_WRITE, remove its
definition and related functions.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 710d6d0209c4..b39d978058cb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1401,19 +1401,17 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * Layout A: lowest bit should be 1
  * | bit0 = 1 | bit1 | bit2 | ... | bit MAX | private data .... |
  * bit 0	PAGE_PRIVATE_NOT_POINTER
- * bit 1	PAGE_PRIVATE_ATOMIC_WRITE
- * bit 2	PAGE_PRIVATE_DUMMY_WRITE
- * bit 3	PAGE_PRIVATE_ONGOING_MIGRATION
- * bit 4	PAGE_PRIVATE_INLINE_INODE
- * bit 5	PAGE_PRIVATE_REF_RESOURCE
- * bit 6-	f2fs private data
+ * bit 1	PAGE_PRIVATE_DUMMY_WRITE
+ * bit 2	PAGE_PRIVATE_ONGOING_MIGRATION
+ * bit 3	PAGE_PRIVATE_INLINE_INODE
+ * bit 4	PAGE_PRIVATE_REF_RESOURCE
+ * bit 5-	f2fs private data
  *
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
  */
 enum {
 	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
-	PAGE_PRIVATE_ATOMIC_WRITE,		/* data page from atomic write path */
 	PAGE_PRIVATE_DUMMY_WRITE,		/* data page for padding aligned IO */
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
 	PAGE_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
@@ -1458,19 +1456,16 @@ PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
 PAGE_PRIVATE_GET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
 PAGE_PRIVATE_GET_FUNC(dummy, DUMMY_WRITE);
 
 PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
 PAGE_PRIVATE_SET_FUNC(dummy, DUMMY_WRITE);
 
 PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 PAGE_PRIVATE_CLEAR_FUNC(dummy, DUMMY_WRITE);
 
 static inline unsigned long get_page_private_data(struct page *page)
-- 
2.36.1

