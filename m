Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C91739E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjFVKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFVKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956D107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7B09617C3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E8AC433C8;
        Thu, 22 Jun 2023 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687429026;
        bh=LKeF6N/V+xgw47jyD6tRnEV8eEabABkGvs7O5k9QKhM=;
        h=From:To:Cc:Subject:Date:From;
        b=Jxh4dVRbcJ+uww/w+YUjVODVegZPu/WRfX+VdZ0r1aRjnKLgoSlh3WIEG4sKDO/7+
         4UYYdnjR8rbY4GwlXYSc97d2Wa7+FlAGKCLqGoggoHsdCY+JrXIMkH4/pi53S16Vdh
         kzqWtrDvdoGAB3WVViZTz1rWUvgpG+LI1rv7RgYK5PiT8oCmN/Lr/00Ku63Uo8/VLY
         SxOl15+TTXMh73Z7YD1a3hs/xFw/L117EpNiP0xTXpDMr+gyCulSEYTn6Ld6Sv5XKF
         b7NpnTYZu4fF6/HLgl66MPtZkEXJHFFitbNndNgT5+CZlZDueYR2p+h8+ThvDJuPm6
         yHIIpc5nFVa2A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: fix out-of-bounds fsid access
Date:   Thu, 22 Jun 2023 12:16:52 +0200
Message-Id: <20230622101701.3399585-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

orangefs_statfs() copies two consecutive fields of the superblock into
the statfs structure, which triggers a warning from the string fortification
helpers:

In file included from fs/orangefs/super.c:8:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

Change the memcpy() to an individual assignment of the two fields, which helps
both the compiler and human readers understand better what it does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/orangefs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d7..509a74aca2dcb 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -201,7 +201,10 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		     (long)new_op->downcall.resp.statfs.files_avail);
 
 	buf->f_type = sb->s_magic;
-	memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));
+	buf->f_fsid = (__kernel_fsid_t) {{
+		ORANGEFS_SB(sb)->fs_id,
+		ORANGEFS_SB(sb)->id,
+	}};
 	buf->f_bsize = new_op->downcall.resp.statfs.block_size;
 	buf->f_namelen = ORANGEFS_NAME_MAX;
 
-- 
2.39.2

