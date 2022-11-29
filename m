Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3563BE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiK2LD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiK2LDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:03:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE361B82
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:01:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB181F74D;
        Tue, 29 Nov 2022 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669719666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnF+S4ABivhEwceM26UwAyb7GulsTdaWSuk6tmdHDcM=;
        b=VXPAQLSOElgDBdoBRiNcLWHZiOnYHF/4Jv2xS+A+CT917tHnI8IhxHuhrmzKo6h7ci41Q/
        yVQeQSKDuKAgqqilzV5tiw/ktFJXL8dzas7ilhB5/uRADBuaWzT2I88hqfJ2qnYSbxRg6n
        aU2eeer25rQvJTqYWepspR6V6kgbqPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669719666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnF+S4ABivhEwceM26UwAyb7GulsTdaWSuk6tmdHDcM=;
        b=BdTYwDj6ceM4n96RU9Qry5HFkGa0r+Bv3znoZZHKEh7cfUDs8/EgsO4Eek+9mvu6jTaQah
        w33Chl5sbpXBoiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED1BB13AF6;
        Tue, 29 Nov 2022 11:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dx0xOXHmhWMnWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 29 Nov 2022 11:01:05 +0000
Message-ID: <67e6ebce-f8cc-7d28-5e85-8a3909c2d180@suse.cz>
Date:   Tue, 29 Nov 2022 12:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
To:     Marco Elver <elver@google.com>, Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221129063358.3012362-1-feng.tang@intel.com>
 <20221129063358.3012362-2-feng.tang@intel.com>
 <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 10:31, Marco Elver wrote:
> On Tue, 29 Nov 2022 at 07:37, Feng Tang <feng.tang@intel.com> wrote:
>>
>> kmalloc redzone check for slub has been merged, and it's better to add
>> a kunit case for it, which is inspired by a real-world case as described
>> in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):
>>
>> "
>>   octeon-hcd will crash the kernel when SLOB is used. This usually happens
>>   after the 18-byte control transfer when a device descriptor is read.
>>   The DMA engine is always transferring full 32-bit words and if the
>>   transfer is shorter, some random garbage appears after the buffer.
>>   The problem is not visible with SLUB since it rounds up the allocations
>>   to word boundary, and the extra bytes will go undetected.
>> "
>>
>> To avoid interrupting the normal functioning of kmalloc caches, a
>> kmem_cache mimicing kmalloc cache is created with similar and all
>> necessary flags to have kmalloc-redzone enabled, and kmalloc_trace()
>> is used to really test the orig_size and redzone setup.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> ---
>> Changelog:
>>
>>   since v1:
>>   * create a new cache mimicing kmalloc cache, reduce dependency
>>     over global slub_debug setting (Vlastimil Babka)
>>
>>  lib/slub_kunit.c | 23 +++++++++++++++++++++++
>>  mm/slab.h        |  3 ++-
>>  2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
>> index a303adf8f11c..dbdd656624d0 100644
>> --- a/lib/slub_kunit.c
>> +++ b/lib/slub_kunit.c
>> @@ -122,6 +122,28 @@ static void test_clobber_redzone_free(struct kunit *test)
>>         kmem_cache_destroy(s);
>>  }
>>
>> +static void test_kmalloc_redzone_access(struct kunit *test)
>> +{
>> +       struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_kmalloc", 32, 0,
>> +                               SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE|DEFAULT_FLAGS,
>> +                               NULL);
>> +       u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
>> +
>> +       kasan_disable_current();
>> +
>> +       /* Suppress the -Warray-bounds warning */
>> +       OPTIMIZER_HIDE_VAR(p);
>> +       p[18] = 0xab;
>> +       p[19] = 0xab;
>> +
>> +       kmem_cache_free(s, p);
>> +       validate_slab_cache(s);
>> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
>> +
>> +       kasan_enable_current();
>> +       kmem_cache_destroy(s);
>> +}
>> +
>>  static int test_init(struct kunit *test)
>>  {
>>         slab_errors = 0;
>> @@ -141,6 +163,7 @@ static struct kunit_case test_cases[] = {
>>  #endif
>>
>>         KUNIT_CASE(test_clobber_redzone_free),
>> +       KUNIT_CASE(test_kmalloc_redzone_access),
>>         {}
>>  };
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index c71590f3a22b..b6cd98b16ba7 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -327,7 +327,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>>  /* Legal flag mask for kmem_cache_create(), for various configurations */
>>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
>> -                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
>> +                        SLAB_KMALLOC | SLAB_SKIP_KFENCE | \
>> +                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS)
> 
> Shouldn't this hunk be in the previous patch, otherwise that patch
> alone will fail?

Good point.

> This will also make SLAB_SKIP_KFENCE generally available to be used
> for cache creation. This is a significant change, and before it wasn't
> possible. Perhaps add a brief note to the commit message (or have a
> separate patch). We were trying to avoid making this possible, as it
> might be abused - however, given it's required for tests like these, I
> suppose there's no way around it.

For SLAB_SKIP_KFENCE, we could also add the flag after creation to avoid
this trouble? After all there is a sysfs file to control it at runtime
anyway (via skip_kfence_store()).
In that case patch 1 would have to wrap kmem_cache_create() and the flag
addition with a new function to avoid repeating. That function could also be
adding SLAB_NO_USER_FLAGS to kmem_cache_create(), instead of the #define
DEFAULT_FLAGS.

For SLAB_KMALLOC there's probably no such way unless we abuse the internal
APIs even more and call e.g. create_boot_cache() instead of
kmem_cache_create(). But that one is __init, so probably not. If we do
instead allow the flag, I wouldn't add it to SLAB_CORE_FLAGS but rather
SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTED.

> Thanks,
> -- Marco

