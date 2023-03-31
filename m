Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF86D18EC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCaHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCaHqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E921A964
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c29so27811084lfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9Da587yD3PbmNzuxHtISgYGF/c0UcFhpnI3XbozKYY=;
        b=WhIeT8yZ1o/ma+upJnPbKC6jjyndWr1Ue5kWJNwBwKCjyWbvGEeCs9c1isnCfUWXbo
         ik1rsQyVrAl3P3CeWG12vErnNGjWnmydHmntxh5euiXiIFA4GCTTQt+39UbeRFa3yyIK
         WCGwByscPFXVujWHZrezChIos/u/HDXINpuz/NSktS4FRmsYbSg4gPowhzZRuMPI7EfI
         1p+N9x4Gap83fwS0JdgdLyjK7EPMthPjGHtpEMFrYcvKHOEHjZWSPUmhDvHbSyt0ZFIt
         kV1iIFj888cJSCrIVKBmDPWC1qs1E3rvFt7wWyq+I5K6zexUil7gi3L66+cuykDw/9Na
         IrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9Da587yD3PbmNzuxHtISgYGF/c0UcFhpnI3XbozKYY=;
        b=pnCawlU4VqYfqdfrnBoVCWRJPtNfTaQTc1fKa3Ui/3Ml9X2twsQwa6gSPce9u5QjWy
         Gr0ws4bfHxqkZVTr57ZLNvGlyPELeGHDujCDHTMKYhna5uqCsMYrbZSZyp+FOEyPVgJP
         4+Y+gzGqDNb2X55p7IEhnR/SRZHIzB5HPBMFamMpJeFc30Rw24JWphR4CjGZCCZFx+PG
         PqrD6kORyAGL7A/2rvjoGP9yP4Tmt0Dj9ZtQZ6ct+Yt4UbcIHWa8J6K2P0pDtW9WQ0SF
         0Xymr75SWiscXc8QRsp88DJ7wl7zcYRX+8XtiMlvFYBTvJsOjx6tIao0e4JEeK/nyCKR
         LMaA==
X-Gm-Message-State: AAQBX9e946tS8d0GSS080Kfu+E5jhiVJ++SJTczflrSO+rHihlJG7uCi
        Ipz3r6GxWBAikv7MRhJ5QYwjIw==
X-Google-Smtp-Source: AKy350YJLEL832UqMybhUSYSx+FATBh6zndVnXbgwbG39t6H/inKwVnOuDFfIzBwqmKGJlN13Ag7xg==
X-Received: by 2002:ac2:57d0:0:b0:4e9:ad85:aa09 with SMTP id k16-20020ac257d0000000b004e9ad85aa09mr7356576lfo.68.1680248776742;
        Fri, 31 Mar 2023 00:46:16 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:16 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 05/10] mtd: spi-nor: core: Make spi_nor_set_4byte_addr_mode_brwr public
Date:   Fri, 31 Mar 2023 07:46:01 +0000
Message-Id: <20230331074606.3559258-6-tudor.ambarus@linaro.org>
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

This method can be retrieved at BFPT parsing time. The method is
described in JESD216 BFPT[SFDP_DWORD(16)], BIT(28) and BIT(20).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4c9264e427ff..75d28224ec62 100644
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
index 067945c10023..8953ddeb8625 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -650,6 +650,7 @@ int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
 int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
 					       bool enable);
+int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_prep_and_lock(struct spi_nor *nor);
-- 
2.40.0.348.gf938b09366-goog

