Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD26C4364
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCVGlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCVGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9C5BC83
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so22046534lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CqzcpXczhyO/MskUeS2f3sX+qT4MR1so+/9l/YtqFc=;
        b=FBY/smWUsRVvtCRBAfu8tQadv6JK++O9TapE/YI0DuNHxOCWLhDs9GYPplwqqpsBN5
         zVkmNEZr7JO0NIFOnoRkM+/kA0/flpg7UlxvUyezgLe69esU9lgSuei0bOORS9cW03t1
         8O8XnEfpk2qVI3bQiPy4QJnSZXgQ7q7V1jXrcR+WhYuWOVcQLkiKD56DbPzvluSBTO92
         RHlyaPq42jgfy73Onu8iS27AINcP82/5iYD/pTUwGROob5gLLEgz1EGBXIjz90Z8JoJt
         yYfsDmgzPJoGKQj6sLskGF4mSscx1fjW8OZHqHrIpN6RDcuSMlS503Hd+hGOEiuI/eL2
         TutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CqzcpXczhyO/MskUeS2f3sX+qT4MR1so+/9l/YtqFc=;
        b=si/OrXoYGV6g0JOBdhTN80TEjOCaw1lCEUQ4QowNtGVidtbqKQM1KGw/gE5m0/WR4/
         P8HrW7yd854SDEo87xUN45RmCjSR1/oGYcryyKZVRESnyP5xPE1vuOL89/1w77Wmjp+u
         lXOXp+7JueaNeC0lIIlVbB3xe0SOP0Lj0FJGAd8o09TlYNCVRnad4Ts68XN3KE+RPK0m
         NcGphwX/VqRQJl58BlxyqjFUEIDtZVaQCJ8ZLj4MBKZJFMUx9aa2vpDLVdEOck4yt4X/
         2jHnew3WdsONppzSxF7ss23hII2XpXSTDIuQnqFtjdCVOvYtl8ykbF3ZQpdD4v3seLtb
         sogA==
X-Gm-Message-State: AO0yUKXTo+Nfo4GNjz1M7Ji9f4bYXuDb1WU1gX/eofXiVjYxtqI6cvYe
        F9571yq2ntGBECiKTKXF/jUNzgzK2Bw95egJBW4D7g==
X-Google-Smtp-Source: AK7set+T+BKSGh6wjzTT0l/3oupZc6kAm36EV9dKkOOpmKKNSV807apEePn3kBnZaY/cn0m5+R86Lg==
X-Received: by 2002:a05:6512:3751:b0:4a4:68b9:19e7 with SMTP id a17-20020a056512375100b004a468b919e7mr1642583lfs.15.1679467242589;
        Tue, 21 Mar 2023 23:40:42 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:41 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v4 07/11] mtd: spi-nor: Favor the BFPT-parsed set_4byte_addr_mode method
Date:   Wed, 22 Mar 2023 06:40:29 +0000
Message-Id: <20230322064033.2370483-8-tudor.ambarus@linaro.org>
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

JESD216 SFDP defines in the BFPT standard methods to enter and exit the
4-Byte Address Mode. The flash parameters and settings that are retrieved
from SFDP have higher precedence than the static initialized ones, because
they should be more accurate and less error prone than those initialized
statically. Favor the BFPT-parsed set_4byte_addr_mode method and use the
generic core methods where possible.
This patch may introduce regressions in case BFPT contains wrong data. The
fix is to introduce a post_bfpt() fixup hook and update the wrong BFPT
data.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c      | 7 ++++++-
 drivers/mtd/spi-nor/macronix.c  | 8 +++++++-
 drivers/mtd/spi-nor/micron-st.c | 6 ++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e212cc3c630d..2a08f8de97fa 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2533,6 +2533,8 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
  */
 static void spi_nor_late_init_params(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->late_init)
 		nor->manufacturer->fixups->late_init(nor);
@@ -2540,6 +2542,10 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->info->fixups && nor->info->fixups->late_init)
 		nor->info->fixups->late_init(nor);
 
+	/* Default method kept for backward compatibility. */
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+
 	spi_nor_init_flags(nor);
 	spi_nor_init_fixup_flags(nor);
 
@@ -2606,7 +2612,6 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 91a8fa7d4512..075a26945f2d 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -105,11 +105,17 @@ static const struct flash_info macronix_nor_parts[] = {
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
-	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+}
+
+static void macronix_nor_late_init(struct spi_nor *nor)
+{
+	if (!nor->params->set_4byte_addr_mode)
+		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
 	.default_init = macronix_nor_default_init,
+	.late_init = macronix_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_macronix = {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index a75f0f4e1c38..4d5333b14807 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -425,13 +425,15 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static void micron_st_nor_late_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+
 	if (nor->info->mfr_flags & USE_FSR)
-		nor->params->ready = micron_st_nor_ready;
+		params->ready = micron_st_nor_ready;
+	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups micron_st_nor_fixups = {
-- 
2.40.0.rc1.284.g88254d51c5-goog

