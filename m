Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F456312C1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 07:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiKTG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 01:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTG7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 01:59:22 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0265A1A29;
        Sat, 19 Nov 2022 22:59:20 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFLw50mMCzHvrS;
        Sun, 20 Nov 2022 14:58:45 +0800 (CST)
Received: from huawei.com (10.175.104.82) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 20 Nov
 2022 14:59:18 +0800
From:   Baisong Zhong <zhongbaisong@huawei.com>
To:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mchehab@kernel.org>, <zhongbaisong@huawei.com>,
        <Adams.xu@azwave.com.cn>
Subject: [PATCH -next] media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()
Date:   Sun, 20 Nov 2022 14:59:18 +0800
Message-ID: <20221120065918.2160782-1-zhongbaisong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Chen reports a kernel bug as blew:

general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
...
Call Trace:
<TASK>
__i2c_transfer+0x77e/0x1930 drivers/i2c/i2c-core-base.c:2109
i2c_transfer+0x1d5/0x3d0 drivers/i2c/i2c-core-base.c:2170
i2cdev_ioctl_rdwr+0x393/0x660 drivers/i2c/i2c-dev.c:297
i2cdev_ioctl+0x75d/0x9f0 drivers/i2c/i2c-dev.c:458
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:870 [inline]
__se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd834a8bded

In az6027_i2c_xfer(), if msg[i].addr is 0x99,
a null-ptr-deref will caused when accessing msg[i].buf.
For msg[i].len is 0 and msg[i].buf is null.

Fix this by checking msg[i].len in az6027_i2c_xfer().

Fixes: 76f9a820c867 ("V4L/DVB: AZ6027: Initial import of the driver")
Link: https://lore.kernel.org/lkml/CAO4mrfcPHB5aQJO=mpqV+p8mPLNg-Fok0gw8gZ=zemAfMGTzMg@mail.gmail.com/
Reported-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
---
 drivers/media/usb/dvb-usb/az6027.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index cf15988dfb51..7d78ee09be5e 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -975,6 +975,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 		if (msg[i].addr == 0x99) {
 			req = 0xBE;
 			index = 0;
+			if (msg[i].len < 1) {
+				i = -EOPNOTSUPP;
+				break;
+			}
 			value = msg[i].buf[0] & 0x00ff;
 			length = 1;
 			az6027_usb_out_op(d, req, value, index, data, length);
-- 
2.25.1

