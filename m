Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A4610D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJ1Jbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJ1Jbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FA1C6BFD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BAF06271D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1059C433D6;
        Fri, 28 Oct 2022 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666949500;
        bh=on4ve1L/tc15LIA9yjdcewdPR3skPWPiVhzzpmc0SE8=;
        h=From:To:Cc:Subject:Date:From;
        b=oEm3wHfRMe+buCKOwTMPwYYVDTpBMqxXzCWLXqLSe/P2ZQe7+yQT1FiL4w2C+sx8M
         JvCPtXdaaMuOsVLRneYmHdX1EqpkO+mGUR2NXe+/qRZbg2SIiT/6XID3dHaPkhHKdh
         DaCmLXC4zANKsgldhSgjhKtTF541MRB7XI6o41+WXBzInXQJAK8vJ3z1iqgI4EqhTA
         u9RvR5mVUHZm/xrjUlOtf/IQlhx8YzL7yG3BWCrbbiWmhipp7zQr8lYMeOwU8aJsFh
         p6BsMSBPrke9gRa9TtElcAXznmHvLbq8jdTnC+j8LWbKvUNa7RRuvoHQIeIuoGvLO2
         Cw1yuykhilKsA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to destroy sbi->post_read_wq in error path of f2fs_fill_super()
Date:   Fri, 28 Oct 2022 17:30:26 +0800
Message-Id: <20221028093026.1406495-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

In error path of f2fs_fill_super(), this patch fixes to call
f2fs_destroy_post_read_wq() once if we fail in f2fs_start_ckpt_thread().

Fixes: 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount option")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..696f094c4505 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4523,9 +4523,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_destroy_node_manager(sbi);
 free_sm:
 	f2fs_destroy_segment_manager(sbi);
-	f2fs_destroy_post_read_wq(sbi);
 stop_ckpt_thread:
 	f2fs_stop_ckpt_thread(sbi);
+	f2fs_destroy_post_read_wq(sbi);
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
-- 
2.25.1

