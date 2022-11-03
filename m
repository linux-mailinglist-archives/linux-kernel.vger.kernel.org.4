Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033166178B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKCIde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:33:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B91163;
        Thu,  3 Nov 2022 01:33:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D09222207;
        Thu,  3 Nov 2022 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667464409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lW8tq5oEp8fEH7EtnVZjUEBjsnMp73rXze5VdCAXOxQ=;
        b=mjIZMVd0ZM7fO7d9A8eqEbCu3XQ0/sd59ol7mHMNaRGHy0Of/euQC66bED81re4A0KCFab
        TDbjQg5fsNt3tBE0niyv724ac843sr3ZVZhtGVHqB017EkaVf7RYqZLcjXl5ofldOSFUsD
        GOkHicyNXmmyDVz7wXXYq5hJwXR3wdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667464409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lW8tq5oEp8fEH7EtnVZjUEBjsnMp73rXze5VdCAXOxQ=;
        b=mMWuZH57DHFGF2PA9VSi7g2hTnHZ9xbv9Og+AUP02fWcp83Y657n9sx9EEbh5Yj4y8qWmH
        j2BJEyTOiqt3dVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8B7013AAF;
        Thu,  3 Nov 2022 08:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MvsjNNh8Y2MrPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Nov 2022 08:33:28 +0000
Message-ID: <f88a5d34-de05-25d7-832d-36b3a3eddd72@suse.cz>
Date:   Thu, 3 Nov 2022 09:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
To:     Feng Tang <feng.tang@intel.com>
Cc:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz>
 <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <097d8fba-bd10-a312-24a3-a4068c4f424c@suse.cz> <Y2NXiiAF6V2DnBrB@feng-clx>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y2NXiiAF6V2DnBrB@feng-clx>
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

On 11/3/22 06:54, Feng Tang wrote:
> On Wed, Nov 02, 2022 at 04:22:37PM +0800, Vlastimil Babka wrote:
>> On 11/1/22 11:33, John Thomson wrote:
> [...]
>> > 
>> > [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #62 SMP Tue Nov  1 19:49:52 AEST 2022
>> > [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache ptr: 0x0
>> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #62
>> > [    0.000000] Stack : 810fff78 80084d98 80889d00 00000004 00000000 00000000 80889d5c 80c90000
>> > [    0.000000]         80920000 807bd380 8089d368 80923bd3 00000000 00000001 80889d08 00000000
>> > [    0.000000]         00000000 00000000 807bd380 8084bd51 00000002 00000002 00000001 6d6f4320
>> > [    0.000000]         00000000 80c97ce9 80c97d14 fffffffc 807bd380 00000000 00000003 00000dc0
>> > [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
>> > [    0.000000]         ...
>> > [    0.000000] Call Trace:
>> > [    0.000000] [<80008260>] show_stack+0x28/0xf0
>> > [    0.000000] [<8070cdc0>] dump_stack_lvl+0x60/0x80
>> > [    0.000000] [<801c1428>] kmem_cache_alloc+0x5c0/0x740
>> > [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
>> > [    0.000000] [<80928060>] prom_init+0x44/0xf0
>> > [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
>> > [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
>> > [    0.000000] 
>> > [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
>> 
>> The stack means CONFIG_TRACING=n, is that right?
>  
> Yes, from the kconfig, CONFIG_TRACING is not set.
> 
>> That would mean
>> prom_soc_init()
>>   soc_dev_init()
>>     kzalloc() -> kmalloc()
>>       kmalloc_trace()  // after #else /* CONFIG_TRACING */
>>         kmem_cache_alloc(s, flags);
>> 
>> Looks like this path is a small bug in the wasting detection patch, as we
>> throw away size there.
> 
> Yes, from the code reading and log from John, it is.
> 
> One strange thing is, I reset the code to v6.0, and found that 
> __kmem_cache_alloc_lru() also access the 's->object_size'
> 
> void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> 			     gfp_t gfpflags)
> {
> 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> 	...
> }
> 
> And from John's dump_stack() info, this call is also where the NULL pointer
> happens, which I still can't figue out.
> 
>> AFAICS before this patch, we "survive" "kmem_cache *s" being NULL as
>> slab_pre_alloc_hook() will happen to return NULL and we bail out from
>> slab_alloc_node(). But this is a side-effect, not an intended protection.
>> Also the CONFIG_TRACING variant of kmalloc_trace() would have called
>> trace_kmalloc dereferencing s->size anyway even before this patch.
>> 
>> I don't think we should add WARNS in the slab hot paths just to prevent this
>> rare error of using slab too early. At most VM_WARN... would be acceptable
>> but still not necessary as crashing immediately from a NULL pointer is
>> sufficient.
>> 
>> So IMHO mips should fix their soc init, 
> 
> Yes, for the mips fix, John has proposed to defer the calling of prom_soc_init(),
> which looks reasonable.
> 
>> and we should look into the
>> CONFIG_TRACING=n variant of kmalloc_trace(), to pass orig_size properly.
> 
> You mean check if the pointer is NULL and bail out early. 

No I mean here:

#else /* CONFIG_TRACING */
/* Save a function call when CONFIG_TRACING=n */
static __always_inline __alloc_size(3)                                   
void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
{       
        void *ret = kmem_cache_alloc(s, flags);
                    
        ret = kasan_kmalloc(s, ret, size, flags);
        return ret;
}

we call kmem_cache_alloc() and discard the size parameter, so it will assume
s->object_size (and as the side-effect, crash if s is NULL). We shouldn't
add "s is NULL?" checks, but fix passing the size - probably switch to
__kmem_cache_alloc_node()? and in the following kmalloc_node_trace() analogically.

