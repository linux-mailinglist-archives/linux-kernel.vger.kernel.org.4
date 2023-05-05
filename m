Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2B6F896B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjEETS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjEETSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF364681
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A3264016
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5877FC433A4;
        Fri,  5 May 2023 19:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683314323;
        bh=WqR7xSNCDj5K0Ml3rB03N8hM6nrYRl2mEIN/908vw7A=;
        h=From:To:Cc:Subject:Date:From;
        b=OGiaSO4C8fvx6Y/tXE89myDZ3z0EaZDePnhKDQdzQTiH4ZWzD41u3/cRLpdtriKnT
         pXPLCHrnWPODUjfcrYSzu1NFJadNUUY0aYGgnwGDAlnAmyE9IY0yIE5nVhbACq+VSK
         jGdUTs8Jtahsc0eZy06KwcGQdlgFyGR11sFFCFu2sZLGQcA94lMrFFVyimfQOUJ34/
         J4f4MDvjhx+hvJLf38UEkgF7QJkPQDrq0PNreAofB/QVHhOh5bpeAE8bhpRjE/4qEm
         d/JuHUhXJ2DH4VCxv8hNHGr6HM+EHP6BRNQw9QQY5qSC+GxISStqwZXoprusM5noCR
         HsLAtcY1zf5NQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix the wrong condition to determine atomic context
Date:   Fri,  5 May 2023 12:18:41 -0700
Message-ID: <20230505191841.3185179-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should use !in_task for irq context.

Fixes: 1aa161e43106 ("f2fs: fix scheduling while atomic in decompression path")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11653fa79289..10b545a1088e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -743,7 +743,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		ret = -EFSCORRUPTED;
 
 		/* Avoid f2fs_commit_super in irq context */
-		if (in_task)
+		if (!in_task)
 			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
 		else
 			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
-- 
2.40.1.521.gf1e218fcd8-goog

