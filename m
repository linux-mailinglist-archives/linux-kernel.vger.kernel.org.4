Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF2615D93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKBIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKBIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:22:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA8620BD6;
        Wed,  2 Nov 2022 01:22:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA5B31F86C;
        Wed,  2 Nov 2022 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667377357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPRiEjy3sfuyzgubEp1HGpBV7YGim3ifA/HV0tLfnYk=;
        b=HR0DbvwEKwqE0jXE9wxcEt6cpVRp4LaTS6f9pIr9OBR0pTABiwb4A5kP2ggUe8XOvvuvAI
        V/a9ucMZIK4X1p5ZxB739DwpyE0wEwJ+bav0iWKoh9rmqBgHQ3AH63WQU0/niXPj+pmigZ
        R8zhqttaA0RSTouc/gNBy6nOr14wXQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667377357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPRiEjy3sfuyzgubEp1HGpBV7YGim3ifA/HV0tLfnYk=;
        b=6AUEvKJ4zLJGEWdb+7cxizn2dkm9ueZljCFWDB0EFv/CmZ+chd6ZmglRG7XH+EEPwxSK1H
        zu0Fwco3uVxZw2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 924811376E;
        Wed,  2 Nov 2022 08:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PpT3Is0oYmMuCAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Nov 2022 08:22:37 +0000
Message-ID: <097d8fba-bd10-a312-24a3-a4068c4f424c@suse.cz>
Date:   Wed, 2 Nov 2022 09:22:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
To:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz> <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 11:33, John Thomson wrote:
> On Tue, 1 Nov 2022, at 09:31, Hyeonggon Yoo wrote:
>> On Tue, Nov 01, 2022 at 09:20:21AM +0000, John Thomson wrote:
>>> On Tue, 1 Nov 2022, at 07:57, Feng Tang wrote:
>>> > Hi Thomson,
>>> >
>>> > Thanks for testing!
>>> >
>>> > + mips maintainer and mail list. The original report is here
>>> >
>>> > https://lore.kernel.org/lkml/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
>>>
>>> I am guessing my issue comes from __kmem_cache_alloc_lru accessing s->object_size when (kmem_cache) s is NULL?
>>> If that is the case, this change is not to blame, it only exposes the issue?
>>> 
>>> I get the following dmesg (note very early NULL kmem_cache) with the below change atop v6.1-rc3:
>>> 
>>> transfer started ......................................... transfer ok, time=2.02s
>>> setting up elf image... OK
>>> jumping to kernel code
>>> zimage at:     80B842A0 810B4EFC
>>> 
>>> Uncompressing Linux at load address 80001000
>>> 
>>> Copy device tree to address  80B80EE0
>>> 
>>> Now, booting the kernel...
>>> 
>>> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #61 SMP Tue Nov  1 18:04:13 AEST 2022
>>> [    0.000000] slub: kmem_cache_alloc called with kmem_cache: 0x0
>>> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache: 0x0
>>> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
>>> [    0.000000] printk: bootconsole [early0] enabled
>>> [    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
>>> [    0.000000] MIPS: machine is MikroTik RouterBOARD 760iGS
>>> 
>>> normal boot
>>> 
>>> 
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 157527d7101b..10fcdf2520d2 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -3410,7 +3410,13 @@ static __always_inline
>>>  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>>  			     gfp_t gfpflags)
>>>  {
>>> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>>> +	void *ret;
>>> +	if (IS_ERR_OR_NULL(s)) {
>>> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
>>> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, 0);
>>> +	} else {
>>> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>>> +	}
>>>  
>>>  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
>>>  
>>> @@ -3419,6 +3425,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>>  
>>>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
>>>  {
>>> +	if (IS_ERR_OR_NULL(s))
>>> +		pr_warn("slub: kmem_cache_alloc called with kmem_cache: %pSR\n", s);
>>>  	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
>>>  }
>>>  EXPORT_SYMBOL(kmem_cache_alloc);
>>> @@ -3426,6 +3434,8 @@ EXPORT_SYMBOL(kmem_cache_alloc);
>>>  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>>  			   gfp_t gfpflags)
>>>  {
>>> +	if (IS_ERR_OR_NULL(s))
>>> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
>>>  	return __kmem_cache_alloc_lru(s, lru, gfpflags);
>>>  }
>>>  EXPORT_SYMBOL(kmem_cache_alloc_lru);
>>> 
>>> 
>>> Any hints on where kmem_cache_alloc would be being called from this early?
>>> I will start looking from /init/main.c around pr_notice("%s", linux_banner);
>>
>> Great. Would you try calling dump_stack(); when we observed s == NULL?
>> That would give more information about who passed s == NULL to these
>> functions.
>>
> 
> With the dump_stack() in place:
> 
> Now, booting the kernel...
> 
> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #62 SMP Tue Nov  1 19:49:52 AEST 2022
> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache ptr: 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #62
> [    0.000000] Stack : 810fff78 80084d98 80889d00 00000004 00000000 00000000 80889d5c 80c90000
> [    0.000000]         80920000 807bd380 8089d368 80923bd3 00000000 00000001 80889d08 00000000
> [    0.000000]         00000000 00000000 807bd380 8084bd51 00000002 00000002 00000001 6d6f4320
> [    0.000000]         00000000 80c97ce9 80c97d14 fffffffc 807bd380 00000000 00000003 00000dc0
> [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<80008260>] show_stack+0x28/0xf0
> [    0.000000] [<8070cdc0>] dump_stack_lvl+0x60/0x80
> [    0.000000] [<801c1428>] kmem_cache_alloc+0x5c0/0x740
> [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> [    0.000000] [<80928060>] prom_init+0x44/0xf0
> [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> [    0.000000] 
> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3

The stack means CONFIG_TRACING=n, is that right?

That would mean
prom_soc_init()
  soc_dev_init()
    kzalloc() -> kmalloc()
      kmalloc_trace()  // after #else /* CONFIG_TRACING */
        kmem_cache_alloc(s, flags);

Looks like this path is a small bug in the wasting detection patch, as we
throw away size there.

AFAICS before this patch, we "survive" "kmem_cache *s" being NULL as
slab_pre_alloc_hook() will happen to return NULL and we bail out from
slab_alloc_node(). But this is a side-effect, not an intended protection.
Also the CONFIG_TRACING variant of kmalloc_trace() would have called
trace_kmalloc dereferencing s->size anyway even before this patch.

I don't think we should add WARNS in the slab hot paths just to prevent this
rare error of using slab too early. At most VM_WARN... would be acceptable
but still not necessary as crashing immediately from a NULL pointer is
sufficient.

So IMHO mips should fix their soc init, and we should look into the
CONFIG_TRACING=n variant of kmalloc_trace(), to pass orig_size properly.
