Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597006221C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiKICLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKICLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:11:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA866C9C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C77AB81CD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1900FC433C1;
        Wed,  9 Nov 2022 02:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667959900;
        bh=el+9iDBLBzbkqcIXd+VbVRLhL+sNygO7vW88HQ7wz0Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RSm0iYTzd8Ef9RbgEX2v/Tj3V1G/oN+I/GfMxdhJQMDwIzzoEOv+2oREZYoKQXAyE
         qdd8Fttb3PZb/C2wxomUuIvL6YVMZo9QxLOIote9coQJqsWlrPMWEGsGkMYL7KQqX+
         B+/EezEPcmud4epjkW0cvC4n1o3PHxcR4CJgpdisHy5+Q+9B93PKLP/QHjtBgskLRs
         I7N2nJl9C9bfymZKKFvu95cyElE8IbU2VL3fqADYCRG1XvCkaqyZJDRkBo+oNpA527
         91hvklb6XID/DP3u71YKGoH6ZIQIu6TWYR+ec7UalV7O+d+w/Wb7rvMTH/xTv5Nwaf
         1zJRoxrsFiflw==
Date:   Tue, 8 Nov 2022 18:11:38 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: allow to read node block after shutdown
Message-ID: <Y2sMWrKXJtGSmUz7@google.com>
References: <20221109020917.4121067-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109020917.4121067-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If block address is still alive, we should give a valid node block even after
shutdown. Otherwise, we can see zero data when reading out a file.

Cc: stable@vger.kernel.org
Fixes: 83a3bfdb5a8 ("f2fs: indicate shutdown f2fs to allow unmount successfully")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 - Cc: stable

 fs/f2fs/node.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 983572f23896..b9ee5a1176a0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1360,8 +1360,7 @@ static int read_node_page(struct page *page, blk_opf_t op_flags)
 		return err;
 
 	/* NEW_ADDR can be seen, after cp_error drops some dirty node pages */
-	if (unlikely(ni.blk_addr == NULL_ADDR || ni.blk_addr == NEW_ADDR) ||
-			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
+	if (unlikely(ni.blk_addr == NULL_ADDR || ni.blk_addr == NEW_ADDR)) {
 		ClearPageUptodate(page);
 		return -ENOENT;
 	}
-- 
2.38.1.431.g37b22c650d-goog

