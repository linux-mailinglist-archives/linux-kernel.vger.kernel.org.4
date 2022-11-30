Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E165F63E437
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiK3XFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3XFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:05:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6294939
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:05:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB1A41F45B;
        Wed, 30 Nov 2022 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669849541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6t/1gH9rWwLg3waldr2UlOAUoUcBLbX/7yAdRnju3k=;
        b=S4dvT7AAegiHK2rewnwfpJ3fDHpmbEElZFQH7qyk2FtAJdF1owpiBfegGuTLj/mfFcWuSi
        VSkS4yqWIZCg6WWH+gmBLmGq0RztvMRnCdcxkAdy5JKnqxOwuRHXhXE3Nd2k2SiL3ZqC1i
        llQVfqJn2CyM2tm4OoHD1F1Z+Bcswcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669849541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6t/1gH9rWwLg3waldr2UlOAUoUcBLbX/7yAdRnju3k=;
        b=vQ+jVArFkV0qwv4Kn+exiXdJbzxi+pgL6c3v1SpZkTHCcz06jrKMH957eMeSdjipdHPkLg
        C+pETNm6uGiP87CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7274513A70;
        Wed, 30 Nov 2022 23:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lSwGG8Xhh2MhbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 30 Nov 2022 23:05:41 +0000
Message-ID: <b98a61ae-da11-00c0-60a9-30a3c043f761@suse.cz>
Date:   Thu, 1 Dec 2022 00:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
To:     Feng Tang <feng.tang@intel.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221130085451.3390992-1-feng.tang@intel.com>
 <20221130085451.3390992-2-feng.tang@intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221130085451.3390992-2-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 09:54, Feng Tang wrote:
> kmalloc redzone check for slub has been merged, and it's better to add
> a kunit case for it, which is inspired by a real-world case as described
> in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):
> 
> "
>   octeon-hcd will crash the kernel when SLOB is used. This usually happens
>   after the 18-byte control transfer when a device descriptor is read.
>   The DMA engine is always transferring full 32-bit words and if the
>   transfer is shorter, some random garbage appears after the buffer.
>   The problem is not visible with SLUB since it rounds up the allocations
>   to word boundary, and the extra bytes will go undetected.
> "
> 
> To avoid interrupting the normal functioning of kmalloc caches, a
> kmem_cache mimicing kmalloc cache is created with similar flags, and
> kmalloc_trace() is used to really test the orig_size and redzone setup.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
> 
>   since v2:
>     * only add SLAB_KMALLOC to SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTEDa,
>       and use new wrapper of cache creation(Vlastimil Babka)
> 
>   since v1:
>     * create a new cache mimicing kmalloc cache, reduce dependency
>       over global slub_debug setting (Vlastimil Babka)
> 
>  lib/slub_kunit.c | 22 ++++++++++++++++++++++
>  mm/slab.h        |  4 +++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 5b0c8e7eb6dc..ff24879e3afe 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -135,6 +135,27 @@ static void test_clobber_redzone_free(struct kunit *test)
>  	kmem_cache_destroy(s);
>  }
>  
> +static void test_kmalloc_redzone_access(struct kunit *test)
> +{
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
> +				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
> +	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
> +
> +	kasan_disable_current();
> +
> +	/* Suppress the -Warray-bounds warning */
> +	OPTIMIZER_HIDE_VAR(p);
> +	p[18] = 0xab;
> +	p[19] = 0xab;
> +
> +	kmem_cache_free(s, p);
> +	validate_slab_cache(s);
> +	KUNIT_EXPECT_EQ(test, 2, slab_errors);

With this ordering the expectation was failing as slab_Errors was 0, had to
fix it up to look more like TestSlub_RZ_alloc:

> +	kasan_enable_current();
> +	kmem_cache_destroy(s);
> +}
> +

--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -148,11 +148,11 @@ static void test_kmalloc_redzone_access(struct kunit *test)
        p[18] = 0xab;
        p[19] = 0xab;
 
-       kmem_cache_free(s, p);
        validate_slab_cache(s);
        KUNIT_EXPECT_EQ(test, 2, slab_errors);
 
        kasan_enable_current();
+       kmem_cache_free(s, p);
        kmem_cache_destroy(s);
 }

With that, added both to slab.git branch slab/for-6.2/kmalloc_redzone
Thanks!
