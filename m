Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5836FD118
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjEIVXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjEIVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB586B1;
        Tue,  9 May 2023 14:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB2AD63779;
        Tue,  9 May 2023 21:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60657C4339B;
        Tue,  9 May 2023 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667234;
        bh=fvggIfwE4DYJULyIHUQCishCUS8+oRGIdCElfL9i1Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9M+hF6SnnHha9BxsH+EM0BAogBu0jmQogOAnZJQcwqHsa1opOyGvOljYCqGjKyC7
         hO4R5hKl3N65Q0uM83Iu+2GAi9yWzNEZlVa6rVukD2Qb+IiDz1mu/EU9RZkXB17vuB
         MfDhuXDNinCGrTduNdmuz6+EQR8AXPH8Cyg80qYmiOIci1KCKKgTZFV/CeRLRX2rd2
         YPe/Lt1kcUlrRc3WwP39A/Y663y7lHBDVndrQ/YVI5ZcCwse7IgWjRfKmmc6X1pa19
         aogEPNGQklSi7M8y8choUyCE4HEiLelmx4tb5emFJG/bFbOtFBmE3Na0GLZGKrB5ii
         pnBwtRdQIGCqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 08/13] fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()
Date:   Tue,  9 May 2023 17:20:16 -0400
Message-Id: <20230509212023.22105-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212023.22105-1-sashal@kernel.org>
References: <20230509212023.22105-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit ec275bf9693d19cc0fdce8436f4c425ced86f6e7 ]

In a previous commit c1006bd13146, ni->mi.mrec in ni_write_inode()
could be NULL, and thus a NULL check is added for this variable.

However, in the same call stack, ni->mi.mrec can be also dereferenced
in ni_clear():

ntfs_evict_inode(inode)
  ni_write_inode(inode, ...)
    ni = ntfs_i(inode);
    is_rec_inuse(ni->mi.mrec) -> Add a NULL check by previous commit
  ni_clear(ntfs_i(inode))
    is_rec_inuse(ni->mi.mrec) -> No check

Thus, a possible null-pointer dereference may exist in ni_clear().
To fix it, a NULL check is added in this function.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 95556515ded3d..d24e12d348d49 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -101,7 +101,7 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
-- 
2.39.2

