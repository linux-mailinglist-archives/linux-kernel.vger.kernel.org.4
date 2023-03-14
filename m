Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B736B99F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCNPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCNPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:40:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF251EFF2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2152CB818BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9BDC433D2;
        Tue, 14 Mar 2023 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678808302;
        bh=DLDxlhOLPnktraFE2/3JBXLe7fPvmLFetbLKdPk5yhE=;
        h=From:Date:Subject:To:Cc:From;
        b=VUmWcjQSkfaeLGd3H1VApOX/EjhlCYgjLY9cL3zf5/JdQYF6Wig7gcUAAaoZjqojZ
         cl2VWyWdk9SwdXaBarb6c1BhpfKHMBsjWT/IEUQNl+7bcXleFYeDhxIFOGem60newc
         7SHUya1Tu215vyBzQf6FNGT9hxq84PgO9IskiyZIhWRGcaLiMrQtqUXUZrGzoMmGZb
         MSPbblxu7s96n7kO0duZdubwSZgDwZl3RsaKdDD/wwWsIw1KSM6htD9NDcaBXzn4DF
         ZszZmBHzoTmkfbICCjc5FQ01+U4uGbQ6boEWMHhHhcAbeuP7ki9ck0YZE4GNe+EDSG
         iqvYTeTInJy4A==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 14 Mar 2023 08:38:08 -0700
Subject: [PATCH] drm/vmwgfx: Fix uninitialized use of dst_pitch in
 vmw_stdu_bo_cpu_commit()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-vmware-wuninitialized-v1-1-1bb4b0989758@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN+UEGQC/x2NQQqDQAwAvyI5N6CrXUq/UnrIaqyBmpbEalH8e
 9ceh2GYDZxN2OFabGA8i8tLM1SnAtqB9MEoXWYIZajLumpwHhcyxuWjojIJPWXlDsMlxtinM8W
 QILeJnDEZaTsc9Ug+sR3ibdzL9z+83ff9B6yIDneAAAAA
To:     zackr@vmware.com
Cc:     linux-graphics-maintainer@vmware.com, ndesaulniers@google.com,
        trix@redhat.com, krastevm@vmware.com, mombasawalam@vmware.com,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=nathan@kernel.org;
 h=from:subject:message-id; bh=DLDxlhOLPnktraFE2/3JBXLe7fPvmLFetbLKdPk5yhE=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCkCU94aRb7dWmlQWy319OrGLGHeHW1r7yj+ez/9N2dUQ
 du5Os6qjlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARJWuG/+mT/jLIH9lZ8nVt
 cPCFkoOnCzfbpWwPf85lIDt929ef3zgZGeZnXdRUWT9n44H6PMP52uYh69b5l3Gy8H+W0LDr/PX
 TiR8A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns (or errors with CONFIG_WERROR):

  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:509:29: error: variable 'dst_pitch' is uninitialized when used here [-Werror,-Wuninitialized]
          src_offset = ddirty->top * dst_pitch + ddirty->left * stdu->cpp;
                                     ^~~~~~~~~
  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:492:26: note: initialize the variable 'dst_pitch' to silence this warning
          s32 src_pitch, dst_pitch;
                                  ^
                                   = 0
  1 error generated.

The assignments were switched around in such a way that dst_pitch was
used before it was assigned. Swap the pitch assignments to fix the issue
and make it clear which section they are used in.

Fixes: 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
Link: https://github.com/ClangBuiltLinux/linux/issues/1811
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I am not sure if this is the right fix, as it was not entirely clear to
me that src_pitch and dst_pitch were being used in the right assignments
but this is the obvious fix otherwise. Consider this a bug report if
not :)
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index d79a6eccfaa4..030e977c68e2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -504,11 +504,11 @@ static void vmw_stdu_bo_cpu_commit(struct vmw_kms_dirty *dirty)
 		return;
 
 	/* Assume we are blitting from Guest (bo) to Host (display_srf) */
-	src_pitch = stdu->display_srf->metadata.base_size.width * stdu->cpp;
+	dst_pitch = ddirty->pitch;
 	src_bo = &stdu->display_srf->res.guest_memory_bo->tbo;
 	src_offset = ddirty->top * dst_pitch + ddirty->left * stdu->cpp;
 
-	dst_pitch = ddirty->pitch;
+	src_pitch = stdu->display_srf->metadata.base_size.width * stdu->cpp;
 	dst_bo = &ddirty->buf->tbo;
 	dst_offset = ddirty->fb_top * src_pitch + ddirty->fb_left * stdu->cpp;
 

---
base-commit: c87e859cdeb5d106cb861326e3135c606d61f88d
change-id: 20230314-vmware-wuninitialized-28666fb5a62b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

