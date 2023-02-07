Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918F568D006
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBGHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjBGHBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:01:53 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82A3756C;
        Mon,  6 Feb 2023 23:01:20 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A4067C0000EE;
        Mon,  6 Feb 2023 23:00:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A4067C0000EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753256;
        bh=YqTnMvUmm6mN9pglAR9q3l9V8OmrxxcY/uGC906lOlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAQ4yVoRZVR3gShVQr4aVgZlxGhQJJYiUTzqFK905XPsy7/52adT/Hx/iYleO9LN6
         Ny3itapq/QdpTLGdLeMcWTLoDdvaTDZDY4g1kayZqrFlrVS5sNKEFqyr4GmEdncgRs
         i1E4kKwh+OdxAMINvo2tKgF6C7YJP2yB1F5HxSOU=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id A264318041CAC6;
        Mon,  6 Feb 2023 23:00:56 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id EA7EA101B41; Mon,  6 Feb 2023 23:00:49 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
Date:   Mon,  6 Feb 2023 22:58:24 -0800
Message-Id: <20230207065826.285013-14-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general the controller supports SPI dual mode operation but the
particular SPI flash dual io read op switches from single mode in cmd
phase to dual mode in address and data phase. This is not compatible
with prepend operation where cmd and address are sent out through the
prepend buffer and they must use same the number of io pins.

This patch disables these SPI flash dual io read ops through the mem_ops
supports_op interface. This makes sure the SPI flash driver selects the
compatible read ops at run time.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v3:
- Replace hard-coded opcode with SPINOR_OP definition

Changes in v2:
- Remove the code that uses the deprecated flag use_cs_workaround
- Always disable dual io read ops as prepend is the default mode

 drivers/spi/spi-bcm63xx-hsspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 6a289deb5848..1e9e906d297c 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -20,6 +20,8 @@
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/reset.h>
 #include <linux/pm_runtime.h>
 
@@ -682,6 +684,26 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+static bool bcm63xx_hsspi_mem_supports_op(struct spi_mem *mem,
+			    const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	/* Controller doesn't support spi mem dual io mode */
+	if ((op->cmd.opcode == SPINOR_OP_READ_1_2_2) ||
+		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_4B) ||
+		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_DTR) ||
+		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_DTR_4B))
+		return false;
+
+	return true;
+}
+
+static const struct spi_controller_mem_ops bcm63xx_hsspi_mem_ops = {
+	.supports_op = bcm63xx_hsspi_mem_supports_op,
+};
+
 static irqreturn_t bcm63xx_hsspi_interrupt(int irq, void *dev_id)
 {
 	struct bcm63xx_hsspi *bs = (struct bcm63xx_hsspi *)dev_id;
@@ -779,6 +801,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	mutex_init(&bs->msg_mutex);
 	init_completion(&bs->done);
 
+	master->mem_ops = &bcm63xx_hsspi_mem_ops;
 	master->dev.of_node = dev->of_node;
 	if (!dev->of_node)
 		master->bus_num = HSSPI_BUS_NUM;
-- 
2.37.3

