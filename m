Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643563607F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiKWNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiKWNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:52:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB88765A;
        Wed, 23 Nov 2022 05:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669211094; x=1700747094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ThpPRnT3H2tIfP/zSsUWW1oRAj/U3AJ3PTwjtrPgLE=;
  b=XPKwM/rlGGPF8I/7Z+bTmJo1UWxbHMlhZzuMOgzuWiYM/6mY0W61A8sE
   z7N/KkRab52oVfbjtYGGELgLXwSRC5VhymWatWzzUDNktNfevqwzKJ6OF
   J377cIgK/dZW0phwVjfVE4V0TeEjv/Qgg/17g5l9z2k5zGntpUT1cmjyW
   JOURB4fEHdy1rR92dJIvbmdbumzP2MwqFcmHruHSVrSBEh6LIRRuJDofd
   kmkF197WyK6XF2hzOpD/v52U4DMoqkDUWVhUi7rK2VEVCqOEmQC9Orked
   VwpiIcGZDZB3CdPNdAXhtqjC974LYJE6WekbtMhmtfdJofHFF1yHVdd9E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="340947058"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="340947058"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 05:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="672880767"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="672880767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 05:44:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxq3U-00GIyb-2x;
        Wed, 23 Nov 2022 15:44:48 +0200
Date:   Wed, 23 Nov 2022 15:44:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v4 4/4] x86/of: Add support for boot time interrupt
 delivery mode configuration
Message-ID: <Y34j0BgRTVS6KG4i@smile.fi.intel.com>
References: <20221123100850.22969-1-rtanwar@maxlinear.com>
 <20221123100850.22969-5-rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123100850.22969-5-rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 06:08:50PM +0800, Rahul Tanwar wrote:
> Presently, init/boot time interrupt delivery mode is enumerated
> only for ACPI enabled systems by parsing MADT table or for older
> systems by parsing MP table. But for OF based x86 systems, it is
> assumed & hardcoded to legacy PIC mode. This causes boot time crash
> for platforms which do not use 8259 compliant legacy PIC.
> 
> Add support for configuration of init time interrupt delivery mode
> for x86 OF based systems by introducing a new optional boolean
> property 'intel,virtual-wire-mode' for interrupt-controller node
> of local APIC. This property emulates IMCRP Bit 7 of MP feature
> info byte 2 of MP floating pointer structure.
> 
> Defaults to legacy PIC mode if absent. Configures it to virtual
> wire compatibility mode if present.

From code perspective looks good to me, but you need to have a blessing by DT
people for first two patches.

With whatever property name agreed on,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  arch/x86/kernel/devicetree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index fcc6f1b7818f..458e43490414 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -167,7 +167,14 @@ static void __init dtb_lapic_setup(void)
>  			return;
>  	}
>  	smp_found_config = 1;
> -	pic_mode = 1;
> +	if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {
> +		pr_info("Virtual Wire compatibility mode.\n");
> +		pic_mode = 0;
> +	} else {
> +		pr_info("IMCR and PIC compatibility mode.\n");
> +		pic_mode = 1;
> +	}
> +
>  	register_lapic_address(lapic_addr);
>  }
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


