Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9573B633C06
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiKVMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiKVMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:06:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B052FFE1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:06:13 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGjdK0qYLzmVvB;
        Tue, 22 Nov 2022 20:05:41 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 20:06:10 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] comedi: drivers: pcl730: Fix potential memory leak in pcl730_attach()
Date:   Tue, 22 Nov 2022 20:04:28 +0800
Message-ID: <20221122120428.25069-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcl730_attach() calls comedi_request_region() and won't release the
resource allocated by alloc_resource() when pcl730_attach() failed latter.
Add release_region() to prevent memory leak.

Fixes: 6f9aa29b47f6 ("staging: comedi: pcl730: use comedi_request_region()")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/comedi/drivers/pcl730.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/pcl730.c b/drivers/comedi/drivers/pcl730.c
index d2733cd5383d..c463de8a14e1 100644
--- a/drivers/comedi/drivers/pcl730.c
+++ b/drivers/comedi/drivers/pcl730.c
@@ -274,8 +274,14 @@ static int pcl730_attach(struct comedi_device *dev,
 		return ret;
 
 	ret = comedi_alloc_subdevices(dev, board->n_subdevs);
-	if (ret)
+	if (ret) {
+		if (dev->iobase && dev->iolen) {
+			release_region(dev->iobase, dev->iolen);
+			dev->iobase = 0;
+			dev->iolen = 0;
+		}
 		return ret;
+	}
 
 	subdev = 0;
 
-- 
2.17.1

