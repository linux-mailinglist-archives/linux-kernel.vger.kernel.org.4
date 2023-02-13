Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660BE6940FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBMJZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBMJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:25:06 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 302701555A;
        Mon, 13 Feb 2023 01:25:03 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 957D520C8B72;
        Mon, 13 Feb 2023 01:25:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 957D520C8B72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676280302;
        bh=g0sUDZUZPSozLfPSFtOhNE8txHqjio4WGyZV6VO7onw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXxtBYyZK7Lhe8lOkWYXpXS8uK2M8i64rNKEI7Qcb7M/8atqDkPrW7MN6GDqeJqt8
         rdchrlIM4lZYS0j/RletwrfbjvSjh926xzoLo04yqJYD6EAnBbotAxKG5QgRV1oFwI
         VrmziZDwh9bPmE6h/dRNJavT6We3FdwaqAXsMm2g=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 6/8] crypto: ccp - Add vdata for platform device
Date:   Mon, 13 Feb 2023 09:24:27 +0000
Message-Id: <20230213092429.1167812-7-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When matching the "psp" platform_device, the register offsets are
determined at runtime from the ASP ACPI table. The structure containing
the offset is passed through the platform data field provided before
registering the platform device.

To support this scenario, dynamically allocate vdata structs and fill
those in with offsets provided by the platform. Due to the fields of the
structs being const, it was necessary to use temporary structs and
memcpy, as any assignment of the whole struct fails with an 'read-only
location' compiler error.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-platform.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 5dcc834deb72..2e57ec15046b 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/acpi.h>
+#include <linux/platform_data/psp.h>
 
 #include "ccp-dev.h"
 
@@ -86,6 +87,60 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 	return NULL;
 }
 
+static void sp_platform_fill_vdata(struct sp_dev_vdata *vdata, struct psp_vdata *psp,
+				   struct sev_vdata *sev, const struct psp_platform_data *pdata)
+{
+	struct sev_vdata sevtmp = {
+		.cmdresp_reg = pdata->sev_cmd_resp_reg,
+		.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg,
+		.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg,
+	};
+	struct psp_vdata psptmp = {
+		.sev = sev,
+		.feature_reg = pdata->feature_reg,
+		.inten_reg = pdata->irq_en_reg,
+		.intsts_reg = pdata->irq_st_reg,
+	};
+
+	memcpy(sev, &sevtmp, sizeof(*sev));
+	memcpy(psp, &psptmp, sizeof(*psp));
+	vdata->psp_vdata = psp;
+}
+
+static struct sp_dev_vdata *sp_get_platform_version(struct sp_device *sp)
+{
+	struct psp_platform_data *pdata;
+	struct device *dev = sp->dev;
+	struct sp_dev_vdata *vdata;
+	struct psp_vdata *psp;
+	struct sev_vdata *sev;
+
+	pdata = dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "missing platform data\n");
+		return NULL;
+	}
+
+	vdata = devm_kzalloc(dev, sizeof(*vdata) + sizeof(*psp) + sizeof(*sev), GFP_KERNEL);
+	if (!vdata)
+		return NULL;
+
+	psp = (void *)vdata + sizeof(*vdata);
+	sev = (void *)psp + sizeof(*psp);
+	sp_platform_fill_vdata(vdata, psp, sev, pdata);
+
+	dev_dbg(dev, "PSP feature register:\t%x\n", psp->feature_reg);
+	dev_dbg(dev, "PSP IRQ enable register:\t%x\n", psp->inten_reg);
+	dev_dbg(dev, "PSP IRQ status register:\t%x\n", psp->intsts_reg);
+	dev_dbg(dev, "SEV cmdresp register:\t%x\n", sev->cmdresp_reg);
+	dev_dbg(dev, "SEV cmdbuf lo register:\t%x\n", sev->cmdbuff_addr_lo_reg);
+	dev_dbg(dev, "SEV cmdbuf hi register:\t%x\n", sev->cmdbuff_addr_hi_reg);
+	dev_dbg(dev, "SEV cmdresp IRQ:\t%x\n", pdata->mbox_irq_id);
+	dev_dbg(dev, "ACPI cmdresp register:\t%x\n", pdata->acpi_cmd_resp_reg);
+
+	return vdata;
+}
+
 static int sp_get_irqs(struct sp_device *sp)
 {
 	struct sp_platform *sp_platform = sp->dev_specific;
@@ -137,6 +192,8 @@ static int sp_platform_probe(struct platform_device *pdev)
 	sp->dev_specific = sp_platform;
 	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
 					 : sp_get_acpi_version(pdev);
+	if (!sp->dev_vdata)
+		sp->dev_vdata = sp_get_platform_version(sp);
 	if (!sp->dev_vdata) {
 		ret = -ENODEV;
 		dev_err(dev, "missing driver data\n");
-- 
2.25.1

