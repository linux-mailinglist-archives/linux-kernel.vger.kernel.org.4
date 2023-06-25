Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06F73D0BE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjFYMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFYMBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:01:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15269DA;
        Sun, 25 Jun 2023 05:01:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QpqLt0v4lz4f41Tl;
        Sun, 25 Jun 2023 20:01:10 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP1 (Coremail) with SMTP id cCh0CgCX8BqDLJhkkwNMLw--.23764S2;
        Sun, 25 Jun 2023 20:01:09 +0800 (CST)
Message-ID: <5c222541-4add-2ca6-90a1-faf11e0b5319@huaweicloud.com>
Date:   Sun, 25 Jun 2023 20:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/1] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Jann Horn <jannh@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
 <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
 <3fdc76f0-6c45-c405-0024-d1d69b5bf068@suse.cz>
 <202306221307.6CF63BAC20@keescook>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <202306221307.6CF63BAC20@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgCX8BqDLJhkkwNMLw--.23764S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary7tw18Jw1UZw48uFyrXrb_yoW5JFyDpF
        W3J3W7trs5Jr45Cwn2va1Iqw1Fv3s5tF45Xw1fu345uwn8Ja4IgryDKr4Iqa4kArn3uw10
        qF4j9F97Z3ZIv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/06/23 4:10, Kees Cook wrote:
> On Thu, Jun 22, 2023 at 03:56:04PM +0200, Vlastimil Babka wrote:
>> On 6/16/23 13:18, GONG, Ruiqi wrote:
>>> index a3c95338cd3a..6150e9a946a7 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -337,6 +337,55 @@ config SLUB_CPU_PARTIAL
>>>  	  which requires the taking of locks that may cause latency spikes.
>>>  	  Typically one would choose no for a realtime system.
>>>  
>>> +config RANDOM_KMALLOC_CACHES
>>> +	default n
>>> +	depends on SLUB
>>> +	bool "Random slab caches for normal kmalloc"
>>> +	help
>>> +	  A hardening feature that creates multiple copies of slab caches for
>>> +	  normal kmalloc allocation and makes kmalloc randomly pick one based
>>> +	  on code address, which makes the attackers unable to spray vulnerable
>>> +	  memory objects on the heap for exploiting memory vulnerabilities.
>>> +
>>> +choice
>>> +	prompt "Number of random slab caches copies"
>>> +	depends on RANDOM_KMALLOC_CACHES
>>> +	default RANDOM_KMALLOC_CACHES_16
>>> +	help
>>> +	  The number of copies of random slab caches. Bigger value makes the
>>> +	  potentially vulnerable memory object less likely to collide with
>>> +	  objects allocated from other subsystems or modules.
>>
>> When I read this, without further knowledge, why would I select anything
>> else than the largest value? It should mention memory overhead maybe?
> 
> Yeah, good idea.
> 

No problem. Will add some text about memory overhead into the help
paragraph of RANDOM_KMALLOC_CACHES.

>> Also would anyone really select only "2" and thus limit the collision
>> probability to 50% and not less? "4" also seems quite low for the given
>> purpose? Could we just pick and hardcode 8 or 16 and avoid the selection, at
>> least until there's some more experience with the whole approach?
> 
> I assume it was for doing performance (speed or space) analysis for
> people interested in tuning it. The default is 16, which is what most
> folks will end up with. i.e. I'm not sure I see a benefit to dropping 2
> and 4, since I imagine people will either want the highest value (16),
> or the ability to do a full comparison of each setting.
> 
> Regardless, I would be fine if we dropped 2 and 4, since I am focused on
> the maximum number (16) of hash buckets. :)
> 

It's true that 2 and 4 don't make much sense from the hardening
perspective, and I added them only to cover all possible choices. And
since the overhead difference between 8 and 16 is small, I will hardcode
16 and drop all other options in the next version.

> -Kees
> 

