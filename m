Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85292719179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFADmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjFADmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:42:00 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58A132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:41:25 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6af89b0f3e5so486849a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685590884; x=1688182884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQY1JU8moFXE1W3SirSI8a8Dbb5xHzyOr30FYUnPWTQ=;
        b=GTWH47FO8OfigD8aP4foNif6vKu6VEruPMOJ+CFA1ngFeUKmmk0mOn4lUbVu24JbGi
         jRtDs1G5Cl3oXSLxtkhtkBLhD81a+nHL9RAzpe12MLFYrpOOsIbOLqghtrEnCPO4Kw/7
         AAt4t8wkTWHmAL2C3akDY4TGn+DcM44x+dUsrKKt9xUbtkiReKAFE+1bU+3yD0u9bMri
         JDYBceL0A1HTxGY+AJ8rwXaBNODjKZJyUJW4+4zEyQM/IyeSk6vLvm3SP63wy8XYB53i
         CJg52nAeyLMn2gdh3UZV4/XM4iuCq+fdjrdOVJ7kiPk6B5laugm2HcK5c72FgELb5pqb
         qmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685590884; x=1688182884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQY1JU8moFXE1W3SirSI8a8Dbb5xHzyOr30FYUnPWTQ=;
        b=GHkzaysSyDsawXQwQT5IiOlis1aHkJAud4lQ591COEdiC3N0e1z4oeWcmerrDGhzfu
         ZIWFGDrQV+hMUAoVXR9Sns/LHf0wMT7Kofg3MgW58kTXJbCOZsZVqjFx43tEPqGeVPZY
         HIvSBYDwmcsqSJj9tqmaASaM2KDB8S5FlP+qvJpKv0Y2+kuufrz0xucWQQxsqwNuoQrW
         nLVneLztEzAQ3Qknwj3L2455bq13KHW9J4snOzDQBW4fPJGrbMH+8Hjj7ym+tCFY3As9
         lkZXk0cCQBhMyY5YOYlb6iGu0K+RDZerKhxphIZAEwj6ozmtUx9OK/IE7mqgnQ4zU3Cs
         9gkQ==
X-Gm-Message-State: AC+VfDwB+dBrGeGABQbrCUbFEEX3xtOHARvdxEDzKyJSWHe6uM5D4QRJ
        ViigaS58xV1v6f+lJLzTwur3DJyHvKYzPoKIgtc=
X-Google-Smtp-Source: ACHHUZ5S27NM5LopXe+Cl3LvtUdlwgpxlePBULRuBPEPkqxvqOyAi9LvTqLQZWwIlVqS2cnUT/IWEg==
X-Received: by 2002:a05:6358:919c:b0:125:9643:3f9b with SMTP id j28-20020a056358919c00b0012596433f9bmr5154855rwa.8.1685590884337;
        Wed, 31 May 2023 20:41:24 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090abf8500b00253305f36c4sm296872pjs.18.2023.05.31.20.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 20:41:23 -0700 (PDT)
Message-ID: <5903fc0a-787e-9471-0256-77ff66f0bdef@bytedance.com>
Date:   Thu, 1 Jun 2023 11:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 8:04 PM, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> Gitweb:        https://git.kernel.org/tip/c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 30 May 2023 13:20:46 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 30 May 2023 22:46:27 +02:00
> 
> sched/fair: Multi-LLC select_idle_sibling()
> 
> Tejun reported that when he targets workqueues towards a specific LLC
> on his Zen2 machine with 3 cores / LLC and 4 LLCs in total, he gets
> significant idle time.
> 
> This is, of course, because of how select_idle_sibling() will not
> consider anything outside of the local LLC, and since all these tasks
> are short running the periodic idle load balancer is ineffective.
> 
> And while it is good to keep work cache local, it is better to not
> have significant idle time. Therefore, have select_idle_sibling() try
> other LLCs inside the same node when the local one comes up empty.
> 
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
>   kernel/sched/features.h |  1 +
>   2 files changed, 39 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0c..0172458 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>   }
>   
>   /*
> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> + * local LLC comes up empty.
> + */
> +static int
> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	struct sched_domain *parent = sd->parent;
> +	struct sched_group *sg;
> +
> +	/* Make sure to not cross nodes. */
> +	if (!parent || parent->flags & SD_NUMA)
> +		return -1;
> +
> +	sg = parent->groups;
> +	do {
> +		int cpu = cpumask_first(sched_group_span(sg));
> +		struct sched_domain *sd_child;
> +
> +		sd_child = per_cpu(sd_llc, cpu);
> +		if (sd_child != sd) {

Since sd_llc is cpu private, I think it should be:

		if (!cpus_share_cache(cpu, target))

> +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
> +			if ((unsigned)i < nr_cpumask_bits)
> +				return i;
> +		}
> +
> +		sg = sg->next;
> +	} while (sg != parent->groups);
> +
> +	return -1;
> +}
> +
> +/*
>    * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
>    * the task fits. If no CPU is big enough, but there are idle ones, try to
>    * maximize capacity.
> @@ -7199,6 +7231,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	if ((unsigned)i < nr_cpumask_bits)
>   		return i;
>   
> +	if (sched_feat(SIS_NODE)) {
> +		i = select_idle_node(p, sd, target);
> +		if ((unsigned)i < nr_cpumask_bits)
> +			return i;
> +	}
> +
>   	return target;
>   }
>   
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c..9e390eb 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>    */
>   SCHED_FEAT(SIS_PROP, false)
>   SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_NODE, true)
>   
>   /*
>    * Issue a WARN when we do multiple update_rq_clock() calls
