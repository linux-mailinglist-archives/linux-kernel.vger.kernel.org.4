Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64886FCE82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEITZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjEITZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:25:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DD268D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:25:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac81d2bfbcso67882401fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683660313; x=1686252313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8mwiEqJrqUKLjr+CTYZwgPnU7EpYWeys0Xhrb5/CYI=;
        b=NrSG6Zy5wwtEkL+Y3N0rFVqtodQL4ZNgPGFOhh/K0SWS41MfCfdDNJf5pk+BS1eAtC
         E3xuWLmd/6IZCQoaC8S140aUPtr3I8JtjOHi59AZ3sDRdFNZBmauG+jAbCB95tiAEFCm
         a3ZmYyUCbW9USPPgji0Ru+nJQNndC7qRMKGjK//AZ3dbNgH9uCIDJHDvs9QLlq9WREMI
         MWLJ2opAMKkQeVfB2QaJ7ZJkVkEAzWhWHRfXFqCSvSVUoOZs6w3lXYoInOtXym1IKJKy
         CUXfuFmKLFmeaSfOFGO+s4MglzDkREEkac6ypBBq4OkxLEQ1HMmFmre0Um/T0Pg+i1Yu
         TA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660313; x=1686252313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8mwiEqJrqUKLjr+CTYZwgPnU7EpYWeys0Xhrb5/CYI=;
        b=J6fW3UB4M2ehJqs3GU/TYGVQC6NxL0nnUvXg8AzBWroYMRe/lCizVvGG5VjoMiyu+z
         FixIzOdJ7WzTtCIOYphkOTagvItQvNczAJIn8cZLvKMVPLWmIr0GMiXgtFtMrFXc4aSy
         881RNzafgNiZJFTyMoLG+W3iAL+aDCiOkOxGHX0rxm13WavHVGyP81RxbnXZOufrUK5x
         91dXs12M/MqaaaWisbMf2NVQGjDiqHKxXSlUVvqjaGj+pxqjPbNY7iTW658/e1lsppqw
         9nrrEemIV6T6TNWwkf9uFI1u7/eVStqEXnj2sKtfK+E5yJOc5rKb9kjYKjf86OME2q5J
         lxTQ==
X-Gm-Message-State: AC+VfDy2drFbyK4W4uNAp1BNRr/lfER/PRDmkSTLVwjVdbkL1dy4jAgz
        Fz02zWdfzBf+gafmIRIjvdhuxw==
X-Google-Smtp-Source: ACHHUZ6zZgyh0wuaR1VlvC1ggGYZmX+KkqMgwByqSu+OQdCtGDpZb9QCFralrQ03BSjXYkOlcUaVag==
X-Received: by 2002:a2e:8190:0:b0:2ad:8ca0:dbeb with SMTP id e16-20020a2e8190000000b002ad8ca0dbebmr1116636ljg.18.1683660312756;
        Tue, 09 May 2023 12:25:12 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id 19-20020a05651c009300b002a6007383a0sm1681131ljq.135.2023.05.09.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:25:12 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     miquel.raynal@bootlin.com
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/2] mtd: spi-nor: spansion: make sure local struct does not contain garbage
Date:   Tue,  9 May 2023 19:25:06 +0000
Message-ID: <20230509192506.947094-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230509192506.947094-1-tudor.ambarus@linaro.org>
References: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <20230509192506.947094-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following error was seen with um-x86_64-gcc12/um-allyesconfig:
+ /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27

Set the spi_mem_op fields at the time of declaration so that all
uninitialized members be initialized to default value.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 6afcc84080c41 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index d44ffaac1dba..257d05ed4146 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -492,7 +492,10 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 			  const struct sfdp_parameter_header *bfpt_header,
 			  const struct sfdp_bfpt *bfpt)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op =
+		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_ARCFN, 1,
+					  nor->bouncebuf);
 	int ret;
 
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
@@ -500,10 +503,6 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 		return ret;
 
 	/* Read Architecture Configuration Register (ARCFN) */
-	op = (struct spi_mem_op)
-		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_ARCFN, 1,
-					  nor->bouncebuf);
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
 	if (ret)
 		return ret;
-- 
2.40.1.521.gf1e218fcd8-goog

