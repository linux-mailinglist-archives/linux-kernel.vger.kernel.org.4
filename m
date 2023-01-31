Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473BD682F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjAaOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjAaOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82545F45
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:47:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC72E61548
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B84C433EF;
        Tue, 31 Jan 2023 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176428;
        bh=qLSS2GASRL8RKpxdXDWhe4iVsIVVZ3UeUtKqaOGvO0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOYe00Am1ogdvGACUfNzfDLl7Vazf31h+dx1uwjgSsY8+82XiJJxXzz7kypcFN5Il
         O4Z50WMV/rsQiKRF34E/fOJrKodWsjm5nDkK6FPpPj179zCkmIlKLtxx2AzCPMyofr
         xrF4s9nNeBgpV/5KybxZtsBmauh8rUsKE2+UtkOVASTOPI4+tE5Hgn+eeXn0YUZmY5
         Bc1pRXjwsQ6LtyEfQ36lRVkZNrrx4PWRzLlnoNISmky/bNgms8GZy910hAe7HGcg13
         85A3idfKezrp19KjRnupUbkL7+XmNzu0pdFa3pI2B+QISFgD768PCWJ5YHvoJ3XxbR
         vh0tZ4DiwIT1A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: fix to update age extent correctly during truncation
Date:   Tue, 31 Jan 2023 22:47:00 +0800
Message-Id: <20230131144701.34418-2-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230131144701.34418-1-chao@kernel.org>
References: <20230131144701.34418-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_free may be less than len, we should update age extent cache
w/ range [fofs, len] rather than [fofs, nr_free].

Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f4de96a3744b..746ffcd09b6c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -617,7 +617,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page),
 							dn->inode) + ofs;
 		f2fs_update_read_extent_cache_range(dn, fofs, 0, len);
-		f2fs_update_age_extent_cache_range(dn, fofs, nr_free);
+		f2fs_update_age_extent_cache_range(dn, fofs, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
 	}
 	dn->ofs_in_node = ofs;
-- 
2.36.1

