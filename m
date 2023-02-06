Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A968C333
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBFQ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:28:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26407CA3E;
        Mon,  6 Feb 2023 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J5qsFrHxoW2pjLsk9qiM9/YFEvZ8jiTM8kTlPvrNykI=; b=BAOxXGE+aFkV0YgDmD1FI0nQiT
        48D0zmDTiKokqjB1LeJHR93tlsQGGgNTC0x2cG2h/L7Am0B/95CtGNPtOInhD+73dvwezG6eQYyH3
        rA7a7iXsUxdf46SWBs2/tFq3olzRo6TkaLEtAcNW+G2vp+iKRzMd9ooklmMzdmebP+MLEWeJ5JXnA
        hf9UYirDZq2OJN0hVB2LuETgO/dKleQXaGU7zvEIozLPrNiKkzS0JvTVTzQCi+3E4KUvdeBERS8FU
        PDVtmkzsjQRLNAEK/+t6EqQE/Kw12aDRLHDK+Fkg+D3vL6XC7ZF92aELPJYKcx5B2uvh2dV3KOT+P
        J8A+lwlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP4Lx-009KBQ-T0; Mon, 06 Feb 2023 16:28:25 +0000
Date:   Mon, 6 Feb 2023 08:28:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>, Allan Day <aday@redhat.com>,
        Michael Catanzaro <mcatanzaro.kernel@gmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        pmladek@suse.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
Message-ID: <Y+EqqRddrIZ8yWiT@bombadil.infradead.org>
References: <20230131130041.629-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131130041.629-1-petr.pavlu@suse.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:00:41PM +0100, Petr Pavlu wrote:
> The acpi-cpufreq and pcc-cpufreq drivers are loaded through per-CPU
> module aliases.

It gets me to question, what makes this "per-CPU module aliases" and
how do we find other similar uses as they are likely incorrect too?

> This can result in many unnecessary load requests during
> boot if another frequency module, such as intel_pstate, is already
> active. 

Perhaps you should mention that in the worst case, without the fix in
commit 0254127ab977e ("module: Don't wait for GOING modules") some of
these module load requests could fail and prevent boot, and that
discussion over these duplicate module reqests ended up in us deciding that
they are not needed, we just need one.

> For instance, on a typical Intel system, one can observe that
> udev makes 2x#CPUs attempts to insert acpi_cpufreq and 1x#CPUs attempts
> for pcc_cpufreq. All these tries then fail if another frequency module
> is already registered.
> 
> Both acpi-cpufreq and pcc-cpufreq drivers have their platform firmware
> interface defined by ACPI. Allowed performance states and parameters
> must be same for each CPU. This makes it possible to model these
> interfaces as platform devices.
> 
> The patch extends the ACPI parsing logic to check the ACPI namespace if
> the PPC or PCC interface is present and creates a virtual platform
> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
> drivers are then updated to map to these devices.
> 
> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
> boot and only if a given interface is available in the firmware.

That could cut boot time too? If so how much?

  Luis

> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  drivers/acpi/Makefile          |  1 +
>  drivers/acpi/acpi_cpufreq.c    | 49 ++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c             |  1 +
>  drivers/acpi/internal.h        |  2 ++
>  drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++++++++------------
>  drivers/cpufreq/pcc-cpufreq.c  | 34 ++++++++++++++++-------
>  6 files changed, 99 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/acpi/acpi_cpufreq.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index feb36c0b9446..880db1082c3e 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -57,6 +57,7 @@ acpi-y				+= evged.o
>  acpi-y				+= sysfs.o
>  acpi-y				+= property.o
>  acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
> +acpi-$(CONFIG_X86)		+= acpi_cpufreq.o
>  acpi-$(CONFIG_X86)		+= x86/apple.o
>  acpi-$(CONFIG_X86)		+= x86/utils.o
>  acpi-$(CONFIG_X86)		+= x86/s2idle.o
> diff --git a/drivers/acpi/acpi_cpufreq.c b/drivers/acpi/acpi_cpufreq.c
> new file mode 100644
> index 000000000000..7cf243c67475
> --- /dev/null
> +++ b/drivers/acpi/acpi_cpufreq.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Registration of platform devices for ACPI Processor Performance Control and
> + * Processor Clocking Control.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +
> +#include "internal.h"
> +
> +static void __init cpufreq_add_device(const char *name)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL,
> +					       0);
> +	if (IS_ERR(pdev))
> +		pr_err("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
> +}
> +
> +static acpi_status __init acpi_pct_match(acpi_handle handle, u32 level,
> +					 void *context, void **return_value)
> +{
> +	bool *pct = context;
> +
> +	/* Check if the first CPU has _PCT. The data must be same for all. */
> +	*pct = acpi_has_method(handle, "_PCT");
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +void __init acpi_cpufreq_init(void)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +	bool pct = false;
> +
> +	status = acpi_get_handle(NULL, "\\_SB", &handle);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
> +			    ACPI_UINT32_MAX, acpi_pct_match, NULL, &pct, NULL);
> +	if (pct)
> +		cpufreq_add_device("acpi-cpufreq");
> +
> +	if (acpi_has_method(handle, "PCCH"))
> +		cpufreq_add_device("pcc-cpufreq");
> +}
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 0c05ccde1f7a..f1559e26d5ff 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1428,6 +1428,7 @@ static int __init acpi_init(void)
>  	acpi_viot_init();
>  	acpi_agdi_init();
>  	acpi_apmt_init();
> +	acpi_cpufreq_init();
>  	return 0;
>  }
>  
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index ec584442fb29..c9b1a5f689fa 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -157,8 +157,10 @@ static inline void acpi_early_processor_set_pdc(void) {}
>  
>  #ifdef CONFIG_X86
>  void acpi_early_processor_osc(void);
> +void acpi_cpufreq_init(void);
>  #else
>  static inline void acpi_early_processor_osc(void) {}
> +static inline void acpi_cpufreq_init(void) {}
>  #endif
>  
>  /* --------------------------------------------------------------------------
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 78adfb2ffff6..e1a5384cf21c 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -965,7 +965,7 @@ static void __init acpi_cpufreq_boost_init(void)
>  	acpi_cpufreq_driver.boost_enabled = boost_state(0);
>  }
>  
> -static int __init acpi_cpufreq_init(void)
> +static int __init acpi_cpufreq_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  
> @@ -1010,13 +1010,32 @@ static int __init acpi_cpufreq_init(void)
>  	return ret;
>  }
>  
> -static void __exit acpi_cpufreq_exit(void)
> +static int acpi_cpufreq_remove(struct platform_device *pdev)
>  {
>  	pr_debug("%s\n", __func__);
>  
>  	cpufreq_unregister_driver(&acpi_cpufreq_driver);
>  
>  	free_acpi_perf_data();
> +
> +	return 0;
> +}
> +
> +static struct platform_driver acpi_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "acpi-cpufreq",
> +	},
> +	.remove		= acpi_cpufreq_remove,
> +};
> +
> +static int __init acpi_cpufreq_init(void)
> +{
> +	return platform_driver_probe(&acpi_cpufreq_platdrv, acpi_cpufreq_probe);
> +}
> +
> +static void __exit acpi_cpufreq_exit(void)
> +{
> +	platform_driver_unregister(&acpi_cpufreq_platdrv);
>  }
>  
>  module_param(acpi_pstate_strict, uint, 0644);
> @@ -1027,18 +1046,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
>  
> -static const struct x86_cpu_id __maybe_unused acpi_cpufreq_ids[] = {
> -	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
> -	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
> -	{}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
> -
> -static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
> -	{ACPI_PROCESSOR_OBJECT_HID, },
> -	{ACPI_PROCESSOR_DEVICE_HID, },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> -
> -MODULE_ALIAS("acpi");
> +MODULE_ALIAS("platform:acpi-cpufreq");
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 9f3fc7a073d0..0c362932ca60 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -384,7 +384,7 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
>  	return ret;
>  }
>  
> -static int __init pcc_cpufreq_probe(void)
> +static int __init pcc_cpufreq_evaluate(void)
>  {
>  	acpi_status status;
>  	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -576,7 +576,7 @@ static struct cpufreq_driver pcc_cpufreq_driver = {
>  	.name = "pcc-cpufreq",
>  };
>  
> -static int __init pcc_cpufreq_init(void)
> +static int __init pcc_cpufreq_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  
> @@ -587,9 +587,9 @@ static int __init pcc_cpufreq_init(void)
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> -	ret = pcc_cpufreq_probe();
> +	ret = pcc_cpufreq_evaluate();
>  	if (ret) {
> -		pr_debug("pcc_cpufreq_init: PCCH evaluation failed\n");
> +		pr_debug("pcc_cpufreq_probe: PCCH evaluation failed\n");
>  		return ret;
>  	}
>  
> @@ -607,21 +607,35 @@ static int __init pcc_cpufreq_init(void)
>  	return ret;
>  }
>  
> -static void __exit pcc_cpufreq_exit(void)
> +static int pcc_cpufreq_remove(struct platform_device *pdev)
>  {
>  	cpufreq_unregister_driver(&pcc_cpufreq_driver);
>  
>  	pcc_clear_mapping();
>  
>  	free_percpu(pcc_cpu_info);
> +
> +	return 0;
>  }
>  
> -static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
> -	{ACPI_PROCESSOR_OBJECT_HID, },
> -	{ACPI_PROCESSOR_DEVICE_HID, },
> -	{},
> +static struct platform_driver pcc_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "pcc-cpufreq",
> +	},
> +	.remove		= pcc_cpufreq_remove,
>  };
> -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> +
> +static int __init pcc_cpufreq_init(void)
> +{
> +	return platform_driver_probe(&pcc_cpufreq_platdrv, pcc_cpufreq_probe);
> +}
> +
> +static void __exit pcc_cpufreq_exit(void)
> +{
> +	platform_driver_unregister(&pcc_cpufreq_platdrv);
> +}
> +
> +MODULE_ALIAS("platform:pcc-cpufreq");
>  
>  MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
>  MODULE_VERSION(PCC_VERSION);
> 
