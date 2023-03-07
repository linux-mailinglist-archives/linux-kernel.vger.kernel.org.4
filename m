Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE466AF6A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjCGUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCGUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6F149BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7CD0B81A13
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EA2C4339E;
        Tue,  7 Mar 2023 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220607;
        bh=sx9Ska8GnWbf3HJSlVgv4lIynyLqn9kogPDu8a552jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HATc+3nZBgpYA7WxgcsLrrwNmWlMvHUUg0l8blmDSDPZMlvnW+Td0ZVFQJk+Bj0k8
         AhHpJZw7SDYavoRNPxGJEiXx+j2kTT3jMLN3kz1APKIcIwmEQ9lwbmmckGaJ9NnXk7
         ABwuO8G502gOeWuFDtWt12zFs0qMFc+HVEaQ107uRW1AOzg4IF5t3+gL/iVvi+yZ3N
         N9UOknTK1+HpIcBick8jlK4gP49QeYT5vE28RkRbNYrhtLTw8iMQzhgebFwB+EX8W1
         8HTVZbDsAX1Y1SsBd9CSIL1lQ2eab++Y404P4Sy8rHmwYRYL4bRWx0dvr7YVOcGsQT
         a8I8o8pzvnZLg==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] mailbox: mpfs: switch to txdone_poll
Date:   Tue,  7 Mar 2023 20:22:52 +0000
Message-Id: <20230307202257.1762151-3-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=conor.dooley@microchip.com; h=from:subject; bh=pqrvE31Z8S43X6j0wjeGX8SFR94cn2rhVr8RYJQR2+M=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4W2PxUvdBePK1wZ+ubiL2b7mqTsytN3p0iYqvNO9 Nx92Seoo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOZO4PhD5/qMzbTpXzH10w1 ratfY/Lr+atDlznLH8XkX5vhMSH/XibDH/5tjKUzDJ6e4N7QmMFyxMvcIC/sVNUxj1Mrei6kqGi ZcwMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The system controller on PolarFire SoC has no interrupt to signify that
the TX has been completed. The interrupt instead signals that a service
requested by the mailbox client has succeeded. If a service fails, there
will be no interrupt delivered.

Switch to polling the busy register to determine whether transmission
has completed.

Fixes: 83d7b1560810 ("mbox: add polarfire soc system controller mailbox")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index d37560e91116..e0e825bdbad9 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -79,6 +79,13 @@ static bool mpfs_mbox_busy(struct mpfs_mbox *mbox)
 	return status & SCB_STATUS_BUSY_MASK;
 }
 
+static bool mpfs_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
+
+	return !mpfs_mbox_busy(mbox);
+}
+
 static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 {
 	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
@@ -183,7 +190,6 @@ static irqreturn_t mpfs_mbox_inbox_isr(int irq, void *data)
 
 	mpfs_mbox_rx_data(chan);
 
-	mbox_chan_txdone(chan, 0);
 	return IRQ_HANDLED;
 }
 
@@ -213,6 +219,7 @@ static const struct mbox_chan_ops mpfs_mbox_ops = {
 	.send_data = mpfs_mbox_send_data,
 	.startup = mpfs_mbox_startup,
 	.shutdown = mpfs_mbox_shutdown,
+	.last_tx_done = mpfs_mbox_last_tx_done,
 };
 
 static int mpfs_mbox_probe(struct platform_device *pdev)
@@ -248,7 +255,8 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 	mbox->controller.num_chans = 1;
 	mbox->controller.chans = mbox->chans;
 	mbox->controller.ops = &mpfs_mbox_ops;
-	mbox->controller.txdone_irq = true;
+	mbox->controller.txdone_poll = true;
+	mbox->controller.txpoll_period = 10u;
 
 	ret = devm_mbox_controller_register(&pdev->dev, &mbox->controller);
 	if (ret) {
-- 
2.39.2

