Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6060E623
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiJZRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiJZRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874452E4B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D924661FE6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BD7C433C1;
        Wed, 26 Oct 2022 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666803970;
        bh=YZ9Ddar4PAfk9R3rj0CvKnajhWqM9BJYuumKNjXPKZs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=AtTvO1XFSdu9F3VoDHNMw0JKNgkRurqsJ6Z+lfYSaPeKZIofuj9fYBHV9jEcW/+ud
         RPhez5AOe2fILRmbAYwWmE38KCMqXKK9zl77DYTW66X/6IAuDnGIQOoK20vFv99m7Q
         7y00cEQqrXafhAPHkAW5bwblPQmiCKrl9pcZAf4w1FQgLbtELvzAQW6+HjEsSf2Ggf
         7jxkt8ITQMWGSCMXQMWNnfabh2kJvNp9Ji4CbciKYBmjqUrPHYp4fPZJ2YyTp7AqCb
         8X55mY/ZcZZYxm2zGbF2gpMoVE6brEZEdtUpY73/OK5lDt2hWGZhS4jTRUV4o0TbTI
         8mQEbJJX0/Q8w==
Date:   Wed, 26 Oct 2022 10:06:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: allow to set compression for inlined file
Message-ID: <Y1lpAJiPCMSXf1d5@google.com>
References: <20221024233634.803695-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024233634.803695-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below commit disallows to set compression on empty created file which
has a inline_data. Let's fix it.

Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
  Change log from v1:
   - add returning an error

 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1c4004c9245f..8cd52b0965b1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1915,6 +1915,10 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			if (!f2fs_disable_compressed_file(inode))
 				return -EINVAL;
 		} else {
+			/* try to convert inline_data to support compression */
+			int err = f2fs_convert_inline_inode(inode);
+			if (err)
+				return err;
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
-- 
2.38.0.135.g90850a2211-goog

