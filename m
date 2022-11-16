Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6D62B09D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKPBia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKPBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:38:24 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB942AC;
        Tue, 15 Nov 2022 17:38:23 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBlzr50s2z15MPB;
        Wed, 16 Nov 2022 09:38:00 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 09:38:21 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     <linux@roeck-us.net>, <wim@linux-watchdog.org>
CC:     <hucool.lihua@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>
Subject: [PATCH v2] watchdog: pcwd_usb: Fix attempting to access uninitialized memory
Date:   Wed, 16 Nov 2022 10:07:06 +0800
Message-ID: <20221116020706.70847-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115134213.GD4189373@roeck-us.net>
References: <20221115134213.GD4189373@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack variable msb and lsb may be used uninitialized in function
usb_pcwd_get_temperature and usb_pcwd_get_timeleft when usb card no response.

The build waring is:
drivers/watchdog/pcwd_usb.c:336:22: error: ‘lsb’ is used uninitialized in this function [-Werror=uninitialized]
  *temperature = (lsb * 9 / 5) + 32;
                  ~~~~^~~
drivers/watchdog/pcwd_usb.c:328:21: note: ‘lsb’ was declared here
  unsigned char msb, lsb;
                     ^~~
cc1: all warnings being treated as errors
scripts/Makefile.build:250: recipe for target 'drivers/watchdog/pcwd_usb.o' failed
make[3]: *** [drivers/watchdog/pcwd_usb.o] Error 1

Fixes: b7e04f8c61a4 ("mv watchdog tree under drivers")
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
---
v1 -> v2: just initialize lsb and msb with 0, but returning -EFAULT
---
 drivers/watchdog/pcwd_usb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 1bdaf17c1d38..8202f0a6b093 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -325,7 +325,8 @@ static int usb_pcwd_set_heartbeat(struct usb_pcwd_private *usb_pcwd, int t)
 static int usb_pcwd_get_temperature(struct usb_pcwd_private *usb_pcwd,
 							int *temperature)
 {
-	unsigned char msb, lsb;
+	unsigned char msb = 0x00;
+	unsigned char lsb = 0x00;
 
 	usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
 
@@ -341,7 +342,8 @@ static int usb_pcwd_get_temperature(struct usb_pcwd_private *usb_pcwd,
 static int usb_pcwd_get_timeleft(struct usb_pcwd_private *usb_pcwd,
 								int *time_left)
 {
-	unsigned char msb, lsb;
+	unsigned char msb = 0x00;
+	unsigned char lsb = 0x00;
 
 	/* Read the time that's left before rebooting */
 	/* Note: if the board is not yet armed then we will read 0xFFFF */
-- 
2.17.1

