Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1044B6530A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLUMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLUMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:14:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369F22BE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:14:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E941B81983
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2728FC433EF;
        Wed, 21 Dec 2022 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671624890;
        bh=xHeuYny/QiUYypo1l91/ZWGhfaqY5OXoUHg7oqTSwt0=;
        h=From:To:Cc:Subject:Date:From;
        b=b4BuqnZ9f7fXig9gfWkhZ4r0fC9Ka2RlZeZ3EGonvK9v4dpNo9GV3lUW9gMs5TXer
         IbPy63WfMasS8plSOoMQzjojtWoVk/xJWZuz1kz2R93h6aKeriu2OGg4giUG+4jYg9
         HZ1hS4fWwbSUFEr3oH5QotXa3PUW9usoSuSnRUXu3ZnIOXuCNaZ+sZbKpq24uYreTg
         Lmh7GirSDLqkTIvG+QMuEtMgYhaYC2QUw4oPnki6ipFL6jeymnDn16f1eaqeu330cY
         dlty8GEhAXe091aV6SLyxoahyCDzDwEZFQWa/td83g9rHHoq+xjrimizn3u7bzebQO
         DPeBBTe+gk+mw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to support .migrate_folio for compressed inode
Date:   Wed, 21 Dec 2022 20:14:45 +0800
Message-Id: <20221221121445.14400-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed .migrate_folio for compressed inode, in order to support
migration of compressed inode's page.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2532f369cb10..719b0a0184b0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1813,6 +1813,7 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
 const struct address_space_operations f2fs_compress_aops = {
 	.release_folio = f2fs_release_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
-- 
2.36.1

