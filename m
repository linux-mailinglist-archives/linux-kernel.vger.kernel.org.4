Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434526D18EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCaHql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCaHqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC001B34E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h9so22150970ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VskMtKqJo2Tm6jcABPqz9otpp15wXPXFPfERL76lmb8=;
        b=Elu0oDZbKYEaJk3BPLEWS5s8WTLK+AaaOOVyg0VGUguJTbOOn25MNKzUV3tCoWCCTT
         BiCRfHHRXXZZfUOACZrGAK/qaOzRs15WE+pgplX+7qZd9dAz9/KW7RTSEq99zR0Gp2x1
         DxqR6vFs5pY6d4hICY+TzZynuFIi5us7VYuUJ+I0V6rObnijrCZ+xO6O1skXCrc8zk7j
         CY/YPA+MFqglO4ThyH56V+xL3ZPK2fnHJND6e1XCMR/BDhrUWqJx6EB4VHdK4GlRkHbw
         3mdt1XI4rrMwBJCs61qe3pXW6gUTl1aQr6S1DLRxkrfqFLm5mb9Owc7LYEwPMqNlTF6T
         0GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VskMtKqJo2Tm6jcABPqz9otpp15wXPXFPfERL76lmb8=;
        b=0onBUBLdBTGmEqlNGUR+wzOBuOgKsgbMvk7NWqnSEIafLmOuQX/aFae3jIsfjOEMez
         xqg5aM5WOfpE0ys4mWZY3ABeJTextnkmuiUdxq3IDIdf7PtRPGVjq836wDP0t+JmghnA
         UtuC4OJrlawa7/H3h78xDO0TkP8nz3BlS0b2HJumGDqUbQSvY6JxLA9Q9PBJJzwwFCEy
         iQ08OrVeNpsHVBRB20updo1GuOa2rYjhh+023ifimanNqjQzwYjxxcLZiAOBanKMgQ06
         lyF6BtOvyvsvuEOnfDiwGIu08U9cNZ6++TDh2/cwytYVinmu2ynBdt/hT6R/bB0fPPhb
         pxkw==
X-Gm-Message-State: AAQBX9cCXJmwEan7Cg8+99RXC3O+UUoEb3EzUO3V+VQ1EQe+ruiXEu0m
        V3M5g9djH9DyhMzGYMBCJbYLIg==
X-Google-Smtp-Source: AKy350aAhXaohE8Hvyy3v/ekKM2Vs2P+IJ8jEz+Nt0k2TBTY5ykvbGfHN5gWB273oUVJ87tLm+i9Rg==
X-Received: by 2002:a2e:320a:0:b0:298:b03d:5715 with SMTP id y10-20020a2e320a000000b00298b03d5715mr8307472ljy.25.1680248775893;
        Fri, 31 Mar 2023 00:46:15 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:15 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 04/10] mtd: spi-nor: core: Update name and description of spi_nor_set_4byte_addr_mode
Date:   Fri, 31 Mar 2023 07:46:00 +0000
Message-Id: <20230331074606.3559258-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename method to spi_nor_set_4byte_addr_mode_en4b_ex4b and extend its
description. This method is described in JESD216 BFPT[SFDP_DWORD(16)],
BIT(31) and BIT(23).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c     | 8 +++++---
 drivers/mtd/spi-nor/core.h     | 2 +-
 drivers/mtd/spi-nor/macronix.c | 2 +-
 drivers/mtd/spi-nor/winbond.c  | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e8f6141c0ef6..4c9264e427ff 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -508,14 +508,16 @@ int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 }
 
 /**
- * spi_nor_set_4byte_addr_mode() - Enter/Exit 4-byte address mode.
+ * spi_nor_set_4byte_addr_mode_en4b_ex4b() - Enter/Exit 4-byte address mode
+ *			using SPINOR_OP_EN4B/SPINOR_OP_EX4B. Typically used by
+ *			Winbond and Macronix.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -556,7 +558,7 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
 	if (ret)
 		return ret;
 
-	ret = spi_nor_set_4byte_addr_mode(nor, enable);
+	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d8e3fd60d6ee..067945c10023 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -647,7 +647,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 			     const enum spi_nor_protocol proto);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
-int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
 int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
 					       bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 6853ec9ae65d..91a8fa7d4512 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -105,7 +105,7 @@ static const struct flash_info macronix_nor_parts[] = {
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
-	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ca39acf4112c..9cea241c204b 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -188,7 +188,7 @@ static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
-	ret = spi_nor_set_4byte_addr_mode(nor, enable);
+	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
 	if (ret || enable)
 		return ret;
 
-- 
2.40.0.348.gf938b09366-goog

