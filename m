Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0085B6238C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiKJBWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJBWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:22:49 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02FE028
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:22:48 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N73wY32N4zHvhS;
        Thu, 10 Nov 2022 09:22:21 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 09:22:46 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <windhl@126.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] powerpc/pseries: fix possible memory leak in ibmebus_bus_init()
Date:   Thu, 10 Nov 2022 09:19:29 +0800
Message-ID: <20221110011929.3709774-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_register() returns error in ibmebus_bus_init(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop
the reference count that was set in device_initialize() when it fails,
so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index a870cada7acd..ed5fc70b7353 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -455,6 +455,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
-- 
2.25.1

