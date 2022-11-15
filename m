Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067B862993D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiKOMwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKOMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:52:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251EB27FC5;
        Tue, 15 Nov 2022 04:52:07 -0800 (PST)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBQzV5FXczHvsT;
        Tue, 15 Nov 2022 20:51:34 +0800 (CST)
Received: from [10.136.108.160] (10.136.108.160) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 20:52:03 +0800
Message-ID: <d3393e2f-a79c-d2c1-f752-71bd21a7ddbf@huawei.com>
Date:   Tue, 15 Nov 2022 20:52:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: [PATCH v3] USB: gadget: Fix use-after-free during usb config switch
Content-Language: en-US
References: <20221115065404.6067-1-xuetao09@huawei.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <jakobkoschel@gmail.com>, <geert+renesas@glider.be>,
        =?UTF-8?B?5byg5bu65rab?= <water.zhangjiantao@huawei.com>,
        <colin.i.king@gmail.com>,
        =?UTF-8?B?6Jab5rab?= <xuetao09@huawei.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
From:   jiantao zhang <water.zhangjiantao@huawei.com>
In-Reply-To: <20221115065404.6067-1-xuetao09@huawei.com>
X-Forwarded-Message-Id: <20221115065404.6067-1-xuetao09@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.108.160]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of switching USB config from rndis to other config,
if the hardware does not support the ->pullup callback, or the
hardware encounters a low probability fault, both of them may cause
the ->pullup callback to fail, which will then cause a system panic
(use after free).

The gadget drivers sometimes need to be unloaded regardless of the
hardware's behavior.

Analysis as follows:
=======================================================================
(1) write /config/usb_gadget/g1/UDC "none"

gether_disconnect+0x2c/0x1f8
rndis_disable+0x4c/0x74
composite_disconnect+0x74/0xb0
configfs_composite_disconnect+0x60/0x7c
usb_gadget_disconnect+0x70/0x124
usb_gadget_unregister_driver+0xc8/0x1d8
gadget_dev_desc_UDC_store+0xec/0x1e4

(2) rm /config/usb_gadget/g1/configs/b.1/f1

rndis_deregister+0x28/0x54
rndis_free+0x44/0x7c
usb_put_function+0x14/0x1c
config_usb_cfg_unlink+0xc4/0xe0
configfs_unlink+0x124/0x1c8
vfs_unlink+0x114/0x1dc

(3) rmdir /config/usb_gadget/g1/functions/rndis.gs4

panic+0x1fc/0x3d0
do_page_fault+0xa8/0x46c
do_mem_abort+0x3c/0xac
el1_sync_handler+0x40/0x78
0xffffff801138f880
rndis_close+0x28/0x34
eth_stop+0x74/0x110
dev_close_many+0x48/0x194
rollback_registered_many+0x118/0x814
unregister_netdev+0x20/0x30
gether_cleanup+0x1c/0x38
rndis_attr_release+0xc/0x14
kref_put+0x74/0xb8
configfs_rmdir+0x314/0x374

If gadget->ops->pullup() return an error, function rndis_close() will be
called, then it will causes a use-after-free problem.
=======================================================================

Fixes: 0a55187a1ec8 ("USB: gadget core: Issue ->disconnect() callback 
from usb_gadget_disconnect()")
Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
Signed-off-by: TaoXue <xuetao09@huawei.com>
---
V2 -> V3: Solved the format issues of Fixes and backtraces.
V1 -> V2: V1 will affect the original function, V2 just move the callback
after "if" statement, so that the original function will not be affected.
And fixed formatting issues.

  drivers/usb/gadget/udc/core.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index c63c0c2cf649..bf9878e1a72a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -734,13 +734,13 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
  	}
   	ret = gadget->ops->pullup(gadget, 0);
-	if (!ret) {
+	if (!ret)
  		gadget->connected = 0;
-		mutex_lock(&udc_lock);
-		if (gadget->udc->driver)
-			gadget->udc->driver->disconnect(gadget);
-		mutex_unlock(&udc_lock);
-	}
+
+	mutex_lock(&udc_lock);
+	if (gadget->udc->driver)
+		gadget->udc->driver->disconnect(gadget);
+	mutex_unlock(&udc_lock);
   out:
  	trace_usb_gadget_disconnect(gadget, ret);
-- 
2.17.1

