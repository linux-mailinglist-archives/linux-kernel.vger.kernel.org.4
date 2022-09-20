Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD635BE34C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiITKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiITKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1471BEE;
        Tue, 20 Sep 2022 03:31:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22CA121CA8;
        Tue, 20 Sep 2022 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663669903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxA0/0TiFti37VW/MInsc7VC0/281DSV8FYTm2yNBt8=;
        b=Y0oH2LqYa+mXOTgLMdgA0HwkLj5+7iveRezVjwmDA8OkP/gZLJBsHGqIhwz4KOYUXezPHv
        aH8mtwY+dI7NI2pOxvtRfshYDlYk0A9KEvrbnch0ZN1NrcXs5PFeYZlm+D8defBo8Qd06I
        Kf+iHkg4jiof9pTdqSSFCVR8kDztkrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663669903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxA0/0TiFti37VW/MInsc7VC0/281DSV8FYTm2yNBt8=;
        b=uBdfy7gdkzfJYDvbAps4KCruWHfQ1NwD4+UL+NqDA0ecT9Ruaq3hstbu3EfiQYnCmzd+Pg
        ggm0OsRJnncSCBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C37A413ABB;
        Tue, 20 Sep 2022 10:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RH+2Lo6WKWO/IwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 20 Sep 2022 10:31:42 +0000
Message-ID: <30b3c8d3-3e2e-8f07-a05e-3c91fccde024@suse.cz>
Date:   Tue, 20 Sep 2022 12:31:42 +0200
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
 <60111450-d66a-a146-1a70-0c093400f3e5@suse.cz>
 <7d79d13b-0579-452f-7a07-4e3eba205d23@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7d79d13b-0579-452f-7a07-4e3eba205d23@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 12:21, Alexander Atanasov wrote:
> On 20.09.22 12:29, Vlastimil Babka wrote:
>> On 9/20/22 11:17, Alexander Atanasov wrote:
>>> Hello,
>>>
>>> On 20.09.22 11:42, Vlastimil Babka wrote:
>>>>> +static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
>>>>> +                size_t length)
>>>>> +{
>>>>> +    if (s->refcount > 1)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    s->flags &= ~SLAB_FAILSLAB;
>>>>> +    if (buf[0] == '1')
>>>>> +        s->flags |= SLAB_FAILSLAB;
>>>>
>>>> Could we at least use a temporary variable to set up the final value and
>>>> then do a WRITE_ONCE() to s->flags, so the compiler is not allowed to do
>>>> some funky stuff? Assuming this is really the only place where we modify
>>>> s->flags during runtime, so we can't miss other updates due to RMW.
>>>
>>> Since it is set or clear - instead of temporary variable and potentially two
>>> writes and RMW issues i would suggest this:
>>> +    if (buf[0] == '1')
>>> +        s->flags |= SLAB_FAILSLAB;
>>> +       else
>>> +        s->flags &= ~SLAB_FAILSLAB;
>>
>> This way also has RMW issues, and also the compiler is allowed to
>> temporarily modify s->flags any way it likes; with WRITE_ONCE() it can't.
> 
> Okay, so the safest way is this?
> 
> if (buf[0] == '1')
>     WRITE_ONCE(s->flags, READ_ONCE(s->flags) | SLAB_FAILSLAB);
> else
>     WRITE_ONCE(s->flags, READ_ONCE(s->flags) & ~SLAB_FAILSLAB);

Yeah, that would work. Given we are the only writer, we shouldn't even need
a READ_ONCE.

> It got me thinking how many places would break if the compiler
> starts to temporariliy modify the flags - i hope it never does.

That's likely true as well. But the macros have been introduced for this
purpose AFAIK.
