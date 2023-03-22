Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FFC6C4362
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCVGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCVGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A85504C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g17so22067897lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxz/5hnL2T7rNNpiPeZo7eIaeTKEHB7uXS6/jbC9PHU=;
        b=v+kPJMRJo1rQREWsNHIc9ZOfW9W4JUMXNoruq6ACxJ+y8XA1x0Ij4qJb7WVc0AtjCL
         yODyRwyU9PJKa3DShgHmzxs2t46D9W3SuVIb/ipRi754mWES3fu71jG8gpELb4lBZrNj
         mfs7Xt21ETj+Kgek445U2ysnqWzq9YbmypaiCc0SPhf8S6D1kkXVSbRJqjCey831Cvsj
         nniXhNZ7vMLe70dnsm+tJqWIQzlLylsFo4zuu9rlijzs9CH9K+l4kgebVSuNpsF4NVWm
         EZ8OR7gD6e/xofa7RWD5k5KBwWFEVOKQegdcgS93MimKFWyq/xkCSavYJZQTuWtKPfNy
         Ftrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxz/5hnL2T7rNNpiPeZo7eIaeTKEHB7uXS6/jbC9PHU=;
        b=mhLgpw5A4ZBWhse91lrxDoBkLMrlFoc/R3xwzK0FZNBM+hx76oSM98Yd32kdKLLAyn
         ov68P2ubJcPTscYBy/pEta8yzXIrCiO308nZyjV0b2OEKJLO02DkZ0PzfpiSFYYuqMGF
         NZwZny44LWp/5KKpDb+4ptkZMiBeSTrkELWTrQH5xtHvvS2mR4WngULCtQQ7vQdS2GVf
         WbJCOdIUjjFsrurLuV2ILjBervMG+3M9GjImu8yFH5XfhcWVb7eS2D0ALWGUtjv5ju34
         K77jhThur8vSnp7IdGKbODBI8BwqcwZqkRpmN2mAV+IJu+zHh8E75LgiwmPSUBf8Q9Ao
         54xg==
X-Gm-Message-State: AO0yUKXk1BXEgiUogn0DCQJjeCYR6is42VdewStnBMm4M1CufyjA/M36
        caJ3b+3YlH2qmmr2gaVd1ux2bw==
X-Google-Smtp-Source: AK7set/4hxkITfYD5g8YTDG4mtdd/X3KLEWegGCwXWTJigSb1WfNYd725qkEj86RzXzmzo1Ec/rcwA==
X-Received: by 2002:ac2:434e:0:b0:4d5:8dd8:75f9 with SMTP id o14-20020ac2434e000000b004d58dd875f9mr1763398lfl.24.1679467240702;
        Tue, 21 Mar 2023 23:40:40 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:40 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 05/11] mtd: spi-nor: core: Make spi_nor_set_4byte_addr_mode_brwr public
Date:   Wed, 22 Mar 2023 06:40:27 +0000
Message-Id: <20230322064033.2370483-6-tudor.ambarus@linaro.org>
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

This method can be retrieved at BFPT parsing time. The method is
described in JESD216 BFPT[SFDP_DWORD(16)], BIT(28) and BIT(20).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d80366f8a7e9..e212cc3c630d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -579,7 +579,7 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
+int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 7961b81262db..394d251450f7 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -637,6 +637,7 @@ int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
 int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
 					       bool enable);
+int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
-- 
2.40.0.rc1.284.g88254d51c5-goog

