Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8A46C435E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVGko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0F5504C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x17so22068363lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlGRV4Vhjc5QjOFgeSLcd0kZILFPjn08+TF/cmBPkFY=;
        b=uCKZa9QeBxerqrIsMoSQJ6uqAnomCynjZFwSl6qEn4TFlAEjxOPbHVrJB7E0BkwkTx
         SXiuYJCPdb89tZrSpddToqvKlV7M9biNNoTmfIIfiysX6PDTK6RgMj8IR821PiCndIeh
         V/MKInlsxlM3klGQKHXOBuH78FiYRdDxdaBgLTh/JjXDhug7nNmIh4UabesZkBtEQNXF
         oFZrCJteY8SDzfZQWVMeOUQ51rfeLvY3FDRe8QBZPsKL9JyvIwABfa0x0eCkVA+D/eSL
         K3XBdNI3USnjqXe5SRvKWHTEU6c3uJviMNSALz23RONNIjw9XZzrgmc+o+X4xm27vf2O
         1l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlGRV4Vhjc5QjOFgeSLcd0kZILFPjn08+TF/cmBPkFY=;
        b=Cg3ZKmssu8uZR69eV9VUHMjPXs1P8gEg8SkUJuYDmwxJzt2XT6GpgYGBOqomNzZQXd
         4KFiTmcM2BrT0e/JMssGOwehLBzXiMFYDSrioB9n5jAl5JLSUoxahAeqYCO5NQzwqz0W
         GWF/iLWTHiiXHEI+Aml+X0oNX+JBmVlJPxrZNQtxOIbFYuUTHf4hJZqsJkky8PKXrpWi
         13bQj3bQeJ/bA7QOocoDwefKLyFk/gAo4Gbd4iglbSfLGxpJMJJRpsA+Lu4Z7ifNMWyh
         DTpxTYtOiCfx9THADeLl7qQG/QMVddMvVx+6xQeizqTPcAfOc3q2FrOTZT+TTID6AtB+
         MFdg==
X-Gm-Message-State: AAQBX9czzK12y/L8huSQa7RKf6Ho0Lm3vgTCmYbwT/3KtMtIzmrM2ORA
        CCaTxNjpduZgNW6hPchbLNt8ng==
X-Google-Smtp-Source: AK7set/gJMXStUd+2nNEyzeYJ/hzFyEM8ObZQirw/aRa36i7qRDdFoYiAf7/P5XnmOpjKyZIf1YtLw==
X-Received: by 2002:ac2:48aa:0:b0:4d5:c96f:f7c7 with SMTP id u10-20020ac248aa000000b004d5c96ff7c7mr1606305lfg.23.1679467238091;
        Tue, 21 Mar 2023 23:40:38 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:37 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 01/11] mtd: spi-nor: core: Move generic method to core - micron_st_nor_set_4byte_addr_mode
Date:   Wed, 22 Mar 2023 06:40:23 +0000
Message-Id: <20230322064033.2370483-2-tudor.ambarus@linaro.org>
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

This method is described in JESD216 BFPT[SFDP_DWORD(16)], BIT(30) and
BIT(22). Move the method to core.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c      | 24 ++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h      |  1 +
 drivers/mtd/spi-nor/micron-st.c | 24 ------------------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0a78045ca1d9..8d246b1b439a 100644
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
index 25423225c29d..aa44474c042a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -635,6 +635,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
+int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
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
2.40.0.rc1.284.g88254d51c5-goog

