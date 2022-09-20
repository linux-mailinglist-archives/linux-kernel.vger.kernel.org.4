Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB215BE222
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiITJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiITJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:30:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222D2B2;
        Tue, 20 Sep 2022 02:29:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 051B81F8BB;
        Tue, 20 Sep 2022 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663666181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v86Gb5apC1XqegEl+G9+nVcNXc/lLIOPGIQ/KR+N2Qg=;
        b=x3HbK7EijxLI/OHQLM6LUQoQFzf6fLy2x7usS2Byaa9c/OkKBOWFxUx3JEwtv8bxUoV8pT
        lcirGlTcsIN1OUatgGDMLRAarntWuG7ogEf/+RdKcIBxYboFB65Dthuble1oizonGZd9vO
        GxYuaJTf6LJzlBQIjtD854zyPGX7OYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663666181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v86Gb5apC1XqegEl+G9+nVcNXc/lLIOPGIQ/KR+N2Qg=;
        b=Z5ZeNre0jVeIRQ3XvfdH3oUtX8VVz0sa2D4eDtIk3Z7vpJ02dxfb8pGZqxtIhlksiqWfS1
        nFw8KwOmYM7I1aAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B87EE1346B;
        Tue, 20 Sep 2022 09:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pnoaLASIKWN7BwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 20 Sep 2022 09:29:40 +0000
Message-ID: <60111450-d66a-a146-1a70-0c093400f3e5@suse.cz>
Date:   Tue, 20 Sep 2022 11:29:40 +0200
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
 <21646f5c-39ee-a51c-f30c-272de85ee350@suse.cz>
 <6f5a8f71-3d82-97bf-90e1-0f33546bb59b@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6f5a8f71-3d82-97bf-90e1-0f33546bb59b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 11:17, Alexander Atanasov wrote:
> Hello,
> 
> On 20.09.22 11:42, Vlastimil Babka wrote:
>> On 9/20/22 10:20, Alexander Atanasov wrote:
>>> In (060807f841ac mm, slub: make remaining slub_debug related attributes
>>> read-only failslab) it was made RO.
>>
>> "read-only) failslab was made RO" ?
> 
> Yep.
> 
>>> I think it became a collateral victim to the other two options
>>> (sanity_checks and trace) for which the reasons are perfectly valid.
>>
>> The commit also mentioned that modifying the flags is not protected in any
>> way, see below.
> 
> Yes, indeed.
> 
>>> +static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
>>> +                size_t length)
>>> +{
>>> +    if (s->refcount > 1)
>>> +        return -EINVAL;
>>> +
>>> +    s->flags &= ~SLAB_FAILSLAB;
>>> +    if (buf[0] == '1')
>>> +        s->flags |= SLAB_FAILSLAB;
>>
>> Could we at least use a temporary variable to set up the final value and
>> then do a WRITE_ONCE() to s->flags, so the compiler is not allowed to do
>> some funky stuff? Assuming this is really the only place where we modify
>> s->flags during runtime, so we can't miss other updates due to RMW.
> 
> Since it is set or clear - instead of temporary variable and potentially two
> writes and RMW issues i would suggest this:
> +    if (buf[0] == '1')
> +        s->flags |= SLAB_FAILSLAB;
> +       else
> +        s->flags &= ~SLAB_FAILSLAB;

This way also has RMW issues, and also the compiler is allowed to
temporarily modify s->flags any way it likes; with WRITE_ONCE() it can't.

> If at some point more places need to modify the flags at runtime they can
> switch to atomic bit ops.


