Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4115BE086
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiITInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiITInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:43:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572F659FA;
        Tue, 20 Sep 2022 01:42:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED52A1F898;
        Tue, 20 Sep 2022 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663663357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIiaZw8kyqLy+k7/L0lKws/bc45zpwA5196SAUlqTnE=;
        b=WhWdox47SVo2w033FWXOrKg4uJsJ6QizXju5q9h/4jzaYV8ks9I4eN+TT2KfxCtxL94d0i
        mNLY29nzm2AgHF5XYQhRvzfBETyTbtFKvcbcJYM6APTbCrjauOYYtwnWiJi+DGvoUinlIL
        Mawd1xVO96D1gzT1UtAa3vCdhmPuO48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663663357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIiaZw8kyqLy+k7/L0lKws/bc45zpwA5196SAUlqTnE=;
        b=s/4W4QsI7MIf3DbvvNSN4Q1jXe4XzTNY7nKe7NOHSDEdhww6/O7rMGlwb6E5fvAfql+YmC
        sW/6+WTFjlYI6ZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2FEF13ABB;
        Tue, 20 Sep 2022 08:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MYoFK/18KWOmcAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 20 Sep 2022 08:42:37 +0000
Message-ID: <21646f5c-39ee-a51c-f30c-272de85ee350@suse.cz>
Date:   Tue, 20 Sep 2022 10:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm: Make failslab writable again
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel@openvz.org, Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220920082033.1727374-1-alexander.atanasov@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220920082033.1727374-1-alexander.atanasov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 10:20, Alexander Atanasov wrote:
> In (060807f841ac mm, slub: make remaining slub_debug related attributes
> read-only failslab) it was made RO.

"read-only) failslab was made RO" ?

> I think it became a collateral victim to the other two options
> (sanity_checks and trace) for which the reasons are perfectly valid.

The commit also mentioned that modifying the flags is not protected in any
way, see below.

> Here is why:
>  - sanity_checks and trace are slab internal debug options,
>    failslab is used for fault injection.
>  - for fault injections, which by presumption are random, it
>    does not matter if it is not set atomically. You need to
>    set atleast one more option to trigger fault injection.
>  - in a testing scenario you may need to change it at runtime
>    example: module loading - you test all allocations limited
>    by the space option. Then you move to test only your module's
>    own slabs.
>  - when set by command line flags it effectively disables all
>    cache merges.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Vijayanand Jitta <vjitta@codeaurora.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Link: http://lkml.kernel.org/r/20200610163135.17364-5-vbabka@suse.cz
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  Documentation/mm/slub.rst |  2 ++
>  mm/slub.c                 | 14 +++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> index 43063ade737a..86837073a39e 100644
> --- a/Documentation/mm/slub.rst
> +++ b/Documentation/mm/slub.rst
> @@ -116,6 +116,8 @@ options from the ``slub_debug`` parameter translate to the following files::
>  	T	trace
>  	A	failslab
>  
> +failslab file is writable, so writing 1 or 0 will enable or disable
> +the option at runtime. Write returns -EINVAL if cache is an alias.
>  Careful with tracing: It may spew out lots of information and never stop if
>  used on the wrong slab.
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..7c15d312e0fb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5617,7 +5617,19 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
>  {
>  	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
>  }
> -SLAB_ATTR_RO(failslab);
> +
> +static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
> +				size_t length)
> +{
> +	if (s->refcount > 1)
> +		return -EINVAL;
> +
> +	s->flags &= ~SLAB_FAILSLAB;
> +	if (buf[0] == '1')
> +		s->flags |= SLAB_FAILSLAB;

Could we at least use a temporary variable to set up the final value and
then do a WRITE_ONCE() to s->flags, so the compiler is not allowed to do
some funky stuff? Assuming this is really the only place where we modify
s->flags during runtime, so we can't miss other updates due to RMW.

> +	return length;
> +}
> +SLAB_ATTR(failslab);
>  #endif
>  
>  static ssize_t shrink_show(struct kmem_cache *s, char *buf)
> 
> base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf

