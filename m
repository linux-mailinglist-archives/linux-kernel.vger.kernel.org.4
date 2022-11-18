Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1862F29B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiKRKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiKRKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:32:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803D922EE;
        Fri, 18 Nov 2022 02:32:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D77F1F890;
        Fri, 18 Nov 2022 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668767557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzHJXeK3Q2/Bx013Ighw0ir5MysszSUlvQpViISJqBs=;
        b=g8xwvhAwqhbxisPUlVbujWUoHsv5l3uONqGun9DeIQiCAadM+i1rYsCwZIaj4H4PpmIkgI
        v0pg0R+CThhbSKC5VAVA1zhrmiDrRN84oYCMC+vbKDlunUICpi8B7IdDTW2/+eKdRxmt/s
        Yx8YBG1i1FbxFUiL3sXhWVkWHeEWA2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668767557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzHJXeK3Q2/Bx013Ighw0ir5MysszSUlvQpViISJqBs=;
        b=IGKMdrU51wRPjSgtt3cDgq7HIyboRyHc/nsdePlag/9cMrpqnR2NQkqLjJOG1FY+dFyZeS
        Pge36YS2pYY05lDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C66113A66;
        Fri, 18 Nov 2022 10:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XG5tDUVfd2NwRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 10:32:37 +0000
Message-ID: <230127af-6c71-e51e-41a4-aa9547c2c847@suse.cz>
Date:   Fri, 18 Nov 2022 11:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221118035656.gonna.698-kees@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221118035656.gonna.698-kees@kernel.org>
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

On 11/18/22 04:56, Kees Cook wrote:
> With all "silently resizing" callers of ksize() refactored, remove the

At cursory look seems it's true now in -next (but not mainline?) can you
confirm?
That would probably be safe enough to have slab.git expose this to -next now
and time a PR appropriately in the next merge window?

> logic in ksize() that would allow it to be used to effectively change
> the size of an allocation (bypassing __alloc_size hints, etc). Users
> wanting this feature need to either use kmalloc_size_roundup() before an
> allocation, or use krealloc() directly.
> 
> For kfree_sensitive(), move the unpoisoning logic inline. Replace the
> some of the partially open-coded ksize() in __do_krealloc with ksize()
> now that it doesn't perform unpoisoning.
> 
> Adjust the KUnit tests to match the new ksize() behavior.
> 
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: linux-mm@kvack.org
> Cc: kasan-dev@googlegroups.com
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - improve kunit test precision (andreyknvl)
> - add Ack (vbabka)
> v1: https://lore.kernel.org/all/20221022180455.never.023-kees@kernel.org
> ---
>  mm/kasan/kasan_test.c | 14 +++++++++-----
>  mm/slab_common.c      | 26 ++++++++++----------------
>  2 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7502f03c807c..fc4b22916587 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -821,7 +821,7 @@ static void kasan_global_oob_left(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>  
> -/* Check that ksize() makes the whole object accessible. */
> +/* Check that ksize() does NOT unpoison whole object. */
>  static void ksize_unpoisons_memory(struct kunit *test)
>  {
>  	char *ptr;
> @@ -829,15 +829,19 @@ static void ksize_unpoisons_memory(struct kunit *test)
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
>  	real_size = ksize(ptr);
> +	KUNIT_EXPECT_GT(test, real_size, size);
>  
>  	OPTIMIZER_HIDE_VAR(ptr);
>  
> -	/* This access shouldn't trigger a KASAN report. */
> -	ptr[size] = 'x';
> +	/* These accesses shouldn't trigger a KASAN report. */
> +	ptr[0] = 'x';
> +	ptr[size - 1] = 'x';
>  
> -	/* This one must. */
> -	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size]);
> +	/* These must trigger a KASAN report. */
> +	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> +	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);
>  
>  	kfree(ptr);
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8276022f0da4..27caa57af070 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1335,11 +1335,11 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  	void *ret;
>  	size_t ks;
>  
> -	/* Don't use instrumented ksize to allow precise KASAN poisoning. */
> +	/* Check for double-free before calling ksize. */
>  	if (likely(!ZERO_OR_NULL_PTR(p))) {
>  		if (!kasan_check_byte(p))
>  			return NULL;
> -		ks = kfence_ksize(p) ?: __ksize(p);
> +		ks = ksize(p);
>  	} else
>  		ks = 0;
>  
> @@ -1407,21 +1407,21 @@ void kfree_sensitive(const void *p)
>  	void *mem = (void *)p;
>  
>  	ks = ksize(mem);
> -	if (ks)
> +	if (ks) {
> +		kasan_unpoison_range(mem, ks);
>  		memzero_explicit(mem, ks);
> +	}
>  	kfree(mem);
>  }
>  EXPORT_SYMBOL(kfree_sensitive);
>  
>  size_t ksize(const void *objp)
>  {
> -	size_t size;
> -
>  	/*
> -	 * We need to first check that the pointer to the object is valid, and
> -	 * only then unpoison the memory. The report printed from ksize() is
> -	 * more useful, then when it's printed later when the behaviour could
> -	 * be undefined due to a potential use-after-free or double-free.
> +	 * We need to first check that the pointer to the object is valid.
> +	 * The KASAN report printed from ksize() is more useful, then when
> +	 * it's printed later when the behaviour could be undefined due to
> +	 * a potential use-after-free or double-free.
>  	 *
>  	 * We use kasan_check_byte(), which is supported for the hardware
>  	 * tag-based KASAN mode, unlike kasan_check_read/write().
> @@ -1435,13 +1435,7 @@ size_t ksize(const void *objp)
>  	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
>  		return 0;
>  
> -	size = kfence_ksize(objp) ?: __ksize(objp);
> -	/*
> -	 * We assume that ksize callers could use whole allocated area,
> -	 * so we need to unpoison this area.
> -	 */
> -	kasan_unpoison_range(objp, size);
> -	return size;
> +	return kfence_ksize(objp) ?: __ksize(objp);
>  }
>  EXPORT_SYMBOL(ksize);
>  

