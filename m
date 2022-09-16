Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861835BAE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiIPNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiIPNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:38:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E2AD9A6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:38:55 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MTZn85yWtz14Qc9;
        Fri, 16 Sep 2022 21:34:52 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 21:38:53 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 16 Sep
 2022 21:38:52 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] bus: mvebu-mbus: use DEFINE_SHOW_ATTRIBUTE to simplify mvebu_{sdram/devs}_debug
Date:   Fri, 16 Sep 2022 22:12:44 +0800
Message-ID: <20220916141244.2174005-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/bus/mvebu-mbus.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 5dc2669432ba..d51573ac525e 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -466,18 +466,7 @@ static int mvebu_sdram_debug_show(struct seq_file *seq, void *v)
 	struct mvebu_mbus_state *mbus = &mbus_state;
 	return mbus->soc->show_cpu_target(mbus, seq, v);
 }
-
-static int mvebu_sdram_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_sdram_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_sdram_debug_fops = {
-	.open = mvebu_sdram_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_sdram_debug);
 
 static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 {
@@ -516,18 +505,7 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int mvebu_devs_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_devs_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_devs_debug_fops = {
-	.open = mvebu_devs_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_devs_debug);
 
 /*
  * SoC-specific functions and definitions
-- 
2.25.1

