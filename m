Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBBF6108A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJ1DTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiJ1DTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:19:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F4125D3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:19:27 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mz73f0TLhzpW7P;
        Fri, 28 Oct 2022 11:15:58 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 11:19:25 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 11:19:25 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <chenzhongjin@huawei.com>
Subject: [PATCH] ASoC: core: Fix use-after-free in snd_soc_exit()
Date:   Fri, 28 Oct 2022 11:16:03 +0800
Message-ID: <20221028031603.59416-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reports a use-after-free:

BUG: KASAN: use-after-free in device_del+0xb5b/0xc60
Read of size 8 at addr ffff888008655050 by task rmmod/387
CPU: 2 PID: 387 Comm: rmmod
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
<TASK>
dump_stack_lvl+0x79/0x9a
print_report+0x17f/0x47b
kasan_report+0xbb/0xf0
device_del+0xb5b/0xc60
platform_device_del.part.0+0x24/0x200
platform_device_unregister+0x2e/0x40
snd_soc_exit+0xa/0x22 [snd_soc_core]
__do_sys_delete_module.constprop.0+0x34f/0x5b0
do_syscall_64+0x3a/0x90
entry_SYSCALL_64_after_hwframe+0x63/0xcd
...
</TASK>

It's bacause in snd_soc_init(), snd_soc_util_init() is possble to fail,
but its ret is ignored, which makes soc_dummy_dev unregistered twice.

snd_soc_init()
    snd_soc_util_init()
        platform_device_register_simple(soc_dummy_dev)
        platform_driver_register() # fail
    	platform_device_unregister(soc_dummy_dev)
    platform_driver_register() # success
...
snd_soc_exit()
    snd_soc_util_exit()
    # soc_dummy_dev will be unregistered for second time

To fix it, handle error and stop snd_soc_init() when util_init() fail.
Also clean debugfs when util_init() or driver_register() fail.

Fixes: fb257897bf20 ("ASoC: Work around allmodconfig failure")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 sound/soc/soc-core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 12a82f5a3ff6..a409fbed8f34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3477,10 +3477,23 @@ EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_link_cpus);
 
 static int __init snd_soc_init(void)
 {
+	int ret;
+
 	snd_soc_debugfs_init();
-	snd_soc_util_init();
+	ret = snd_soc_util_init();
+	if (ret)
+		goto err_util_init;
 
-	return platform_driver_register(&soc_driver);
+	ret = platform_driver_register(&soc_driver);
+	if (ret)
+		goto err_register;
+	return 0;
+
+err_register:
+	snd_soc_util_exit();
+err_util_init:
+	snd_soc_debugfs_exit();
+	return ret;
 }
 module_init(snd_soc_init);
 
-- 
2.17.1

