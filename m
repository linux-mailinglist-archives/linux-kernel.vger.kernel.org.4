Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BED677FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjAWPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjAWPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:50 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9177C12F2C;
        Mon, 23 Jan 2023 07:24:27 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2739220E2D15;
        Mon, 23 Jan 2023 07:23:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2739220E2D15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487419;
        bh=kkDxZ7tUwT0Uo+e694DaWN5gRE9F7nibTWpCkLw2i3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5MxCEGujjEaZH+QtZxR+jxvdFxLcGfrMqPwfNsCobz8BQLAugzHtMDurcuLL0T4L
         AwTNX0kp0UJEpXPPxjrlfm5Xh7VKrP5STJvtF1jMqT5XiELQIL+RuxVK2H3R6zgidY
         u9xFs/q76p3A8ugKzc0vTINDye5I2/MVi4h9yZLs=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v1 6/8] crypto: ccp - Add vdata for platform device
Date:   Mon, 23 Jan 2023 15:22:48 +0000
Message-Id: <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
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

When matching the "psp" platform_device, determine the register offsets
at runtime from the ASP ACPI table. Pass the parsed register offsets
from the ASPT through platdata.

To support this scenario, mark the members of 'struct sev_vdata' and
'struct psp_vdata' non-const so that the probe function can write the
values. This does not affect the other users of sev_vdata/psp_vdata as
they define the whole struct const and the pointer in struct
sp_dev_vdata stays const too.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/kernel/psp.c            |  3 ++
 drivers/crypto/ccp/sp-dev.h      | 12 +++----
 drivers/crypto/ccp/sp-platform.c | 57 +++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
index 24181d132bae..68511a14df63 100644
--- a/arch/x86/kernel/psp.c
+++ b/arch/x86/kernel/psp.c
@@ -199,6 +199,9 @@ static int __init psp_init_platform_device(void)
 	if (err)
 		return err;
 	err = platform_device_add_resources(&psp_device, res, 2);
+	if (err)
+		return err;
+	err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
 	if (err)
 		return err;
 
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 20377e67f65d..aaa651364425 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -40,9 +40,9 @@ struct ccp_vdata {
 };
 
 struct sev_vdata {
-	const unsigned int cmdresp_reg;
-	const unsigned int cmdbuff_addr_lo_reg;
-	const unsigned int cmdbuff_addr_hi_reg;
+	unsigned int cmdresp_reg;
+	unsigned int cmdbuff_addr_lo_reg;
+	unsigned int cmdbuff_addr_hi_reg;
 };
 
 struct tee_vdata {
@@ -56,9 +56,9 @@ struct tee_vdata {
 struct psp_vdata {
 	const struct sev_vdata *sev;
 	const struct tee_vdata *tee;
-	const unsigned int feature_reg;
-	const unsigned int inten_reg;
-	const unsigned int intsts_reg;
+	unsigned int feature_reg;
+	unsigned int inten_reg;
+	unsigned int intsts_reg;
 };
 
 /* Structure to hold SP device data */
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index ea8926e87981..281dbf6b150c 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/acpi.h>
+#include <linux/platform_data/psp.h>
 
 #include "ccp-dev.h"
 
@@ -30,11 +31,31 @@ struct sp_platform {
 	unsigned int irq_count;
 };
 
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+static struct sev_vdata sev_platform = {
+	.cmdresp_reg = -1,
+	.cmdbuff_addr_lo_reg = -1,
+	.cmdbuff_addr_hi_reg = -1,
+};
+static struct psp_vdata psp_platform = {
+	.sev = &sev_platform,
+	.feature_reg = -1,
+	.inten_reg = -1,
+	.intsts_reg = -1,
+};
+#endif
+
 static const struct sp_dev_vdata dev_vdata[] = {
 	{
 		.bar = 0,
 #ifdef CONFIG_CRYPTO_DEV_SP_CCP
 		.ccp_vdata = &ccpv3_platform,
+#endif
+	},
+	{
+		.bar = 0,
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+		.psp_vdata = &psp_platform,
 #endif
 	},
 };
@@ -57,7 +78,7 @@ MODULE_DEVICE_TABLE(of, sp_of_match);
 #endif
 
 static const struct platform_device_id sp_plat_match[] = {
-	{ "psp" },
+	{ "psp", (kernel_ulong_t)&dev_vdata[1] },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sp_plat_match);
@@ -86,6 +107,38 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 	return NULL;
 }
 
+static struct sp_dev_vdata *sp_get_plat_version(struct platform_device *pdev)
+{
+	struct sp_dev_vdata *drvdata = (struct sp_dev_vdata *)pdev->id_entry->driver_data;
+	struct device *dev = &pdev->dev;
+
+	if (drvdata == &dev_vdata[1]) {
+		struct psp_platform_data *pdata = dev_get_platdata(dev);
+
+		if (!pdata) {
+			dev_err(dev, "missing platform data\n");
+			return NULL;
+		}
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+		psp_platform.feature_reg = pdata->feature_reg;
+		psp_platform.inten_reg = pdata->irq_en_reg;
+		psp_platform.intsts_reg = pdata->irq_st_reg;
+		sev_platform.cmdresp_reg = pdata->sev_cmd_resp_reg;
+		sev_platform.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg;
+		sev_platform.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg;
+		dev_dbg(dev, "GLBL feature:\t%x\n", pdata->feature_reg);
+		dev_dbg(dev, "GLBL irq en:\t%x\n", pdata->irq_en_reg);
+		dev_dbg(dev, "GLBL irq st:\t%x\n", pdata->irq_st_reg);
+		dev_dbg(dev, "SEV cmdresp:\t%x\n", pdata->sev_cmd_resp_reg);
+		dev_dbg(dev, "SEV cmdbuf lo:\t%x\n", pdata->sev_cmd_buf_lo_reg);
+		dev_dbg(dev, "SEV cmdbuf hi:\t%x\n", pdata->sev_cmd_buf_hi_reg);
+		dev_dbg(dev, "SEV mbox:\t%x\n", pdata->mbox_irq_id);
+		dev_dbg(dev, "ACPI cmdresp:\t%x\n", pdata->acpi_cmd_resp_reg);
+#endif
+	}
+	return drvdata;
+}
+
 static int sp_get_irqs(struct sp_device *sp)
 {
 	struct sp_platform *sp_platform = sp->dev_specific;
@@ -137,6 +190,8 @@ static int sp_platform_probe(struct platform_device *pdev)
 	sp->dev_specific = sp_platform;
 	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
 					 : sp_get_acpi_version(pdev);
+	if (!sp->dev_vdata && pdev->id_entry)
+		sp->dev_vdata = sp_get_plat_version(pdev);
 	if (!sp->dev_vdata) {
 		ret = -ENODEV;
 		dev_err(dev, "missing driver data\n");
-- 
2.25.1

