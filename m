Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B18707CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjERJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjERJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3030A26B6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B201064DC4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0437C4339C;
        Thu, 18 May 2023 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684402183;
        bh=ovRBMbfJ+0e2fp3fL3pzSwAhC4xZCypG0p8+sBPPWG4=;
        h=From:To:Cc:Subject:Date:From;
        b=dK4qFyZA0dN8yAUQzL0S7ZuaDDKgCMkUCp6ChHtGI8CYUiXzM5K7iCKLWZ8xYLxLT
         bld7GfUibB0TpXwUu15G9AN6FShQKFDpCuyRFSH9EaEQRBuc4h/qGDwuI63K7rOaPH
         oK7hByarOUsIsUtr5fo45qAzwAbEJKIJIDSAjyn9yu4/eECkOxOcq6OAqGZAKrBp3F
         Ub4UDY9jICBvxWPGvuNAJ37SvuoGrGmWWH+Eg1c7q7bPSs7qqrpdmZj3WEGbIgQ1Uz
         FDP9QLUjlRwYqFCv5pVv5HImXJOxi8E7QczE6vehmh67uQyaxgbfiPJv+Yu/ItG74E
         Tg9ESaJozjm0w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to use le32_to_cpu() in RAW_IS_INODE()
Date:   Thu, 18 May 2023 17:29:31 +0800
Message-Id: <20230518092931.2280835-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__le32 type variable should be converted w/ le32_to_cpu() before access.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7f6c51a6b930..a4bff3b5b887 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2840,7 +2840,11 @@ static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 		cond_resched();
 }
 
-#define RAW_IS_INODE(p)	((p)->footer.nid == (p)->footer.ino)
+static inline bool RAW_IS_INODE(struct f2fs_node *node)
+{
+	return le32_to_cpu(node->footer.ino) ==
+			le32_to_cpu(node->footer.nid);
+}
 
 static inline bool IS_INODE(struct page *page)
 {
-- 
2.40.1

