Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4E6B7364
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCMKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCMKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:02:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F44BB91
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:02:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c4so7272618pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678701720;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXANLhq6tckZDSNAl3pWRue83VDgkmFiya0dDV01Ibo=;
        b=XRni4sVh7rqm2rybFgmG9ehCEYEnMYqE+BXMDbp2mU7pVa0dEYRg0sT/XGlT4eRPZb
         GnXLT6aBaZtcLL8nbyR0/ivuhI1sipTsDJx2NuFE5gs2WsMaoE0SxFb0Nx9dvZeuq6jp
         XvyWWzNkYg+E2tE9qEVfXSCGnr8f3WoFDy4yFMcMRQEihgNqCQ68yM8365ucU6nmHPY5
         NVEc3bO7JRz2hNWqEPomJT2YYcNFSXHkSxMgsbgHrxh2z7o8gcKQxPbhxrF70CM35qVn
         l3eP6jG4TrHZjPNdnKAQpwCXpT4kjyXgLjRYDAr0TqynYUe1P8sJJZ4ONDhpD1ZCIETK
         QgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678701720;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXANLhq6tckZDSNAl3pWRue83VDgkmFiya0dDV01Ibo=;
        b=z71Zw13nM+ffTm1eAIaQJKINLVU3bTiSmCcMtPrWUCa//2L/IH6npDyk/VmHk0HcHM
         JdWncjBRxLHz7kTHQaxVzkRX9GwP4kTer4fPSvygFbM43It/rqZ/07zMgzAKKh81Gv+H
         S82B/TBYwa9PYNrU5g7TlipL/xZ/DVMq8HvXvckeE4wQcaC3UzP6Vp66FMcxWl1No3X1
         wPgpfFGYw5ZctcmIY8a5VzNq8zcgiSMmBaMa7PYvEzbEtuYBHLqbEaAc8M+9NRBrhKiI
         YxYF+iw1CHYd25q79fydE7Z/VWdBtmJVUg/8Zo2yBbmpfZ3sp6Nm3OnwLAyHlRLvpGkb
         kLzQ==
X-Gm-Message-State: AO0yUKWOOFBMO70aIBbI5BGJOe4GyX0jGCRsEBXtuxqAgbChiFm/aIWt
        SqAWHQXxmwz239SbOgoYwFE=
X-Google-Smtp-Source: AK7set9JU6LMjZ8hjZh9RFDjRA+WSzb36HL8/YMo6u4+aIvEPBbT8dTFzipt8L+GY1OTCK1iQMinGA==
X-Received: by 2002:aa7:951b:0:b0:623:4d92:82af with SMTP id b27-20020aa7951b000000b006234d9282afmr3955447pfp.31.1678701719972;
        Mon, 13 Mar 2023 03:01:59 -0700 (PDT)
Received: from nvidia.nvidia.com (nat-hk.nvidia.com. [203.18.50.4])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0062505afff9fsm963294pfn.126.2023.03.13.03.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 03:01:59 -0700 (PDT)
From:   Luke He <sixuerain@gmail.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     sixuerain@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Add support for XMC XM25QH256C / XM25QU256C / XM25QH512C / XM25QU512C site: https://www.xmcwh.com/site/product#
Date:   Mon, 13 Mar 2023 18:01:53 +0800
Message-Id: <20230313100153.15441-1-sixuerain@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luke He <sixuerain@gmail.com>
---
 drivers/mtd/spi-nor/xmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 051411e86339..6db01b80237f 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -16,6 +16,18 @@ static const struct flash_info xmc_nor_parts[] = {
 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) }
 };
 
 const struct spi_nor_manufacturer spi_nor_xmc = {
-- 
2.17.1

