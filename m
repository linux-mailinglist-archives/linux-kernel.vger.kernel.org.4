Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB785BED01
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiITSsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiITSsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:48:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF747436D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:48:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b5so5941585wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sYGkRYa3l7UDhvpu09qUEbAPCdOAg7Sh9qulo+MPJsg=;
        b=RhEADarMcfwqx06RJ5pKHOLDpARgUmLEibIOuaPmPrmtHeGpNQb8+bpiW6fDW0LlqY
         ByvGg4YAL/NTG5nQQM2bDGEMh26Js9cw10ws0aK7w2ShLXyG2Ke8E5/XpoYq3R7qLjY1
         uW2nzhKZY7q7gNsBxwCZR+jSk7dQ1lssroYMmB5FKVyaPPWd/EMAU0Hf9uzSqRLqhbGp
         ONLmc3V63ZX8QOt7kshON/KuHkvp2vSWkrHt2nvJPknbmvMabA7xOCOfbeugb3k6SYgz
         4oOfutXiAl3nJUnQ5Kzm6Y2g3116T1QzfGprD9cmXj279vtlaELjbpfIC+NcUIpajUkM
         VtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sYGkRYa3l7UDhvpu09qUEbAPCdOAg7Sh9qulo+MPJsg=;
        b=HSS0q1d3VOhKFGMBZzJNKdhFwPgpKvR1XfZPa1JR2LJVoqsxFYAi7vFr//Ae9aA/DQ
         CwrvdJdD9W7fRW6zK5nC//xcNcTfrQi66nJVPSKs98R6SsE1w1M44F2rslMFb2bigT7Y
         XhRYxaxfrWPBvFtHS9t0aHWUdsmEV6MK/Vgsxyp/bU3YX7zUJlk094kE1b9VXDOMOlSM
         HqQKf3a6jcwCOcr/lTUE+lKrl+feH7HJrIdxtkWls9ZCXnj3bu3UXe/bNCHny3CVSmri
         M/htRz7Uh8xpWDBjZfXwQY3AN7lWnRnfX+GIeIooHc9OIJlovqGO7tt9FxL53SmlwF2S
         99rA==
X-Gm-Message-State: ACrzQf0RSXb8z4cR6ayW8kffX2fL+4j3Kq0aPcn1we2zEoDO9+H5FcFg
        mMsrPc/hdYrn2V0TifwJriIZuA==
X-Google-Smtp-Source: AMsMyM7pa5QdD4ZmGPKkW3ltpbqJyuLGw/cLMDy6S75S+Zi8DkGzecVEEWssv0F0yB4mdO8A6QmlOA==
X-Received: by 2002:adf:f80b:0:b0:228:dbb9:5bdf with SMTP id s11-20020adff80b000000b00228dbb95bdfmr14987846wrp.327.1663699690940;
        Tue, 20 Sep 2022 11:48:10 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003b4c40378casm469974wmj.39.2022.09.20.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:48:10 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v3 2/2] mtd: spi-nor: add SFDP fixups for Quad Page Program
Date:   Tue, 20 Sep 2022 19:48:08 +0100
Message-Id: <20220920184808.44876-2-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SFDP table of some flash chips do not advertise support of Quad Input
Page Program even though it has support. Use flags and add hardware
cap for these chips.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---

Change from v2: SPI_NOR_QUAD_PP added to info->flags instead of
info->fixup_flags.
Link: https://lore.kernel.org/lkml/498c33a8-014f-e542-f143-cba5760fafdd@microchip.com/

Results from the tests given by Tudor in the following mail.

 drivers/mtd/spi-nor/core.c | 6 ++++++
 drivers/mtd/spi-nor/core.h | 2 ++
 drivers/mtd/spi-nor/issi.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d75..992fb332514d8 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2474,6 +2474,12 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
+
+	if (nor->info->flags & SPI_NOR_QUAD_PP) {
+		nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+		spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_1_1_4],
+					SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
+	}
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 85b0cf254e974..c2334fe33e2f9 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -458,6 +458,7 @@ struct spi_nor_fixups {
  *   SPI_NOR_NO_ERASE:        no erase command needed.
  *   NO_CHIP_ERASE:           chip does not support chip erase.
  *   SPI_NOR_NO_FR:           can't do fastread.
+ *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
@@ -507,6 +508,7 @@ struct flash_info {
 #define SPI_NOR_NO_ERASE		BIT(6)
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
+#define SPI_NOR_QUAD_PP			BIT(9)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 8b48459b5054c..014cd9038bedc 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -73,6 +73,7 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
 		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		FLAGS(SPI_NOR_QUAD_PP)
 		.fixups = &is25lp256_fixups },
 
 	/* PMC */
-- 
2.30.2

