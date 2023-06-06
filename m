Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B551724E34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjFFUgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjFFUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C91A7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6E66380A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A6C433D2;
        Tue,  6 Jun 2023 20:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686083808;
        bh=0cYUz6iSpj0eGwIL3jk2KHuInnAfLbouhLwJjaUDn/U=;
        h=From:To:Cc:Subject:Date:From;
        b=grmxwQPihJZONINOr57RH3NFIbNisnRHwKJOkoK1+XFzKQ9/U8SF/YIRWEKwBCVNK
         KYuGs7WfGbxp9X+IqWMqiRBsXKGhAO8uFUzWX3sZ79ppoEH9pypErF1/wXxfbWF9mf
         gqQtV/VZE143HcdJwoHokLSMb8ZmUjZnzSy1ZhINqnH0NxOPgDLhoOkX5NpI4mIkKZ
         WccMw5QkjpTROKGyDNqBMXYB8OX7Qu1IcNssR3BVROAaCW3RiFWUf8QUWczS1fgUz2
         xZVBmhQnXAKOOWJpg/vys8Jl4FlzELW6Hfr+i7wPT4BGjk/mjIoAM59IEXZFknDB1B
         Y2QAwpiuFRmig==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: compress tmp files given extension
Date:   Tue,  6 Jun 2023 13:36:45 -0700
Message-ID: <20230606203645.3926651-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

Let's compress tmp files for the given extension list.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3e35eb7dbb8f..cdc94c8e60f7 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -161,7 +161,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 
 	/* Compress wanting extension. */
 	for (i = 0; i < ext_cnt; i++) {
-		if (is_extension_exist(name, ext[i], false)) {
+		if (is_extension_exist(name, ext[i], true)) {
 			set_compress_context(inode);
 			return;
 		}
-- 
2.41.0.rc0.172.g3f132b7071-goog

