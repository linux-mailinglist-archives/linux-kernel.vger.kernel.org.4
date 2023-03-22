Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500A06C435D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCVGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCVGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB659E6D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi9so22026321lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbdjw1RSh3TEpk/7p7usBCYi4BEXdtSILvnz97JipYc=;
        b=Sh9Cd9BbxyTKKZzOwojOx1zCCxqy5Farawal5XysHHeyLiixDg2zZEAvx3DSsuUTMT
         J5qsR9Xr7C2ELEZiaNIYPZfw23Cl/UUfuSYeX3550OtjgcVqPmgKZqWCbWJg60hgwaP+
         i4q5n2DW/5pcwGqnNzqQupXmMBIJVa5J8bFUV93th0Jg8iuIuzgKvFlbqEQ+ToEfn2a9
         Zv9m//fmuNrQkvSCbBY7l/l/g04xJDkUPmxX6Dc8lfA3MzfgT/EswH8ikyHm38REsuXs
         /wC+dvSlPGud69QrZqHXPIqDqR3CVPcq5AK7VhFT7jnPAoMMkVojT3041jY/jdY1mD7Z
         /xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbdjw1RSh3TEpk/7p7usBCYi4BEXdtSILvnz97JipYc=;
        b=7Km2hJApokNF/A62Ly5sgwDs4HMGeiON9kzOVaOSfVcrKuBlh+sayNqlAhuBZd6lYB
         3q/10QTezL96ywOxS9SPw9OSqGglG/iBbSVbmtgTkwsekjlRsIBlgtKvsl8QBpzyYfyW
         sa7dzWokLBONPNZN2+imYSnps5893PJuVybpPFvBYPXkGJ9UYXV9J9eCyLcwTmNXXfrR
         gZkjLg2HOS74Dlo5s8kNE/KBlAw2zzpWu6RI91TSH6hb4ZjGgEPYZJ86BL4ekADQOwAq
         WLy3B8UTjX6neTP0QwRC3jhERpumzfRK4K/Y9I/TMiD1d3vCBS2ZQZfJ9dfV+C2imtn0
         Lndg==
X-Gm-Message-State: AO0yUKXPFj8I42zaiugTlY7ZMcHI2cMmU3UVGbVL5UPBuOa59Tk4HY+5
        27srIh6F+pTdlryiOTADUWAt8Q==
X-Google-Smtp-Source: AK7set/H6+Aq8gAk3QEpJ20qjtugTm4sRtXWEgnVic14jRpmQYPYNbdlWkA3NFahwpLABQCB0Afl2A==
X-Received: by 2002:ac2:44d9:0:b0:4db:ee9:7684 with SMTP id d25-20020ac244d9000000b004db0ee97684mr1609008lfm.56.1679467238677;
        Tue, 21 Mar 2023 23:40:38 -0700 (PDT)
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
Subject: [PATCH v4 02/11] mtd: spi-nor: core: Update name and description of micron_st_nor_set_4byte_addr_mode
Date:   Wed, 22 Mar 2023 06:40:24 +0000
Message-Id: <20230322064033.2370483-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
index 8d246b1b439a..2cb7425b3694 100644
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
index aa44474c042a..2fc08c26081f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -635,7 +635,8 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
-int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
+					       bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
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
2.40.0.rc1.284.g88254d51c5-goog

