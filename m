Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F7741DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjF2BlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2BlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044C199B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E7C614B3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFD6C433C0;
        Thu, 29 Jun 2023 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688002870;
        bh=IRiMTzPSBBDNyJP17NyLwGG1gecMwGYnqIEp9NdQdYc=;
        h=From:To:Cc:Subject:Date:From;
        b=je+daSnVyZAyW2Pk9dbcmPDrLMWrJwD6yiv0OOTNVgVFbc8b+qCmG5kCO7id/jBm9
         GL39Ofu40OM7Z7v+cQnebYB8nzzaDUWCuFPi33MbQbXZioTu0Hn48Wl5V9jHu/+fTL
         gBUQQoClCyI+P3wXsXDrKTH9tAwd1U1PSQzYp1EHI7z0ZLShqrsLkKxe38VhEsl7b2
         4PGpRs9NTeVCiwYhdVAAiZ8JgMCHzPkRlAqhnCzxdL1+gfHcV0Ic90J9D/sCsA12Zt
         ADl86kY3nchQNs5TTcWJE7OpMQdB6qFkbZrFSErEkiKCG+Us9ud2UeQcJuc2SGNY3o
         TmgyiB3Us0HRg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix error path handling in truncate_dnode()
Date:   Thu, 29 Jun 2023 09:41:02 +0800
Message-Id: <20230629014102.3057853-1-chao@kernel.org>
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

If truncate_node() fails in truncate_dnode(), it missed to call
f2fs_put_page(), fix it.

Fixes: 7735730d39d7 ("f2fs: fix to propagate error from __get_meta_page()")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4a105a0cd794..dadea6b01888 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -943,8 +943,10 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	dn->ofs_in_node = 0;
 	f2fs_truncate_data_blocks(dn);
 	err = truncate_node(dn);
-	if (err)
+	if (err) {
+		f2fs_put_page(page, 1);
 		return err;
+	}
 
 	return 1;
 }
-- 
2.40.1

