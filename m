Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6489067305A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjASE3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjASDop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:44:45 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF94CE6D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a184so507005pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=drqNP1ReL0LAnB1bXR9V1s7ICcasOudSRqe6jqMt2bM=;
        b=jhz4GeEfq2rJG0lS3kQfb8ybKtGLhxsf3/sS/JFBCdnblA9p9FcsvcqtZEEwgKMj9J
         7ES7Qc8JkiuiytYXVTJiQwLdSr9J1b187akn9hXZGaJa/7TzaiqsPuVcRvvIb5+7Llko
         UXEQWc+iKhSb+Lo8AgV4GDKiyEF7yd2k32fAt/OsZxPzh0a91XiyAgkd8hw8ReTx+OwJ
         4kYMWt68cCbDDXOSZJMoMPb83nHAuvh6MVVp2mLwELH1q0SlSC+o2E25r8NqyjbKcOAs
         VHGKYVoYHbDBvDs8kbHbdYvE6fE1I9aa9mZJwNO7yzF9eo+llio1CewxcNXNSAarHtHw
         66OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drqNP1ReL0LAnB1bXR9V1s7ICcasOudSRqe6jqMt2bM=;
        b=0v0tutX2F6rFWdwdzsHxO6XBznty9td5wl1zt0ozpX2JLqeMb5QD7cJcmsBSwrnEUi
         Px2WGnwYsiieo8MRqpLj/Ys0rNzS9ONoDwmZ60GtVT2YGbY6BZWtwxw1icqoWeCuxhju
         eH8s6VcCF6HReNVe8g9vER2fbH0zcCwqIP/H4yqmEJUyiE5/NqrceGL7rjbeKm4GEwgt
         n65RawtVQQiDgAJbsQNrhFCRNyAu+jnsB4A77PBYPADgtfA2zMnpNYkbtlsp9wEOXGjy
         dGFrrVEr6mohmZRjwQj35PjA5lliQSOwSvN8zFiVudE9hL+FmSpHrS0/TAlWzOf/frAE
         YJhA==
X-Gm-Message-State: AFqh2kqW9UaE+8K2NZLNbP0+V7rOr1wpX6KZV7MYXK/A2GD/1KDa91bi
        TO5AIjEiV5SAK5OH6RJ2O+hn6A==
X-Google-Smtp-Source: AMrXdXszMtARD3z90a13KzWB+2QBGITprh5mlaG6kwOXJXNaeKaXzZxRwmEaW7r5bJbjtw+ZptVFDw==
X-Received: by 2002:a62:4e0e:0:b0:588:94f3:f564 with SMTP id c14-20020a624e0e000000b0058894f3f564mr10247992pfb.30.1674099654921;
        Wed, 18 Jan 2023 19:40:54 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:54 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 10/15] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:39:13 -0800
Message-Id: <20230119033918.44117-11-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Rebase to linux-next 6.2.0-rc1

---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 676313e1bdad..e042781d3db5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -40,6 +40,7 @@
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
 #define CQSPI_SLOW_SRAM		BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -89,6 +90,7 @@ struct cqspi_st {
 	u32			pd_dev_id;
 	bool			wr_completion;
 	bool			slow_sram;
+	bool			apb_ahb_hazard;
 };
 
 struct cqspi_driver_platdata {
@@ -978,6 +980,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->wr_delay)
 		ndelay(cqspi->wr_delay);
 
+	/*
+	 * If a hazard exists between the APB and AHB interfaces, perform a
+	 * dummy readback from the controller to ensure synchronization.
+	 */
+	if (cqspi->apb_ahb_hazard)
+		readl(reg_base + CQSPI_REG_INDIRECTWR);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1700,6 +1709,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->wr_completion = false;
 		if (ddata->quirks & CQSPI_SLOW_SRAM)
 			cqspi->slow_sram = true;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1825,6 +1836,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata pensando_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1850,6 +1865,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,socfpga-qspi",
 		.data = &socfpga_qspi,
 	},
+	{
+		.compatible = "amd,pensando-elba-qspi",
+		.data = &pensando_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

