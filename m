Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3B67A5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjAXWdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjAXWdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:19 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC824E529;
        Tue, 24 Jan 2023 14:33:05 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4A964C0000F2;
        Tue, 24 Jan 2023 14:33:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4A964C0000F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599585;
        bh=R9v3QNnFjnhJ+Q1VxNUecO321RU+3kqGA8Tpef+bMY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7jT862/iy/XlOUCWfMpqFsN0P9o2VF5Ff4cmyzNipZ/pt2Weskp3ZU/JlbSED/vh
         ePYbM9SQRitWXFN15KncZXKvPhd5feXy9c0RJpcDJ1ez+AcHjumMQHhHVNLDcjVu3+
         FSlR/wahcNVCe+FJTT2jWx5pEvdUu5HHSFyMRW8g=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 48F6D18041CAC6;
        Tue, 24 Jan 2023 14:33:05 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id A1981101B54; Tue, 24 Jan 2023 14:32:57 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
Date:   Tue, 24 Jan 2023 14:12:09 -0800
Message-Id: <20230124221218.341511-7-william.zhang@broadcom.com>
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

HSSPI controller uses big endian for the opcode in the message to the
controller ping pong buffer. Use cpu_to_be16 to properly handle the
endianness for both big and little endian host.

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v2:
- Fix build error for Alpha platform
Reported-by: kernel test robot <lkp@intel.com>

 drivers/spi/spi-bcm63xx-hsspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 01d5acad4a1b..a65a0ec67641 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -194,7 +194,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			tx += curr_step;
 		}
 
-		__raw_writew(opcode | curr_step, bs->fifo);
+		__raw_writew((u16)cpu_to_be16(opcode | curr_step), bs->fifo);
 
 		/* enable interrupt */
 		__raw_writel(HSSPI_PINGx_CMD_DONE(0),
-- 
2.37.3

