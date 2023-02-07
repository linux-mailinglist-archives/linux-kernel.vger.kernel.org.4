Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7681368CFFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBGHAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjBGHAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:00:40 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4B37F1D;
        Mon,  6 Feb 2023 23:00:18 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1C056C0000EE;
        Mon,  6 Feb 2023 23:00:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1C056C0000EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753218;
        bh=h0//fydItnwV7NDFyqcw4F89N1pWP9gSxhy9x4rfWR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiFOXvadJPQAOt3besPaD0FeZPIM5l3FTJ503akCuavw8shStRQnOvWlSTHvfrJi8
         kMYfuj4mhHuLJWYgbv9PKklNj1IE5CYMplHSVUZYCxkaIkQqxJPxcRTnIQWHtVVvGL
         vLEbwNwoiaQPpi6KAgz6NnwbSJoCMlx9e07RSmGY=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 1A50D18041CAC6;
        Mon,  6 Feb 2023 23:00:18 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 72F64101B35; Mon,  6 Feb 2023 23:00:11 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] spi: export spi_transfer_cs_change_delay_exec function
Date:   Mon,  6 Feb 2023 22:58:19 -0800
Message-Id: <20230207065826.285013-9-william.zhang@broadcom.com>
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

For SPI controller that implements transfer_one_message, it needs to
insert the delay that required by cs change event between the transfers.
Add a wrapper for the local function _spi_transfer_cs_change_delay_exec
and export it for SPI controller driver to use.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

(no changes since v1)

 drivers/spi/spi.c       | 7 +++++++
 include/linux/spi/spi.h | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3cc7bb4d03de..00a176804378 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1484,6 +1484,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
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
index 9a32495fbb1f..19857ebb1d95 100644
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
@@ -263,8 +266,6 @@ static inline void *spi_get_drvdata(struct spi_device *spi)
 	return dev_get_drvdata(&spi->dev);
 }
 
-struct spi_message;
-
 /**
  * struct spi_driver - Host side "protocol" driver
  * @id_table: List of SPI devices supported by this driver
-- 
2.37.3

