Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574C6EBF1A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDWLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDWLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:11:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11110C6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 04:11:38 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q45Ch4n0XzKtfv;
        Sun, 23 Apr 2023 19:10:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 19:11:35 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <haver@vnet.ibm.com>, <s.hauer@pengutronix.de>, <yhao016@ucr.edu>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubi: Refuse attaching if mtd's erasesize is 0
Date:   Sun, 23 Apr 2023 19:10:41 +0800
Message-ID: <20230423111041.684297-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists mtd devices with zero erasesize, which will trigger a
divide-by-zero exception while attaching ubi device.
Fix it by refusing attaching if mtd's erasesize is 0.

Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
Reported-by: Yu Hao <yhao016@ucr.edu>
Link: https://lore.kernel.org/lkml/977347543.226888.1682011999468.JavaMail.zimbra@nod.at/T/
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/build.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 6a2d1ef8d43c..69e92c31ace0 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -896,6 +896,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 		return -EINVAL;
 	}
 
+	/* UBI cannot work on flashes with zero erasesize. */
+	if (!mtd->erasesize) {
+		pr_err("ubi: refuse attaching mtd%d - zero erasesize flash is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
-- 
2.31.1

