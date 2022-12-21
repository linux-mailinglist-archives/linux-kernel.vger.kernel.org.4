Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4565309D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLUMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F5A2628
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:13:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1417B81983
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D252C433F0;
        Wed, 21 Dec 2022 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671624830;
        bh=xIFUOdw6h/m98UutRxVbjzmSxlBaUQ21YinqKn/ghXE=;
        h=From:To:Cc:Subject:Date:From;
        b=SVvvbmhux64d167V+FcTPMv/TnlGk5unW1vg9fGJ7J68k8U7F1EiLeZdwLiX5NPOe
         P2tJryziI5jqb+cuCJVMrRoKP1+HHXWJvFjrFlY9SqJWfoTIHmbwYSazch2w8FN3pb
         nO72pXCAFq3M7ywNSzGjUfejRK8KBEilutCLu8WiyBQ0Am1k1oVPC4hSxPQm7OCWuq
         xMCa9jzuF86GEKBNOKw/O3L2/5DcA7cKN1iwu6bHXWlojiyP20c+NFsGqYCfl7dY5Z
         dK18SiGkeBCKBfxZRf4b/opxSEiF3irXDa9gQNg6c8okS/opzSukt2vKEqWYnHSm26
         GCPvS5dBTp06g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to call clear_page_private_reference in .{release,invalid}_folio
Date:   Wed, 21 Dec 2022 20:13:45 +0800
Message-Id: <20221221121345.14353-1-chao@kernel.org>
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

b763f3bedc2d ("f2fs: restructure f2fs page.private layout") missed
to call clear_page_private_reference() in .{release,invalid}_folio,
fix it, though it's not a big deal since folio_detach_private() was
called to clear all privae info and reference count in the page.

BTW, remove page_private_reference() definition as it never be used.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 fs/f2fs/f2fs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b1ec0fbf1c8f..53d8945df2c1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3696,6 +3696,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		}
 	}
 
+	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
 	if (test_opt(sbi, COMPRESS_CACHE) &&
@@ -3721,6 +3722,7 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 			clear_page_private_data(&folio->page);
 	}
 
+	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
 	folio_detach_private(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9da26d4ec017..049d4fa0b59e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1453,7 +1453,6 @@ static inline void clear_page_private_##name(struct page *page) \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
-PAGE_PRIVATE_GET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_GET_FUNC(dummy, DUMMY_WRITE);
-- 
2.36.1

