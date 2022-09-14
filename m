Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5B5B7F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiINDie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:38:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A385FAFC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:38:28 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS5YZ2g1Szcn56;
        Wed, 14 Sep 2022 11:34:42 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:38:27 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:38:27 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <linux@armlinux.org.uk>,
        <jayakumar.lkml@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] [ARM] am300epd: Release platform device in case of platform_device_add_data() fails
Date:   Wed, 14 Sep 2022 11:34:55 +0800
Message-ID: <20220914033455.98964-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform device need to be released when platform_device_add_data()
fails. Use platform_device_put() to release 'pdev' in error path.

Fixes: 4ce255c1420d ("[ARM] 5354/1: mach-pxa: add AM300 platform driver v3")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/arm/mach-pxa/am300epd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index 4b55bc89db8f..f8542b6aa9b7 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -275,11 +275,14 @@ int __init am300_init(void)
 		return -ENOMEM;
 
 	/* the am300_board that will be seen by broadsheetfb is a copy */
-	platform_device_add_data(am300_device, &am300_board,
+	ret = platform_device_add_data(am300_device, &am300_board,
 					sizeof(am300_board));
+	if (ret) {
+		platform_device_put(am300_device);
+		return ret;
+	}
 
 	ret = platform_device_add(am300_device);
-
 	if (ret) {
 		platform_device_put(am300_device);
 		return ret;
-- 
2.17.1

