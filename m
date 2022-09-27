Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE55EC9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiI0Qps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiI0Qp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28213F26
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664297120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJgd373y00u6OoO8RAM18F2fCJ0BD0Jh8m7p8Foc1w4=;
        b=HALDpdaJJLm/mtmrTR1NvNXdF1gAkfyEJhTdz1VkZ+a8KhyOnUv6AtQiiShCrc4vs+WoQw
        mC85HfDF0tcYDONig82lumt86TOlPAp1eJAkJb3DoIE74EQPfFu2sDYxZgGVFqrKcju3cl
        V3yUt1KCA7gq27k8sgqbfAGrsq52eyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-2wGeArcLMaKnGWTeeoKwlg-1; Tue, 27 Sep 2022 12:45:19 -0400
X-MC-Unique: 2wGeArcLMaKnGWTeeoKwlg-1
Received: by mail-wm1-f71.google.com with SMTP id r7-20020a1c4407000000b003b3f017f259so5798523wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=eJgd373y00u6OoO8RAM18F2fCJ0BD0Jh8m7p8Foc1w4=;
        b=jkPOwlSofqjZPMvYmpFTiqmzkeP5LDlcYa7L/VrpfjbF7s88ECffE165p+sYL7jPlI
         HDR/OP6q3XnPsxPLHOOQ8L+C+vkOJIManJWMLgO+Eec9Y5kayxOzn+GiejCaBPNW7sCD
         93UJ6xeWpVk1+xL/QgP+Qj5EPMun6+p6898Caj/bhEzpK5piZjYjtPTRlyWr7BSJA4KM
         RcdGhOZQugrDbN3X0CTqs/lfWXFt15RjNqUbtr2BT7pYCCbu3H24XAZFf9Lz7XYxcxB8
         G7h2/DP64+L2yAGmt9v/p26Y0fy2vfeM418FRgIXSatcv+klNbwCLbxM3bLp4AjWtf1L
         frEg==
X-Gm-Message-State: ACrzQf0UTKczaQjSAWYMYa0mtJ9qVuv/JbXYZkg1wWJ1hpzZaVvqjAEC
        feyO7v2BcV1f5e3OB8ep6LbDLGecNyzG3sDHxv+NuCCAAHdpQW6l04MQ7iGFv6zHp02+rz3/B8Y
        kI5ts4KgpReRCmJn3GJgEayQg
X-Received: by 2002:a05:6000:1687:b0:22a:3516:4f98 with SMTP id y7-20020a056000168700b0022a35164f98mr17198012wrd.525.1664297118139;
        Tue, 27 Sep 2022 09:45:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5TSt7aiYS9wyhijktid6xBQmelnexwMFjxC9sY22eg66YL48Ms5o3nyBrUuZcLFa9dXplgPw==
X-Received: by 2002:a05:6000:1687:b0:22a:3516:4f98 with SMTP id y7-20020a056000168700b0022a35164f98mr17197998wrd.525.1664297117969;
        Tue, 27 Sep 2022 09:45:17 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b003b477532e66sm3637988wms.2.2022.09.27.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:45:17 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v4 5/7] sched/topology: Introduce sched_numa_hop_mask()
In-Reply-To: <YzCYXEytXy8UJQFv@yury-laptop>
References: <20220923132527.1001870-1-vschneid@redhat.com>
 <20220923155542.1212814-4-vschneid@redhat.com>
 <YzCYXEytXy8UJQFv@yury-laptop>
Date:   Tue, 27 Sep 2022 17:45:15 +0100
Message-ID: <xhsmhfsgc4vhg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/22 11:05, Yury Norov wrote:
> On Fri, Sep 23, 2022 at 04:55:40PM +0100, Valentin Schneider wrote:
>> +const struct cpumask *sched_numa_hop_mask(int node, int hops)
>> +{
>> +	struct cpumask ***masks = rcu_dereference(sched_domains_numa_masks);
>> +
>> +	if (node == NUMA_NO_NODE && !hops)
>> +		return cpu_online_mask;
>> +
>> +	if (node >= nr_node_ids || hops >= sched_domains_numa_levels)
>> +		return ERR_PTR(-EINVAL);
>
> This looks like a sanity check. If so, it should go before the snippet
> above, so that client code would behave consistently.
>

nr_node_ids is unsigned, so -1 >= nr_node_ids is true.

>> +
>> +	if (!masks)
>> +		return NULL;
>
> In (node == NUMA_NO_NODE && !hops) case you return online cpus. Here
> you return NULL just to convert it to cpu_online_mask in the caller.
> This looks inconsistent. So, together with the above comment, this
> makes me feel that you'd do it like this:
>
>  const struct cpumask *sched_numa_hop_mask(int node, int hops)
>  {
>       struct cpumask ***masks;
>
>       if (node >= nr_node_ids || hops >= sched_domains_numa_levels)
>         {
>  #ifdef CONFIG_SCHED_DEBUG
>                 pr_err(...);
>  #endif
>               return ERR_PTR(-EINVAL);
>         }
>
>       if (node == NUMA_NO_NODE && !hops)
>               return cpu_online_mask; /* or NULL */
>
>         masks = rcu_dereference(sched_domains_numa_masks);
>       if (!masks)
>               return cpu_online_mask; /* or NULL */
>
>       return masks[hops][node];
>  }

If we're being pedantic, sched_numa_hop_mask() shouldn't return
cpu_online_mask in those cases, but that was the least horrible
option I found to get something sensible for the NUMA_NO_NODE /
!CONFIG_NUMA case. I might be able to better handle this with your
suggestion of having a mask iterator.

