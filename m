Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B22642CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiLEQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09341CE1A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670257862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHhzQw/CjxDjwlNJmwDQzqyO8fri5N61JkSmsbVVt1o=;
        b=CO9jaVFnTIhKIJtLQgbKuKLE/m/YrLONmBRcYI69Gc1L8wbOdGeljfW9vPNtF0DX7uhxrB
        zZGGSahj8T10kyBR4dD/Idd+OkFVGKPI9lDjmPWRK54eqvEeW4Jk2KBB2xIvt3Vkai0Vz+
        bjYbyW/u75oiWoSLe/wwp+9q+E7m31Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73--vGpsqClNt6fYfui6UQkLA-1; Mon, 05 Dec 2022 11:30:56 -0500
X-MC-Unique: -vGpsqClNt6fYfui6UQkLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA47D800B23;
        Mon,  5 Dec 2022 16:30:55 +0000 (UTC)
Received: from [10.22.9.203] (unknown [10.22.9.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AACF52028E96;
        Mon,  5 Dec 2022 16:30:54 +0000 (UTC)
Message-ID: <f360e681-0fa9-be4b-ea78-d7783b39048b@redhat.com>
Date:   Mon, 5 Dec 2022 11:30:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [Regression] mqueue performance degradation after "The new cgroup
 slab memory controller" patchset.
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        "Luther, Sven" <Sven.Luther@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Bonn, Jonas" <Jonas.Bonn@windriver.com>
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
 <CALvZod6FGQyuubJ0tAjvBHrhc7r-wFsaz7so74Yk_Fd8x3yLOQ@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CALvZod6FGQyuubJ0tAjvBHrhc7r-wFsaz7so74Yk_Fd8x3yLOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 11:06, Shakeel Butt wrote:
> Hi Sven,
>
> On Mon, Dec 5, 2022 at 6:56 AM Luther, Sven <Sven.Luther@windriver.com> wrote:
>> #regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792
>>
>> We are making heavy use of mqueues, and noticed a degradation of performance between 4.18 & 5.10 linux kernels.
>>
>> After a gross per-version tracing, we did kernel bisection between 5.8 and 5.9
>> and traced the issue to a 10 patches (of which 9 where skipped as they didn't boot) between:
>>
>>
>> commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)
>> Author: Roman Gushchin <guro@fb.com>
>> Date:   Thu Aug 6 23:21:27 2020 -0700
>>
>>      mm: memcg/slab: use a single set of kmem_caches for all allocations
>>
>> and:
>>
>> commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8ed7a04279ae277f0f024430246ea5eec)
>> Author: Roman Gushchin <guro@fb.com>
>> Date:   Thu Aug 6 23:20:52 2020 -0700
>>
>>      mm: memcg/slab: allocate obj_cgroups for non-root slab pages
>>
>> All of them are part of the "The new cgroup slab memory controller" patchset:
>>
>>    https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/
>>
>> from Roman Gushchin, which moves the accounting for page level to the object level.
>>
>> Measurements where done using the a test programmtest, which measures mix/average/max time mqueue_send/mqueue_rcv,
>> and average for getppid, both measured over 100 000 runs. Results are shown in the following table
>>
>> +----------+--------------------------+-------------------------+----------------+
>> | kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getppid     |
>> | version  | min avg  max   variation | min avg max   variation | (ns) variation |
>> +----------+--------------------------+-------------------------+----------------+
>> | 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149      base  |
>> | 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -11,83%  |
>> | 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -11,83%  |
>> | 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -10,78%  |
>> | 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -12,87%  |
>> | 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -12,87%  |
>> +----------+--------------------------+-------------------------+-----------------
>>
> Is the last kernel 6.0.3? Also we know there is performance impact of
> per-object kmem accounting. Can you try the latest i.e. 6.1-rc8? There
> are a couple of memcg charging optimization patches merged in this
> window.

It is known that per-object kmem accounting regresses performance. I had 
submitted a number of optimization patches that got merged into v5.14. 
So the regression is reduced in the 5.15 line above. It looks like there 
are some additional regressions in the latest kernel. We will need to 
figure out what causes it.

Cheers,
Longman

