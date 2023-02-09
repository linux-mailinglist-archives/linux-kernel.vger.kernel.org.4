Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA86911CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBIUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBIUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:04:29 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8765ACCE;
        Thu,  9 Feb 2023 12:04:20 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B3408C0000E6;
        Thu,  9 Feb 2023 12:04:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B3408C0000E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675973059;
        bh=LSc6gVvW76JeEdaqRanq1SO6TNyQn+Rx8s3TB2RHs+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4xjI1Xjl7GoqsvSX9mfpPDXvbmcVREZ+OPzPV+1lTdUT+w1cMYwRJYakcQrZU/Zr
         Orkxbv4vTQY5ps56xU5E/pTxUVjM+NsTftA3L2btWs57Hhp+sRoro86Pv+abtwTsnQ
         daey4sHS9RmRUixY5jyrIzYafp0SdAZF9h8XLyc4=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id B071A18041CAC7;
        Thu,  9 Feb 2023 12:04:19 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id EF725101B7B; Thu,  9 Feb 2023 12:04:12 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     f.fainelli@gmail.com, dregan@mail.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com, William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/15] spi: export spi_transfer_cs_change_delay_exec function
Date:   Thu,  9 Feb 2023 12:02:39 -0800
Message-Id: <20230209200246.141520-9-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230209200246.141520-1-william.zhang@broadcom.com>
References: <20230209200246.141520-1-william.zhang@broadcom.com>
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

For SPI controller that implements transfer_one_message, it needs to
insert the delay that required by cs change event between the transfers.
Add a wrapper for the local function _spi_transfer_cs_change_delay_exec
and export it for SPI controller driver to use.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v4:
- Rebase using the latest linux spi git for-next branch code

 drivers/spi/spi.c       | 7 +++++++
 include/linux/spi/spi.h | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 21a8c3a8eee4..f4eb447c565d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1483,6 +1483,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	}
 }
 
+void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
+						  struct spi_transfer *xfer)
+{
+	_spi_transfer_cs_change_delay(msg, xfer);
+}
+EXPORT_SYMBOL_GPL(spi_transfer_cs_change_delay_exec);
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9b23a1d0dd0d..88cb2a1390ce 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -26,6 +26,7 @@ struct spi_controller;
 struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
+struct spi_message;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -119,6 +120,8 @@ struct spi_delay {
 
 extern int spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer);
 extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
+extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
+						  struct spi_transfer *xfer);
 
 /**
  * struct spi_device - Controller side proxy for an SPI slave device
@@ -283,8 +286,6 @@ static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct gpio_d
 	spi->cs_gpiod = csgpiod;
 }
 
-struct spi_message;
-
 /**
  * struct spi_driver - Host side "protocol" driver
  * @id_table: List of SPI devices supported by this driver
-- 
2.37.3

