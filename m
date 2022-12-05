Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403B643544
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiLEUIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiLEUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:08:35 -0500
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64222BE5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:08:32 -0800 (PST)
Date:   Mon, 5 Dec 2022 12:08:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670270910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RM7CfezPPGUav4Lu0t/qwJdsYnLC3YJVlzAQP3YTuPI=;
        b=GiQWgTJ6UTtJOmb5w3cPc9P2E7cWItMRPqs8Se1Z6wFfmT+yiKILuinJ1nWYlLc9UCuonp
        1rquDwpn88+qs6w3Qt79G2pnr9tNFJm/uC31fX+nnJMTXpA5RkxtLTg3iISSilDgk9Sxo+
        8hR4g/SU4Ba738nIjpy4oa7S/9CpuS8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "Luther, Sven" <Sven.Luther@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Bonn, Jonas" <Jonas.Bonn@windriver.com>
Subject: Re: [Regression] mqueue performance degradation after "The new
 cgroup slab memory controller" patchset.
Message-ID: <Y45PuH2C8VdHbrzD@P9FQF9L96D>
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:55:48PM +0000, Luther, Sven wrote:
> #regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792
> 
> We are making heavy use of mqueues, and noticed a degradation of performance between 4.18 & 5.10 linux kernels.
> 
> After a gross per-version tracing, we did kernel bisection between 5.8 and 5.9
> and traced the issue to a 10 patches (of which 9 where skipped as they didn't boot) between:
> 
> 
> commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)
> Author: Roman Gushchin <guro@fb.com>
> Date:   Thu Aug 6 23:21:27 2020 -0700
> 
>     mm: memcg/slab: use a single set of kmem_caches for all allocations
> 
> and:
> 
> commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8ed7a04279ae277f0f024430246ea5eec)
> Author: Roman Gushchin <guro@fb.com>
> Date:   Thu Aug 6 23:20:52 2020 -0700
> 
>     mm: memcg/slab: allocate obj_cgroups for non-root slab pages
> 
> All of them are part of the "The new cgroup slab memory controller" patchset:
> 
>   https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/
> 
> from Roman Gushchin, which moves the accounting for page level to the object level.
> 
> Measurements where done using the a test programmtest, which measures mix/average/max time mqueue_send/mqueue_rcv,
> and average for getppid, both measured over 100 000 runs. Results are shown in the following table
> 
> +----------+--------------------------+-------------------------+----------------+
> | kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getppid     |
> | version  | min avg  max   variation | min avg max   variation | (ns) variation |
> +----------+--------------------------+-------------------------+----------------+
> | 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149      base  |
> | 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -11,83%  |
> | 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -11,83%  |
> | 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -10,78%  |
> | 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -12,87%  |
> | 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -12,87%  |
> +----------+--------------------------+-------------------------+-----------------

Hi Sven!

Thank you for the report! As Waiman said, it's not a secret that per-object tracking
makes individual allocations slower, but for the majority of workloads it's well
compensated by significant memory savings and a lower fragmentation.

It seems there is another regression between 5.15 and 6.03, which is a separate
topic, but how big is the real regression between 4.18 and 5.15? The benchmark
shows about 14%, but is you real workload suffering at the same level?
If the answer is yes, the right thing to do is to introduce some sort of
mqueue-specific caching for allocated objects.

Thanks!

Roman
