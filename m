Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38E6C4367
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCVGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCVGkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B784A59E6D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y20so22080649lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiEhw/MYHGHqYkcULW44qvOE1f5BKxwdN9TbdhHpk2k=;
        b=BBaAP+qofU6gmMoZlFnCXX5iuME7bAK/wwLkOJ2EcO8w35hd21eorA711U2+NkSE4S
         w+wQs0/U5LhpKGGHGuv4FfUpvh2uYVqm5ngOKU9v+dayckn9I6DTisjrE5a78OR3Q/hn
         RQ5nyrPPfAyKHcgqgdwK1/U3W1DPhw9Rw9oYPLS8SGX42riKBlsh8rbob3BvhBmuoQ9K
         mPaktuupbfiZ7Gbp5WDnswM1DTGpEVy/Agr7lceidC9nW5BKWMqiOdkSCFW3d/a7B4Qe
         Vgb5Bcl2DmLLsyxc6bfcvECAcAInt/jzF22HK6lSJ8UvtjFCg4oTo1Skdu1WmI19gjYK
         BRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiEhw/MYHGHqYkcULW44qvOE1f5BKxwdN9TbdhHpk2k=;
        b=K92eZjY26k/CzVBYASQUxqsDGUjsn/2F7c4uvDtU3VW6tdRIKWjBIFfd6IGolYtrPI
         prQYeOMk09HULvEwx/WktwhVLi/EA6bLt2r4Im1t0K+QlSF0hqiZBW5Mj4KwijmbDNCi
         uPfKa1Z894NYAE2YFewlvSKHc+UDHhGtYgk1QxVV8S6w+Bz1YOWIuXc/G+kJTVAAg+lG
         YNI226f4n+xRzKR754orSY6k8qw9l9p/Kv4lOQ7yeBPem48QNpnM/Km+4bI5IqdgB1Ac
         zkOFxxm4MS+KFfmOlPTgUWZDff6bv2fq7fUNlYMMdLq5VhHUYHV8/Pw+H4O3mTh4Ehll
         0uqQ==
X-Gm-Message-State: AO0yUKUI21ZdFXD5a2cEkiozi7Z/JJQHkoxLViWPcNxLU1Y7T6ImboVP
        wCMV8jCW8MJs3Co1uWkWoOaKlw==
X-Google-Smtp-Source: AK7set9mwp/p2VqPULgSXCe1sfhlNyAc9FbRP4BC0wGsaqvFqr85PMyc+ebH+CiHqgx0/P+pMV3taQ==
X-Received: by 2002:a19:5210:0:b0:4ea:d6c7:c897 with SMTP id m16-20020a195210000000b004ead6c7c897mr1608728lfb.31.1679467245271;
        Tue, 21 Mar 2023 23:40:45 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 10/11] mtd: spi-nor: core: Introduce spi_nor_set_4byte_addr_mode()
Date:   Wed, 22 Mar 2023 06:40:32 +0000
Message-Id: <20230322064033.2370483-11-tudor.ambarus@linaro.org>
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
index 868414017399..4b2a6697a192 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2767,9 +2767,35 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
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
@@ -2811,10 +2837,9 @@ static int spi_nor_init(struct spi_nor *nor)
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
@@ -2933,7 +2958,7 @@ static void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET) {
-		ret = nor->params->set_4byte_addr_mode(nor, false);
+		ret = spi_nor_set_4byte_addr_mode(nor, false);
 		if (ret)
 			/*
 			 * Do not stop the execution in the hope that the flash
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 394d251450f7..7152688d3985 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -638,6 +638,7 @@ int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
 int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
 					       bool enable);
 int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable);
+int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
-- 
2.40.0.rc1.284.g88254d51c5-goog

