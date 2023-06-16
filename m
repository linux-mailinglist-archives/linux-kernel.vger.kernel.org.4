Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72322732E36
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbjFPKaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjFPK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718F35A2;
        Fri, 16 Jun 2023 03:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17E9D6349F;
        Fri, 16 Jun 2023 10:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DBCC433C9;
        Fri, 16 Jun 2023 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911211;
        bh=rSEb/w50RTkiFKiOzkPGyvLE6/1Q7fd6nKAAIBZYvxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvFdsjU/qTqufKhRD/XOPl5aDFUzuH8feJTbj2TpbOsBP1W8WDpnpJDpKypn2DrHk
         gOA/NYiujDndC6t9jRRZ6rVRfSeGdcod+EgSq/DZQJTBLnDGGKWGUHWgGphpqGNI0a
         hpJrnNhSlJWPTvmkxJ1z7dZLDITvLpiPJY/J4dC8mlXjycb6fKHir1U9oQaKtvBO6x
         0nLKUZR5LJ04eby2Ztk0LouTOs5M49OvNREH4YTekvHUfn0eEFf169EqO5QU9KrCOB
         xeYKTXE/yFQHT5aZp6QH+cQy2rMT4THgMHtftlcq1lOaUxbFh1H0UK9/JYkafiHe4Y
         qlEY01zA4HgBA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>, rpeterso@redhat.com,
        cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 6.1 13/26] gfs2: Don't get stuck writing page onto itself under direct I/O
Date:   Fri, 16 Jun 2023 06:26:10 -0400
Message-Id: <20230616102625.673454-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit fa58cc888d67e640e354d8b3ceef877ea167b0cf ]

When a direct I/O write is performed, iomap_dio_rw() invalidates the
part of the page cache which the write is going to before carrying out
the write.  In the odd case, the direct I/O write will be reading from
the same page it is writing to.  gfs2 carries out writes with page
faults disabled, so it should have been obvious that this page
invalidation can cause iomap_dio_rw() to never make any progress.
Currently, gfs2 will end up in an endless retry loop in
gfs2_file_direct_write() instead, though.

Break this endless loop by limiting the number of retries and falling
back to buffered I/O after that.

Also simplify should_fault_in_pages() sightly and add a comment to make
the above case easier to understand.

Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/file.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 60c6fb91fb589..bc6cd5f4b1077 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -783,9 +783,13 @@ static inline bool should_fault_in_pages(struct iov_iter *i,
 	if (!user_backed_iter(i))
 		return false;
 
+	/*
+	 * Try to fault in multiple pages initially.  When that doesn't result
+	 * in any progress, fall back to a single page.
+	 */
 	size = PAGE_SIZE;
 	offs = offset_in_page(iocb->ki_pos);
-	if (*prev_count != count || !*window_size) {
+	if (*prev_count != count) {
 		size_t nr_dirtied;
 
 		nr_dirtied = max(current->nr_dirtied_pause -
@@ -869,6 +873,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	size_t prev_count = 0, window_size = 0;
 	size_t written = 0;
+	bool enough_retries;
 	ssize_t ret;
 
 	/*
@@ -912,11 +917,17 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (ret > 0)
 		written = ret;
 
+	enough_retries = prev_count == iov_iter_count(from) &&
+			 window_size <= PAGE_SIZE;
 	if (should_fault_in_pages(from, iocb, &prev_count, &window_size)) {
 		gfs2_glock_dq(gh);
 		window_size -= fault_in_iov_iter_readable(from, window_size);
-		if (window_size)
-			goto retry;
+		if (window_size) {
+			if (!enough_retries)
+				goto retry;
+			/* fall back to buffered I/O */
+			ret = 0;
+		}
 	}
 out_unlock:
 	if (gfs2_holder_queued(gh))
-- 
2.39.2

