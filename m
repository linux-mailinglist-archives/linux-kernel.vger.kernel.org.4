Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50931638625
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKYJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKYJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:26:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F9326F1;
        Fri, 25 Nov 2022 01:26:21 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJTxQ1ltpz15Mv1;
        Fri, 25 Nov 2022 17:25:46 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 17:26:18 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <joel@jms.id.au>, <andrew@aj.id.au>
Subject: [PATCH] media: aspeed: Fix return value check in aspeed_video_debugfs_create()
Date:   Fri, 25 Nov 2022 09:24:15 +0000
Message-ID: <20221125092415.29635-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function debugfs_create_file() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Fixes: 52fed10ad756 ("media: aspeed: add debugfs")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 20f795ccc11b..c8fc2450e409 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1780,10 +1780,12 @@ static int aspeed_video_debugfs_create(struct aspeed_video *video)
 	debugfs_entry = debugfs_create_file(DEVICE_NAME, 0444, NULL,
 					    video,
 					    &aspeed_video_debugfs_ops);
-	if (!debugfs_entry)
+	if (IS_ERR(debugfs_entry)) {
 		aspeed_video_debugfs_remove(video);
+		return ERR_PTR(debugfs_entry);
+	}

-	return !debugfs_entry ? -EIO : 0;
+	return 0;
 }
 #else
 static void aspeed_video_debugfs_remove(struct aspeed_video *video) { }
--
2.17.1

