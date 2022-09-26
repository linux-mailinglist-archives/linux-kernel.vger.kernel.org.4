Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D835EA56A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiIZMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiIZL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:58:53 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A275D79ED6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:52:44 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28QATohO057043;
        Mon, 26 Sep 2022 18:29:50 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Sep
 2022 18:50:57 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 1/2] i3c: master: Free the old_dyn_addr when reattach.
Date:   Mon, 26 Sep 2022 18:51:44 +0800
Message-ID: <20220926105145.8145-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28QATohO057043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to free the old_dyn_addr when the caller want to
reattach the device to the different dynamic address. If the
old_dyn_addr is 0 the function will treat it as no old_dyn_addr is
reserved on the bus. Without the patch, when the driver reattach the i3c
device after setnewda the old_dyn_addr will be permanently occupied.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7850287dfe7a..6349ce0ce835 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1379,6 +1379,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
+		if (old_dyn_addr)
+			i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
+						     I3C_ADDR_SLOT_FREE);
 	}
 
 	if (master->ops->reattach_i3c_dev) {
-- 
2.25.1

