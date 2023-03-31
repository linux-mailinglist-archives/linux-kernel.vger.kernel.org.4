Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04876D18EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCaHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCaHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99351A442
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g19so14675948lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pMraFU/tPRiVpv9JeCuToE/iyKjmq4cdy7RBmS30j8=;
        b=a2xc6P3BIbU9HViqxC5luoJqe1Z5BNokKvWSvidpmBZQN5PNJhVz3uxhS4mrWBLcpg
         hef4LAuCVpK8v/EBNUUMDskjn01qaaAJ1nIhSRWQTYo4IOAmY5lMLmNe98tDHkWfIlMs
         oPcADQLgvvqQwX3XhD6G4mFy+L/9CaaLvpUEmbr8RUVaGZ7UTw3tZ9q6vfMjVtgUE7um
         1m7mTbjJUbmYyu/i46Ys1VUVzZzfg85pc/nUjZxux1XulbTJl06No2LT2LJIXbond1jO
         t9sOIpwsVQudNbF5FAr8rpk1YWaBTB0zaZKEEHAqOHZzG8ZMm2pV3L6WxF9Kx28ffJYy
         GaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pMraFU/tPRiVpv9JeCuToE/iyKjmq4cdy7RBmS30j8=;
        b=j/EDGytm0q63yCB/uEMQX8jhEk9LJ6FPbP8o5LNFsERHi2klmz0dFPa6bn2slHysZ/
         yHFwsli1qlGio94D0zH61bwdSBOr3b9/elo9vw3VePIajrUI3+Z3eVSwjUDkog9+3n3J
         7ySpEFkTfuB+EdZM5odtmc8kv3350aAxUaRDn1Lfg8WwlpiBPb/C3PDp37QHzbPMTDg9
         qs9XikMaK2WbC0Gp5Rij3Y8h5GKqADdUF/SfG+e8dkb4qu41YgklBJg6rx9Om28iGOWI
         p3hQ4mwffEihcH/t5v7NwcnhFEklTp0WsLLZtOncYl8sFdc7edhBsfIcyf5LTPSpaSsS
         X+7A==
X-Gm-Message-State: AAQBX9ftNjFAJ0WndWcBvEUADaCvJ1UuowyAX7wArFurabkNYNBzSgCr
        4f+Ut2lfUt9D8qPIXZzQlxcf5mQyxtxEHHDyaZGeIg==
X-Google-Smtp-Source: AKy350bGAI8Dt1/8LPSgMhIVrpvYp0Y5IEXcym6m0mizAvSfJXRcOZFguoi74BWJ/MBVXaYwXCP2Ww==
X-Received: by 2002:a19:c20a:0:b0:4a4:68b9:60ae with SMTP id l10-20020a19c20a000000b004a468b960aemr8189955lfc.57.1680248775241;
        Fri, 31 Mar 2023 00:46:15 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:14 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 03/10] mtd: spi-nor: core: Update name and description of spansion_set_4byte_addr_mode
Date:   Fri, 31 Mar 2023 07:45:59 +0000
Message-Id: <20230331074606.3559258-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename method to spi_nor_set_4byte_addr_mode_brwr and extend its
description. This method is described in JESD216 BFPT[SFDP_DWORD(16)],
BIT(28) and BIT(20).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 07be81afdc33..e8f6141c0ef6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -564,15 +564,20 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
 }
 
 /**
- * spansion_set_4byte_addr_mode() - Set 4-byte address mode for Spansion
- * flashes.
+ * spi_nor_set_4byte_addr_mode_brwr() - Set 4-byte address mode using
+ *			SPINOR_OP_BRWR. Typically used by Spansion flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
+ * 8-bit volatile bank register used to define A[30:A24] bits. MSB (bit[7]) is
+ * used to enable/disable 4-byte address mode. When MSB is set to ‘1’, 4-byte
+ * address mode is active and A[30:24] bits are don’t care. Write instruction is
+ * SPINOR_OP_BRWR(17h) with 1 byte of data.
+ *
  * Return: 0 on success, -errno otherwise.
  */
-static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+static int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -2964,7 +2969,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
+	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
-- 
2.40.0.348.gf938b09366-goog

