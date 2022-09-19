Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC35BCFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiISPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:01:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A2F303FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:01:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8769922224;
        Mon, 19 Sep 2022 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663599666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmT7O1nTC5ewzPsWTyUyQ6zAmAiduoQIoZYJtb3b+/8=;
        b=borvO9NJzYlT2QJ+/yKEWVnOBoh8qjAvRxZf3wIk+grVLI8RgZa7KQPL6vckViHXUbHu2j
        CT+UZ30lmgoOp4SvJlNyjZIJ1RAbWeSgtCobKq+iloGykzghoYAA9raV2gNFv49cNwuNWO
        Y1YwVUp9R9x3xftcRI7nceTQAUYHQis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663599666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmT7O1nTC5ewzPsWTyUyQ6zAmAiduoQIoZYJtb3b+/8=;
        b=5YECWEHBU2yXwwMziXEswMp2WSASf5Lx1SAGpANi9GlrdPioYwaWtoQPhsOSk4zJr+xJYY
        sNOcYE/GMjD0YsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F24A13A96;
        Mon, 19 Sep 2022 15:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wzOlEjKEKGOjbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 19 Sep 2022 15:01:06 +0000
Message-ID: <1920ee84-994e-e4bf-63e4-167842edca72@suse.cz>
Date:   Mon, 19 Sep 2022 17:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] lib/stackdepot: Add a refcount field in
 stack_record
Content-Language: en-US
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-2-osalvador@suse.de>
 <CA+fCnZcNr2JeCkTF=uCxjPCJKFi_d1chv0tjubvMisUdQtCeRw@mail.gmail.com>
 <YxbEi7A3e+y5qNwY@localhost.localdomain>
 <CA+fCnZcxDoUVewkv8PeSybXYy2Qf3wv7tOtvXBmJiF0rAvyPtg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+fCnZcxDoUVewkv8PeSybXYy2Qf3wv7tOtvXBmJiF0rAvyPtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/22 00:33, Andrey Konovalov wrote:
>> We cannot do that for __reset_page_owner(), because the stack we are
>> saving is the freeing stacktrace, and we are not interested in that.
>> That is why __reset_page_owner() does:
>>
>>  <---
>>  depot_stack_handle_t alloc_handle;
>>
>>  ...
>>  alloc_handle = page_owner->handle;
>>  handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_DEPOT_ACTION_NONE);
>>  page_owner->free_handle = handle
>>  stack_depot_dec_count(alloc_handle);
>>  --->
>>
>> alloc_handle contains the handle for the allocation stacktrace, which was set
>> in __set_page_owner(), and page_owner->free handle contains the handle for the
>> freeing stacktrace.
>> But we are only interested in the allocation stack and we only want to increment/decrement
>> that on allocation/free.
> 
> But what is the problem with incrementing the refcount for free
> stacktrace in __reset_page_owner? You save the stack there anyway.
> 
> Or is this because you don't want to see free stack traces when
> filtering for bigger refcounts? I would argue that this is not a thing
> stack depot should care about. If there's a refcount, it should
> reflect the true number of references.

But to keep this really a "true number" we would have to now decrement the
counter when the page gets freed by a different stack trace, i.e. we replace
the previously stored free_handle with another one. Which is possible, but
seems like a waste of CPU?

> Perhaps, what you need is some kind of per-stack trace user metadata.
> And the details of what format this metadata takes shouldn't be
> present in the stack depot code.

I was thinking ideally we might want fully separate stackdepot storages
per-stack trace user, i.e. separate hashmaps and dynamically allocated
handles instead of the static "slabs" array. Different users tend to have
distinct stacks so that would make lookups more effective too. Only
CONFIG_STACKDEPOT_ALWAYS_INIT users (KASAN) would keep using the static
array due to their inherent limitations wrt dynamic allocations.

Then these different stackdepot instances could be optionally refcounted or
not, and if need be, have additional metadata as you suggest.

>> > Could you split out the stack depot and the page_owner changes into
>> > separate patches?
>>
>> I could, I am not sure if it would make the review any easier though,
>> as you could not match stackdepot <-> page_owner changes.
>>
>> And we should be adding a bunch of code that would not be used till later on.
>> But I can try it out if there is a strong opinion.
> 
> Yes, splitting would be quite useful. It allows backporting stack
> depot changes without having to backport any page_owner code. As long
> as there are not breaking interface changes, of course.
> 
> Thanks!
> 

