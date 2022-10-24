Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005B60C03B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJYAyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiJYAxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176A104504
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28A061632
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ACBC433B5;
        Mon, 24 Oct 2022 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666654596;
        bh=N+eoJ9Y4rEs3YSsl7usF2YxvUJ1yMmWw/73dM3wnX7g=;
        h=From:To:Cc:Subject:Date:From;
        b=QzcPBFUwqZHTnmwC4YE/ioV4IVP6l7urzv0ljg/nLA6j3ZgQE1YZyoqYoNfeHUPl6
         fk/aL5Pk09G+Pn6LOKQjq3LdKHYpymqTgU3jMTa1u6lXRD+U4FYH5nAdYAmOEml+UP
         UDcF0QEegpoEW+aoLdETjZsn0zfcNqI8ITdf6Ju4OplJSmrdXOHt3Q8iPHQIk7ayq8
         QxunYY73J1hnQXgmeFH1sFl6bTvGwuG1kYWk+Y0rK4FGr47O0L6Y8WUbUMfW7vP6gn
         Lc+heoSQJJCyveIVo77+zdxx6aU+rojIVzzi/L7xMcAcOTUoSgI2dxqqhlkZCCTian
         nC9R+i0jPNqSw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow to set compression for inlined file
Date:   Mon, 24 Oct 2022 16:36:34 -0700
Message-Id: <20221024233634.803695-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1c4004c9245f..304fe08edc61 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1915,6 +1915,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			if (!f2fs_disable_compressed_file(inode))
 				return -EINVAL;
 		} else {
+			/* try to convert inline_data to support compression */
+			f2fs_convert_inline_inode(inode);
+
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
-- 
2.38.0.135.g90850a2211-goog

