Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAF71155D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbjEYSp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbjEYSnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E151268D;
        Thu, 25 May 2023 11:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4FE64919;
        Thu, 25 May 2023 18:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06264C433A0;
        Thu, 25 May 2023 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039932;
        bh=P12QkZF3C6C16RHWjPfDDVPk4kIX+N03V18889yx9TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zj4LlkS/PLmvTGZuf86WS9Ye+JKPRv0qAtUzF9RsPzbtyKrvHXxLjbwf0NC2/LUoX
         4dzeDtg1hNUIL7XjJvYS0yoOMvqNK8LQ6xXfJenLE7u5KuLX0D9uh5vQvGATo/1iN8
         +v0v8QPSq2UVIWa7HDa5QZn8EAU9qcuiy7qZREh1VqFrc+kFXx8wIfvB8vziyuxr1N
         bAMCkmbL3iS9TDzQyrdemTOUVYIuJz7OD3RrYUJv+HkNdVOeG56R75WLcC4jxwjaRr
         1Ys8uHgLwYQy5AAAFRHjstOiEYCWLwilcwZsdIfjb1Na3spRYdu29/AWlmShtOT0ZO
         j7A+BxhALE+gg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 57/57] block: Deny writable memory mapping if block is read-only
Date:   Thu, 25 May 2023 14:36:07 -0400
Message-Id: <20230525183607.1793983-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 69baa3a623fd2e58624f24f2f23d46f87b817c93 ]

User should not be able to write block device if it is read-only at
block level (e.g force_ro attribute). This is ensured in the regular
fops write operation (blkdev_write_iter) but not when writing via
user mapping (mmap), allowing user to actually write a read-only
block device via a PROT_WRITE mapping.

Example: This can lead to integrity issue of eMMC boot partition
(e.g mmcblk0boot0) which is read-only by default.

To fix this issue, simply deny shared writable mapping if the block
is readonly.

Note: Block remains writable if switch to read-only is performed
after the initial mapping, but this is expected behavior according
to commit a32e236eb93e ("Partially revert "block: fail op_is_write()
requests to read-only partitions"")'.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230510074223.991297-1-loic.poulain@linaro.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/fops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index e406aa605327e..6197d1c41652d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -685,6 +685,16 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	return error;
 }
 
+static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *bd_inode = bdev_file_inode(file);
+
+	if (bdev_read_only(I_BDEV(bd_inode)))
+		return generic_file_readonly_mmap(file, vma);
+
+	return generic_file_mmap(file, vma);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_close,
@@ -692,7 +702,7 @@ const struct file_operations def_blk_fops = {
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
 	.iopoll		= iocb_bio_iopoll,
-	.mmap		= generic_file_mmap,
+	.mmap		= blkdev_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= blkdev_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.39.2

