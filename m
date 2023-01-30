Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC70680861
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjA3JWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjA3JVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:21:46 -0500
Received: from vsp04-out.oderland.com (vsp04-out.oderland.com [IPv6:2a02:28f0::31:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BB86A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:21:44 -0800 (PST)
X-Scanned-Cookie: f500bda16b244583931b552d2d35209f2e653c44
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
        by vsp-out.oderland.com (Halon) with ESMTPSA
        id 826dac8c-a07f-11ed-84da-3167612d0455;
        Mon, 30 Jan 2023 10:21:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ed0B94xsqNqJd94Zwcm9kr+L8XMZvFguOtTUNMulaA=; b=Yfgkk28gf3fJvP5Ju08zAIRzJ5
        3MXCfJonVoX+et3HNf9QiBraYUR1WdaKnr/Vt31bLq2MpkSieV2rEtWh+cqTi6KJuBlzDsKz0WV1W
        wr8PtJiALInhKzd3U4DwZUrY5X4KhB4nReJ1jM9muQQMTQ/4f9p8MkoOi2s1F/732ff1Dq8bivKL5
        uVer+W7VH2ODWRR9aR5wnh1A1pWgMJfuwsOUHZbwKGovxnPGXkZOKk7ZYfR7Y4T0OXf364DZlnfxd
        B4eJyh+gpnyclQZZoOnt3uFTL2cbYszZNyqwRuuhpPiPAzeXl5rnQngv2+IrV0oIw1hHnsxQM4Qcy
        7MoED3aA==;
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:48568 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <josef@oderland.se>)
        id 1pMQMB-00AhxU-NW;
        Mon, 30 Jan 2023 10:21:42 +0100
Message-ID: <952fdc14-a8e5-a59a-9c7d-af1adf361d77@oderland.se>
Date:   Mon, 30 Jan 2023 10:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-acpi@vger.kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <20221121102113.41893-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-oderland-domain-valid: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 11:21, Roger Pau Monne wrote:
> When running as a Xen dom0 the number of CPUs available to Linux can
> be different from the number of CPUs present on the system, but in
> order to properly fetch processor performance related data _PDC must
> be executed on all the physical CPUs online on the system.
>
> The current checks in processor_physically_present() result in some
> processor objects not getting their _PDC methods evaluated when Linux
> is running as Xen dom0.  Fix this by introducing a custom function to
> use when running as Xen dom0 in order to check whether a processor
> object matches a CPU that's online.
>
> Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
>   arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
>   arch/x86/xen/enlighten.c              | 27 +++++++++++++++++++++++++++
>   drivers/acpi/processor_pdc.c          | 11 +++++++++++
>   3 files changed, 48 insertions(+)
>
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index 16f548a661cf..b9f512138043 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -61,4 +61,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
>   void __init mem_map_via_hcall(struct boot_params *boot_params_p);
>   #endif
>   
> +#ifdef CONFIG_XEN_DOM0
> +bool __init xen_processor_present(uint32_t acpi_id);
> +#else
> +static inline bool xen_processor_present(uint32_t acpi_id)
> +{
> +	BUG();
> +	return false;
> +}
> +#endif
> +
>   #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index b8db2148c07d..d4c44361a26c 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
>   }
>   EXPORT_SYMBOL(xen_arch_unregister_cpu);
>   #endif
> +
> +#ifdef CONFIG_XEN_DOM0
> +bool __init xen_processor_present(uint32_t acpi_id)
> +{
> +	unsigned int i, maxid;
> +	struct xen_platform_op op = {
> +		.cmd = XENPF_get_cpuinfo,
> +		.interface_version = XENPF_INTERFACE_VERSION,
> +	};
> +	int ret = HYPERVISOR_platform_op(&op);
> +
> +	if (ret)
> +		return false;
> +
> +	maxid = op.u.pcpu_info.max_present;
> +	for (i = 0; i <= maxid; i++) {
> +		op.u.pcpu_info.xen_cpuid = i;
> +		ret = HYPERVISOR_platform_op(&op);
> +		if (ret)
> +			continue;
> +		if (op.u.pcpu_info.acpi_id == acpi_id)
> +			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
> +	}
> +
> +	return false;
> +}
My compiler (Default GCC on Fedora 32, compiling for Qubes) complain 
loudly that the below was missing.

+}
+EXPORT_SYMBOL(xen_processor_present);

`ERROR: MODPOST xen_processor_present 
[drivers/xen/xen-acpi-processor.ko] undefined!`

Same thing with xen_sanitize_pdc in the next patch.

+}
+EXPORT_SYMBOL(xen_sanitize_pdc);

Everything compiled fine after those changes.
> +#endif
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 8c3f82c9fff3..18fb04523f93 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -14,6 +14,8 @@
>   #include <linux/acpi.h>
>   #include <acpi/processor.h>
>   
> +#include <xen/xen.h>
> +
>   #include "internal.h"
>   
>   static bool __init processor_physically_present(acpi_handle handle)
> @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
>   		return false;
>   	}
>   
> +	if (xen_initial_domain())
> +		/*
> +		 * When running as a Xen dom0 the number of processors Linux
> +		 * sees can be different from the real number of processors on
> +		 * the system, and we still need to execute _PDC for all of
> +		 * them.
> +		 */
> +		return xen_processor_present(acpi_id);
> +
>   	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
>   	cpuid = acpi_get_cpuid(handle, type, acpi_id);
>   

