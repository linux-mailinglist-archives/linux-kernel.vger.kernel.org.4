Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EE6D18E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCaHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCaHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D51A95C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j11so27759160lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vyY0YqKS1SLB05+MmKNy/QrEH8YuBL5xLp1nkmp3M0=;
        b=CCefbeXgqsEJBMHGQDT4yv5/UyPJoy/+zWC5qH5dvQGDNUsF6mMtXAz5wZiYkN5BQo
         MCWdl/GhEBk2ItYSonQc2Lp35kV9kAmogwuqZWYfVrC4OoF8+pPeiRPCV/qOutLflMyf
         CNj8daBkbeQObZrLDrEs/zYlfw3FrCvzJr0R33a7+Z7BiKilj4X3mYeHFKgm5mO71JIu
         ZGcOH32VIh3zW55zqkyMrsIn0kh8hmdg/6WE0kJZkQcCmowkFsdNJ4dVJX3yOKPs7If/
         wwpMlF9cge5OO+O6Daj2pHBWtsOaY+WRMzo8KOGlx8Vqo9cmgrznLeIlFdifPpdzpBYK
         r0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vyY0YqKS1SLB05+MmKNy/QrEH8YuBL5xLp1nkmp3M0=;
        b=7V4THt72qOzmcZGy37igwAX1p5NvnUwMW6sWKAOJiApiGhmpGx5BWRhJEIeVWQNDjU
         EQyuus71Z3zK19y+wLpHFSzYa2rCFKgkc8z5xuefsQsrBLhlLYphvcQMthwM7c5grQMK
         lV/kDqjXpk1+EZEvLYZbt8x9pJ8bgRQq/blffCaaF9MsJNNxDw0q3B+JvUXd1n3AfXDH
         Y52791I3BRGY75kdKtvP1Vi0XYgGLEzobjgFjxeYTX+nBoPLg7+RnLYSl8DgfGvjzP4z
         9DxHc3cecwqhrvQF2diFXXJ4IPFR56cqdGOMXXFn53o1ijnJhR9df4+IadlPzBB65Moa
         dvRg==
X-Gm-Message-State: AAQBX9c9ZNWtw7aCJEyfZssPgcKHH0Oy2IewMmKBIW76fvI0C7V9Ks/O
        hI06IoOvRnJLqvTHNlc5G1/jng==
X-Google-Smtp-Source: AKy350b4xxIBOgaXMB9NOFPWS1tARj7J6oK3qK1H7J7KhoMM8z2ZImNHVkPe7Cq0Z6so7UmQvFwV+A==
X-Received: by 2002:ac2:5699:0:b0:4e8:3bac:4e32 with SMTP id 25-20020ac25699000000b004e83bac4e32mr6767504lfr.53.1680248773602;
        Fri, 31 Mar 2023 00:46:13 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:13 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 01/10] mtd: spi-nor: core: Move generic method to core - micron_st_nor_set_4byte_addr_mode
Date:   Fri, 31 Mar 2023 07:45:57 +0000
Message-Id: <20230331074606.3559258-2-tudor.ambarus@linaro.org>
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

This method is described in JESD216 BFPT[SFDP_DWORD(16)], BIT(30) and
BIT(22). Move the method to core.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c      | 24 ++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h      |  1 +
 drivers/mtd/spi-nor/micron-st.c | 24 ------------------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9e6a0730cdb8..d104c81f22c5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -538,6 +538,30 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return ret;
 }
 
+/**
+ * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
+ * Micron flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_set_4byte_addr_mode(nor, enable);
+	if (ret)
+		return ret;
+
+	return spi_nor_write_disable(nor);
+}
+
 /**
  * spansion_set_4byte_addr_mode() - Set 4-byte address mode for Spansion
  * flashes.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index de31e430f77e..d5cb42245820 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -648,6 +648,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_prep_and_lock(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 7bb86df52f0b..3bbf65234ebd 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -301,30 +301,6 @@ static const struct flash_info st_nor_parts[] = {
 	{ "m25px80",    INFO(0x207114,  0, 64 * 1024, 16) },
 };
 
-/**
- * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
- * Micron flashes.
- * @nor:	pointer to 'struct spi_nor'.
- * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
- *		address mode.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
-{
-	int ret;
-
-	ret = spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret = spi_nor_set_4byte_addr_mode(nor, enable);
-	if (ret)
-		return ret;
-
-	return spi_nor_write_disable(nor);
-}
-
 /**
  * micron_st_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
-- 
2.40.0.348.gf938b09366-goog

