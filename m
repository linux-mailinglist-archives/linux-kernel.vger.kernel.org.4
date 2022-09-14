Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD15B7F62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiINDan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:30:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5885A2D6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:30:35 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS5NS5fxSzcfgj;
        Wed, 14 Sep 2022 11:26:48 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:30:33 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:30:33 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <Julia.Lawall@inria.fr>, <joel@jms.id.au>, <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc: Avoid platform device Leak in the event of platform_device_add() fails
Date:   Wed, 14 Sep 2022 11:26:59 +0800
Message-ID: <20220914032659.96388-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Use platform_device_put() to free the platform device and return
directly in the event platform_device_add() fails.

Fixes: a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index c1c430c66dc9..5171635c3450 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1487,6 +1487,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 {
 	struct pmac_i2c_bus *bus;
 	int i = 0;
+	int ret;
 
 	/* In the case where we are initialized from smp_init(), we must
 	 * not use the timer (and thus the irq). It's safe from now on
@@ -1502,7 +1503,11 @@ static int __init pmac_i2c_create_platform_devices(void)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
 		bus->platform_dev->dev.of_node = bus->busnode;
-		platform_device_add(bus->platform_dev);
+		ret = platform_device_add(bus->platform_dev);
+		if (ret) {
+			platform_device_put(bus->platform_dev);
+			return ret;
+		}
 	}
 
 	/* Now call platform "init" functions */
-- 
2.17.1

