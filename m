Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901116529F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiLTXjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiLTXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:39:15 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7EF1FFB3;
        Tue, 20 Dec 2022 15:39:14 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso8116725oto.11;
        Tue, 20 Dec 2022 15:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XlyL4eZgxl2gJRdFFgKM+VBWZmuzkyYGsqXR6u61R0=;
        b=gLSNN54/JqgknJRWigZnw30uYE4qH/j9bzYouusWEJ/AwOcMyWRW1z72wiN0aKr4Cs
         qenpKTp6B6HuJZ6GnabPsv9n3Vy9KzwFfP4+4KbE5Tcan0zNC/TXnYB4amkcqncjBrt5
         kZNLNe7ICJHZ8Kj0ygJL91izbxjLLY4PKPBcaXC6Fvh8luYbSAUyg2E8RXHR8tvN8NOH
         5uWVCfSM4nALNd2osvCML8yCvQO3uBgtpwHAF3Z3SMNEx2MXGSPkLCU6UR7qQmWRfqI7
         j2f4QEdbEWnmC17Ujrm0btMj8Vu/GZTiqSR2Ho9/v60GN5B5FLXxRSQeeBekUPF/k/No
         jVQA==
X-Gm-Message-State: ANoB5pmPW+f6QRvJWQyzuM+Gq31j/6J6XDNT4ugCYkcPBLErBBikrJWS
        uCRmhOjeS7O3PHy1v5955A==
X-Google-Smtp-Source: AA0mqf76HhtVIRBeJvzpUAhwT9Xm/qY66R7iSPT7ARjb2LU3Qded5XZ+7SyPF0eEzj0tLE9RivBBUA==
X-Received: by 2002:a05:6830:2782:b0:661:dfeb:ea5a with SMTP id x2-20020a056830278200b00661dfebea5amr26041265otu.25.1671579553857;
        Tue, 20 Dec 2022 15:39:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683022fa00b00661ad8741b4sm6299549otc.24.2022.12.20.15.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 15:39:13 -0800 (PST)
Received: (nullmailer pid 1289304 invoked by uid 1000);
        Tue, 20 Dec 2022 23:39:12 -0000
Date:   Tue, 20 Dec 2022 17:39:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        Ionela.Voinescu@arm.com, Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/5] cacheinfo: Use RISC-V's init_cache_level() as
 generic OF implementation
Message-ID: <20221220233912.GA1193943-robh@kernel.org>
References: <20221209103130.572196-1-pierre.gondois@arm.com>
 <20221209103130.572196-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209103130.572196-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:31:23AM +0100, Pierre Gondois wrote:
> RISC-V's implementation of init_of_cache_level() is following
> the Devicetree Specification v0.3 regarding caches, cf.:
> - s3.7.3 'Internal (L1) Cache Properties'
> - s3.8 'Multi-level and Shared Cache Nodes'
> 
> Allow reusing the implementation by moving it.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
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

Not in this patch, but in patch 5, shouldn't riscv init_cache_level() be 
removed? The topology code already called init_of_cache_level() and 
RiscV has nothing architectural to add/change. IOW, init_cache_level() 
should only do architecture defined init, and not anything DT or ACPI 
related (unless those are non-standard).

Rob
