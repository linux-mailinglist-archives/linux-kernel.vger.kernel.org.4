Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7451E60FFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiJ0SFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiJ0SEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:04:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9D160ECD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33169B8273A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B8EC433C1;
        Thu, 27 Oct 2022 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666893859;
        bh=Re061QOM1zSa4SDCeCrNjsAINlsDxks5xlguK2smzZM=;
        h=From:To:Cc:Subject:Date:From;
        b=MAnB/3Kscb3IH5sMmjEndAtFL5eaFb6jyqsw4Chj4n52vle3fXSVrnPIjuT/KFpq9
         1tDMeF7EXE6QVvQ9/Lr6c78DUwwS/pJXpYBGqxI3Ody5kr0+btddiyB8YyYSbR/4Kc
         khArmFkwnpoi8QSdZlJRm/4GhiEqBrZdX8QpkVprrCpmNn8YZ9+rcFHKSE6l96X4kT
         ITLxNn5bZfEy5DtSbwAI0t/MT5N5g979aXhAgZqPZ0MMKqAv2q3/ojimU9bKM6yu+a
         VS6+D6pYs9kSlC8hWUCBk83xfcs4I/CtH1sju0ekXEYnOhIwI+KKo3A3rbRhm8nfYJ
         /eQ9uFQik5Oig==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not stop threads in irq context
Date:   Thu, 27 Oct 2022 11:04:16 -0700
Message-Id: <20221027180416.3786792-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
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

Let's stop threads first to avoid irq context.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a241e4073f1d..14b4bb0f8ce6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3905,6 +3905,9 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	int err;
 
+	f2fs_stop_gc_thread(sbi);
+	f2fs_stop_discard_thread(sbi);
+
 	f2fs_down_write(&sbi->sb_lock);
 
 	spin_lock(&sbi->error_lock);
@@ -4014,9 +4017,6 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	 */
 	smp_wmb();
 	sb->s_flags |= SB_RDONLY;
-
-	f2fs_stop_gc_thread(sbi);
-	f2fs_stop_discard_thread(sbi);
 }
 
 static void flush_error_work(struct work_struct *work)
-- 
2.38.1.273.g43a17bfeac-goog

