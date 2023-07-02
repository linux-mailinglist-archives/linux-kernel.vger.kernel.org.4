Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0C745076
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGBTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGBTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FD7D9;
        Sun,  2 Jul 2023 12:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A57760C7A;
        Sun,  2 Jul 2023 19:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D806BC433CA;
        Sun,  2 Jul 2023 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326702;
        bh=0Gc8JN2bcaLif+Exbg4sFXgL2Sb5gM6PzQoioJyn+NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFOFyjJ0qzFwjLFbOFDU+qwzkbuBfJhXVXYqiaWEbm/kq6PJV1w2qqDXA4on6MPPL
         equbZ0u+Yasad785HLGyL+F3c+lYOlWr47x3dnzJmZGkDuLSGcr4Nji5E/AS37DP5L
         y3ge9Vx6ubDZTcZNfgmAZDctPJs3mjffWQzEo4LJN+s3+y7L6l5tcnwZ68QXgH4tRy
         IuT10FF/TorLZPZRfBbGTj+LK4prIMWcq4gurrhiJuWI3dGRsuBuI+oTZpGsojaG6U
         +MOmRqHMKbHUsIfpkXvb3YSI9Dx8cofZNdm+ZIc1KmOGYWU5SXTckKXOfSJvor76YN
         L++OVp6VjyCkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, anton@tuxera.com,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.4 04/16] ntfs: do not dereference a null ctx on error
Date:   Sun,  2 Jul 2023 15:38:03 -0400
Message-Id: <20230702193815.1775684-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: Danila Chernetsov <listdansp@mail.ru>

[ Upstream commit aa4b92c5234878d55da96d387ea4d3695ca5e4ab ]

In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
'ctx' pointer in error handling.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs/mft.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 48030899dc6ec..0155f106ec344 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1955,36 +1955,38 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 				"attribute.%s", es);
 		NVolSetErrors(vol);
 	}
-	a = ctx->attr;
+
 	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
 		ntfs_error(vol->sb, "Failed to truncate mft data attribute "
 				"runlist.%s", es);
 		NVolSetErrors(vol);
 	}
-	if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
-		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+	if (ctx) {
+		a = ctx->attr;
+		if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
+			if (ntfs_mapping_pairs_build(vol, (u8 *)a + le16_to_cpu(
 				a->data.non_resident.mapping_pairs_offset),
 				old_alen - le16_to_cpu(
-				a->data.non_resident.mapping_pairs_offset),
+					a->data.non_resident.mapping_pairs_offset),
 				rl2, ll, -1, NULL)) {
-			ntfs_error(vol->sb, "Failed to restore mapping pairs "
+				ntfs_error(vol->sb, "Failed to restore mapping pairs "
 					"array.%s", es);
-			NVolSetErrors(vol);
-		}
-		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
-			ntfs_error(vol->sb, "Failed to restore attribute "
+				NVolSetErrors(vol);
+			}
+			if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
+				ntfs_error(vol->sb, "Failed to restore attribute "
 					"record.%s", es);
+				NVolSetErrors(vol);
+			}
+			flush_dcache_mft_record_page(ctx->ntfs_ino);
+			mark_mft_record_dirty(ctx->ntfs_ino);
+		} else if (IS_ERR(ctx->mrec)) {
+			ntfs_error(vol->sb, "Failed to restore attribute search "
+				"context.%s", es);
 			NVolSetErrors(vol);
 		}
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-	} else if (IS_ERR(ctx->mrec)) {
-		ntfs_error(vol->sb, "Failed to restore attribute search "
-				"context.%s", es);
-		NVolSetErrors(vol);
-	}
-	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
+	}
 	if (!IS_ERR(mrec))
 		unmap_mft_record(mft_ni);
 	up_write(&mft_ni->runlist.lock);
-- 
2.39.2

