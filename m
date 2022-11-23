Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA6634DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiKWCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiKWCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:15:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F85EB9B99;
        Tue, 22 Nov 2022 18:15:04 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH4Sn5S6jzRpNh;
        Wed, 23 Nov 2022 10:14:33 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 10:15:02 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>
CC:     <renzhijie2@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH -next] usb: fotg210: Fix build error when CONFIG_USB_FOTG210_UDC=y && CONFIG_USB_GADGET=m
Date:   Wed, 23 Nov 2022 10:11:53 +0800
Message-ID: <20221123021153.205291-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The combination of CONFIG_USB_FOTG210_UDC=y and
CONFIG_USB_GADGET=m results in the following error:

drivers/usb/fotg210/fotg210-udc.o: In function `fotg210_done':
fotg210-udc.c:(.text+0x75b): undefined reference to
`usb_gadget_giveback_request'
drivers/usb/fotg210/fotg210-udc.o: In function `fotg210_irq':
fotg210-udc.c:(.text+0x1586): undefined reference to `usb_gadget_udc_reset'
drivers/usb/fotg210/fotg210-udc.o: In function `fotg210_udc_remove':
fotg210-udc.c:(.text+0x179a): undefined reference to `usb_del_gadget_udc'
drivers/usb/fotg210/fotg210-udc.o: In function `fotg210_udc_probe':
fotg210-udc.c:(.text+0x19ed): undefined reference to
`usb_ep_set_maxpacket_limit'
fotg210-udc.c:(.text+0x1a11): undefined reference to
`usb_ep_set_maxpacket_limit'
fotg210-udc.c:(.text+0x1ace): undefined reference to `usb_add_gadget_udc'
fotg210-udc.c:(.text+0x1b74): undefined reference to
`usb_ep_set_maxpacket_limit'
make[1]: *** [vmlinux] Error 1
make: *** [vmlinux] Error 2
make: *** Waiting for unfinished jobs....

Make USB_FOTG210_UDC depends on USB_GADGET=y to fix this.

Fixes: 1dd33a9f1b95 ("usb: fotg210: Collect pieces of dual mode controller")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
 drivers/usb/fotg210/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/fotg210/Kconfig b/drivers/usb/fotg210/Kconfig
index 534206ee0d1d..bc07c7fc8998 100644
--- a/drivers/usb/fotg210/Kconfig
+++ b/drivers/usb/fotg210/Kconfig
@@ -24,7 +24,7 @@ config USB_FOTG210_HCD
 	  module will be called fotg210-hcd.
 
 config USB_FOTG210_UDC
-	depends on USB_GADGET
+	depends on USB_GADGET = y
 	bool "Faraday FOTG210 USB Peripheral Controller support"
 	help
 	   Faraday USB2.0 OTG controller which can be configured as
-- 
2.17.1

