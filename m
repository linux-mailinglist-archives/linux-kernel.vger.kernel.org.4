Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5340666DB90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjAQKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjAQKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:52:51 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2573303F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:52:48 -0800 (PST)
Received: from fedcomp.intra.ispras.ru (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 31B2244C101E;
        Tue, 17 Jan 2023 10:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 31B2244C101E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1673952767;
        bh=dGy1xNl2G2/14BqmxD3Z5TPjwoKzMoc8HvevkbhoXhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoptNKAXc39Pxz4Y3honDfHZmBXpt0/OBWUWHMT+Z6lV+0VPkWdiv4LKFA6bLs3ew
         Dlq8tu42kMMs+wFekzAoUXq5Fdi3BS0EZ+enHRF4rOa0np4PcoUZpNT0hQy9LxzkKA
         /m06bW5QjT8JuIP+aQqHw+IuX28oI0dsjbdWi8wQ=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com
Subject: [PATCH 1/1] squashfs: harden sanity check in squashfs_read_xattr_id_table
Date:   Tue, 17 Jan 2023 13:52:26 +0300
Message-Id: <20230117105226.329303-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117105226.329303-1-pchelkin@ispras.ru>
References: <20230117105226.329303-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While mounting a corrupted filesystem, a signed integer '*xattr_ids' can
become less than zero. This leads to the incorrect computation of 'len'
and 'indexes' values which can cause null-ptr-deref in copy_bio_to_actor()
or out-of-bounds accesses in the next sanity checks inside
squashfs_read_xattr_id_table().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 506220d2ba21 ("squashfs: add more sanity checks in xattr id lookup")
Reported-by: syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 fs/squashfs/xattr_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index 087cab8c78f4..f6d78cbc3e74 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -76,7 +76,7 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 	/* Sanity check values */
 
 	/* there is always at least one xattr id */
-	if (*xattr_ids == 0)
+	if (*xattr_ids <= 0)
 		return ERR_PTR(-EINVAL);
 
 	len = SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids);
-- 
2.34.1

