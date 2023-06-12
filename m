Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB572C9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjFLPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjFLPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B7E69
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E5462889
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B98EC4339B;
        Mon, 12 Jun 2023 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686583027;
        bh=zvMmSk16NAGIeLq/EL3xVdNol4rQeFRyAw2A01ZY1Os=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IhQTGNZ8O8RGV/cM7SpgNfZL/3shSHAvFLxU3wHUn9zvhTysxcMBk+gE/rhOd1t6y
         oso5GzBlEQluyifZFXhwB1ykK6SHldGCi/ryo0ah/xLpcPcRC941K1PHrk9ZTygSby
         EmU/vi35gJm0jRwqwV9fQDIiCA+gC/yOvhsqB0YtWwP+vQLsMdBbn4zWZpwxhjCAo5
         YcgN8H+PJxyk3n5LEnAusCYO4WOn6ipsxXD7rCkk7x1+ZXCIuWYmkLTmxR9nG74flX
         mosppfyQOcdnT3H/75VJ3TC6GGS8XVDn0yOK2R4ViINoNEE9QUxpfUOI6ONf25PoxZ
         Cykv5GXwfuwlw==
Date:   Mon, 12 Jun 2023 08:17:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] f2fs: set zstd default compression level to
 ZSTD_CLEVEL_DEFAULT
Message-ID: <ZIc28R76RSEC6uo1@google.com>
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607162954.2651657-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZSTD does not support compress_level=0.

The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
started to complain this.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - use default macro

 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fd23caa1ed9..ce3b628b5072 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -627,7 +627,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	int len = 4;
 
 	if (strlen(str) == len) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_OPTION(sbi).compress_level = ZSTD_CLEVEL_DEFAULT;
 		return 0;
 	}
 
-- 
2.41.0.162.gfafddb0af9-goog

