Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB08697A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBOLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBOLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:09:02 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB62914A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:08:55 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SFebpT64kwevESFebpYEea; Wed, 15 Feb 2023 12:08:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 15 Feb 2023 12:08:54 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: nand: mxic-ecc: Fix mxic_ecc_data_xfer_wait_for_completion() when irq is used
Date:   Wed, 15 Feb 2023 12:08:45 +0100
Message-Id: <beddbc374557e44ceec897e68c4a5d12764ddbb9.1676459308.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() and readl_poll_timeout() don't handle their
return value the same way.

wait_for_completion_timeout() returns 0 on time out (and >0 in all other
cases)
readl_poll_timeout() returns 0 on success and -ETIMEDOUT upon a timeout.

In order for the error handling path to work in both cases, the logic
against wait_for_completion_timeout() needs to be inverted.

Fixes: 48e6633a9fa2 ("mtd: nand: mxic-ecc: Add Macronix external ECC engine support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This is really spurious.
If I'm right, this means that it never worked!

Can any one with the hardware test?
---
 drivers/mtd/nand/ecc-mxic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index 8afdca731b87..6b487ffe2f2d 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -429,6 +429,7 @@ static int mxic_ecc_data_xfer_wait_for_completion(struct mxic_ecc_engine *mxic)
 		mxic_ecc_enable_int(mxic);
 		ret = wait_for_completion_timeout(&mxic->complete,
 						  msecs_to_jiffies(1000));
+		ret = ret ? 0 : -ETIMEDOUT;
 		mxic_ecc_disable_int(mxic);
 	} else {
 		ret = readl_poll_timeout(mxic->regs + INTRPT_STS, val,
-- 
2.34.1

