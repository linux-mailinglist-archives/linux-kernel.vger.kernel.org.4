Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AADD69DE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBULOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBULN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:13:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40501B773
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:13:56 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 27FDE3F586
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676978034;
        bh=ro4x+56p6k4eFwybCxILtCF2vhcwpYTnKWiQ2Fw4Iq4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QnwpGe9xRsZhbTFijauqOnXr8lefQT/X6BdUd9ANKN84M7HyMOF2bX8lx7W5HA/p6
         jENkP4kEHsDHzbVhHvdP27U+DuC3+H19rPRT/ir8gzfNMwVaHV5nTlJRMDTou9JNF9
         1Dm0/1IFIFI2V2kmVMTPvYJzLrl46Et71t0B4DCgkvyDB2IO7vD27rVdxmoLkwyZyx
         mI4fBCFeTFc15rzY9wVQWMC+yjoPblDuiVFpavEHIwY8pujWHEIOvmDOHSzNb4xdKK
         X8Sw7jrGOzAcYUFvBhEP+rPZnqTxV+V5hCXqVPpkJLZ3X1HYPb8EHcUDuz6JLq19Zo
         Xoj7yOTE5PsSA==
Received: by mail-ed1-f70.google.com with SMTP id dm14-20020a05640222ce00b0046790cd9082so5925753edb.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro4x+56p6k4eFwybCxILtCF2vhcwpYTnKWiQ2Fw4Iq4=;
        b=E2VCfuD7ZJ8Qae1NsLLN1a2h6K5RavQUNoDUKBP+7LEFitNYuPdgVf+k4de+ie7+3s
         ihOJFJT72Q/qjJhADaZ6XT60JgSkFA8zSVDy3b8CGa84v52wCrs2Y1dkDGoGX/uoizos
         Up8qRpdodvxdUEAKfvdQDSIFRx4Slc8p2jrTYCt14btVFas+1TRa0MvpHdZtn9D5/FfM
         0LtpC7RlFhQZwLDGET+PAAxgQaQsy3ZdZ4DY8tQkRItym9/f7lMn0GY6Lj4g4o7xubnI
         jDpT40YHdjD/5zHMTBKxZJ9bqZU264Ke23tb2z48BobiHF+Y9zsUBL0utxihAnugtL9l
         GJwQ==
X-Gm-Message-State: AO0yUKU21k+gTWXtdz1jU+2p0sO2+eCxZcKPugAGKtKxy48mPz/94uEM
        jeDL+IylD1G2GpWdvv63C8lVuGJMNTXkS6WJlOCO22SwtnLk9Lwp2m7rt3ed61iqMQtD9YILuPi
        Wmd9dIJ19zt2+cRR/0NqmWWtmy8rAbBt6kcaH9agNAg==
X-Received: by 2002:a17:907:c297:b0:8aa:6edf:2a9 with SMTP id tk23-20020a170907c29700b008aa6edf02a9mr13089948ejc.69.1676978033507;
        Tue, 21 Feb 2023 03:13:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9qGtS26yt0C3R8UVON9AwCXrJoOkhG6nyRf+nsk0tAcFExR5s6BvJMjzCmiEfCTQYQ1KHnCg==
X-Received: by 2002:a17:907:c297:b0:8aa:6edf:2a9 with SMTP id tk23-20020a170907c29700b008aa6edf02a9mr13089925ejc.69.1676978033219;
        Tue, 21 Feb 2023 03:13:53 -0800 (PST)
Received: from localhost.localdomain (host-79-44-179-55.retail.telecomitalia.it. [79.44.179.55])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709066bce00b008cff300cf47sm2804832ejs.72.2023.02.21.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:13:52 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: fix shift-out-of-bounds in spi_nor_set_erase_type()
Date:   Tue, 21 Feb 2023 12:13:46 +0100
Message-Id: <20230221111346.34268-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that according to JEDEC JESD216B Standard erase size needs to
be a power of 2, but sometimes we set the size to 0 (e.g., in
spi_nor_parse_4bait()) causing UBSAN warnings like the following:

  UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2026:24
  shift exponent 4294967295 is too large for 32-bit type 'int'
  Hardware name: Dell Inc. XPS 13 9300/077Y9N, BIOS 1.11.0 03/22/2022
  Call Trace:
   <TASK>
   show_stack+0x4e/0x61
   dump_stack_lvl+0x4a/0x6f
   dump_stack+0x10/0x18
   ubsan_epilogue+0x9/0x3a
   __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
   spi_nor_set_erase_type.cold+0x16/0x1e [spi_nor]
   spi_nor_parse_4bait+0x270/0x380 [spi_nor]
   spi_nor_parse_sfdp+0x47f/0x610 [spi_nor]

Fix by checking if size is a power when setting struct
spi_nor_erase_type, otherwise consider size, mask and shift as invalid.

Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories")
Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/mtd/spi-nor/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d67c926bca8b..3c5b5bf9cbd1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2019,11 +2019,17 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 void spi_nor_set_erase_type(struct spi_nor_erase_type *erase, u32 size,
 			    u8 opcode)
 {
-	erase->size = size;
 	erase->opcode = opcode;
 	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
-	erase->size_shift = ffs(erase->size) - 1;
-	erase->size_mask = (1 << erase->size_shift) - 1;
+	if (likely(is_power_of_2(size))) {
+		erase->size = size;
+		erase->size_shift = ffs(erase->size) - 1;
+		erase->size_mask = (1 << erase->size_shift) - 1;
+	} else {
+		erase->size = 0u;
+		erase->size_shift = ~0u;
+		erase->size_mask = ~0u;
+	}
 }
 
 /**
-- 
2.38.1

