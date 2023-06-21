Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03417387B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjFUOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFUOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C31FDC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8AD56157E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD0C433C0;
        Wed, 21 Jun 2023 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358878;
        bh=z+HfjrMuouGlgw7YWfEPcYtDKLy+uS4g+mpDaNbRbAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzrcMK40y8V7/yiZ8JwB0ucY1cFDYQxsVw1y+ImdfdfOD3JBAcHUXoQG7XLviO77A
         L3DX2ZOhpXj9OMSCpB72XffBy3G2zQ0Qru57/hZb5z0s6xk3qK35bJeiFgifGc5Q4P
         JZD08llY246f7cxJ065iEhR0IdG6PQGF3lU7NY9tpEZRXr2p/PIcMxsEdgfIviNFQN
         rkjBHc0xSiGf76YOUGwq1SRVFKU381Z+L7dSiPHPp5EIcLyAVOEVEpA/wM2i5XXC0Y
         ylB0LMJQrcDqSWvAClMZj/CwBQgox3oCQkezAPtdlIXZKoPzbEExV8BpDuu7oBYrHc
         0Bf2fRcJubjEQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/79] befs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:27 -0400
Message-ID: <20230621144735.55953-13-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index eee9237386e2..1eee7baa808b 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -363,7 +363,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	inode->i_mtime.tv_sec =
 	    fs64_to_cpu(sb, raw_inode->last_modified_time) >> 16;
 	inode->i_mtime.tv_nsec = 0;   /* lower 16 bits are not a time */
-	inode->i_ctime = inode->i_mtime;
+	inode_ctime_set(inode, inode->i_mtime);
 	inode->i_atime = inode->i_mtime;
 
 	befs_ino->i_inode_num = fsrun_to_cpu(sb, raw_inode->inode_num);
-- 
2.41.0

