Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E95E76E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiIWJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiIWJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:25:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF15C8405
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:25:13 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYmsH4jy8zHqJg;
        Fri, 23 Sep 2022 17:22:59 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:25:11 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 17:25:10 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <chenxiaosong2@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] debugfs: use DEFINE_SHOW_ATTRIBUTE to define debugfs_regset32_fops
Date:   Fri, 23 Sep 2022 18:25:54 +0800
Message-ID: <20220923102554.2443452-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/debugfs/file.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 950c63fa4d0b..ddb3fc258df9 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1121,7 +1121,7 @@ void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 }
 EXPORT_SYMBOL_GPL(debugfs_print_regs32);
 
-static int debugfs_show_regset32(struct seq_file *s, void *data)
+static int debugfs_regset32_show(struct seq_file *s, void *data)
 {
 	struct debugfs_regset32 *regset = s->private;
 
@@ -1136,17 +1136,7 @@ static int debugfs_show_regset32(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int debugfs_open_regset32(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_show_regset32, inode->i_private);
-}
-
-static const struct file_operations fops_regset32 = {
-	.open =		debugfs_open_regset32,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
 
 /**
  * debugfs_create_regset32 - create a debugfs file that returns register values
@@ -1167,7 +1157,7 @@ void debugfs_create_regset32(const char *name, umode_t mode,
 			     struct dentry *parent,
 			     struct debugfs_regset32 *regset)
 {
-	debugfs_create_file(name, mode, parent, regset, &fops_regset32);
+	debugfs_create_file(name, mode, parent, regset, &debugfs_regset32_fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_regset32);
 
-- 
2.31.1

