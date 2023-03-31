Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917916D18E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCaHqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCaHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A50412D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a44so3487028ljr.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoM5IcMFOlwAkgefBXvzdq63SNxS3h5z+T8L5WUCxbQ=;
        b=eWwksvi7bY0KdPMtgyCCYi0QRvj0uj6OuIt3slYMOQ37g7a/+rwy0JTpyRCPut3O7i
         SjIr6xxbm50xmmAD5NdfS/WekYRwiYefyFA9xlN3metimi6tSDOq3T+xWfQSBU/ZIxTE
         aucrn9tGeig0rFmBF5V16+e1c2V2Olmr5H6ALfbpx8uqtPYTNcs5AKFjC2SzKRevteif
         VS7GaJJ1L3M4vPL6ItjcMQvG4/Gfo8oUU3U0JwTU0ody6ka/GPQGcJeQzzjjHRpiJSjf
         5FbvW98MO3kTyraSi6XDnKDoM4PCI9SXZuQm5C6uXEOfzvr9623bf9HxA8LcuMkKi77P
         +vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoM5IcMFOlwAkgefBXvzdq63SNxS3h5z+T8L5WUCxbQ=;
        b=1oQPoHPHw/rzoFcNtk/88m4IFCO8JNBTTIdqOO4Lh5GW2mJLBihrw2kwzzKfal2631
         ma62SOij80kZODIdWOfZu8cYzlp3tS2o1fyMG9WKMFLwGtDnU8V++CorF7LarV6Fh0R1
         4w9mbbllqrcPDxeR9YkdX5OQnlehJR7RqD2SNYfyKc41isOz8S0nBmtPn7ZHTemRVEdz
         wUTkktsBxnrLCbRtG0NeRQjcqxcX4Qbxd6+8hJXC1Lrt3fas6wZsdxrYskVBaw5BFNhn
         RrOfOkoELK1+H6bWWnVLYg+vDgtZZA++qio133cyctOATN1dGiajYZ34A6IMtXZBWaYk
         mX8A==
X-Gm-Message-State: AAQBX9fRkOpvcmHGqwBWakOZnJwMU8whGSYWKgTICqdx1YsicMXXQAm4
        1fhlcgHxDxEneQju+5gO7ORhyg==
X-Google-Smtp-Source: AKy350ZvvmiQEQeJV0rJBPeHTPNfWqhIEkTZVdJomaf/QsxtJ4WB3dJCEvZpAAsVlcpNlFq6ICZ1gg==
X-Received: by 2002:a2e:918a:0:b0:298:ac88:8d51 with SMTP id f10-20020a2e918a000000b00298ac888d51mr8205985ljg.42.1680248774455;
        Fri, 31 Mar 2023 00:46:14 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:13 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 02/10] mtd: spi-nor: core: Update name and description of micron_st_nor_set_4byte_addr_mode
Date:   Fri, 31 Mar 2023 07:45:58 +0000
Message-Id: <20230331074606.3559258-3-tudor.ambarus@linaro.org>
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

Rename method to spi_nor_set_4byte_addr_mode_wren_en4b_ex4b and extend
its description. This method is described in JESD216 BFPT[SFDP_DWORD(16)],
BIT(30) and BIT(22).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c      | 7 ++++---
 drivers/mtd/spi-nor/core.h      | 3 ++-
 drivers/mtd/spi-nor/micron-st.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d104c81f22c5..07be81afdc33 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -539,15 +539,16 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 }
 
 /**
- * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
- * Micron flashes.
+ * spi_nor_set_4byte_addr_mode_wren_en4b_ex4b() - Set 4-byte address mode using
+ * SPINOR_OP_WREN followed by SPINOR_OP_EN4B or SPINOR_OP_EX4B. Typically used
+ * by ST and Micron flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d5cb42245820..d8e3fd60d6ee 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -648,7 +648,8 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
-int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
+					       bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_prep_and_lock(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3bbf65234ebd..a75f0f4e1c38 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -425,7 +425,7 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static void micron_st_nor_late_init(struct spi_nor *nor)
-- 
2.40.0.348.gf938b09366-goog

