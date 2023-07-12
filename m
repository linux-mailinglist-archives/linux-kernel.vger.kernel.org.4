Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2E74FE16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGLEIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGLEIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:08:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC05E69;
        Tue, 11 Jul 2023 21:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YChG1L30DPI1h5Tm1ppaAui5qRCoxqDSfR5uw5XSFq4=; b=DIFtzDM7DrG7bi3/cIyX1Qkmmq
        /JVbO6spNTRVUG2Dxh8j+cxiBRVwVbcRF0YGOtdlaKPnP0Se4nfMLyzxP1IIggBvN5ciMAMJcS+pg
        hlt+fwpEvXBj87n+BL2IXG+KSh1lXAZG61I/XFDYiPVpuKOOL40v1+BTujTcniJWq+FUARkvn+G9A
        gnOvXrqFqfB5EUS+TS4aJXYKjeNp821BOEdri/3/zoNoh90mSp53EPkS7HM5CPClyDZuVChjc/G5/
        votszxxw5DJjuphyNPpG0Iu65T9fPnm2qYfAlTFxs9KMkXnHWipgHqFbO4DdcGO0PTHJsrSM2wATr
        plw6SWcg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJR9d-00GSqU-1O;
        Wed, 12 Jul 2023 04:08:41 +0000
Message-ID: <74f05266-e659-bd2f-e8be-1dc62d82084c@infradead.org>
Date:   Tue, 11 Jul 2023 21:08:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] cpufreq: sparc: Don't mark cpufreq callbacks with __init
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <94682b1572da4a3c6afd31bddf93b797f73fff5e.1689055100.git.viresh.kumar@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <94682b1572da4a3c6afd31bddf93b797f73fff5e.1689055100.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 20:58, Viresh Kumar wrote:
> These callbacks can be called again by the cpufreq core after the driver
> is initialized and must be kept around. We currently get section
> mismatch build warnings.
> 
> Don't mark them with __init.
> 
> Fixes: dcfce7c2cee4 ("cpufreq: sparc: Don't allocate cpufreq_driver dynamically")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Rafael,
> 
> Please apply this for -rc2. Thanks.
> 
>  drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
>  drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
> index d3510cfdb3eb..2783d3d55fce 100644
> --- a/drivers/cpufreq/sparc-us2e-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> @@ -269,7 +269,7 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
>  	return smp_call_function_single(cpu, __us2e_freq_target, &index, 1);
>  }
>  
> -static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
> +static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
>  	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
> diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
> index 91d1ed558136..6c3657679a88 100644
> --- a/drivers/cpufreq/sparc-us3-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us3-cpufreq.c
> @@ -117,7 +117,7 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
>  	return smp_call_function_single(cpu, update_safari_cfg, &new_bits, 1);
>  }
>  
> -static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
> +static int us3_freq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
>  	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;

-- 
~Randy
