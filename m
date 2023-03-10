Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3606B3A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCJJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCJJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:26:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3711567E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:21:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1paYwH-0002ig-3D; Fri, 10 Mar 2023 10:21:25 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1paYwG-0038yg-Bj; Fri, 10 Mar 2023 10:21:24 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1paYwF-004DqG-G4; Fri, 10 Mar 2023 10:21:23 +0100
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] spi: core: add spi_split_transfers_maxwords
Date:   Fri, 10 Mar 2023 10:20:52 +0100
Message-Id: <20230310092053.1006459-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spi_split_transfers_maxwords() function that splits
spi_transfers transparently into multiple transfers
that are below a given number of SPI words.

This function reuses most of its code from
spi_split_transfers_maxsize() and for transfers with
eight or less bits per word actually behaves the same.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 drivers/spi/spi.c       | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 44b85a8d47f1..165e4a286080 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3621,6 +3621,55 @@ int spi_split_transfers_maxsize(struct spi_controller *ctlr,
 }
 EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
 
+
+/**
+ * spi_split_transfers_maxwords - split spi transfers into multiple transfers
+ *                                when an individual transfer exceeds a
+ *                                certain number of SPI words
+ * @ctlr:     the @spi_controller for this transfer
+ * @msg:      the @spi_message to transform
+ * @maxwords: the number of words to limit each transfer to
+ * @gfp:      GFP allocation flags
+ *
+ * Return: status of transformation
+ */
+int spi_split_transfers_maxwords(struct spi_controller *ctlr,
+				 struct spi_message *msg,
+				 size_t maxwords,
+				 gfp_t gfp)
+{
+	struct spi_transfer *xfer;
+
+	/*
+	 * Iterate over the transfer_list,
+	 * but note that xfer is advanced to the last transfer inserted
+	 * to avoid checking sizes again unnecessarily (also xfer does
+	 * potentially belong to a different list by the time the
+	 * replacement has happened).
+	 */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		size_t maxsize;
+		int ret;
+
+		if (xfer->bits_per_word <= 8)
+			maxsize = maxwords;
+		else if (xfer->bits_per_word <= 16)
+			maxsize = 2 * maxwords;
+		else
+			maxsize = 4 * maxwords;
+
+		if (xfer->len > maxsize) {
+			ret = __spi_split_transfer_maxsize(ctlr, msg, &xfer,
+							   maxsize, gfp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_split_transfers_maxwords);
+
 /*-------------------------------------------------------------------------*/
 
 /* Core methods for SPI controller protocol drivers.  Some of the
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4fa26b9a3572..f8dff44d77e5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1295,6 +1295,10 @@ extern int spi_split_transfers_maxsize(struct spi_controller *ctlr,
 				       struct spi_message *msg,
 				       size_t maxsize,
 				       gfp_t gfp);
+extern int spi_split_transfers_maxwords(struct spi_controller *ctlr,
+					struct spi_message *msg,
+					size_t maxwords,
+					gfp_t gfp);
 
 /*---------------------------------------------------------------------------*/
 

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.30.2

