Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5B66A282
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjAMTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjAMTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:00:18 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7192660CE5;
        Fri, 13 Jan 2023 11:00:07 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 4FBFBE0F1B;
        Fri, 13 Jan 2023 22:00:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=un4iekTAGShKOgiEqknkF/bWRTvm2tqOhETsV7qQ9zQ=; b=MY9qAJB7oyPY
        y4dm2goANNmsf1VV4dDHzjj3CFPROgnbRPs30XVYFQFFe/rj7zGRqngcle8Eqn/S
        k+ED6LjYJII9Poo+aTAaWnZqccv8/8cLlgH7137W1z+ZrF+/atSBzhr/fYmQTEbE
        AsToHw/NbzIg8Ndg2otBkha6DWtkyXk=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 35029E0F19;
        Fri, 13 Jan 2023 22:00:06 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 22:00:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] spi: dw: Fix wrong FIFO level setting for long xfers
Date:   Fri, 13 Jan 2023 21:59:42 +0300
Message-ID: <20230113185942.2516-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to using the u16 type in the min_t() macros the SPI transfer length
will be cast to word before participating in the conditional statement
implied by the macro. Thus if the transfer length is greater than 64KB the
Tx/Rx FIFO threshold level value will be determined by the leftover of the
truncated after the type-case length. In the worst case it will cause the
dramatical performance drop due to the "Tx FIFO Empty" or "Rx FIFO Full"
interrupts triggered on each xfer word sent/received to/from the bus.

The problem can be easily fixed by specifying the unsigned int type in the
min_t() macros thus preventing the possible data loss.

Fixes: ea11370fffdf ("spi: dw: get TX level without an additional variable")
Reported-by: Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Use min_t(unisgned int, ...) macros instead of just min(). (@Andy)
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 99edddf9958b..c3bfb6c84cab 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -366,7 +366,7 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 	 * will be adjusted at the final stage of the IRQ-based SPI transfer
 	 * execution so not to lose the leftover of the incoming data.
 	 */
-	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
+	level = min_t(unsigned int, dws->fifo_len / 2, dws->tx_len);
 	dw_writel(dws, DW_SPI_TXFTLR, level);
 	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
 
-- 
2.39.0


