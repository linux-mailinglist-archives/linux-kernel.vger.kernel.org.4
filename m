Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0BC70270D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjEOIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjEOIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:20:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BAE6C;
        Mon, 15 May 2023 01:20:05 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKXLN6zGXzsR3y;
        Mon, 15 May 2023 16:18:04 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 16:20:02 +0800
Message-ID: <6db163dc-e7fc-e304-5007-74db66a3ad1a@huawei.com>
Date:   Mon, 15 May 2023 16:20:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
 <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
 <b9331fe4-11c8-5323-e757-5cae3c1e2233@suse.cz>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <b9331fe4-11c8-5323-e757-5cae3c1e2233@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/05/14 17:30, Vlastimil Babka wrote:
> On 5/12/23 12:11, Gong Ruiqi wrote:
>>
>>
>> On 2023/05/11 2:43, Hyeonggon Yoo wrote:
>>> On Mon, May 8, 2023 at 12:53 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>>>>
>>
>> [...]
>>
>>>>
>>>> The overhead of performance has been tested on a 40-core x86 server by
>>>> comparing the results of `perf bench all` between the kernels with and
>>>> without this patch based on the latest linux-next kernel, which shows
>>>> minor difference. A subset of benchmarks are listed below:
>>>>
>>>
>>> Please Cc maintainers/reviewers of corresponding subsystem in MAINTAINERS file.
>>
>> Okay, I've appended maintainers/reviewers of linux-hardening and
>> security subsystem to the Cc list.
> 
> I think they were CC'd on v1 but didn't respond yet. I thought maybe if
> I run into Kees at OSS, I will ask him about it, but didn't happen.

Yeah it would be great if you can contact Kees or other developers of
hardening to know their opinions about this, since I'm curious about
what they think of this as well.

> As a slab maintainer I don't mind adding such things if they don't
> complicate the code excessively, and have no overhead when configured
> out. This one would seem to be acceptable at first glance, although
> maybe the CONFIG space is too wide, and the amount of #defines in
> slab_common.c is also large (maybe there's a way to make it more
> concise, maybe not).
> 
> But I don't have enough insight into hardening to decide if it's a
> useful mitigation that people would enable, so I'd hope for hardening
> folks to advise on that. Similar situation with freelist hardening in
> the past, which was even actively pushed by Kees, IIRC.

For the effectiveness of this mechanism, I would like to provide some
results of the experiments I did. I conducted actual defense tests on
CVE-2021-22555 and CVE-2016-8655 by reverting fixing patch to recreate
exploitable environments, and running the exploits/PoCs on the
vulnerable kernel with and without our randomized kmalloc caches patch.
With our patch, the originally exploitable environments were not pwned
by running the PoCs.
