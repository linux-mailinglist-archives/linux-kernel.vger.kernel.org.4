Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97277738ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjFUQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFUQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:20:15 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3F10CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:20:10 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0Yx-0016ia-Dk; Wed, 21 Jun 2023 17:20:07 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0Yx-001z4h-0Y;
        Wed, 21 Jun 2023 17:20:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 4/5] i3c: show error messages in of_i3c_master_add_i3c_boardinfo
Date:   Wed, 21 Jun 2023 17:20:04 +0100
Message-Id: <20230621162005.473049-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
References: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_i3c_master_add_i3c_boardinfo() fails, then there's no much to say
what the issue was (most of the error returns are -EINVAL), so add some
printing of the errors using dev_err() showing the node that failed and
what the issue was.

This should help with finding which device-tree node was causing the
issue and also mirrors the i2c case where it shows the node and the
error.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i3c/master.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index bc42669f5c6d..2a9ebb1d9d57 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2050,32 +2050,42 @@ of_i3c_master_add_i3c_boardinfo(struct i3c_master_controller *master,
 		return -ENOMEM;
 
 	if (reg[0]) {
-		if (reg[0] > I3C_MAX_ADDR)
+		if (reg[0] > I3C_MAX_ADDR) {
+			dev_err(dev, "%pOF: address too big\n", node);
 			return -EINVAL;
+		}
 
 		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
 							  reg[0]);
-		if (addrstatus != I3C_ADDR_SLOT_FREE)
+		if (addrstatus != I3C_ADDR_SLOT_FREE) {
+			dev_err(dev, "%pOF: slot in use\n", node);
 			return -EINVAL;
+		}
 	}
 
 	boardinfo->static_addr = reg[0];
 
 	if (!of_property_read_u32(node, "assigned-address", &init_dyn_addr)) {
-		if (init_dyn_addr > I3C_MAX_ADDR)
+		if (init_dyn_addr > I3C_MAX_ADDR) {
+			dev_err(dev, "%pOF: cannot assign address\n", node);
 			return -EINVAL;
+		}
 
 		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
 							  init_dyn_addr);
-		if (addrstatus != I3C_ADDR_SLOT_FREE)
+		if (addrstatus != I3C_ADDR_SLOT_FREE) {
+			dev_err(dev, "%pOF: slot in use\n", node);
 			return -EINVAL;
+		}
 	}
 
 	boardinfo->pid = ((u64)reg[1] << 32) | reg[2];
 
 	if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
-	    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
+	    I3C_PID_RND_LOWER_32BITS(boardinfo->pid)) {
+		dev_err(dev, "%pOF: bad PID\n", node);
 		return -EINVAL;
+	}
 
 	boardinfo->init_dyn_addr = init_dyn_addr;
 	boardinfo->of_node = of_node_get(node);
-- 
2.40.1

