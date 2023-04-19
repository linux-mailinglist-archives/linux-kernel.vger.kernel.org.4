Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F846E7FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjDSQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjDSQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:53:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42996BB;
        Wed, 19 Apr 2023 09:53:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAD741424;
        Wed, 19 Apr 2023 09:53:47 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE86F3F5A1;
        Wed, 19 Apr 2023 09:53:02 -0700 (PDT)
Message-ID: <41ae3b9e-c774-5061-b045-d5ec2a658880@arm.com>
Date:   Wed, 19 Apr 2023 18:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
 <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
 <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
 <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
 <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
In-Reply-To: <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Just 2 other comments:
> a-
> It might be interesting to change the order in which cpc registers are read
> just to see if it has an impact, but even if it has, I m not sure how this
> could be exploitable.
> Just in case, I mean doing that, but I think that b. might be better to try.
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c51d3ccb4cca..479b55006020 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1350,8 +1350,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>                   }
>           }
>    
> -       cpc_read(cpunum, delivered_reg, &delivered);
>           cpc_read(cpunum, reference_reg, &reference);
> +       cpc_read(cpunum, delivered_reg, &delivered);
>           cpc_read(cpunum, ref_perf_reg, &ref_perf);
>    
>           /*
> 
> b-
> In the trace that you shared, the cpc_read() calls in the fist
> cppc_get_perf_ctrs() calls seem to always take a bit more time than in the
> second cppc_get_perf_ctrs() call.
> Would it be possible to collect traces similar as above with 3 or 4 calls to
> cppc_get_perf_ctrs() instead of 2 ? It would allow to check whether in the first
> call, accessing the cpc registers takes more time than in the following calls,
> due to cache misses or other reasons.
> Ideally statistics on the result would be the best, or if you have a trace.dat
> to share containing a trace with multiple cppc_cpufreq_get_rate() calls.
> 
> Example of code where we do 4 calls to cppc_get_perf_ctrs():
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..6370f2f0bdad 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -853,6 +853,20 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>    
>           udelay(2); /* 2usec delay between sampling */
>    
> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +       if (ret)
> +               return ret;
> +
> +       udelay(2); /* 2usec delay between sampling */
> +
> +       /* Do a third call. */
> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +       if (ret)
> +               return ret;
> +
> +       udelay(2); /* 2usec delay between sampling */
> +
> +       /* Do a fourth call. */
>           ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>           if (ret)
>                   return ret;

And also, if the cpc_read() calls in the third/fourth call are actually faster,
would it be possible to check whether the computed frequency is more accurate
(i.e. no over/undershoot) ?
