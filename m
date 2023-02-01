Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADF686EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBATYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBATYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:24:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5C081B3B;
        Wed,  1 Feb 2023 11:24:10 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 02D9A20B7102; Wed,  1 Feb 2023 11:24:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02D9A20B7102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675279450;
        bh=EPJPPr3ChGOrp2Xq1Cs4W8MzEv9V0kxUPttEaK356pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5qIKCVtbdQkoMT+9JeiWYvw4Z26avwz+jaYZGlX74oVu1EULxWpLjXmZ5AtbyMMP
         9qkgtjNgziTPKqx8gnUcCOXzEEfTpsv7XuDdeyjdD17/RRmksPsqosdMYLIQK6xp5A
         aBSQ9qTvyHT6XK0oZKITJ61xJPG8bqA4mfOtSfmU=
Date:   Wed, 1 Feb 2023 11:24:09 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 6/8] crypto: ccp - Add vdata for platform device
Message-ID: <20230201192409.GA14074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
 <6f76fe2b-63ea-8c45-87d8-3de30d3d76c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f76fe2b-63ea-8c45-87d8-3de30d3d76c2@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:36:01PM -0600, Tom Lendacky wrote:
> On 1/23/23 09:22, Jeremi Piotrowski wrote:
> >When matching the "psp" platform_device, determine the register offsets
> >at runtime from the ASP ACPI table. Pass the parsed register offsets
> >from the ASPT through platdata.
> >
> >To support this scenario, mark the members of 'struct sev_vdata' and
> >'struct psp_vdata' non-const so that the probe function can write the
> >values. This does not affect the other users of sev_vdata/psp_vdata as
> >they define the whole struct const and the pointer in struct
> >sp_dev_vdata stays const too.
> >
> >Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> >---
> >  arch/x86/kernel/psp.c            |  3 ++
> >  drivers/crypto/ccp/sp-dev.h      | 12 +++----
> >  drivers/crypto/ccp/sp-platform.c | 57 +++++++++++++++++++++++++++++++-
> >  3 files changed, 65 insertions(+), 7 deletions(-)
> >
> >diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
> >index 24181d132bae..68511a14df63 100644
> >--- a/arch/x86/kernel/psp.c
> >+++ b/arch/x86/kernel/psp.c
> >@@ -199,6 +199,9 @@ static int __init psp_init_platform_device(void)
> >  	if (err)
> >  		return err;
> >  	err = platform_device_add_resources(&psp_device, res, 2);
> >+	if (err)
> >+		return err;
> >+	err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
> >  	if (err)
> >  		return err;
> >diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
> >index 20377e67f65d..aaa651364425 100644
> >--- a/drivers/crypto/ccp/sp-dev.h
> >+++ b/drivers/crypto/ccp/sp-dev.h
> >@@ -40,9 +40,9 @@ struct ccp_vdata {
> >  };
> >  struct sev_vdata {
> >-	const unsigned int cmdresp_reg;
> >-	const unsigned int cmdbuff_addr_lo_reg;
> >-	const unsigned int cmdbuff_addr_hi_reg;
> >+	unsigned int cmdresp_reg;
> >+	unsigned int cmdbuff_addr_lo_reg;
> >+	unsigned int cmdbuff_addr_hi_reg;
> >  };
> >  struct tee_vdata {
> >@@ -56,9 +56,9 @@ struct tee_vdata {
> >  struct psp_vdata {
> >  	const struct sev_vdata *sev;
> >  	const struct tee_vdata *tee;
> >-	const unsigned int feature_reg;
> >-	const unsigned int inten_reg;
> >-	const unsigned int intsts_reg;
> >+	unsigned int feature_reg;
> >+	unsigned int inten_reg;
> >+	unsigned int intsts_reg;
> >  };
> >  /* Structure to hold SP device data */
> >diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> >index ea8926e87981..281dbf6b150c 100644
> >--- a/drivers/crypto/ccp/sp-platform.c
> >+++ b/drivers/crypto/ccp/sp-platform.c
> >@@ -22,6 +22,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/acpi.h>
> >+#include <linux/platform_data/psp.h>
> >  #include "ccp-dev.h"
> >@@ -30,11 +31,31 @@ struct sp_platform {
> >  	unsigned int irq_count;
> >  };
> >+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> >+static struct sev_vdata sev_platform = {
> >+	.cmdresp_reg = -1,
> >+	.cmdbuff_addr_lo_reg = -1,
> >+	.cmdbuff_addr_hi_reg = -1,
> >+};
> >+static struct psp_vdata psp_platform = {
> >+	.sev = &sev_platform,
> >+	.feature_reg = -1,
> >+	.inten_reg = -1,
> >+	.intsts_reg = -1,
> >+};
> >+#endif
> >+
> >  static const struct sp_dev_vdata dev_vdata[] = {
> >  	{
> >  		.bar = 0,
> >  #ifdef CONFIG_CRYPTO_DEV_SP_CCP
> >  		.ccp_vdata = &ccpv3_platform,
> >+#endif
> >+	},
> >+	{
> >+		.bar = 0,
> >+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> >+		.psp_vdata = &psp_platform,
> >  #endif
> >  	},
> >  };
> >@@ -57,7 +78,7 @@ MODULE_DEVICE_TABLE(of, sp_of_match);
> >  #endif
> >  static const struct platform_device_id sp_plat_match[] = {
> >-	{ "psp" },
> >+	{ "psp", (kernel_ulong_t)&dev_vdata[1] },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(platform, sp_plat_match);
> >@@ -86,6 +107,38 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
> >  	return NULL;
> >  }
> >+static struct sp_dev_vdata *sp_get_plat_version(struct platform_device *pdev)
> >+{
> >+	struct sp_dev_vdata *drvdata = (struct sp_dev_vdata *)pdev->id_entry->driver_data;
> 
> s/drvdata/vdata/
> 

ok

> >+	struct device *dev = &pdev->dev;
> >+
> 
> Should check for null vdata and return NULL, e.g.:
> 
> 	if (!vdata)
> 		return NULL;
> 

ok

> >+	if (drvdata == &dev_vdata[1]) {
> 
> This should be a check for vdata->psp_vdata being non-NULL and
> vdata->psp_vdata->sev being non-NULL, e.g.:
> 
> 	if (vdata->psp_vdata && vdata->psp_vdata->sev) {
> 
> >+		struct psp_platform_data *pdata = dev_get_platdata(dev);
> >+
> >+		if (!pdata) {
> >+			dev_err(dev, "missing platform data\n");
> >+			return NULL;
> >+		}
> >+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> 
> No need for this with the above checks
> 
> >+		psp_platform.feature_reg = pdata->feature_reg;
> 
> These should then be:
> 
> 		vdata->psp_vdata->inten_reg = pdata->feature_reg;
> 		...

I see where you're going with this and the above suggestions, but
the psp_vdata pointer is const in struct sp_dev_vdata and so is the
sev pointer in struct psp_vdata. I find these consts to be important
and doing it this way would require casting away the const. I don't
think that's worth doing.

> 
> >+		psp_platform.inten_reg = pdata->irq_en_reg;
> >+		psp_platform.intsts_reg = pdata->irq_st_reg;
> >+		sev_platform.cmdresp_reg = pdata->sev_cmd_resp_reg;
> 
> And this should be:
> 
> 		vdata->psp_vdata->sev->cmdbuff_addr_lo = ...
> 
> >+		sev_platform.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg;
> >+		sev_platform.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg;
> >+		dev_dbg(dev, "GLBL feature:\t%x\n", pdata->feature_reg);
> 
> s/GLBL feature/PSP feature register/
> 
> >+		dev_dbg(dev, "GLBL irq en:\t%x\n", pdata->irq_en_reg);
> 
> s/GLBL irq en/PSP IRQ enable register/
> 
> >+		dev_dbg(dev, "GLBL irq st:\t%x\n", pdata->irq_st_reg);
> 
> s/GLBL irq st/PSP IRQ status register/
> 
> >+		dev_dbg(dev, "SEV cmdresp:\t%x\n", pdata->sev_cmd_resp_reg);
> 
> s/SEV cmdresp/SEV cmdresp register/
> 
> >+		dev_dbg(dev, "SEV cmdbuf lo:\t%x\n", pdata->sev_cmd_buf_lo_reg);
> 
> s/SEV cmdbuf lo/SEV cmdbuf lo register/
> 
> >+		dev_dbg(dev, "SEV cmdbuf hi:\t%x\n", pdata->sev_cmd_buf_hi_reg);
> 
> s/SEV cmdbuf hi/SEV cmdbuf hi register/
> 
> >+		dev_dbg(dev, "SEV mbox:\t%x\n", pdata->mbox_irq_id);
> 
> s/SEV mbox/SEV cmdresp IRQ/
> 

ok to all the above rewordings

> 
> >+		dev_dbg(dev, "ACPI cmdresp:\t%x\n", pdata->acpi_cmd_resp_reg);
> 
> Duplicate entry

I don't see it. This is the ACPI register (the one used for the IRQ config).
Here's how these prints look when the module is loaded with dyndbg=+p:

  ccp psp: GLBL feature:  0
  ccp psp: GLBL irq en:   4
  ccp psp: GLBL irq st:   8
  ccp psp: SEV cmdresp:   10
  ccp psp: SEV cmdbuf lo: 14
  ccp psp: SEV cmdbuf hi: 18
  ccp psp: SEV mbox:      1
  ccp psp: ACPI cmdresp:  20

> 
> >+#endif
> >+	}
> >+	return drvdata;
> >+}
> >+
> >  static int sp_get_irqs(struct sp_device *sp)
> >  {
> >  	struct sp_platform *sp_platform = sp->dev_specific;
> >@@ -137,6 +190,8 @@ static int sp_platform_probe(struct platform_device *pdev)
> >  	sp->dev_specific = sp_platform;
> >  	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
> >  					 : sp_get_acpi_version(pdev);
> >+	if (!sp->dev_vdata && pdev->id_entry)
> 
> Move this pdev->id_entry check into sp_get_plat_version(), returning
> NULL if not set.
> 

ok

> Thanks,
> Tom
> 
> >+		sp->dev_vdata = sp_get_plat_version(pdev);
> >  	if (!sp->dev_vdata) {
> >  		ret = -ENODEV;
> >  		dev_err(dev, "missing driver data\n");
