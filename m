Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E209B7450B1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGBTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGBTke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E419B7;
        Sun,  2 Jul 2023 12:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B26060C99;
        Sun,  2 Jul 2023 19:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D6C433C7;
        Sun,  2 Jul 2023 19:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326733;
        bh=Av03rwNzvIUGcDE3jFO/D0wlmqH+PZSBkTKuwNYnWDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRUNNUE8zDOPrlUefVk0H+NBq1s/FQ5yGG0/+0sposdW0nvsq101pmid/E752siIO
         WBep7H9zMzdlPPUOCSAL1y459yLI2KcFv3u8J0gvkvZ00P1TdHbcLQZtTZ4YQqZM8G
         n5UDJ76J1k9fm2WHD97j5vdukaTpG82GSGobCvkAj6vGAMXAXURLpVZn5JPwC0tmhQ
         wap/tuQiurWl2j3J+G+NG2UNg/Fi0rSyWLZnSjuhsYzprdGrIpGi+xx0wyf1NVWvdK
         in2WN9Z6+M1E+Gs9MdUSh2ybDC61nIE/4h6X/HBy146Zaosdk3IDsI9yNh+3Y0YJhi
         jl6zK/44xN4vQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, Ian Kent <raven@themaw.net>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, autofs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 15/16] autofs: set ctime as well when mtime changes on a dir
Date:   Sun,  2 Jul 2023 15:38:14 -0400
Message-Id: <20230702193815.1775684-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 797a1d894d7b7586f422cabf8d7807cd39d0b5aa ]

When adding entries to a directory, POSIX generally requires that the
ctime also be updated alongside the mtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Ian Kent <raven@themaw.net>
Message-Id: <20230612104524.17058-4-jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs/root.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 6baf90b08e0ef..93046c9dc4610 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
-	dir->i_mtime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	return 0;
 }
@@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
-	dir->i_mtime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	spin_lock(&sbi->lookup_lock);
 	__autofs_add_expiring(dentry);
@@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
-	dir->i_mtime = current_time(dir);
+	dir->i_mtime = dir->i_ctime = current_time(dir);
 
 	return 0;
 }
-- 
2.39.2

