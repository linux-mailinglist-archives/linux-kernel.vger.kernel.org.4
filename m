Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B766DC2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjDJCV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJCV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A853E1FC4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B6A60DD0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A9FC433EF;
        Mon, 10 Apr 2023 02:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681093312;
        bh=4T3lyXoA1FoV6P5GhQMMg5O/djdkaXone30k5xsKe0I=;
        h=From:To:Cc:Subject:Date:From;
        b=L0SmKFIOvAmAlaiZ9aKuw5CvWEbwZ52C609Zv78+Db0t3wcmTt04cSrEvcPvqhA7a
         DDIOD+pIFtg6+vUGFSNwH8miY3ZRKv+iaBx0egZQqhgxhU9x/ZicBy7s1MA9lK8fmo
         JI14+MNgTvtHQCO18hRY9dE3mCbaC9PU5z9mmssPiy4SZjoBBxcbWhoFWGJ2whSFd1
         gLYBFu5DRcmSv0+lafLVV3wkMnIoe4yCWnH/7Xh1IBYwHIVKG2dbTdRC4dVocndID1
         1eJZURI6+rNPIroziFLImK1jt5OoSi9PTCHzjTghlSGafeTMeW0iT0zws5Cr1QZRY/
         nF3nUV32e/k5Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: remove unneeded set_page_private() in f2fs_delete_entry()
Date:   Mon, 10 Apr 2023 10:21:45 +0800
Message-Id: <20230410022145.1840993-1-chao@kernel.org>
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

As detach_page_private() should have reset page's private field.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d6dd8327e82d..d5c7c8e55eb4 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -912,7 +912,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		f2fs_remove_dirty_inode(dir);
 
 		detach_page_private(page);
-		set_page_private(page, 0);
 	}
 	f2fs_put_page(page, 1);
 
-- 
2.25.1

