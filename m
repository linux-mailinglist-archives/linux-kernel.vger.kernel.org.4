Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B76D18F5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCaHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCaHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C9F1B350
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 20so22177857lju.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcXZcEx2eHoNQSwUs7M5JpMhYFB2VWPVVcMYUPnoHZs=;
        b=fAQTJA4yiXJKR22sZnpyJp55Cbmo39ruuDQt/ifHXraID6hjnHAWydLebCsDFGp0RQ
         XmzY81Cl+sTaKK+5kJXrVHl8Qe3NRiN+edOAkaZQZGOznBNI0GTBdpx8RdojbAN/EABY
         hIuKD7OuCXnZ3DZjDWzAzEJzc376rWz7r/Z//97JO7vWme7+lV4+5V5/J5LDTOSzWyhL
         8SQ7fb1Yp3rqIBNwW0XVvS0HuNQii4wdAZIownfUCmcOABFlZ9g4B5LRQxpi+sq/EzXO
         92o25th8GGuW2k8416veMKdg2wFl70PUCf7xv26RLrPyDg4sxWkoiEvoQ2dPAQg3Ogwe
         8KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcXZcEx2eHoNQSwUs7M5JpMhYFB2VWPVVcMYUPnoHZs=;
        b=JyoCvxKiVixl3Umsli6lIlW80ircsgWrtJtN+6Da+71yL9jfv6Isa9Q7BYqgidcLLo
         ndbL3Tao0Zr1Bs97Q8OQKB9QdHRE5CehNUDxMvHc4VK7vyyrzsH02L8MveqXDhhgLBTx
         EL3UrHzGngAzYC5iXhco5Zw2Pwuwqc9PYgovj1A2AP9wmG0+v3IOwTxOydb7GO0riw/X
         iSDgpJO8RbiXrXolI4cf8naW9sFDDcwwQALZYkalSNJw0kCaFBiSYKTsnx+OxPSgk2Gv
         DVP/4d5Ms9JDjszX7afzjFOVzN+daFPhkIuR4Wpqq/qi3K9rsbUSzsIXLCoGD1bNp7Zi
         Upxw==
X-Gm-Message-State: AAQBX9ewrtdaA0RZ/3zTrBeEM1YS5aNKm9yj8khUkYRDrTqsZd9NhK7J
        e9j43/pfCaDBQYDoLm6PdOnA8g==
X-Google-Smtp-Source: AKy350YcfCQ/0BL7AU0CYA2k/XkYYE7mIAgMrX3aB/4nmGiGkNyK2nacuzwEX+L2RB8CFF+VZ6MPFw==
X-Received: by 2002:a2e:87c4:0:b0:2a6:1bd3:4f72 with SMTP id v4-20020a2e87c4000000b002a61bd34f72mr1301996ljj.0.1680248779942;
        Fri, 31 Mar 2023 00:46:19 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:19 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 09/10] mtd: spi-nor: core: Introduce spi_nor_set_4byte_addr_mode()
Date:   Fri, 31 Mar 2023 07:46:05 +0000
Message-Id: <20230331074606.3559258-10-tudor.ambarus@linaro.org>
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

Make the method public, as it will be used as a last resort to enable
4byte address mode when we can't determine the address mode at runtime.
Update the addr_nbytes and current address mode while exiting the 4byte
address mode too, as it may be used in the future by manufacturer
drivers. No functional change. spi_nor_restore didn't update the address
mode nbytes, but updating them now doesn't harm as the method is called
in the driver's remove and shutdown paths.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 35 ++++++++++++++++++++++++++++++-----
 drivers/mtd/spi-nor/core.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4f0d90d3dad5..c67369815fde 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3133,9 +3133,35 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->params->quad_enable(nor);
 }
 
-static int spi_nor_init(struct spi_nor *nor)
+/**
+ * spi_nor_set_4byte_addr_mode() - Set address mode.
+ * @nor:                pointer to a 'struct spi_nor'.
+ * @enable:             enable/disable 4 byte address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
+	int ret;
+
+	ret = params->set_4byte_addr_mode(nor, enable);
+	if (ret && ret != -ENOTSUPP)
+		return ret;
+
+	if (enable) {
+		params->addr_nbytes = 4;
+		params->addr_mode_nbytes = 4;
+	} else {
+		params->addr_nbytes = 3;
+		params->addr_mode_nbytes = 3;
+	}
+
+	return 0;
+}
+
+static int spi_nor_init(struct spi_nor *nor)
+{
 	int err;
 
 	err = spi_nor_octal_dtr_enable(nor, true);
@@ -3177,10 +3203,9 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		err = params->set_4byte_addr_mode(nor, true);
-		if (err && err != -ENOTSUPP)
+		err = spi_nor_set_4byte_addr_mode(nor, true);
+		if (err)
 			return err;
-		params->addr_mode_nbytes = 4;
 	}
 
 	return 0;
@@ -3299,7 +3324,7 @@ static void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET) {
-		ret = nor->params->set_4byte_addr_mode(nor, false);
+		ret = spi_nor_set_4byte_addr_mode(nor, false);
 		if (ret)
 			/*
 			 * Do not stop the execution in the hope that the flash
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8953ddeb8625..ea9033cb0a01 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -651,6 +651,7 @@ int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
 int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
 					       bool enable);
 int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_prep_and_lock(struct spi_nor *nor);
-- 
2.40.0.348.gf938b09366-goog

