Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5E5EA568
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiIZMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiIZL6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:58:49 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41CC58DD6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:52:41 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28QATomF057044;
        Mon, 26 Sep 2022 18:29:50 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Sep
 2022 18:50:57 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/2] i3c: master: Remove the wrong place of reattach.
Date:   Mon, 26 Sep 2022 18:51:45 +0800
Message-ID: <20220926105145.8145-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926105145.8145-1-billy_tsai@aspeedtech.com>
References: <20220926105145.8145-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28QATomF057044
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reattach should be used when an I3C device has its address changed.
But the modified place in this patch doesn't have the address changed of
the newdev. This wrong reattach will reserve the same address slot twice
and return unexpected -EBUSY when the bus find the duplicate device with
diffent dynamic address.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6349ce0ce835..351c81a929a6 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1911,10 +1911,6 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 		i3c_master_free_i3c_dev(olddev);
 	}
 
-	ret = i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
-	if (ret)
-		goto err_detach_dev;
-
 	/*
 	 * Depending on our previous state, the expected dynamic address might
 	 * differ:
-- 
2.25.1

