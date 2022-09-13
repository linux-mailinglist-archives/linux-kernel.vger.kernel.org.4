Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9E5B6AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiIMJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiIMJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:36:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5BA192B7;
        Tue, 13 Sep 2022 02:36:35 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRdZT0z6cznVHN;
        Tue, 13 Sep 2022 17:33:53 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 17:36:33 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 17:36:33 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] mips: cavium: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Tue, 13 Sep 2022 18:10:36 +0800
Message-ID: <20220913101038.1902389-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913101038.1902389-1-liushixin2@huawei.com>
References: <20220913101038.1902389-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/mips/cavium-octeon/oct_ilm.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
index 6a4694538bb6..dc05262e85ff 100644
--- a/arch/mips/cavium-octeon/oct_ilm.c
+++ b/arch/mips/cavium-octeon/oct_ilm.c
@@ -28,7 +28,7 @@ struct latency_info {
 static struct latency_info li;
 static struct dentry *dir;
 
-static int show_latency(struct seq_file *m, void *v)
+static int oct_ilm_show(struct seq_file *m, void *v)
 {
 	u64 cpuclk, avg, max, min;
 	struct latency_info curr_li = li;
@@ -43,18 +43,7 @@ static int show_latency(struct seq_file *m, void *v)
 		   curr_li.interrupt_cnt, avg, max, min);
 	return 0;
 }
-
-static int oct_ilm_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, show_latency, NULL);
-}
-
-static const struct file_operations oct_ilm_ops = {
-	.open = oct_ilm_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(oct_ilm);
 
 static int reset_statistics(void *data, u64 value)
 {
@@ -67,7 +56,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(reset_statistics_ops, NULL, reset_statistics, "%llu\n")
 static void init_debugfs(void)
 {
 	dir = debugfs_create_dir("oct_ilm", 0);
-	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_ops);
+	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_fops);
 	debugfs_create_file("reset", 0222, dir, NULL, &reset_statistics_ops);
 }
 
-- 
2.25.1

