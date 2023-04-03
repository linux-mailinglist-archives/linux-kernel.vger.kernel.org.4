Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4B6D4E70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDCQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjDCQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE20EC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49DC261ADA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D92C4339B;
        Mon,  3 Apr 2023 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540876;
        bh=VVcpYsvPB42S9bhD5icaj68wnU6tD0Ujr7cjnyc0m6s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RG56pQe+yzCCW/MbuTaBH80yWs+g5IqypJRlftuPykhevhqMbHz06yUXWtkaVyrb2
         TZVlzvoM/vIoHE4LvoCDDPeODqIn8Kl76Hupl0OUFfjlu3WqYytSJ9g+u+6NS0c11N
         4cGjTDZDbsEfIHM9GWf7h9mJFqsNdoCA6Qq+M9I1HrP9cBUarQKHs29ZMlvE/11IxJ
         mHtfs03+wg+qXIGSJTIklyXZLF1suAw4fCGKRB3D4XQgpsYl5S+O+Ck0PO0LmeU+d3
         RX6tnOB0BrWlptz2N4clpCzRpWGBBdsYWvuEaUyaWmDgstY2bOt09agjXpxSBKdjaS
         0PbYkrFVcPXnw==
Date:   Mon, 3 Apr 2023 09:54:34 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: fix null pointer panic in tracepoint in
 __replace_atomic_write_block
Message-ID: <ZCsEytDjqEjQDPiO@google.com>
References: <20230403165038.3018949-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403165038.3018949-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We got a kernel panic if old_addr is NULL.

https://bugzilla.kernel.org/show_bug.cgi?id=217266

BUG: kernel NULL pointer dereference, address: 0000000000000000
 Call Trace:
  <TASK>
  f2fs_commit_atomic_write+0x619/0x990 [f2fs a1b985b80f5babd6f3ea778384908880812bfa43]
  __f2fs_ioctl+0xd8e/0x4080 [f2fs a1b985b80f5babd6f3ea778384908880812bfa43]
  ? vfs_write+0x2ae/0x3f0
  ? vfs_write+0x2ae/0x3f0
  __x64_sys_ioctl+0x91/0xd0
  do_syscall_64+0x5c/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f69095fe53f

Fixes: 2f3a9ae990a7 ("f2fs: introduce trace_f2fs_replace_atomic_write_block")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 72bce3808394..2439d7029e64 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -257,7 +257,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	f2fs_put_dnode(&dn);
 
 	trace_f2fs_replace_atomic_write_block(inode, F2FS_I(inode)->cow_inode,
-					index, *old_addr, new_addr, recover);
+			index, old_addr ? *old_addr : 0, new_addr, recover);
 	return 0;
 }
 
-- 
2.40.0.348.gf938b09366-goog

