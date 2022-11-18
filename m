Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38F762F3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiKRLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbiKRLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:34:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987FF8A17B;
        Fri, 18 Nov 2022 03:34:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D5A11F924;
        Fri, 18 Nov 2022 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668771242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqSiCxu0crNnAzpBOtWKIOFuXwsDyaQFJ8B2fw8hztU=;
        b=xp48TrunWilM2VXMJbQPGTCbgKrJrgN3/aoAOejdXxVAGchLpF3F9uvn6FpEgI4NasjQk6
        3WycA9Mc4kS/QqHoRbGZNk7C6mHpBWX6tl0lo3GZCDqb/c7wmgK15aQJwiCZhcOl1wtkwy
        N2dvm/1Uh/7JlElbffoX2que33AsF3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668771242;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqSiCxu0crNnAzpBOtWKIOFuXwsDyaQFJ8B2fw8hztU=;
        b=CgCD0rV8e7C6NT95+K7bUFTcW0V980dqZtzu8vKcdLloVmCtk7emO2d9lT5afUd5q1K5Mf
        Wt3GVlDesgwQ/mDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 231CB13A66;
        Fri, 18 Nov 2022 11:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q9jqB6ptd2P4aQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 11:34:02 +0000
Message-ID: <f008f8a2-8d5e-88ab-8d23-a2043ea5abe7@suse.cz>
Date:   Fri, 18 Nov 2022 12:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] slab: Remove special-casing of const 0 size
 allocations
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221118034713.gonna.754-kees@kernel.org>
 <20221118035200.1269184-2-keescook@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221118035200.1269184-2-keescook@chromium.org>
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

On 11/18/22 04:51, Kees Cook wrote:
> Passing a constant-0 size allocation into kmalloc() or kmalloc_node()
> does not need to be a fast-path operation, so the static return value
> can be removed entirely. This is in preparation for making sure that
> all paths through the inlines result in a full extern function call,

So with the kmalloc_trace() already solved, we could now say it's not "in
preparation", but simply "makes sure", right? I can correct that while
picking this patch.

> where __alloc_size() hints will actually be seen[1] by GCC. (A constant
> return value of 0 means the "0" allocation size won't be propagated by
> the inline.)
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/slab.h | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9033937c758e..84be05208418 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -561,17 +561,13 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>  #ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
> -	if (__builtin_constant_p(size)) {
> +	if (__builtin_constant_p(size) && size) {
>  		unsigned int index;
>  
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large(size, flags);
>  
>  		index = kmalloc_index(size);
> -
> -		if (!index)
> -			return ZERO_SIZE_PTR;
> -
>  		return kmalloc_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, size);
> @@ -591,17 +587,13 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  #ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
> -	if (__builtin_constant_p(size)) {
> +	if (__builtin_constant_p(size) && size) {
>  		unsigned int index;
>  
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large_node(size, flags, node);
>  
>  		index = kmalloc_index(size);
> -
> -		if (!index)
> -			return ZERO_SIZE_PTR;
> -
>  		return kmalloc_node_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, node, size);

