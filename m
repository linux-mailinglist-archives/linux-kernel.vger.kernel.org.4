Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0B62D366
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiKQGWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiKQGWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:22:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A032BA0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:22:02 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCVDg4vBGzRpNT;
        Thu, 17 Nov 2022 14:21:39 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 14:21:59 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>
Subject: [PATCH] ARM: mxs: fix memory leak in mxs_machine_init()
Date:   Thu, 17 Nov 2022 06:20:11 +0000
Message-ID: <20221117062011.84602-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_property_read_string() failed, 'soc_dev_attr' should be
freed before return. Otherwise there is a memory leak.

Fixes: 2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 25c9d184fa4c..1c57ac401649 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -393,8 +393,10 @@ static void __init mxs_machine_init(void)

 	root = of_find_node_by_path("/");
 	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
-	if (ret)
+	if (ret) {
+		kfree(soc_dev_attr);
 		return;
+	}

 	soc_dev_attr->family = "Freescale MXS Family";
 	soc_dev_attr->soc_id = mxs_get_soc_id();
--
2.17.1

