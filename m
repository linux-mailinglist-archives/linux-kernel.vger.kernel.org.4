Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2BF610702
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiJ1Azo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiJ1Azm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:55:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF03EA4F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:55:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29S0tMIk116047;
        Thu, 27 Oct 2022 19:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666918522;
        bh=g81pUGPaxhe8PayHAZIcC2NhKRnMLJAiyPcRPYrPo5c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lN71K2qFYBzLJ/pJDqGhZUh+K0r9D7DB7HiXVm7cQfU8dizPcRVT+WofnvxPneuAL
         k6ffdc7iiQFz8/rNVN5FFGPfxSWvHfsORif4s3NQCjig7CODo7EbsoX8m40ikmqnss
         qa/mhamgXPTXkiW08oYujkt7CgqYVj5qqVVm6gUg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29S0tMjs004209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 19:55:22 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 19:55:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 19:55:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29S0tLPl039665;
        Thu, 27 Oct 2022 19:55:21 -0500
Date:   Thu, 27 Oct 2022 19:55:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <grygorii.strashko@ti.com>,
        <khilman@baylibre.com>, <nfrayer@baylibre.com>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Allow the driver to be built as
 module
Message-ID: <20221028005521.gzdo46oz65cxlthd@recent>
References: <20221021080231.1076-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021080231.1076-1-peter.ujfalusi@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:02-20221021, Peter Ujfalusi wrote:
> The ring accelerator driver can be built as module since all depending
> functions are exported.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
>  drivers/soc/ti/Kconfig      |  2 +-
>  drivers/soc/ti/k3-ringacc.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 7e2fb1c16af1..e009d9589af4 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -63,7 +63,7 @@ config TI_SCI_PM_DOMAINS
>  	  rootfs may be available.
>  
>  config TI_K3_RINGACC
> -	bool "K3 Ring accelerator Sub System"
> +	tristate "K3 Ring accelerator Sub System"
>  	depends on ARCH_K3 || COMPILE_TEST
>  	depends on TI_SCI_INTA_IRQCHIP
>  	help
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index f7bf18b8229a..e011412f2975 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -7,7 +7,7 @@
>  
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -336,6 +336,11 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>  
>  	mutex_lock(&ringacc->req_lock);
>  
> +	if (!try_module_get(ringacc->dev->driver->owner)) {

Does a cascaded error handling make sense instead?

goto error_mod_fail?

> +		mutex_unlock(&ringacc->req_lock);
> +		return NULL;
> +	}
> +
>  	if (id == K3_RINGACC_RING_ID_ANY) {
>  		/* Request for any general purpose ring */
>  		struct ti_sci_resource_desc *gp_rings =
> @@ -380,6 +385,7 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>  	return &ringacc->rings[id];
>  
>  error:
> +	module_put(ringacc->dev->driver->owner);

error_mod_fail:

>  	mutex_unlock(&ringacc->req_lock);
>  	return NULL;
>  }
> @@ -616,6 +622,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
>  no_init:
>  	clear_bit(ring->ring_id, ringacc->rings_inuse);
>  
> +	module_put(ringacc->dev->driver->owner);
> +
>  out:
>  	mutex_unlock(&ringacc->req_lock);
>  	return 0;
> @@ -1450,6 +1458,7 @@ static const struct of_device_id k3_ringacc_of_match[] = {
>  	{ .compatible = "ti,am654-navss-ringacc", .data = &k3_ringacc_data, },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, k3_ringacc_of_match);
>  
>  struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
>  					    struct k3_ringacc_init_data *data)
> @@ -1544,12 +1553,26 @@ static int k3_ringacc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int k3_ringacc_remove(struct platform_device *pdev)
> +{
> +	struct k3_ringacc *ringacc = dev_get_drvdata(&pdev->dev);
> +
> +	mutex_lock(&k3_ringacc_list_lock);
> +	list_del(&ringacc->list);
> +	mutex_unlock(&k3_ringacc_list_lock);
> +	return 0;
> +}
> +
>  static struct platform_driver k3_ringacc_driver = {
>  	.probe		= k3_ringacc_probe,
> +	.remove		= k3_ringacc_remove,
>  	.driver		= {
>  		.name	= "k3-ringacc",
>  		.of_match_table = k3_ringacc_of_match,
> -		.suppress_bind_attrs = true,

Might be good to note sysfs behavior change in commit log?

>  	},
>  };
> -builtin_platform_driver(k3_ringacc_driver);
> +module_platform_driver(k3_ringacc_driver);
> +
> +MODULE_LICENSE("GPL v2");

GPL ? checkpatch should have complained?

> +MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
> +MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
> -- 
> 2.38.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
