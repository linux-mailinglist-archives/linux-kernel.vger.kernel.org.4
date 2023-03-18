Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939896BF74F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 02:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCRB50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 21:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCRB5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 21:57:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C64AD2C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 18:57:16 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdkZF38LlznXgR;
        Sat, 18 Mar 2023 09:54:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 18 Mar
 2023 09:57:14 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 4/5] ubi: Reserve sufficient buffer length for the input mask
Date:   Sat, 18 Mar 2023 09:56:20 +0800
Message-ID: <20230318015621.1408243-5-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
References: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
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

Because the mask received by the emulate_failures interface
is a 32-bit unsigned integer, ensure that there is sufficient
buffer length to receive and display this value.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 0c58cbabe9fc..eafeb10e57bf 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -332,7 +332,7 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
 	struct dentry *dent = file->f_path.dentry;
 	struct ubi_device *ubi;
 	struct ubi_debug_info *d;
-	char buf[8];
+	char buf[12];
 	int val;
 
 	ubi = ubi_get_device(ubi_num);
@@ -381,7 +381,7 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
 	struct ubi_device *ubi;
 	struct ubi_debug_info *d;
 	size_t buf_size;
-	char buf[8] = {0};
+	char buf[14] = {0};
 	int val;
 
 	ubi = ubi_get_device(ubi_num);
-- 
2.31.1

