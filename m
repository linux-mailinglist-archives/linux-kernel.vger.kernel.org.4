Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADB86C4360
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCVGkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCVGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3745532A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t11so22078050lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+znX5tPTNkGmk0JqPSC8AVns2+lpyBiaG5wqS+7IkU=;
        b=upBa8JoJB+dW1aq5RxiwsD3VkAe3BDxYlaWXFj12EKZi/U6P/pmFw4z0Wol2+Q3ONE
         GPeGTQMnf3Y1MOjSItUZk2NBpKmmMBo2+n1YkFo2w4bXZsYZdqnHMjGf9Dcgmpv4hPFe
         gtupyxjvFkaZIBDwMMRD72xYjvQwDRWy9zHNEMjmpTmVSnSnBcaxrbVUc+rCBfp55OCB
         I3Dse1PcyhPrSrksuBrQqbz696fAQk3wM9VsoMlkmZRqceeKZxIBvfF1juQuZUzoZSOY
         hVFFujtKuwZe9BTgR6ot58r3kOf4Jf4LA72DOjyWQllDyougtq+zi0PWEo676/YxJgqJ
         l8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+znX5tPTNkGmk0JqPSC8AVns2+lpyBiaG5wqS+7IkU=;
        b=ueflFq+cxK7e89Ed9wFU0bZ5TR7JDzeRkf/HZdovBsFiRqZvyqNWcwse+C3idWWEgX
         S5mg91FyEQDt7PmYXv2E66pEwgzEU3UPFnr84gTjXfrzifMKizpHi1/w2UcHYA/PFf5i
         eIfdflndejQg+WaXyG5j7Bm2hj9OrKxJjj83o4cyMcSQeVZmwpdNc6lVl7GULKRrrnkn
         zCzP8ZqbLPEepLOZ3l0F9wWmuwMRAr0k8kF05bL0ozi+BfSyV6F9Ad0i5QPMiLRwz+H6
         3W6KC0r+OUaVP4554soWAVI/biLIMIlsZRUg5g89ywXcSjoFE7pZlSV19Tt6vu1jjJbz
         Ik+g==
X-Gm-Message-State: AO0yUKUxHzTi/qM9InBYKEJ3DXQAb67TUt+xiodysQ5YT8WzxcWpBZ0M
        LsMT3l/dXGWmbPHCDWb0kOIenw==
X-Google-Smtp-Source: AK7set8Hp2tr7q5+wrvsbOObm6X3ICWNwQTG0szK8hhiPXxRRBMP8UDsjz0rg5nsIHz+J3PHlcoMfQ==
X-Received: by 2002:a05:6512:1285:b0:4e8:3cfe:98c7 with SMTP id u5-20020a056512128500b004e83cfe98c7mr337794lfs.4.1679467239263;
        Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:38 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 03/11] mtd: spi-nor: core: Update name and description of spansion_set_4byte_addr_mode
Date:   Wed, 22 Mar 2023 06:40:25 +0000
Message-Id: <20230322064033.2370483-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
index 2cb7425b3694..e80dcd87189b 100644
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
 
@@ -2599,7 +2604,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
+	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
-- 
2.40.0.rc1.284.g88254d51c5-goog

