Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA366DB943
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDHHNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:13:32 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33BC65D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 00:13:30 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id e13so321705plc.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 00:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680938010; x=1683530010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFPAwgiHpT6Plk0qWcWWjF87lkMYlj7GI2OBZM12Wk8=;
        b=4L5vkqD/UVeFICk20XevXguTR2eipTJblvLfWEz9yTHDGgL6GWGr4ViENnEpCcHD9Q
         gtJjRWe50A8xPpZtVIZDhGn57rXaMioKgYX9ZdU6Fxl7Y0LUYAzLhqnGaGVNBhqmMlGA
         /JIAn5NT93JRBOxrI57VNWqow/niASItHDksHnh/zWHf1UbNFBEh4mCq8GbSQ/s7t7x8
         zYFQO1wPneHc+cLxQUbMgvcQcBT1tuST6WSPuQKbD82tDY6mV0p5PU0O5Kg0C22DaMS7
         ndJd2lfWtg86/oEj3Owh6ElhkRfp79Vm2K0hn/dvhjrfxaZWNqOVXym+Mjuam5yrf6Fc
         QHjQ==
X-Gm-Message-State: AAQBX9euGJyI+h8+R9fxCgDrbOrXGcV0/pprBZ/0Q3SJ+8tchm29abzQ
        F810wRb+O1V/OdvcYK7Ubw3eboPwCD2mszAP
X-Google-Smtp-Source: AKy350akPQ2x1a+/y+SQRvlEsDWR2888PrYXbK3d3/S5x1PK1YzPSjyuY3yt62l7K2TKcbhc0OSOrw==
X-Received: by 2002:a17:903:784:b0:19f:3b86:4710 with SMTP id kn4-20020a170903078400b0019f3b864710mr1073029plb.49.1680938009852;
        Sat, 08 Apr 2023 00:13:29 -0700 (PDT)
Received: from snowbird (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001a5157d1a9dsm2080078plb.14.2023.04.08.00.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:13:29 -0700 (PDT)
Date:   Sat, 8 Apr 2023 00:13:26 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        yebin10@huawei.com, dchinner@redhat.com
Subject: Re: [PATCH v2 2/2] lib/percpu_counter: fix dying cpu compare race
Message-ID: <ZDEUFlwlDOTfLshS@snowbird>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
 <20230406015629.1804722-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406015629.1804722-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 06, 2023 at 09:56:29AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
> condition between a cpu dying and percpu_counter_sum() iterating online CPUs
> was identified.
> Acctually, there's the same race condition between a cpu dying and
> __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
> But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
> then maybe return incorrect result.
> To solve above issue, also need to add dying CPUs count when do quick judgment
> in __percpu_counter_compare().
> 

I've thought a lot of about this since you've sent v1. For the general
problem, you haven't addressed Dave's concerns from [1].

I agree you've found a valid race condition, but as Dave mentioned,
there's no synchronization in __percpu_counter_compare() and
consequently no guarantees about the accuracy of the value.

However, I might be missing something, but I do think the use case in 
5825bea05265 ("xfs: __percpu_counter_compare() inode count debug too expensive")
is potentially valid. If the rhs is an expected lower bound or upper
bound (depending on if you're counting up or down, but not both) and the
count you're accounting has the same expectations as percpu_refcount
(you can only subtract what you've already added), then should the
percpu_counter_sum() ever be on the wrong side of rhs, that should be an
error and visible via percpu_counter_compare().

I need to think a little longer, but my initial thought is while you
close a race condition, the function itself is inherently vulnerable.

[1] https://lore.kernel.org/lkml/ZCu9LtdA+NMrfG9x@rh/

Thanks,
Dennis

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  lib/percpu_counter.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..399840cb0012 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
>  	return 0;
>  }
>  
> +static __always_inline unsigned int num_count_cpus(void)
> +{
> +#ifdef CONFIG_HOTPLUG_CPU
> +	return (num_online_cpus() + num_dying_cpus());
> +#else
> +	return num_online_cpus();
> +#endif
> +}
> +
>  /*
>   * Compare counter against given value.
>   * Return 1 if greater, 0 if equal and -1 if less
> @@ -237,7 +246,7 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
>  
>  	count = percpu_counter_read(fbc);
>  	/* Check to see if rough count will be sufficient for comparison */
> -	if (abs(count - rhs) > (batch * num_online_cpus())) {
> +	if (abs(count - rhs) > (batch * num_count_cpus())) {
>  		if (count > rhs)
>  			return 1;
>  		else
> -- 
> 2.31.1
> 
> 
