Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5696DC2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDJCZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDJCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CC4491
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7208A6175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42D5C433D2;
        Mon, 10 Apr 2023 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681093476;
        bh=lfKqRPUiqgrvfO9fwMhr+hAhaRhNAJLuNXb1o5Hmn2w=;
        h=From:To:Cc:Subject:Date:From;
        b=ehXGleMLkdtUae3AMLDJ+sJKwc91yJFxns08gvEzd3ftR1CZ8UGOtAtpkpI88veiK
         gwBY/GMWbsk0tNs+74lu2kz9CzkjzJI0CkSe+Jyx2v8Ibevvld+V9VmfNEYSkwlXA2
         DyOCVMlWyhvifc2O3OjLr4H2+gQM04KrYm/yNiISbMAD+nzvYAw5o1DsXPsjLpa+x8
         iqtkl2mDbginz5ssOSK6UHVbj3B2L8ldDge0sC0FM1S8+CzwK6kgr9Kf5UkVeFJwrb
         mWQfeQJYax3RgbTqs8XRLYlhczFAd+m0VacWq2b96M1dYUXMy/tnXRfWiaYXw+IpVb
         KtJrl3Zv/M22Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: remove folio_detach_private() in .invalidate_folio and .release_folio
Date:   Mon, 10 Apr 2023 10:24:17 +0800
Message-Id: <20230410022418.1843178-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have maintain PagePrivate and page_private and page reference
w/ {set,clear}_page_private_*, it doesn't need to call
folio_detach_private() in the end of .invalidate_folio and
.release_folio, remove it and use f2fs_bug_on instead.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4946df6dd253..8b179b4bdc03 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3737,7 +3737,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 			inode->i_ino == F2FS_COMPRESS_INO(sbi))
 		clear_page_private_data(&folio->page);
 
-	folio_detach_private(folio);
+	f2fs_bug_on(sbi, PagePrivate(&folio->page));
+	f2fs_bug_on(sbi, page_private(&folio->page));
 }
 
 bool f2fs_release_folio(struct folio *folio, gfp_t wait)
@@ -3759,7 +3760,9 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
-	folio_detach_private(folio);
+	f2fs_bug_on(sbi, PagePrivate(&folio->page));
+	f2fs_bug_on(sbi, page_private(&folio->page));
+
 	return true;
 }
 
-- 
2.25.1

