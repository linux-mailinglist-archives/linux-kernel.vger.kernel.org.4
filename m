Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DF6F76A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjEDUJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjEDUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:09:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C81A11C;
        Thu,  4 May 2023 12:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A64216381F;
        Thu,  4 May 2023 19:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED3CC433D2;
        Thu,  4 May 2023 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229951;
        bh=xRM85o9I9fPfa7NXIPacJD8ttYODnSJqn3HCikW4rek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iInvKMxKbDxVxvCHiOQ/bAAckhABFB/MVBQKJmAACm+Xlq8qVctSe75GK40w1mB2x
         mcdx4wENN1GDsTaEfzCf8WNyKwvcBIYjDRZSYHc6xnBQDmltpmUlt9YHTpJRn72D12
         gR6RryyqN5fTIkQH2pBSVZBJT79sr/QVg0mZkx2LYgFf7AvM3f1cydjNBsPEfO8bI1
         /EcA1xJr3BehPta8nldaGVHf2KFOBOrQ6LGyJfOAGnIXUv1aKEteGQPag4KyMYNm/F
         dpbE7RrlGa9VhOv8jYYZVGO501oihMQ1UuLgz1L1brcNHJfdbr9m03dvrb7DDeW+BY
         hAnJqTIIa7PzA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/13] ext4: set goal start correctly in ext4_mb_normalize_request
Date:   Thu,  4 May 2023 15:52:01 -0400
Message-Id: <20230504195207.3809116-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195207.3809116-1-sashal@kernel.org>
References: <20230504195207.3809116-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit b07ffe6927c75d99af534d685282ea188d9f71a6 ]

We need to set ac_g_ex to notify the goal start used in
ext4_mb_find_by_goal. Set ac_g_ex instead of ac_f_ex in
ext4_mb_normalize_request.
Besides we should assure goal start is in range [first_data_block,
blocks_count) as ext4_mb_initialize_context does.

[ Added a check to make sure size is less than ar->pright; otherwise
  we could end up passing an underflowed value of ar->pright - size to
  ext4_get_group_no_and_offset(), which will trigger a BUG_ON later on.
  - TYT ]

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230303172120.3800725-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a93bd342e0ae6..60f202e63eebd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3116,6 +3116,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
 	ext4_lblk_t end;
 	loff_t size, start_off;
@@ -3296,18 +3297,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
 
 	/* define goal start in order to merge */
-	if (ar->pright && (ar->lright == (start + size))) {
+	if (ar->pright && (ar->lright == (start + size)) &&
+	    ar->pright >= size &&
+	    ar->pright - size >= le32_to_cpu(es->s_first_data_block)) {
 		/* merge to the right */
 		ext4_get_group_no_and_offset(ac->ac_sb, ar->pright - size,
-						&ac->ac_f_ex.fe_group,
-						&ac->ac_f_ex.fe_start);
+						&ac->ac_g_ex.fe_group,
+						&ac->ac_g_ex.fe_start);
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
-	if (ar->pleft && (ar->lleft + 1 == start)) {
+	if (ar->pleft && (ar->lleft + 1 == start) &&
+	    ar->pleft + 1 < ext4_blocks_count(es)) {
 		/* merge to the left */
 		ext4_get_group_no_and_offset(ac->ac_sb, ar->pleft + 1,
-						&ac->ac_f_ex.fe_group,
-						&ac->ac_f_ex.fe_start);
+						&ac->ac_g_ex.fe_group,
+						&ac->ac_g_ex.fe_start);
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
-- 
2.39.2

