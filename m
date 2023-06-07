Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817627265F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFGQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjFGQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFB2114
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B0E6416A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61A6C433A0;
        Wed,  7 Jun 2023 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686155395;
        bh=rAXf1ZqsGnObsvjcYvsmTKbEZgNJCNBl1IG2c3vyIFw=;
        h=From:To:Cc:Subject:Date:From;
        b=F44bcrz7p0Q3Fonp/7x2+bCCOA5CjLELo3I7hay4Bfwg0htX0PWV89tvwlUS/XopD
         AcV0rC+4DVFa6SiUrmmiiKgWYWeRfq4gsy1ZO/x9c0EyZSVuUhtecpLX/obu7Vz7OH
         YGY8xIyCvpxmsLkPdYpWkwjPL8ZC9yyrweCKcM+0LW6pqM8K223ZCJ7DnCr8NRUWwZ
         cUePkopnKDmMAeT1Ik3Z3mMXsLmszn8h/Q7KMBIAsI7XPXg7NT1WsEe+lEtHZddTMi
         WLf9CYwK2lQFwPTaOcbQdEX9pN0xKD/RaocJxysScC6CvxrTElxcffwJUw3O6CTuTc
         aAWXw9ZWODmZw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set zstd default compression level to 3
Date:   Wed,  7 Jun 2023 09:29:54 -0700
Message-ID: <20230607162954.2651657-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
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

ZSTD does not support compress_level=0.

The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
revealed the issue.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fd23caa1ed9..1fb8d4f27a40 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -627,7 +627,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	int len = 4;
 
 	if (strlen(str) == len) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_OPTION(sbi).compress_level = 3;
 		return 0;
 	}
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

