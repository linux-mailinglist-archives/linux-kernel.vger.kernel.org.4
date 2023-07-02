Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E39745119
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjGBTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjGBTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9655E6E;
        Sun,  2 Jul 2023 12:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6CB660D3A;
        Sun,  2 Jul 2023 19:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ACAC433C7;
        Sun,  2 Jul 2023 19:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326897;
        bh=9HxGW5e7fIeBVGOk8ORDiaKGbr+KDpvkz08ec187WSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=armIUf/W4UUNMuvzP7wTTFxqd9CPWUTUXoS/Ntf7aYbuUVSyNLrIDsoP+qN0x/NW5
         kx9oEp6GuWfSzvw+XoQoZYarFWYYT8Cgy/ep5FX0CXxpu7Zs7u+eKgW5T803IRUo1H
         kqpOHlMu4A9i27R9ICy9L5R97rRGGukplPPVxiAczNdya/KgjLCmF9yWXB9wKBMZlS
         IRxR3nlFPpR+eXvqZjvptdug3kptKMDV6SzN73aFlhRq8KJ2ly4r3gRYQIY7oBG680
         7gGL+q8SdvyhhmrOcQprR+rcdbXqGUSbAisFdEUbLEB3eYUHnkwIp25VaaQztBqWjg
         zmpXkBOwLmqsw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/12] btrfs: don't check PageError in __extent_writepage
Date:   Sun,  2 Jul 2023 15:41:16 -0400
Message-Id: <20230702194118.1777794-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194118.1777794-1-sashal@kernel.org>
References: <20230702194118.1777794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3e92499e3b004baffb479d61e191b41b604ece9a ]

__extent_writepage currenly sets PageError whenever any error happens,
and the also checks for PageError to decide if to call error handling.
This leads to very unclear responsibility for cleaning up on errors.
In the VM and generic writeback helpers the basic idea is that once
I/O is fired off all error handling responsibility is delegated to the
end I/O handler.  But if that end I/O handler sets the PageError bit,
and the submitter checks it, the bit could in some cases leak into the
submission context for fast enough I/O.

Fix this by simply not checking PageError and just using the local
ret variable to check for submission errors.  This also fundamentally
solves the long problem documented in a comment in __extent_writepage
by never leaking the error bit into the submission context.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 58785dc7080ad..ce4d87fd9a213 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2296,38 +2296,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	/*
-	 * Here we used to have a check for PageError() and then set @ret and
-	 * call end_extent_writepage().
-	 *
-	 * But in fact setting @ret here will cause different error paths
-	 * between subpage and regular sectorsize.
-	 *
-	 * For regular page size, we never submit current page, but only add
-	 * current page to current bio.
-	 * The bio submission can only happen in next page.
-	 * Thus if we hit the PageError() branch, @ret is already set to
-	 * non-zero value and will not get updated for regular sectorsize.
-	 *
-	 * But for subpage case, it's possible we submit part of current page,
-	 * thus can get PageError() set by submitted bio of the same page,
-	 * while our @ret is still 0.
-	 *
-	 * So here we unify the behavior and don't set @ret.
-	 * Error can still be properly passed to higher layer as page will
-	 * be set error, here we just don't handle the IO failure.
-	 *
-	 * NOTE: This is just a hotfix for subpage.
-	 * The root fix will be properly ending ordered extent when we hit
-	 * an error during writeback.
-	 *
-	 * But that needs a bigger refactoring, as we not only need to grab the
-	 * submitted OE, but also need to know exactly at which bytenr we hit
-	 * the error.
-	 * Currently the full page based __extent_writepage_io() is not
-	 * capable of that.
-	 */
-	if (PageError(page))
+	if (ret)
 		end_extent_writepage(page, ret, page_start, page_end);
 	if (epd->extent_locked) {
 		/*
-- 
2.39.2

