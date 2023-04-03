Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3086D4E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjDCQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjDCQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A75E4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F85F61961
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E816AC433EF;
        Mon,  3 Apr 2023 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540641;
        bh=0ob/hFAIfCGbkHjr+Z2bHwcAANgfDHKR2sqmW+DCfRo=;
        h=From:To:Cc:Subject:Date:From;
        b=nGV7GIESm8duFk1qFhH2HHFziJEwQBrM6CVfBvifvGUxrnFb8s2XDLN40E3yzEh4M
         Eo/B+QGGHGtOgYPLtnoj3Dfj3vLccX8L9dRW9VbjVbxkQ1c7FXNBUislHZjJH/EvQG
         80Wpcw6SdzvNyEEU2QThKuSDz6aEhDN8AL9VsWZEmFQ66Wg00JvasgoY4Os4tyaURt
         VYYU7NqPORiFY8NanHsnmniCQC2uTRkYt5K7nX813Vaqrr8rXjUdFrUDPM7RWPz4vD
         WUzO3UNylaDjd8JNv4KKcsulrcB/xppBGpLuTbBqc0B3CV2c8NJ3z3RyVJSOCyll0K
         rPx3WIrIYayfQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
Date:   Mon,  3 Apr 2023 09:50:38 -0700
Message-Id: <20230403165038.3018949-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
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

We got a kernel panic if old_addr is NULL.

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

