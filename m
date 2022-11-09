Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B67623477
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKIUYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1ABC27
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF4E61CAF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343CEC433D7;
        Wed,  9 Nov 2022 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668025440;
        bh=7+5jyTKDsBSnzUCypgmhEzafnQWwO3MDHgaXspdMOVI=;
        h=From:To:Cc:Subject:Date:From;
        b=T8ooVs2pwLN7kWzDt7NoDC1RaNGkZQxrFFi205GVftjQlo2Nioki0YrA+fcUEIahG
         VzQ1hUkw9QguGB37xPLlBVA0ntWVhfZhPLFLL7mkx7pT918QKQl53AtoVFFCGN1Yi6
         BnjWCN9s6g6CXcagFjozEsiHV8k1ZF4SazO3di3RuN8xmzuH199BiO78xtXzrmtJwt
         Z3nCmj1o9gxdDrMEK2PHSGjSn1IdA5ahBDr/sE1QWZCSqePni6scTKXAA6LOnS9aPp
         l9dxUsv19Fe/soI9y7iaeIx0b23ng9hP0lDEPdiyPH3Mi8Y6+V8zUWPM0soFBxp4t4
         dYcaSgmKNQrYA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, tudor.ambarus@microchip.com,
        pratyush@kernel.org, michael@walle.cc,
        linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: [PATCH] mtd: spi-nor: macronix: Add support for mx66u1g45g
Date:   Wed,  9 Nov 2022 14:23:47 -0600
Message-Id: <20221109202348.93666-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MX66U1G45G is the smaller sibling (128MB) of the MX66U2G45G (256MB)
that is already supported.

Tested on Intel N5X socdk board,
  - random data write, erase, read   - verified erase operations
  - random data write, read and compare  - verified write/read operations

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/mtd/spi-nor/macronix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..46ba898f3dd0 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -97,6 +97,10 @@ static const struct flash_info macronix_nor_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
+	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
+		PARSE_SFDP,
+		FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-- 
2.25.1

