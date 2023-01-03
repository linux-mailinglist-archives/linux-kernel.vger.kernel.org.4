Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829F965BAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjACGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbjACGyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:54:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F7FB48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:54:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u18so41199550eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 22:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYKrmSOx2pt3469lia8FKNW80E8qGEbATC3jLzux/4g=;
        b=SSxZ1bYYpZK8rXkVsCOw5nzTeGVkoJYmeKeFwWPJv3fj2uIFovL0NSLtWF2O+SJwsf
         8tF4sJXRBtbmNt67kAYtyXTuDXLLWoyOt4kbP7jxAgASa9srvQotdlRfrZWNm/6Q3DAU
         buNZZjGu+rTKqwebaXmiTOHafRcQ+OGK17esT1uFHKiWfgoO3fm6W5Kq8uGkLd9mOc7k
         JaBbKuVP4wO/R9tSGQ9WC+tL6TnSaEVUDF7zRJt06rLoGJWkdr47nesKxIqfA03L/GKf
         KKZFmPEv46EKWhkFyddQXxPjgYjQnOexVICxpzi2c+JvQlf6Jt7+m6nkLewV0L/DZWFp
         2Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYKrmSOx2pt3469lia8FKNW80E8qGEbATC3jLzux/4g=;
        b=DhiscGAeIY7EzZOoVI1fDjHt60GiS8z5KZI01S2VEkU8P4S284xY3LtN6t1V2G4EyJ
         mAVT2FXj2NCoPKTlzqYEgxTyBjFHScc14g5IV4qcxoz47s1ykoAgm0ldDVBGVC0xh2Vx
         tQsDKQsLYpuV4Wxs6t79ZYz2AnnhUduuJf3zV1Ujpm6df9dNS5jLwiyeGh1V5qXShSL0
         4yhs07KvO6EaJuHgJ0MzBr5RzN9Egt42rqWeotIeiUTXGH2Wxgn3dU49luFxwPuexCVq
         Et59Cb+Q4pOKbZUNzMXVBS/c2xkIpsDZmi3yrYa673eAG+zOi0p/PlxSAGiSlG6x2cng
         Zm1w==
X-Gm-Message-State: AFqh2kpzcB5n0z841zV8Wfv2/HfuY+jhMvKLHgLkwcsBBSasQqOdKfxb
        MGebNL9qyaXx2xuBCb7nHcOkPA==
X-Google-Smtp-Source: AMrXdXu92FyFlIGfkykwuOeY3JtGSV7RcNkNZqccocQOHoSdmZ08R39/NWRxZWCQMrXbRGmsKqmQjA==
X-Received: by 2002:a05:6402:22ad:b0:488:6003:24b6 with SMTP id cx13-20020a05640222ad00b00488600324b6mr8981767edb.40.1672728852621;
        Mon, 02 Jan 2023 22:54:12 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id cf30-20020a0564020b9e00b0048db3e85cdcsm2400559edb.85.2023.01.02.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 22:54:12 -0800 (PST)
Date:   Tue, 3 Jan 2023 07:54:11 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Message-ID: <20230103065411.2l7k6r57v4phrnos@orel>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:53:16AM +0800, Ley Foon Tan wrote:
> topology_parse_cpu_capacity() is failed to allocate memory with kcalloc()
> after read "capacity-dmips-mhz" DT parameter in CPU DT nodes. This
> topology_parse_cpu_capacity() is called from init_cpu_topology(), move
> call to init_cpu_topology() to later initialization  stage (after memory
> allocation is available).
> 
> Note, this refers to ARM64 implementation, call init_cpu_topology() in
> smp_prepare_cpus().
> 
> Tested on Qemu platform.

Hi Ley,

Can you provide the topologies (command lines) tested?

> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Fixes tag?

> 
> ---
> 
> In drivers/base/arch_topology.c: topology_parse_cpu_capacity():
> 
> 	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
> 				   &cpu_capacity);
> 	if (!ret) {
> 		if (!raw_capacity) {
> 			raw_capacity = kcalloc(num_possible_cpus(),
> 					       sizeof(*raw_capacity),
> 					       GFP_KERNEL);
> 			if (!raw_capacity) {
> 				cap_parsing_failed = true;
> 				return false;
> 			}
> ---
>  arch/riscv/kernel/smpboot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 3373df413c88..ddb2afba6d25 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
>  
>  void __init smp_prepare_boot_cpu(void)
>  {
> -	init_cpu_topology();
>  }
>  
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> @@ -48,6 +47,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	int ret;
>  	unsigned int curr_cpuid;
>  
> +	init_cpu_topology();
> +
>  	curr_cpuid = smp_processor_id();
>  	store_cpu_topology(curr_cpuid);
>  	numa_store_cpu_info(curr_cpuid);
> -- 
> 2.25.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
