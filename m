Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611C6621518
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiKHOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiKHOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:08:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720D870571;
        Tue,  8 Nov 2022 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667916481; x=1699452481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xOw7QIJLsuxkX05KFxFMzYRYL4KbLRoTNIigZpHSnz8=;
  b=1JPjPzwPDkiTcntCM6W7ih29NJEyYuaTFVpLN/S0ItOZKFLbUxk+N5EW
   EhkkpP7jmiUReU1y9Qq0SR+DetG4dDyuWffI96F7j55ewXVqoA1AxdfLd
   B+Vtw0Owcg/lDgyN1Ya8+/yt0GoEKATrRWak/d+JnKPEsJJ+rc/jsmOER
   8PDakYlUzi75iBSHHyfj97D347mRZvKzegg7DsvnKVGWyVhIcn+h5dMtE
   4RJPon1w0C94bIh8mFamzjLVmCmhoZqXIyCMHm6thlgKp0XUPmnwBZIge
   g1tOhOsLrb1G7conEs70Z66X9N8LzVICVMp8sbrxjP0jDN06MIzNtZZP/
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="198904540"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 07:08:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 07:08:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 8 Nov 2022 07:07:57 -0700
Date:   Tue, 8 Nov 2022 14:07:41 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/5] cacheinfo: Use riscv's init_cache_level() as generic
 OF implem
Message-ID: <Y2pirStbsJOidAkz@wendy>
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221108110424.166896-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 12:04:17PM +0100, Pierre Gondois wrote:
> Riscv's implementation of init_of_cache_level() is following

heh, "Riscv" always looks a bit odd!
Code movement looks fine, nothing surface level is broken on RISC-V.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> the Devicetree Specification v0.3 regarding caches, cf.:
> - s3.7.3 'Internal (L1) Cache Properties'
> - s3.8 'Multi-level and Shared Cache Nodes'
> 
> Allow reusing the implementation by moving it.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 39 +------------------------------
>  drivers/base/cacheinfo.c      | 44 +++++++++++++++++++++++++++++++++++
>  include/linux/cacheinfo.h     |  1 +
>  3 files changed, 46 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 90deabfe63ea..440a3df5944c 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -115,44 +115,7 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
>  
>  int init_cache_level(unsigned int cpu)
>  {
> -	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> -	struct device_node *np = of_cpu_device_node_get(cpu);
> -	struct device_node *prev = NULL;
> -	int levels = 0, leaves = 0, level;
> -
> -	if (of_property_read_bool(np, "cache-size"))
> -		++leaves;
> -	if (of_property_read_bool(np, "i-cache-size"))
> -		++leaves;
> -	if (of_property_read_bool(np, "d-cache-size"))
> -		++leaves;
> -	if (leaves > 0)
> -		levels = 1;
> -
> -	prev = np;
> -	while ((np = of_find_next_cache_node(np))) {
> -		of_node_put(prev);
> -		prev = np;
> -		if (!of_device_is_compatible(np, "cache"))
> -			break;
> -		if (of_property_read_u32(np, "cache-level", &level))
> -			break;
> -		if (level <= levels)
> -			break;
> -		if (of_property_read_bool(np, "cache-size"))
> -			++leaves;
> -		if (of_property_read_bool(np, "i-cache-size"))
> -			++leaves;
> -		if (of_property_read_bool(np, "d-cache-size"))
> -			++leaves;
> -		levels = level;
> -	}
> -
> -	of_node_put(np);
> -	this_cpu_ci->num_levels = levels;
> -	this_cpu_ci->num_leaves = leaves;
> -
> -	return 0;
> +	return init_of_cache_level(cpu);
>  }
>  
>  int populate_cache_leaves(unsigned int cpu)
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 4b5cd08c5a65..a4308b48dd3e 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -224,8 +224,52 @@ static int cache_setup_of_node(unsigned int cpu)
>  
>  	return 0;
>  }
> +
> +int init_of_cache_level(unsigned int cpu)
> +{
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct device_node *np = of_cpu_device_node_get(cpu);
> +	struct device_node *prev = NULL;
> +	int levels = 0, leaves = 0, level;
> +
> +	if (of_property_read_bool(np, "cache-size"))
> +		++leaves;
> +	if (of_property_read_bool(np, "i-cache-size"))
> +		++leaves;
> +	if (of_property_read_bool(np, "d-cache-size"))
> +		++leaves;
> +	if (leaves > 0)
> +		levels = 1;
> +
> +	prev = np;
> +	while ((np = of_find_next_cache_node(np))) {
> +		of_node_put(prev);
> +		prev = np;
> +		if (!of_device_is_compatible(np, "cache"))
> +			break;
> +		if (of_property_read_u32(np, "cache-level", &level))
> +			break;
> +		if (level <= levels)
> +			break;
> +		if (of_property_read_bool(np, "cache-size"))
> +			++leaves;
> +		if (of_property_read_bool(np, "i-cache-size"))
> +			++leaves;
> +		if (of_property_read_bool(np, "d-cache-size"))
> +			++leaves;
> +		levels = level;
> +	}
> +
> +	of_node_put(np);
> +	this_cpu_ci->num_levels = levels;
> +	this_cpu_ci->num_leaves = leaves;
> +
> +	return 0;
> +}
> +
>  #else
>  static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
> +int init_of_cache_level(unsigned int cpu) { return 0; }
>  #endif
>  
>  int __weak cache_setup_acpi(unsigned int cpu)
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 00b7a6ae8617..ff0328f3fbb0 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -80,6 +80,7 @@ struct cpu_cacheinfo {
>  
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
> +int init_of_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
>  int cache_setup_acpi(unsigned int cpu);
>  bool last_level_cache_is_valid(unsigned int cpu);
> -- 
> 2.25.1
> 
