Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE15E60F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIVL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIVL1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:27:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742BDED6E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:27:04 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCZ62pB4zlW19;
        Thu, 22 Sep 2022 19:22:54 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:27:02 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <linux@dominikbrodowski.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] pcmcia: Add __init/__exit annotations to module init/exit funcs
Date:   Thu, 22 Sep 2022 19:23:23 +0800
Message-ID: <20220922112323.26353-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/pcmcia/i82092.c       | 4 ++--
 drivers/pcmcia/vrc4171_card.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 192c9049d654..a335748bdef5 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -661,12 +661,12 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	return 0;
 }
 
-static int i82092aa_module_init(void)
+static int __init i82092aa_module_init(void)
 {
 	return pci_register_driver(&i82092aa_pci_driver);
 }
 
-static void i82092aa_module_exit(void)
+static void __exit i82092aa_module_exit(void)
 {
 	pci_unregister_driver(&i82092aa_pci_driver);
 	if (sockets[0].io_base > 0)
diff --git a/drivers/pcmcia/vrc4171_card.c b/drivers/pcmcia/vrc4171_card.c
index 177d77892144..ebaeb582539a 100644
--- a/drivers/pcmcia/vrc4171_card.c
+++ b/drivers/pcmcia/vrc4171_card.c
@@ -699,7 +699,7 @@ static struct platform_driver vrc4171_card_driver = {
 	},
 };
 
-static int vrc4171_card_init(void)
+static int __init vrc4171_card_init(void)
 {
 	int retval;
 
@@ -733,7 +733,7 @@ static int vrc4171_card_init(void)
 	return 0;
 }
 
-static void vrc4171_card_exit(void)
+static void __exit vrc4171_card_exit(void)
 {
 	free_irq(vrc4171_irq, vrc4171_sockets);
 	vrc4171_remove_sockets();
-- 
2.17.1

