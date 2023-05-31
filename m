Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43080717962
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjEaIBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjEaIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:00:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FF10D9;
        Wed, 31 May 2023 00:59:51 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QWM4Z0qGdz18Lsy;
        Wed, 31 May 2023 15:55:10 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 15:59:47 +0800
Message-ID: <83f6cfbd-d081-5a76-7c7f-5e0b90b4ac74@huawei.com>
Date:   Wed, 31 May 2023 15:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        <kasan-dev@googlegroups.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <202305161204.CB4A87C13@keescook>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <202305161204.CB4A87C13@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply. I was trapped by other in-house kernel issues
these days.

On 2023/05/17 3:34, Kees Cook wrote:
> For new CCs, the start of this thread is here[0].
> 
> On Mon, May 08, 2023 at 03:55:07PM +0800, GONG, Ruiqi wrote:
>> When exploiting memory vulnerabilities, "heap spraying" is a common
>> technique targeting those related to dynamic memory allocation (i.e. the
>> "heap"), and it plays an important role in a successful exploitation.
>> Basically, it is to overwrite the memory area of vulnerable object by
>> triggering allocation in other subsystems or modules and therefore
>> getting a reference to the targeted memory location. It's usable on
>> various types of vulnerablity including use after free (UAF), heap out-
>> of-bound write and etc.
> 
> I heartily agree we need some better approaches to deal with UAF, and
> by extension, heap spraying.

Thanks Kees :) Good to hear that!

> 
>> There are (at least) two reasons why the heap can be sprayed: 1) generic
>> slab caches are shared among different subsystems and modules, and
>> 2) dedicated slab caches could be merged with the generic ones.
>> Currently these two factors cannot be prevented at a low cost: the first
>> one is a widely used memory allocation mechanism, and shutting down slab
>> merging completely via `slub_nomerge` would be overkill.
>>
>> To efficiently prevent heap spraying, we propose the following approach:
>> to create multiple copies of generic slab caches that will never be
>> merged, and random one of them will be used at allocation. The random
>> selection is based on the address of code that calls `kmalloc()`, which
>> means it is static at runtime (rather than dynamically determined at
>> each time of allocation, which could be bypassed by repeatedly spraying
>> in brute force). In this way, the vulnerable object and memory allocated
>> in other subsystems and modules will (most probably) be on different
>> slab caches, which prevents the object from being sprayed.
> 
> This is a nice balance between the best option we have now
> ("slub_nomerge") and most invasive changes (type-based allocation
> segregation, which requires at least extensive compiler support),
> forcing some caches to be "out of reach".

Yes it is, and it's also cost-effective: achieving a quite satisfactory
mitigation with a small amount of code (only ~130 lines).

I get this impression also because (believe it or not) we did try to
implement similar idea as the latter one you mention, and that was super
complex, and the workload was really huge ...

> 
>>
>> The overhead of performance has been tested on a 40-core x86 server by
>> comparing the results of `perf bench all` between the kernels with and
>> without this patch based on the latest linux-next kernel, which shows
>> minor difference. A subset of benchmarks are listed below:
>>
>> 			control		experiment (avg of 3 samples)
>> sched/messaging (sec)	0.019		0.019
>> sched/pipe (sec)	5.253		5.340
>> syscall/basic (sec)	0.741		0.742
>> mem/memcpy (GB/sec)	15.258789	14.860495
>> mem/memset (GB/sec)	48.828125	50.431069
>>
>> The overhead of memory usage was measured by executing `free` after boot
>> on a QEMU VM with 1GB total memory, and as expected, it's positively
>> correlated with # of cache copies:
>>
>> 		control		4 copies	8 copies	16 copies
>> total		969.8M		968.2M		968.2M		968.2M
>> used		20.0M		21.9M		24.1M		26.7M
>> free		936.9M		933.6M		931.4M		928.6M
>> available	932.2M		928.8M		926.6M		923.9M
> 
> Great to see the impact: it's relatively tiny. Nice!
> 
> Back when we looked at cache quarantines, Jann pointed out that it
> was still possible to perform heap spraying -- it just needed more
> allocations. In this case, I think that's addressed (probabilistically)
> by making it less likely that a cache where a UAF is reachable is merged
> with something with strong exploitation primitives (e.g. msgsnd).
> 
> In light of all the UAF attack/defense breakdowns in Jann's blog
> post[1], I'm curious where this defense lands. It seems like it would
> keep the primitives described there (i.e. "upgrading" the heap spray
> into a page table "type confusion") would be addressed probabilistically
> just like any other style of attack. Jann, what do you think, and how
> does it compare to the KCTF work[2] you've been doing?

A kindly ping to Jann ;)

> 
> In addition to this work, I'd like to see something like the kmalloc
> caches, but for kmem_cache_alloc(), where a dedicated cache of
> variably-sized allocations can be managed. With that, we can split off
> _dedicated_ caches where we know there are strong exploitation
> primitives (i.e. msgsnd, etc). Then we can carve off known weak heap
> allocation caches as well as make merging probabilistically harder.

Would you please explain more about the necessity of applying similar
mitigation mechanism to dedicated caches?

Based on my knowledge, usually we believe dedicated caches are more
secure, although it's still possible to spray them, e.g. by the
technique that allocates & frees large amounts of slab objects to
manipulate the heap in pages. Nevertheless in most of cases they are
still good since such spraying is (considered to be) hard to implement.

Meanwhile, the aforementioned spraying technique can hardly be mitigated
within SLAB since it operates at the page level, and our randomization
idea cannot protect against it either, so it also makes me inclined to
believe it's not meaningful to apply randomization to dedicated caches.

> I imagine it would be possible to then split this series into two
> halves: one that creates the "make arbitrary-sized caches" API, and the
> second that applies that to kmalloc globally (as done here).
> 
>>
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
>>
>> v2:
>>   - Use hash_64() and a per-boot random seed to select kmalloc() caches.
> 
> This is good: I was hoping there would be something to make it per-boot
> randomized beyond just compile-time.
> 
> So, yes, I think this is worth it, but I'd like to see what design holes
> Jann can poke in it first. :)

Thanks again! I'm looking forward to receiving more comments from mm and
hardening developers.

> 
> -Kees
> 
> [0] https://lore.kernel.org/lkml/20230508075507.1720950-1-gongruiqi1@huawei.com/
> [1] https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html
> [2] https://github.com/thejh/linux/commit/a87ad16046f6f7fd61080ebfb93753366466b761
> 
