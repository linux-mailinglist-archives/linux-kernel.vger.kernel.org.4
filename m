Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39071707C60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjERIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjERIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:54:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D11994
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:54:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f14468ef54so2116893e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684400086; x=1686992086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjAvVBk1hRLHZrA8OFaE6F4f4RtrYr9WV2xvjiGYmh4=;
        b=g32/8heJ3DktSiEENGsRXd/v01cczhkq4W1Yo5mCj/C2Ef4XQ3F8RBjeoC3Cm3DN8S
         7M/2xNp7FAvmxQ9FOwsLAQ801Rl13p7l+bPmWxjhWSofWnKJJ3RlBpOVsBp6BddReuYe
         OBgU9Ahs9LpQM2V0pui+DuCGk5FrCpA07QC1eBgCz8eQWG/FCFyQXMTkPMZzR9PjJWE6
         15dma5h07NttmZepJmV9ilnjYzDM4HmqK543iEqme5pbcZFchnMll0aV+zuPCO8drIv7
         u+8cRTckWZ3Qsddb3ZEtRBkclqOnus/KX6IqkIqNyes5kdUCnbi1GXgB5K6RLjc+i99A
         9Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684400086; x=1686992086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjAvVBk1hRLHZrA8OFaE6F4f4RtrYr9WV2xvjiGYmh4=;
        b=U1SPn3vYhj0TxV+geNgrfNjdSaauCFtvjJgvVseLwHTahXSwbD57S/rV9IVOEXuWfV
         qmyl/EnVAQMczCG+aMpQX63zp7xBkAg1uEPLJqXPqb5oj5Hv8IPTntL8hadO966SBYpO
         6SL5W1V+6J0KZr38dkewHSy5fnLBi4le7nuAbdAqAxcISW+Ibpl4yXFMjIWAYJYRZOO+
         D+reU60SIdjIYaNjqiADdJZ1WW6IG09muE77tnaRzPl6RLZVtozyEa1xK1/NrdJbQuuW
         YojFQsNdv6kySUtVQhet0A1z0u/s2KzF8x52Da3ei0H+R78PqXtHNytZ8OcLCyP9GNSp
         tvpg==
X-Gm-Message-State: AC+VfDxj3N2gljWKcfV6B33FWHVqZ1Y/loq+v75HFK+GitVcXyolRItf
        IppPD+1/A+qpiUcmTepnK9apFaJuHYlTToxTb5scPA==
X-Google-Smtp-Source: ACHHUZ66yUDz9VH5R8zAhzwAIypF9QSua+hRd28G08W56sm7WWljOyDQ3Gn2wHIXgoozj0EISiOr9w==
X-Received: by 2002:ac2:5dc2:0:b0:4f3:82aa:142d with SMTP id x2-20020ac25dc2000000b004f382aa142dmr1171051lfq.47.1684400086103;
        Thu, 18 May 2023 01:54:46 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id r4-20020a056512102400b004f24db9248dsm177513lfr.141.2023.05.18.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 01:54:45 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, todd.e.brandt@intel.com
Cc:     vigneshr@ti.com, pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        regressions@lists.linux.dev, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] mtd: spi-nor: Fix divide by zero for spi-nor-generic flashes
Date:   Thu, 18 May 2023 08:54:40 +0000
Message-ID: <20230518085440.2363676-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We failed to initialize n_banks for spi-nor-generic flashes, which
caused a devide by zero when computing the bank_size.

By default we consider that all chips have a single bank. Initialize
the default number of banks for spi-nor-generic flashes. Even if the
bug is fixed with this simple initialization, check the n_banks value
before dividing so that we make sure this kind of bug won't occur again
if some other struct instance is created uninitialized.

Suggested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217448
Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
Link: https://lore.kernel.org/all/20230516225108.29194-1-todd.e.brandt@intel.com/
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0bb0ad14a2fc..5f29fac8669a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 
 static const struct flash_info spi_nor_generic_flash = {
 	.name = "spi-nor-generic",
+	.n_banks = 1,
 	/*
 	 * JESD216 rev A doesn't specify the page size, therefore we need a
 	 * sane default.
@@ -2921,7 +2922,8 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
 
-	nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
+	if (nor->info->n_banks > 1)
+		params->bank_size = div64_u64(params->size, nor->info->n_banks);
 }
 
 /**
@@ -2987,6 +2989,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	/* Set SPI NOR sizes. */
 	params->writesize = 1;
 	params->size = (u64)info->sector_size * info->n_sectors;
+	params->bank_size = params->size;
 	params->page_size = info->page_size;
 
 	if (!(info->flags & SPI_NOR_NO_FR)) {
-- 
2.40.1.606.ga4b1b128d6-goog

