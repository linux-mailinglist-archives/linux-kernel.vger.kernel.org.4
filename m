Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C99635842
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiKWJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiKWJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:51:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE710FC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:48:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7DDD21D31;
        Wed, 23 Nov 2022 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669196930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXnIT/Zuv/T9a6KrJB+Xh6C3fIWPtdkO8jUxlxm68QQ=;
        b=YhJf3I9D2zC2cBY/PyUxqamizkk+xOpt6DDPWggzNjfKGw/ztZj5ZVRlvdtxNqbMkh9ldD
        SmvEKDBl1Keh7KFoepi+1nN3cEJ3muFktHYiUHjQjr50yC422Q9yo+hOU8KwVwYUd03Jn8
        y2G7uW+nq66IaOqyRfwEEnpNM6/YPHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669196930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXnIT/Zuv/T9a6KrJB+Xh6C3fIWPtdkO8jUxlxm68QQ=;
        b=whDE5RtofSTF6F482RYSjyyVqlWmnxwr7p+bvoSr38u605fihA3+M8n8SzqQOzanUP+5/I
        DT/HmwimlAIJCaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 867AA13AE7;
        Wed, 23 Nov 2022 09:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yN/6H4LsfWOVGQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Nov 2022 09:48:50 +0000
Message-ID: <88abafb9-a961-a217-a95c-744258498722@suse.cz>
Date:   Wed, 23 Nov 2022 10:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 0/3] mm/slub: extend redzone check for kmalloc objects
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <f9da0749-c109-1251-8489-de3cfb50ab24@suse.cz> <Y24H998aujvYXjkV@feng-clx>
 <Y3sc1G6WEKte4Awd@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y3sc1G6WEKte4Awd@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 07:38, Feng Tang wrote:
> On Fri, Nov 11, 2022 at 04:29:43PM +0800, Tang, Feng wrote:
>> On Fri, Nov 11, 2022 at 04:16:32PM +0800, Vlastimil Babka wrote:
>> > > 	for (shift = 3; shift <= 12; shift++) {
>> > > 		size = 1 << shift;
>> > > 		buf = kmalloc(size + 4, GFP_KERNEL);
>> > > 		/* We have 96, 196 kmalloc size, which is not power of 2 */
>> > > 		if (size == 64 || size == 128)
>> > > 			oob_size = 16;
>> > > 		else
>> > > 			oob_size = size - 4;
>> > > 		memset(buf + size + 4, 0xee, oob_size);
>> > > 		kfree(buf);
>> > > 	}
>> > 
>> > Sounds like a new slub_kunit test would be useful? :) doesn't need to be
>> > that exhaustive wrt all sizes, we could just pick one and check that a write
>> > beyond requested kmalloc size is detected?
>> 
>> Just git-grepped out slub_kunit.c :), will try to add a case to it.
>> I'll also check if the case will also be caught by other sanitizer
>> tools like kasan/kfence etc.
> 
> Just checked, kasan has already has API to disable kasan check
> temporarily, and I did see sometime kfence can chime in (4 out of 178
> runs) so we need skip kfenced address.
> 
> Here is the draft patch, thanks!
> 
> From 45bf8d0072e532f43063dbda44c6bb3adcc388b6 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Mon, 21 Nov 2022 13:17:11 +0800
> Subject: [PATCH] mm/slub, kunit: Add a case for kmalloc redzone functionality
> 
> kmalloc redzone check for slub has been merged, and it's better to add
> a kunit case for it, which is inspired by a real-world case as described
> in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):
> 
> "
>   octeon-hcd will crash the kernel when SLOB is used. This usually happens
>   after the 18-byte control transfer when a device descriptor is read.
>   The DMA engine is always transfering full 32-bit words and if the
>   transfer is shorter, some random garbage appears after the buffer.
>   The problem is not visible with SLUB since it rounds up the allocations
>   to word boundary, and the extra bytes will go undetected.
> "
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  lib/slub_kunit.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h        | 15 +++++++++++++++
>  mm/slub.c        |  4 ++--
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 7a0564d7cb7a..0653eed19bff 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -120,6 +120,47 @@ static void test_clobber_redzone_free(struct kunit *test)
>  	kmem_cache_destroy(s);
>  }
>  
> +
> +/*
> + * This case is simulating a real world case, that a device driver
> + * requests 18 bytes buffer, but the device HW has obligation to
> + * operate on 32 bits granularity, so it may actually read or write
> + * 20 bytes to the buffer, and possibly pollute 2 extra bytes after
> + * the requested space.
> + */
> +static void test_kmalloc_redzone_access(struct kunit *test)
> +{
> +	u8 *p;
> +
> +	if (!is_slub_debug_flags_enabled(SLAB_STORE_USER | SLAB_RED_ZONE))
> +		kunit_skip(test, "Test required SLAB_STORE_USER & SLAB_RED_ZONE flags on");

Hrmm, this is not great. I didn't realize that we're testing kmalloc()
specific code, so we can't simply create test-specific caches as in the
other kunit tests.
What if we did create a fake kmalloc cache with the necessary flags and used
it with kmalloc_trace() instead of kmalloc()? We would be bypassing the
kmalloc() inline layer so theoretically orig_size handling bugs could be
introduced there that the test wouldn't catch, but I think that's rather
unlikely. Importantly we would still be stressing the orig_size saving and
the adjusted redzone check using this info.

> +	p = kmalloc(18, GFP_KERNEL);
> +
> +#ifdef CONFIG_KFENCE
> +	{
> +		int max_retry = 10;
> +
> +		while (is_kfence_address(p) && max_retry--) {
> +			kfree(p);
> +			p = kmalloc(18, GFP_KERNEL);
> +		}
> +
> +		if (!max_retry)
> +			kunit_skip(test, "Fail to get non-kfenced memory");
> +	}
> +#endif

With the test-specific cache we could also pass SLAB_SKIP_KFENCE there to
handle this. BTW, don't all slub kunit test need to do that in fact?

Thanks,
Vlastimil

> +
> +	kasan_disable_current();
> +
> +	p[18] = 0xab;
> +	p[19] = 0xab;
> +	kfree(p);
> +
> +	KUNIT_EXPECT_EQ(test, 3, slab_errors);
> +	kasan_enable_current();
> +}
> +
>  static int test_init(struct kunit *test)
>  {
>  	slab_errors = 0;
> @@ -139,6 +180,7 @@ static struct kunit_case test_cases[] = {
>  #endif
>  
>  	KUNIT_CASE(test_clobber_redzone_free),
> +	KUNIT_CASE(test_kmalloc_redzone_access),
>  	{}
>  };
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index e3b3231af742..72f7a85e01ab 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -413,6 +413,17 @@ static inline bool __slub_debug_enabled(void)
>  {
>  	return static_branch_unlikely(&slub_debug_enabled);
>  }
> +
> +extern slab_flags_t slub_debug;
> +
> +/*
> + * This should only be used in post-boot time, after 'slub_debug'
> + * gets initialized.
> + */
> +static inline bool is_slub_debug_flags_enabled(slab_flags_t flags)
> +{
> +	return (slub_debug & flags) == flags;
> +}
>  #else
>  static inline void print_tracking(struct kmem_cache *s, void *object)
>  {
> @@ -421,6 +432,10 @@ static inline bool __slub_debug_enabled(void)
>  {
>  	return false;
>  }
> +static inline bool is_slub_debug_flags_enabled(slab_flags_t flags)
> +{
> +	return false;
> +}
>  #endif
>  
>  /*
> diff --git a/mm/slub.c b/mm/slub.c
> index a24b71041b26..6ef72b8f6291 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -638,9 +638,9 @@ static inline void *restore_red_left(struct kmem_cache *s, void *p)
>   * Debug settings:
>   */
>  #if defined(CONFIG_SLUB_DEBUG_ON)
> -static slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
> +slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
>  #else
> -static slab_flags_t slub_debug;
> +slab_flags_t slub_debug;
>  #endif
>  
>  static char *slub_debug_string;

