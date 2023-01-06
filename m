Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E088660834
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjAFUV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjAFUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:20:55 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9345684620;
        Fri,  6 Jan 2023 12:19:53 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D5160C0000E2;
        Fri,  6 Jan 2023 12:09:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D5160C0000E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035794;
        bh=SvLodN4cQ6TEbn+PEQP+YZBLKZOuvyU97FI3sOksrF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjnHv1LEV8rVFlAGo9JwQxczlOuvzW/ybD7ZQ4by8uCkQham3Dj2vxv8adXm/aLVF
         ENZVCXrYP9pkTLNTxH3GlqKsir4ma60M+VBn4CWpSe4Bm6nuQk7qSU1NU8I0sqscoS
         giOhM1c7Ok/bFO4wn5ohRe6WVDhV0HAbdSrurcl8=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id D32F618041CAC6;
        Fri,  6 Jan 2023 12:09:54 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 2C07C101B33; Fri,  6 Jan 2023 12:09:48 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
Date:   Fri,  6 Jan 2023 12:07:58 -0800
Message-Id: <20230106200809.330769-7-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230106200809.330769-1-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
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

HSSPI controller uses big endian for the opcode in the message to the
controller ping pong buffer. Use cpu_to_be16 to properly handle the
endianness for both big and little endian host.

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 drivers/spi/spi-bcm63xx-hsspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index b871fd810d80..63682c8ff955 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -194,7 +194,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			tx += curr_step;
 		}
 
-		__raw_writew(opcode | curr_step, bs->fifo);
+		__raw_writew(cpu_to_be16(opcode | curr_step), bs->fifo);
 
 		/* enable interrupt */
 		__raw_writel(HSSPI_PINGx_CMD_DONE(0),
-- 
2.37.3

