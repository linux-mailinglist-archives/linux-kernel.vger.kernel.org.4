Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC925F9B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJJI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiJJI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:57:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A567161
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:57:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33456218B5;
        Mon, 10 Oct 2022 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665392258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GJeMJcm8hXSrZyUxyPGtmH7w1EUbF6JJHgm6aL826Q=;
        b=XpVEPQNr4JpLchfnbWg/yC9QA8+wVWd8pRuDeCS9EIS4vwxsGXp45yDRs3cN0xs6YQZbE3
        HOgHIIvtfTwMpoeb1MsKJHUsMcS3Gdj/j6L53VRpzHt7I9OJjU1a2vCiZpivNOpOiuOOOp
        oUoNGreoz47/JgubDCG976QTm6nSk9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665392258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GJeMJcm8hXSrZyUxyPGtmH7w1EUbF6JJHgm6aL826Q=;
        b=2Jygt+R11U9FYm7wJOkr8oW8YTM2YBHqrLO246w8R0cYNWocaqBocj8qw88WOYjZb/wxIn
        KPVH8XeXJpbA33AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E32B413479;
        Mon, 10 Oct 2022 08:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C2doNoHeQ2OxfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 10 Oct 2022 08:57:37 +0000
Message-ID: <5f7aafae-4761-3031-7a7d-963e813e73c3@suse.cz>
Date:   Mon, 10 Oct 2022 10:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm: add stackdepot information on page->private for
 tracking
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <1665026390-16096-1-git-send-email-zhaoyang.huang@unisoc.com>
 <cd103df8-d0da-ab15-5755-c20631055986@suse.cz>
 <CAGWkznHSyT59Ca57EnYu+zY+tkTE=p8LKaJqS0Y7TC4s+aZ8iA@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAGWkznHSyT59Ca57EnYu+zY+tkTE=p8LKaJqS0Y7TC4s+aZ8iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/22 04:25, Zhaoyang Huang wrote:
> On Fri, Oct 7, 2022 at 6:08 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/6/22 05:19, zhaoyang.huang wrote:
>> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> >
>> > Private is vacant for most of Non-LRU pages while the user has explicitly
>> > operation on page->private via set_page_private, I would like introduce
>> > stackdepot information on page->private for a simplified tracking mechanism
>> > which could be help for kernel driver's memory leak.
>> >
>> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>
>> This duplicates the existing page_owner functionality in a way that
>> unconditionally adds overhead to all kernels that have CONFIG_STACKDEPOT
>> enabled build-time (and also misses the need to initialize stackdepot properly).
> Sure. This patch could be deemed as a light and complement of the page
> owner which depends on proc fs in lived system for showing the result.
> This patch could be mainly helpful on RAM dump as it is hard to find
> page_ext for page owners. I also would like to make this optional via
> defconfig item.

I'm still not convinced we need this, between existing page_owner and the
proposed code tagging framework.

https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/

For finding page_ext in crash dumps, it's possible with a scriptable
debugger like drgn or crash-python.

>>
>> Also wouldn't be suprised if some existing page->private users were actually
>> confused by the field suddenly being non-zero without their own action.
> IMO, the existing page->private users will cover this field directly
> without distrubed by handle.

Well the bot wasn't happy so far
https://lore.kernel.org/all/202210072204.cfea59d3-oliver.sang@intel.com/

>>
>> > ---
>> >  mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
>> >  1 file changed, 27 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> > index e5486d4..b79a503 100644
>> > --- a/mm/page_alloc.c
>> > +++ b/mm/page_alloc.c
>> > @@ -75,6 +75,7 @@
>> >  #include <linux/khugepaged.h>
>> >  #include <linux/buffer_head.h>
>> >  #include <linux/delayacct.h>
>> > +#include <linux/stackdepot.h>
>> >  #include <asm/sections.h>
>> >  #include <asm/tlbflush.h>
>> >  #include <asm/div64.h>
>> > @@ -2464,6 +2465,25 @@ static inline bool should_skip_init(gfp_t flags)
>> >       return (flags & __GFP_SKIP_ZERO);
>> >  }
>> >
>> > +#ifdef CONFIG_STACKDEPOT
>> > +static noinline depot_stack_handle_t set_track_prepare(void)
>> > +{
>> > +       depot_stack_handle_t trace_handle;
>> > +       unsigned long entries[16];
>> > +       unsigned int nr_entries;
>> > +
>> > +       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>> > +       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>> > +
>> > +       return trace_handle;
>> > +}
>> > +#else
>> > +static inline depot_stack_handle_t set_track_prepare(void)
>> > +{
>> > +       return 0;
>> > +}
>> > +#endif
>> > +
>> >  inline void post_alloc_hook(struct page *page, unsigned int order,
>> >                               gfp_t gfp_flags)
>> >  {
>> > @@ -2471,8 +2491,14 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>> >                       !should_skip_init(gfp_flags);
>> >       bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
>> >       int i;
>> > +     depot_stack_handle_t stack_handle = set_track_prepare();
>> >
>> > -     set_page_private(page, 0);
>> > +     /*
>> > +      * Don't worry, user will cover private directly without checking
>> > +      * this field and has ability to trace the page. This also will not
>> > +      * affect expected state when freeing
>> > +      */
>> > +     set_page_private(page, stack_handle);
>> >       set_page_refcounted(page);
>> >
>> >       arch_alloc_page(page, order);
>>

