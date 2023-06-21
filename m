Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE82738808
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFUOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjFUOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FDC2117
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7094A61596
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72641C433C0;
        Wed, 21 Jun 2023 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358982;
        bh=lRNOsnrBPUjv4L/g1gjVfCiRbZ+F6XeUXgjCMmQXIRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+y2qDE/qDDLMWOZuIBh7Nvb9leyinmxQqHYG2BeojfL+wM+4CnM1cf0enDuIZlOM
         /Fi7rgJ2bO5MIABG0w2mXexG7aF80adZorF/IVP1jM1T3evqwveCtmEmQi4tin1Ec7
         0z29faQTyUrBE9U/i5qcfE+xzp+o+JQbgu0vAnDbJ4tYGVJoJyqaSZeo/IT++hlbC+
         kY9WWoiptHDbz4jG3pwHQt6fM/0AvWjBExdyIsOZD4Ay3VWwhVc9KeKHY6QGnvp+kM
         9wcB9h/KEpgJymelKoVRiEirPZsLMweswuaSADmoWBH60OhjSgoQlSfIL+2xVfdeHV
         33c+N8iUIT+vg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 73/79] bpf: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:26 -0400
Message-ID: <20230621144735.55953-72-jlayton@kernel.org>
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
 kernel/bpf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..d4489bb761df 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -120,7 +120,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 	inode->i_ino = get_next_ino();
 	inode->i_atime = current_time(inode);
 	inode->i_mtime = inode->i_atime;
-	inode->i_ctime = inode->i_atime;
+	inode_ctime_set(inode, inode->i_atime);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
@@ -149,7 +149,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	dget(dentry);
 
 	dir->i_mtime = current_time(dir);
-	dir->i_ctime = dir->i_mtime;
+	inode_ctime_set(dir, dir->i_mtime);
 }
 
 static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.41.0

