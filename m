Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397566C4361
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCVGky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFD59E7C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y20so22080462lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onn7qzpEkAoSPCvz5HXi6C8mwJXx4hkbdPzDlnc9ItE=;
        b=pAABZrarHek863hg3GjsOPwFr4nfpKBBy0573hnYGg0V5rCZsduRAiguChBAceHph3
         NWqdeR4Wt807f2NBJk7UsVYYBKKIvWOh7sv2YTqbp6yoinKlWmqBQhbDASWnMI7US5vx
         Wni0GuLip4ZiJA9f+AHqecKmOTyY0xWnK3kyyBUXu8Ad4ysaQlmmF8SlqKCjDy9BMTLl
         5mECsjSb78wW4eLbPronCGSVt7z5/cLJ92+UwSs9hgReJzEj5QwmWiNHE7MKf67zFyeQ
         9UQKtIrPEq9O5jfDDeWp433V5JRDhTo+d924hi2e2v10GnAL3es474+YiJB/+o2Q1fqW
         +0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onn7qzpEkAoSPCvz5HXi6C8mwJXx4hkbdPzDlnc9ItE=;
        b=b4o3cTQyenIfuY4Z/XggcKW4lY+2l3xOAD3Mprz2PiEC5SWYVusMPJPNzqA8SiCYwd
         rg2VSF9xZBJ2ItH5WlTVlzpf472dzyeHnOCI589NWahczvvuNyU6ibjv4Xvg/AFHvE13
         ULCA6caXEV+TXalbXbYys+CNC+lrYP0QHAdZY8tzZXl7SEGT80yv5GDAgZ3g7BgViGuP
         fYgnwTht/tWeH6KpT6ej2yJF7s3cetLJ7VDkRZsSMb1gr+IuVRKotSDgz4tQ1L2Ua3+g
         wf7WSRrCdVRj/hQQX4uKEUSIpRJTyB95qdvMQgxL0zNUwDwvtr++6CPByMvm0MLyKwBe
         xouQ==
X-Gm-Message-State: AO0yUKVPq/JVG7rm3cjms1Q4oBS0rRYKLPmkMEGQOQezWlIZGhRcDNif
        PHG5Z04afbnKGwhRdQa2np1eHg==
X-Google-Smtp-Source: AK7set8WvTk1sxAAUY8QOewdfzC3II7UdJzeTUmibypMHp6nvVTMEbWr82rYaZExDxdvogSXvRDVog==
X-Received: by 2002:ac2:442a:0:b0:4e8:3f38:7d21 with SMTP id w10-20020ac2442a000000b004e83f387d21mr1684219lfl.28.1679467239953;
        Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 04/11] mtd: spi-nor: core: Update name and description of spi_nor_set_4byte_addr_mode
Date:   Wed, 22 Mar 2023 06:40:26 +0000
Message-Id: <20230322064033.2370483-5-tudor.ambarus@linaro.org>
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
index e80dcd87189b..d80366f8a7e9 100644
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
index 2fc08c26081f..7961b81262db 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -634,7 +634,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
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
2.40.0.rc1.284.g88254d51c5-goog

