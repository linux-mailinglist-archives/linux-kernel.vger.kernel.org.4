Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB65BCB61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiISMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiISMDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:03:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9D10552
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED3041F979;
        Mon, 19 Sep 2022 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663588995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ManmE5V1ehdOvXYbh2CMRxzGTWmNKmsd43FJKsh3l20=;
        b=1VEiDjt3TJwL0CYwU5+HX73Hh5ZW3EFDxgLV8jf4m1rdXtbsijG066zqBqByDMj8BkFgSY
        vza3ix8d9lK3mZUIwcYfxfkKNCrTUYfWpNSkdKXTInmBV4wF+/KEOmrhWrNY3oTBr9EE6S
        NhMEo2VHPMCdDNgIIL1hf+YpeEGJo9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663588995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ManmE5V1ehdOvXYbh2CMRxzGTWmNKmsd43FJKsh3l20=;
        b=TmALi3dK3WBwwTO2sNwA/NlA5t5ns94RgxLdvvpKmj0lxfgzn1VK9wkqldIp3Hjhy+pDh6
        3DPsgpFMj6M78tAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE6F813ABD;
        Mon, 19 Sep 2022 12:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +dPELYNaKGOxHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 19 Sep 2022 12:03:15 +0000
Message-ID: <e736ad09-e29d-7a76-6823-55e14fec87c1@suse.cz>
Date:   Mon, 19 Sep 2022 14:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm/slab_common: fix possiable double free of kmem_cache
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20220919031241.1358001-1-feng.tang@intel.com>
 <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz> <YyhY7RBLxCEuSHp9@hyeyoo>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YyhY7RBLxCEuSHp9@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 13:56, Hyeonggon Yoo wrote:
> On Mon, Sep 19, 2022 at 11:12:38AM +0200, Vlastimil Babka wrote:
>> On 9/19/22 05:12, Feng Tang wrote:
>> > When doing slub_debug test, kfence's 'test_memcache_typesafe_by_rcu'
>> > kunit test case cause a use-after-free error:
>> >
> 
> If I'm not mistaken, I think the subject should be:
> s/double free/use after free/g

Well, it's both AFAICS. By the initial use-after-free we can read a wrong
s->flags that was modified since we freed for the first time, and it can
lead to another kmem_cache_release() which is basically a double free.

>> >   BUG: KASAN: use-after-free in kobject_del+0x14/0x30
>> >   Read of size 8 at addr ffff888007679090 by task kunit_try_catch/261
>> > 
>> >   CPU: 1 PID: 261 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc5-next-20220916 #17
>> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> >   Call Trace:
>> >    <TASK>
>> >    dump_stack_lvl+0x34/0x48
>> >    print_address_description.constprop.0+0x87/0x2a5
>> >    print_report+0x103/0x1ed
>> >    kasan_report+0xb7/0x140
>> >    kobject_del+0x14/0x30
>> >    kmem_cache_destroy+0x130/0x170
>> >    test_exit+0x1a/0x30
>> >    kunit_try_run_case+0xad/0xc0
>> >    kunit_generic_run_threadfn_adapter+0x26/0x50
>> >    kthread+0x17b/0x1b0
>> >    </TASK>
>> > 
>> > The cause is inside kmem_cache_destroy():
>> > 
>> > kmem_cache_destroy
>> >     acquire lock/mutex
>> >     shutdown_cache
>> >         schedule_work(kmem_cache_release) (if RCU flag set)
>> >     release lock/mutex
>> >     kmem_cache_release (if RCU flag set)
>> 
>> 				      ^ not set
>> 
>> I've fixed that up.
>> 
>> > 
>> > in some certain timing, the scheduled work could be run before
>> > the next RCU flag checking which will get a wrong state.
>> > 
>> > Fix it by caching the RCU flag inside protected area, just like 'refcnt'
> 
> Very nice catch, thanks!
> 
> Otherwise (and with Vlastimil's fix):
> 
> Looks good to me.
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
>> > 
>> > Signed-off-by: Feng Tang <feng.tang@intel.com>
>> 
>> Thanks!
>> 
>> > ---
>> > 
>> > note:
>> > 
>> > The error only happens on linux-next tree, and not in Linus' tree,
>> > which already has Waiman's commit:
>> > 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
>> > without holding slab_mutex/cpu_hotplug_lock")
>> 
>> Actually that commit is already in Linus' rc5 too, so I will send your fix
>> this week too. Added a Fixes: 0495e337b703 (...) too.
>> 
>> >  mm/slab_common.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/mm/slab_common.c b/mm/slab_common.c
>> > index 07b948288f84..ccc02573588f 100644
>> > --- a/mm/slab_common.c
>> > +++ b/mm/slab_common.c
>> > @@ -475,6 +475,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
>> >  void kmem_cache_destroy(struct kmem_cache *s)
>> >  {
>> >  	int refcnt;
>> > +	bool rcu_set;
>> >  
>> >  	if (unlikely(!s) || !kasan_check_byte(s))
>> >  		return;
>> > @@ -482,6 +483,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
>> >  	cpus_read_lock();
>> >  	mutex_lock(&slab_mutex);
>> >  
>> > +	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
>> > +
>> >  	refcnt = --s->refcount;
>> >  	if (refcnt)
>> >  		goto out_unlock;
>> > @@ -492,7 +495,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>> >  out_unlock:
>> >  	mutex_unlock(&slab_mutex);
>> >  	cpus_read_unlock();
>> > -	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
>> > +	if (!refcnt && !rcu_set)
>> >  		kmem_cache_release(s);
>> >  }
>> >  EXPORT_SYMBOL(kmem_cache_destroy);
>> 
> 

