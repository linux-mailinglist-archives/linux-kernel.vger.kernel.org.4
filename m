Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14561398B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiJaPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJaPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:00:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13D101E9;
        Mon, 31 Oct 2022 08:00:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 400931F8E3;
        Mon, 31 Oct 2022 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667228426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7OLFAt5m3+NWpn8rJDH7TyJw22pacbLWyDvlqlCNDU=;
        b=Dg5BqOQELwwPyeShYwBd0wF9Q3xdAEn6NkOsONkA7oS95QnuQDDZE5ZkPh8jnEP+wjAMYR
        U/bwYdZhl6oY9EIhPntLeQctdxJ/Zs867ZESvjSyoBoRsTFB06MbZNDwfL2TylglIoBcTR
        HwKhXR2ApfpOtz3YTIm4d+ZruY6CFgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667228426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7OLFAt5m3+NWpn8rJDH7TyJw22pacbLWyDvlqlCNDU=;
        b=gacRcykumtUdZfjDOREcXx0dOMkpd/KU6tw+pI8uAOWrKkAP/K2rSTjjMEOhT+OBQXuwuu
        qgYXwUkBiM93BnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A3D213451;
        Mon, 31 Oct 2022 15:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SXrmBQrjX2MJDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 31 Oct 2022 15:00:26 +0000
Message-ID: <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
Date:   Mon, 31 Oct 2022 16:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221031105514.GB69385@mutt>
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

On 10/31/22 11:55, Anders Roxell wrote:
> On 2022-10-28 08:53, Kees Cook wrote:
>> Nothing appears to be using ksize() within the kmalloc-backed mempools
>> except the mempool poisoning logic. Use the actual pool size instead
>> of the ksize() to avoid needing any special handling of the memory as
>> needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
>> 
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Link: https://lore.kernel.org/lkml/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This replaces mempool-use-kmalloc_size_roundup-to-match-ksize-usage.patch
>> v4: add review/ack tags, explicitly call out subject change
>> v3: https://lore.kernel.org/lkml/20221025233421.you.825-kees@kernel.org/
>> v2: https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
>> v1: https://lore.kernel.org/lkml/20220923202822.2667581-14-keescook@chromium.org/
>> ---
>>  mm/mempool.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Hi,
> 
> I see the following kernel paninc when I boot an arm64 allmodconfig kernel from todays linux-next tag next-20221031
> This is the .config file I built [1], and here is the full log [2].
> 
> [   17.445316][    T1] [fffe00001188f9bf] address between user and kernel address ranges
> [   17.449021][    T1] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> [   17.453097][    T1] Modules linked in:
> [   17.455384][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B T  6.1.0-rc3-next-20221031 #2 1e3e4f9d63a6fa6d1a293981bef64866cf5e5454
> [   17.463100][    T1] Hardware name: linux,dummy-virt (DT)
> [   17.466247][    T1] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   17.470778][    T1] pc : __poison_element+0x3c/0x80
> [   17.473688][    T1] lr : __poison_element+0x38/0x80
> [   17.476614][    T1] sp : ffff80000eea7b50
> [   17.478996][    T1] x29: ffff80000eea7b50 x28: ffff000008c88468 x27: ffff000008c88450
> [   17.483694][    T1] x26: 0000000000000cc0 x25: ffff000008c88448 x24: ffff000008b3cf80
> [   17.488338][    T1] x23: ffff000008c8844c x22: ffff000008c88460 x21: ffff000008d52a40
> [   17.493032][    T1] x20: ffff000008d52a40 x19: ffff000008b3cf7f x18: 0000000000000000
> [   17.497707][    T1] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   17.502413][    T1] x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
> [   17.507109][    T1] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [   17.511775][    T1] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [   17.516447][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [   17.521116][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000ffffffa5
> [   17.525782][    T1] Call trace:
> [   17.527664][    T1]  __poison_element+0x3c/0x80
> [   17.530409][    T1]  poison_element.isra.0+0x50/0x180
> [   17.533419][    T1]  mempool_init_node+0x224/0x340
> [   17.536298][    T1]  mempool_create+0x78/0x100
> [   17.538989][    T1]  dma_bus_init+0x124/0x2a4
> [   17.541607][    T1]  do_one_initcall+0x29c/0x680
> [   17.544381][    T1]  do_initcalls+0x178/0x240
> [   17.547005][    T1]  kernel_init_freeable+0x2e4/0x36c
> [   17.550018][    T1]  kernel_init+0x30/0x180
> [   17.552534][    T1]  ret_from_fork+0x10/0x20
> [   17.555130][    T1] Code: 94057fb5 8b130280 940575a3 12800b40
> (38336a80) 
> [   17.559124][    T1] ---[ end trace 0000000000000000 ]---
> [   17.562259][    T1] Kernel panic - not syncing: Oops: Fatal exception
> [   17.566094][    T1] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> 
> When I revert this patch the kernel boots fine.
> Any idea what goes wrong?

Oops, I think I know, this should fix it?
----8<----
From a4a5a40852723dfadb2429bee1d5e1f9d3b75f39 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 31 Oct 2022 15:55:47 +0100
Subject: [PATCH] mempool: Do not use ksize() for poisoning-fix

For slab mempools (not kmalloc), pool_data is not object size, but a
kmem_cache pointer; we need to extract the size via kmem_cache_size().

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Link: https://lore.kernel.org/all/20221031105514.GB69385@mutt/
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202210312110.1fe5d224-oliver.sang@intel.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mempool.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 54204065037d..734bcf5afbb7 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -57,8 +57,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
 static void check_element(mempool_t *pool, void *element)
 {
 	/* Mempools backed by slab allocator */
-	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
+	if (pool->free == mempool_kfree) {
 		__check_element(pool, element, (size_t)pool->pool_data);
+	} else if (pool->free == mempool_free_slab) {
+		__check_element(pool, element, kmem_cache_size(pool->pool_data));
 	} else if (pool->free == mempool_free_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
@@ -80,8 +82,10 @@ static void __poison_element(void *element, size_t size)
 static void poison_element(mempool_t *pool, void *element)
 {
 	/* Mempools backed by slab allocator */
-	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
+	if (pool->alloc == mempool_kmalloc) {
 		__poison_element(element, (size_t)pool->pool_data);
+	} else if (pool->alloc == mempool_alloc_slab) {
+		__poison_element(element, kmem_cache_size(pool->pool_data));
 	} else if (pool->alloc == mempool_alloc_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
@@ -111,8 +115,10 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
-	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
+	if (pool->alloc == mempool_kmalloc)
 		kasan_unpoison_range(element, (size_t)pool->pool_data);
+	else if (pool->alloc == mempool_alloc_slab)
+		kasan_unpoison_range(element, kmem_cache_size(pool->pool_data));
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
 				     false);
-- 
2.38.0


