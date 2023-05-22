Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8049770C438
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjEVRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjEVRY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:24:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C70D2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:24:27 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 19GhqmkcjMDzt19Ghqo8DH; Mon, 22 May 2023 19:24:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684776265;
        bh=nm++P8Y9/uDiGvoa6cjYyqpsS2Q8yg7M9892T9WHIPU=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Yni4oQh1DkvKr3PxYj//ns4zx/uK4zXePgF16l2Zkp6hqaQ5E3BRERn8rLVZTwQTZ
         NZKWZ5RVcGTCKRjsdobX0+3+pVugJGBDTaTWs3bT5J5R94uQg1HEjTM5ClMpFtaWHU
         m1xxtmWQTOVcn/ddK4cYzBv6S4iX70oIWscwhtZsZW87PRSnudajQxiQKKu+7ChLhC
         I5a7xpEUZIt67636SIV3+rZ5oaJcKq3eA+BWf45gKqCwZQpwsqGqdynn+8OBGURokJ
         s5tdU15ElC+9997+H0+DA7FH/t0vlAwifBghWjAQ+xaE4p1SD63YGYXBLtNE/Fc9Yv
         Xx3k+G2aSW8QA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 May 2023 19:24:25 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c14fedc0-26f6-d4be-8e8b-b1dbefdf50c7@wanadoo.fr>
Date:   Mon, 22 May 2023 19:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cpufreq: intel_pstate: Avoid initializing variables
 prematurely
Content-Language: fr, en-US
To:     Fieah Lim <kweifat@gmail.com>, srinivas.pandruvada@linux.intel.com,
        lenb@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230520133249.22689-1-kweifat@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230520133249.22689-1-kweifat@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/05/2023 à 15:32, Fieah Lim a écrit :
> all_cpu_data struct is pretty large,
> we should avoid assigning it around when the function has a chance
> to bail out earlier before actually using it.
> 
> The same idea applies to the
> this_cpu of notify_hwp_interrupt
> and
> the hwp_cap of intel_pstate_hwp_boost_up,
> which are also initialized prematurely.
> I think it also qualifies as a micro-optimization.
> 
> While at it, tidy up all the cpu_data initialization,
> for the sake of consistency.
> 
> Signed-off-by: Fieah Lim <kweifat@gmail.com>
> ---

[...]

> @@ -2638,9 +2643,7 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>   
>   static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>   {
> -	struct cpudata *cpu = all_cpu_data[policy->cpu];
> -
> -	pr_debug("CPU %d going online\n", cpu->cpu);
> +	pr_debug("CPU %d going online\n", policy->cpu);

An answer has already been done, but just in case, this change does not 
look equivalent.

CJ

>   
>   	intel_pstate_init_acpi_perf_limits(policy);
>   
> @@ -2649,6 +2652,8 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>   		 * Re-enable HWP and clear the "suspended" flag to let "resume"
>   		 * know that it need not do that.
>   		 */
> +		struct cpudata *cpu = all_cpu_data[policy->cpu];
> +
>   		intel_pstate_hwp_reenable(cpu);
>   		cpu->suspended = false;
>   	}

