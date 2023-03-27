Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFF6CACBC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC0SIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjC0SI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:08:26 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282C30FC;
        Mon, 27 Mar 2023 11:08:23 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RAAhJd020748;
        Mon, 27 Mar 2023 11:08:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=dSTe5tKyUDPYYE43T/TCzSl40TipFrMRqxFOWDoEKEs=;
 b=UjJIZtCr63Ez1yDuF+/V7Ug0ai19hx1jEpirZA5Rtm9MUhGHBYJlomUnbUhbTeULMxQZ
 fJe5VeylOWAzCllX7Cdt3tXrUvKDMe2AAMx6YhfEQF/hbsbVlOG3u62YRSpUxkyv7ihM
 03PvDq6YQfTa3DAdYRWX64Y/s9PlG9pUrLeKLLmkDL5CtuE9TcmSS1/9BOWERqPqjhb2
 SIBw+1wU7hiEijk7+2bRnn4xiS0uZqBQ0nFDMu25h45XEU637ymcEJGitfNQwoT5CkZT
 6QVYVuCK7u/jhhFuJgDBkmxMuJtYyH8vOlMA9D9CGf8wG/PTLb4dFchgFji/t+/EvXpR sA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3phxas85uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:08:21 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Mar
 2023 11:08:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 27 Mar 2023 11:08:19 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id A23635B6921;
        Mon, 27 Mar 2023 11:08:19 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 2/2] spi: octeontx2: Add ACPI support
Date:   Mon, 27 Mar 2023 11:07:53 -0700
Message-ID: <20230327180753.2279-3-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327180753.2279-1-pmalgujar@marvell.com>
References: <20230327180753.2279-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xZ5BkSUKDRp8zA7NLhknLqMlIyIxz6US
X-Proofpoint-ORIG-GUID: xZ5BkSUKDRp8zA7NLhknLqMlIyIxz6US
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ACPI support for SPI controller on Marvell Octeontx2 SOC. This
supports reading the tx(rx)-bus-width from ACPI table which is used to
set the SPI mode - DUAL, QUAD, OCTAL.

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-octeontx2.c | 117 +++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-octeontx2.c b/drivers/spi/spi-octeontx2.c
index 80d9355d119de5486a1a3803f798dd0673b0adf1..31a08b4e574f6f391336852ad0e90f84d63de51a 100644
--- a/drivers/spi/spi-octeontx2.c
+++ b/drivers/spi/spi-octeontx2.c
@@ -5,11 +5,16 @@
  * Copyright (C) 2018 Marvell International Ltd.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
+#ifdef CONFIG_ACPI
+#include <linux/spi/spi-mem.h>
+#endif
 
 #include "spi-octeontx2.h"
 
@@ -227,6 +232,73 @@ int octeontx2_spi_transfer_one_message(struct spi_master *master,
 	return status;
 }
 
+#ifdef CONFIG_ACPI
+
+static bool octeontx2_spi_supports_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	const union acpi_object *obj;
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&spi->dev);
+
+	if (!acpi_dev_get_property(adev, "spi-tx-bus-width", ACPI_TYPE_INTEGER,
+				   &obj)) {
+		switch (obj->integer.value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_TX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_TX_QUAD;
+			break;
+		case 8:
+			spi->mode |= SPI_TX_OCTAL;
+			break;
+		default:
+			dev_warn(&spi->dev,
+				 "spi-tx-bus-width %lld not supported\n",
+				 obj->integer.value);
+			break;
+		}
+	}
+
+	if (!acpi_dev_get_property(adev, "spi-rx-bus-width", ACPI_TYPE_INTEGER,
+				   &obj)) {
+		switch (obj->integer.value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_RX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_RX_QUAD;
+			break;
+		case 8:
+			spi->mode |= SPI_RX_OCTAL;
+			break;
+		default:
+			dev_warn(&spi->dev,
+				 "spi-rx-bus-width %lld not supported\n",
+				 obj->integer.value);
+			break;
+		}
+	}
+
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	return true;
+}
+
+static const struct spi_controller_mem_ops octeontx2_spi_mem_ops = {
+	.supports_op = octeontx2_spi_supports_op,
+};
+
+#endif
+
 static int octeontx2_spi_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *ent)
 {
@@ -235,6 +307,7 @@ static int octeontx2_spi_probe(struct pci_dev *pdev,
 	struct octeontx2_spi *p;
 	union mpix_sts mpi_sts;
 	int ret = -ENOENT;
+	bool has_acpi;
 
 	/* may need to hunt for devtree entry */
 	if (!pdev->dev.of_node) {
@@ -248,6 +321,8 @@ static int octeontx2_spi_probe(struct pci_dev *pdev,
 		of_node_put(np);
 	}
 
+	has_acpi = has_acpi_companion(dev);
+
 	master = spi_alloc_master(dev, sizeof(struct octeontx2_spi));
 	if (!master) {
 		ret = -ENOMEM;
@@ -280,20 +355,26 @@ static int octeontx2_spi_probe(struct pci_dev *pdev,
 	mpi_sts.u64 = readq(p->register_base + OCTEONTX2_SPI_STS(p));
 	p->rcvd_present = mpi_sts.u64 & 0x4 ? true : false;
 
-	p->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		p->clk = devm_clk_get(dev, "sclk");
-		p->sys_freq = 0;
+	if (!has_acpi) {
+		p->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(p->clk)) {
+			p->clk = devm_clk_get(dev, "sclk");
+			p->sys_freq = 0;
+		} else {
+			ret = clk_prepare_enable(p->clk);
+			if (!ret)
+				p->sys_freq = clk_get_rate(p->clk);
+		}
+
+		if (!p->sys_freq)
+			p->sys_freq = SYS_FREQ_DEFAULT;
+		if (tbi_clk_en)
+			p->sys_freq = TBI_FREQ;
 	} else {
-		ret = clk_prepare_enable(p->clk);
-		if (!ret)
-			p->sys_freq = clk_get_rate(p->clk);
+		device_property_read_u32(dev, "sclk", &p->sys_freq);
+		if (!p->sys_freq)
+			p->sys_freq = TBI_FREQ;
 	}
-
-	if (!p->sys_freq)
-		p->sys_freq = SYS_FREQ_DEFAULT;
-	if (tbi_clk_en)
-		p->sys_freq = TBI_FREQ;
 	dev_info(dev, "Reference clock is %u\n", p->sys_freq);
 
 	master->num_chipselect = 4;
@@ -305,6 +386,10 @@ static int octeontx2_spi_probe(struct pci_dev *pdev,
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->max_speed_hz = OCTEONTX2_SPI_MAX_CLOCK_HZ;
 	master->dev.of_node = pdev->dev.of_node;
+	master->dev.fwnode = pdev->dev.fwnode;
+	#ifdef CONFIG_ACPI
+		master->mem_ops = &octeontx2_spi_mem_ops;
+	#endif
 
 	pci_set_drvdata(pdev, master);
 
@@ -315,7 +400,8 @@ static int octeontx2_spi_probe(struct pci_dev *pdev,
 	return 0;
 
 error_disable:
-	clk_disable_unprepare(p->clk);
+	if (!has_acpi)
+		clk_disable_unprepare(p->clk);
 error_put:
 	spi_master_put(master);
 error:
@@ -327,10 +413,13 @@ static void octeontx2_spi_remove(struct pci_dev *pdev)
 	struct spi_master *master = pci_get_drvdata(pdev);
 	struct octeontx2_spi *p;
 
+	bool has_acpi = has_acpi_companion(&pdev->dev);
+
 	p = spi_master_get_devdata(master);
 	/* Put everything in a known state. */
 	if (p) {
-		clk_disable_unprepare(p->clk);
+		if (!has_acpi)
+			clk_disable_unprepare(p->clk);
 		writeq(0, p->register_base + OCTEONTX2_SPI_CFG(p));
 	}
 
-- 
2.17.1

