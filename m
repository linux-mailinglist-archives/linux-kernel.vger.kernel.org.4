Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77E16C835F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCXRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCXRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:30:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A0B77E;
        Fri, 24 Mar 2023 10:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C84B33B63;
        Fri, 24 Mar 2023 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679679003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eiBbPs2SGpkrGMAzRmJfw7VfJ2mVEesg1+9LMIwCTE=;
        b=O46wtOse/KmGUQx3zAOgmnpK5rrOILvob0lQT3LYNVP7LUFw5YuoY//8OHIp6KT0MNxCHo
        MYZwqgBqXt6vRaC6aEhRCHHQiHaZza4Y/0Kuf9ukEoN5OYPwHVFcTlGU2ggU02D0FPqGB9
        3gLQ6K+0fi+cQMMx4ZZwx0oQ4qFbSO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679679003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eiBbPs2SGpkrGMAzRmJfw7VfJ2mVEesg1+9LMIwCTE=;
        b=kZxNL7ERELRnFYwUZ1ebrmvqaNDYDiayXb27qqSoFZGsuJnXQvUdyMeOAvHr1aae7uMsCB
        guhevfdq+HG2fzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171F5138ED;
        Fri, 24 Mar 2023 17:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BiLnBBveHWQ8LQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 24 Mar 2023 17:30:03 +0000
Message-ID: <22a1ec75-155a-2392-ce39-4bca3fc081eb@suse.cz>
Date:   Fri, 24 Mar 2023 18:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm/mempolicy: Fix exception handling in
 shared_policy_replace()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kosaki Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch doesn't apply, seems like it uses spaces instead of tabs. Also I
can't use 'b4' to download it as there are multiple different patches using
the same message-id:

https://lore.kernel.org/all/6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de/

Re: subject, I don't see a bug that this would fix. You could say it's
"cleanup" and this function could use one, but for a cleanup it's not
improving the situation much.

On 3/23/23 18:30, Markus Elfring wrote:
> Date: Thu, 23 Mar 2023 18:18:59 +0100
> 
> The label “err_out” was used to jump to another pointer check despite of
> the detail in the implementation of the function “shared_policy_replace”
> that it was determined already that a corresponding variable contained a
> null pointer because of a failed call of the function “kmem_cache_alloc”.
> 
> 1. Use more appropriate labels instead.
> 
> 2. The implementation of the function “mpol_put” contains a pointer check
>    for its single input parameter.
>    Thus delete a redundant check in the caller.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 42288fe366c4f1ce7522bc9f27d0bc2a81c55264 ("mm: mempolicy: Convert shared_policy mutex to spinlock")

Again this is not a fix.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  mm/mempolicy.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a256a241fd1d..fb0485688dcb 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2736,13 +2736,12 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>          sp_insert(sp, new);
>      write_unlock(&sp->lock);
>      ret = 0;
> +put_mpol:
> +    mpol_put(mpol_new);
>  
> -err_out:
> -    if (mpol_new)
> -        mpol_put(mpol_new);
>      if (n_new)
>          kmem_cache_free(sn_cache, n_new);
> -
> +exit:
>      return ret;
>  
>  alloc_new:
> @@ -2750,10 +2749,10 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>      ret = -ENOMEM;
>      n_new = kmem_cache_alloc(sn_cache, GFP_KERNEL);
>      if (!n_new)
> -        goto err_out;
> +        goto exit;

Just "return ret" and no need for exit label?

>      mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>      if (!mpol_new)
> -        goto err_out;
> +        goto put_mpol;

We are doing this because mpol_new == NULL, so we know there's no reason to
do mpol_put(), we could jump to the freeing of n_new.

>      atomic_set(&mpol_new->refcnt, 1);
>      goto restart;
>  }
> --
> 2.40.0
> 
> 
> 

