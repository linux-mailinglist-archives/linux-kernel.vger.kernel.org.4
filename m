Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F915FEB30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJNIwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJNIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:52:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D51C9384;
        Fri, 14 Oct 2022 01:51:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9FD91F74A;
        Fri, 14 Oct 2022 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665737506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0VGtJ9Ga07XYW6RtddW9XEl9eF9thFhwKrYGC9xYqU=;
        b=FgW3g6NEfPtOkVnlFccCNTIrRzixQUE2DOsUwGRoi9uqm4EwT31zzJlTo0MUlsolrFfPOB
        tTKyOfva/SQdFbKXYyu1MXIMJQedtZV+A4LWksKjz6jqjvmiU4PZuY7qSLIJ+1ouO8cpzk
        3+PfG/W5BBdQBtWvbB/bYRiVzc6EHBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665737506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0VGtJ9Ga07XYW6RtddW9XEl9eF9thFhwKrYGC9xYqU=;
        b=V4zn5GhyabVgTunDoDFFROObFcUfUPovZLMIV2Yw7bhMou+dUy2IbmBMTWQCoYzdieLwbH
        ilCoTsLixeQkqWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 720EC13451;
        Fri, 14 Oct 2022 08:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XHIBGyIjSWMVCwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 08:51:46 +0000
Message-ID: <d2f861c1-0cfd-fa66-1300-3a2a81d204fd@suse.cz>
Date:   Fri, 14 Oct 2022 10:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] mm: Make failslab writable again
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
References: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 14:11, Alexander Atanasov wrote:
> In (060807f841ac mm, slub: make remaining slub_debug related attributes
> read-only) failslab was made read-only.
> I think it became a collateral victim to the two other options for which
> the reasons are perfectly valid.
> Here is why:
>  - sanity_checks and trace are slab internal debug options,
>    failslab is used for fault injection.
>  - for fault injections, which by presumption are random, it
>    does not matter if it is not set atomically. And you need to
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

Thanks, added to slab.git for-6.2/slub-sysfs

> ---
>  Documentation/mm/slub.rst |  2 ++
>  mm/slub.c                 | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> V1->V2: Fixed commit message. Flags are set using WRITE_ONCE.
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
> index 862dbd9af4f5..57cf18936526 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5617,7 +5617,21 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
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
> +	if (buf[0] == '1')
> +		WRITE_ONCE(s->flags, s->flags | SLAB_FAILSLAB);
> +	else
> +		WRITE_ONCE(s->flags, s->flags & ~SLAB_FAILSLAB);
> +
> +	return length;
> +}
> +SLAB_ATTR(failslab);
>  #endif
>  
>  static ssize_t shrink_show(struct kmem_cache *s, char *buf)
> 
> base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf

