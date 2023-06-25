Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3073CDED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjFYB7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFYB7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:59:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FCE10C9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 18:59:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QpZ0X47y9zqV2P;
        Sun, 25 Jun 2023 09:59:24 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:59:36 +0800
Subject: Re: [PATCH] sched/topology: remove unneeded do while loop in
 cpu_attach_domain()
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <yu.c.chen@intel.com>, <tim.c.chen@intel.com>
References: <20230617081926.2035113-1-linmiaohe@huawei.com>
 <20230620141120.GA2016469@hirez.programming.kicks-ass.net>
 <53a9ec35-8332-755c-40ed-54315ffb0d78@huawei.com>
 <20230621131159.GA23663@ranerica-svr.sc.intel.com>
 <20230621185749.GA24063@ranerica-svr.sc.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <268d9d61-ce17-cda6-7a21-148b518ac323@huawei.com>
Date:   Sun, 25 Jun 2023 09:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230621185749.GA24063@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/22 2:57, Ricardo Neri wrote:
> On Wed, Jun 21, 2023 at 06:11:59AM -0700, Ricardo Neri wrote:
>> On Wed, Jun 21, 2023 at 10:53:57AM +0800, Miaohe Lin wrote:
>>> On 2023/6/20 22:11, Peter Zijlstra wrote:
>>>> On Sat, Jun 17, 2023 at 04:19:26PM +0800, Miaohe Lin wrote:
>>>>> When sg != sd->groups, the do while loop would cause deadloop here. But
>>>>> that won't occur because sg is always equal to sd->groups now. Remove
>>>>> this unneeded do while loop.
>>>>
>>>> This Changelog makes no sense to me.. Yes, as is the do {} while loop is
>>>> dead code, but it *should* have read like:
>>>>
>>>> 	do {
>>>> 		sg->flags = 0;
>>>> 		sg = sg->next;
>>>> 	} while (sg != sd->groups);
>>
>> Yes, I agree that this is the correct solution.
> 
> I take this back. I think we should do this:
> 
> @@ -758,19 +758,14 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  		sd = sd->parent;
>  		destroy_sched_domain(tmp);
>  		if (sd) {
> -			struct sched_group *sg = sd->groups;
> -
>  			/*
>  			 * sched groups hold the flags of the child sched
>  			 * domain for convenience. Clear such flags since
>  			 * the child is being destroyed.
>  			 */
> -			do {
> -				sg->flags = 0;
> -			} while (sg != sd->groups);
> +			sd->groups->flags = 0;
>  
>  			sd->child = NULL;
> -		}
>  	}
>  
>  	sched_domain_debug(sd, cpu);
> 
> A comment from Chenyu made got me thinking that we should only clear the
> flags of the local group as viewed from the parent domain. This is because
> the domain being degenerated defines the flags of such group only.

This looks better to my patch. Thanks.

