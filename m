Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EDF5FC3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJLKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJLKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:42:41 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D40AB48A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:42:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 431541E80D90;
        Wed, 12 Oct 2022 18:42:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YvdfTgYXwsXf; Wed, 12 Oct 2022 18:42:47 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A95691E80D32;
        Wed, 12 Oct 2022 18:42:47 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] fs: udf: Optimize udf_free_in_core_inode and udf_find_fileset function
Date:   Wed, 12 Oct 2022 18:42:35 +0800
Message-Id: <20221012104235.3331-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions perform the following optimizations.
1. Delete the type cast of foo pointer. Void * does not need to convert
the type.
2. Delete the initialization assignment of bh variable, which is
assigned first.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/udf/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 4042d9739fb7..06eda8177b5f 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -162,7 +162,7 @@ static void udf_free_in_core_inode(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct udf_inode_info *ei = (struct udf_inode_info *)foo;
+	struct udf_inode_info *ei = foo;
 
 	ei->i_data = NULL;
 	inode_init_once(&ei->vfs_inode);
@@ -820,7 +820,7 @@ static int udf_find_fileset(struct super_block *sb,
 			    struct kernel_lb_addr *fileset,
 			    struct kernel_lb_addr *root)
 {
-	struct buffer_head *bh = NULL;
+	struct buffer_head *bh;
 	uint16_t ident;
 	int ret;
 
-- 
2.18.2

