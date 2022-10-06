Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A165F6778
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiJFNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJFNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:12:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275ABA8CC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:12:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a26so4502167ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Uj6swI85SnMt4TKWB4hA3wAhngDCYA06Mr8UAbXCX9Q=;
        b=VLze14syKQUDXjp5/yioqgGgQub40T7iLwx0bcq0vmk1DWgeotwUNey5IC5+jct8we
         advC8w3sx41bRGYKYK5gbZ3vtJ3XOWmDnIPPeqfndqbJIUT7VP6bD9r0CGGUXE78xtVl
         VBjwCFz/fl9AYvb14rHbDLU/irXt5UNnAk6F0jrnNMLtciVTtH2pW7n62PIYonunUR2T
         exA5+/dMg9cW0Y1IqJ0mJ+wxJioANSA61aUWYPvyV6a3rHC0fMIDadBuvjwxIeQToRLd
         sZxGZTI6OkF10MbSdAkr9JI1OqzrBcz++Jj3efKBO3YxUbQxRpaHZ53TURiKSNQaNs8d
         rksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Uj6swI85SnMt4TKWB4hA3wAhngDCYA06Mr8UAbXCX9Q=;
        b=ry6wDb42JbpifmVInt9KSzerDV1DBaO3wnWJjZ0mLnqpPWdSpt5XYEg6E2dILm9mQq
         mr7Z5JRas4757WT1N0sWI3/JVvxH2Thtbvtieu10E6fEQQD73EWki5eYw2N6o9QJfs41
         xES+aV1YBrT3hCj/pRmqzpZYKqvyAjxHvOnVoqlv6591mUE1GT3UHAz+kZ3//njToc80
         JNuMm68Q8D32OZIU2Ti/6sly8vdPWHHcB3f3cHxnofSt2FprFzDqs3MD/RwH9DV+unjb
         wEG+ArAPAzQZg3jY+I3hd9AFecZCVhbk21+bOxMCT/v9rVPaNz2bexRpd3bv1+bqjdkt
         EkzQ==
X-Gm-Message-State: ACrzQf1nYsd3J25KR+ld6D8lEq704Xh4kssQvRaocRRPjEX6VI2JxN1d
        ZwkuPFjkzDetRLyesOoHiOWhmw==
X-Google-Smtp-Source: AMsMyM5SXI6WyfxKVT3COUhfJ3/eLrlCeOa5idtoTaRyPcPX0sjtGwzkIm7M3KN/vsm+USPV7Fj4Dg==
X-Received: by 2002:a17:907:8686:b0:78b:9606:8b9c with SMTP id qa6-20020a170907868600b0078b96068b9cmr4032609ejc.134.1665061967759;
        Thu, 06 Oct 2022 06:12:47 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id c25-20020aa7c999000000b00457160c3c77sm5707205edt.20.2022.10.06.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:12:47 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:12:46 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] riscv: cpufeature: detect
 RISCV_ALTERNATIVES_EARLY_BOOT earlier
Message-ID: <20221006131246.45m2qqoqfzq6dmls@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:12PM +0800, Jisheng Zhang wrote:
> Now, the riscv_cpufeature_patch_func() do nothing in the stage of
> RISCV_ALTERNATIVES_EARLY_BOOT. We can move the detection of "early
> boot" stage earlier.
> 
> In following patch, we will make riscv_cpufeature_patch_func() scans
> all ISA extensions.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/cpufeature.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 03611b3ef45e..afa54635c180 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -307,6 +307,9 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  	struct alt_entry *alt;
>  	u32 tmp;
>  
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return;
> +
>  	for (alt = begin; alt < end; alt++) {
>  		if (alt->vendor_id != 0)
>  			continue;
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
