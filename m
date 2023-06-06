Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB60A723778
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjFFGTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjFFGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:19:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133610E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4016F61015
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C882C4331F;
        Tue,  6 Jun 2023 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686032345;
        bh=C6VkHFq2s9uK+TWCjxzRIUHXr213fU3r8aFIxm4ay+U=;
        h=From:To:Cc:Subject:Date:From;
        b=iRmSnBbpiE3CrgXLfeEeoAGIzXI2Vr1zU2SFIIibUVmjH+Cjkpb6JDLg6sD9nAjKv
         DwwHxdn8dCoFuvXxrEK/5TLodpuuW6VBotbXXJo8TgIK/loUBaCKZZY68hMja+9qgV
         9DJ2AR0LU/XVolkeq6mTEMAkYyd1iZIjoCdttco/DdbVTyuHy3V3bBsIL3if07Eis9
         i1uIbxNkevbUUpAszIf11V3P2sCrsjn2SAixelulzLLiZiBwtmYuJCTlBdC9PkKHoz
         k+qhb8/CJzWkPpCOJ2gDz5Qx7MvZpVo8s6inemrncOs5RuXbHt/WAq4wBD5Nxp+Dig
         9E6j6tP2/pt0Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: check return value of freeze_super()
Date:   Tue,  6 Jun 2023 14:19:01 +0800
Message-Id: <20230606061901.1179970-1-chao@kernel.org>
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

freeze_super() can fail, it needs to check its return value and do
error handling in f2fs_resize_fs().

Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8cbe4839f640..de893f4f60e1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2271,7 +2271,9 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	if (err)
 		return err;
 
-	freeze_super(sbi->sb);
+	err = freeze_super(sbi->sb);
+	if (err)
+		return err;
 
 	if (f2fs_readonly(sbi->sb)) {
 		thaw_super(sbi->sb);
-- 
2.40.1

