Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E832867A5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjAXWdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjAXWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:35 -0500
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797F5355E;
        Tue, 24 Jan 2023 14:33:11 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B429BC0000F1;
        Tue, 24 Jan 2023 14:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B429BC0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599590;
        bh=ZMcNyYfsZaAO6exRgOHHB5ZhDg4jeLeziD96VQjZ4vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsMHtHYWXQamk1DJWH9ya6bXgVAso5UeTT+XqTQOeVQEleQJMOa67xKyJk0PwuUsD
         PaLaMsx++xqsPvms58PXizwu5X5iijGQa4aTd+MzdgUiBbAmlRVqPdHf2AGLLVVFCS
         VWw6JuRfaWhmVNsuWfFV8MFiOICb7Iid+DCsuCTE=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 7E97418041CAC6;
        Tue, 24 Jan 2023 14:33:10 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 7C6F9101ACF; Tue, 24 Jan 2023 14:33:10 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] spi: bcm63xx-hsspi: Disable spi mem dual io
Date:   Tue, 24 Jan 2023 14:12:15 -0800
Message-Id: <20230124221218.341511-13-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124221218.341511-1-william.zhang@broadcom.com>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
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

Changes in v2:
- Remove the code that uses the deprecated flag use_cs_workaround
- Always disable dual io read ops as prepend is the default mode

 drivers/spi/spi-bcm63xx-hsspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 2a0bef943967..dd320fda7611 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/spi/spi-mem.h>
 #include <linux/reset.h>
 #include <linux/pm_runtime.h>
 
@@ -663,6 +664,23 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+static bool bcm63xx_hsspi_mem_supports_op(struct spi_mem *mem,
+			    const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	/* Controller doesn't support spi mem dual/quad read cmd in prepend mode */
+	if ((op->cmd.opcode == 0xbb) || (op->cmd.opcode == 0xeb))
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
@@ -760,6 +778,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	mutex_init(&bs->msg_mutex);
 	init_completion(&bs->done);
 
+	master->mem_ops = &bcm63xx_hsspi_mem_ops;
 	master->dev.of_node = dev->of_node;
 	if (!dev->of_node)
 		master->bus_num = HSSPI_BUS_NUM;
-- 
2.37.3

