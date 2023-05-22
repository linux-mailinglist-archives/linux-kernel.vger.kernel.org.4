Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8270B69B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjEVHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjEVHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:35:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F451A8;
        Mon, 22 May 2023 00:35:05 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QPpyN5MqDz18LZm;
        Mon, 22 May 2023 15:30:36 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 15:35:03 +0800
Message-ID: <19707cc6-fa5e-9835-f709-bc8568e4c9cd@huawei.com>
Date:   Mon, 22 May 2023 15:35:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        <kasan-dev@googlegroups.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
 <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
 <CAB=+i9R0GZiau7PKDSGdCOijPH1TVqA3rJ5tQLejJpoR55h6dg@mail.gmail.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <CAB=+i9R0GZiau7PKDSGdCOijPH1TVqA3rJ5tQLejJpoR55h6dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/05/17 6:35, Hyeonggon Yoo wrote:
> [Resending this email after noticing I did not reply-to-all]
> 
> On Fri, May 12, 2023 at 7:11 PM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
>>

[...]

> 
>>>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>>>> +# define SLAB_RANDOMSLAB       ((slab_flags_t __force)0x01000000U)
>>>> +#else
>>>> +# define SLAB_RANDOMSLAB       0
>>>> +#endif
> 
> There is already the SLAB_KMALLOC flag that indicates if a cache is a
> kmalloc cache. I think that would be enough for preventing merging
> kmalloc caches?

After digging into the code of slab merging (e.g. slab_unmergeable(),
find_mergeable(), SLAB_NEVER_MERGE, SLAB_MERGE_SAME etc), I haven't
found an existing mechanism that prevents normal kmalloc caches with
SLAB_KMALLOC from being merged with other slab caches. Maybe I missed
something?

While SLAB_RANDOMSLAB, unlike SLAB_KMALLOC, is added into
SLAB_NEVER_MERGE, which explicitly indicates the no-merge policy.
