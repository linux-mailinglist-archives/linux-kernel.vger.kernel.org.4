Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B56A717A96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjEaIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjEaIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485BEE42
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685522796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nx2y8OB2aLxSFND9I+Qn5cRQvjq0n5CCY38YbkEtKAw=;
        b=ixlNjoWAXFVeavpP36sE8jWEe0LZaRUPwXtlCoVthyzyPrGmmavX3Qcr0qeVH56Tsl72As
        CCZyMZxNTl6Fd6eymywCzn0UT3B/JKEBc/rOv9ndLYBAEL7KP4iVK4D0I+br/c7ajeoUv+
        finzqsz4rq9DoyitoRwW5J3QjKAMAss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-DQv-zdoNPoSQ1QXlQoTVqw-1; Wed, 31 May 2023 04:46:33 -0400
X-MC-Unique: DQv-zdoNPoSQ1QXlQoTVqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f613f5d290so91146905e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685522792; x=1688114792;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nx2y8OB2aLxSFND9I+Qn5cRQvjq0n5CCY38YbkEtKAw=;
        b=dYYd6bS0ahZyp/y77WHJa8s/fDRwmrWHrHNpo6gZqAEc8IPoZgXWXXgRRdQb0KRyJL
         z3EkkJVRWD/+uJtNmY5OXIf32fg5fUVeR/UjoHc4Z3lKVzMEq2uNDafAg2alWUHyPZ7D
         uBA+UORJ/m1OX/bbO1gWbiPSlsLqIMcCkGtAzxwR6GSxhmY0/QNbM+e9uBZe32Z3Eqkw
         gGEq9XLTjG89DbxM+8yYI0DfozLT2Cr2zcrbfjaoHHzgFDIsf6+ITnwd1YZqkce6EJy6
         QDEkCNub3BRz028miomH8BDGKDHhIjO9AfsQt1k+Xk34hUdFxBrdcI0n+f2rDUvIya9d
         2eOA==
X-Gm-Message-State: AC+VfDwm6+n4P0g0JV1O/gIMZMy19y+onQMrWSTo/alEzmcfLgVj6AFQ
        zMB+R5z8OHx9GkpmdMr1uMQCuD4aBp3RgFONjDr10xJWK0B79tgXW2WJj8msPtq5I7mMzu+xSP2
        wYKG5+4Blwk++XtSLdA68cW+G
X-Received: by 2002:a1c:ed14:0:b0:3f5:ffe2:91c0 with SMTP id l20-20020a1ced14000000b003f5ffe291c0mr3840030wmh.0.1685522792111;
        Wed, 31 May 2023 01:46:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40ukZYaC9+p2ae+0GrHp4hYdn2NPfwIUaiQLhpoTRtuUrMnrS/tcvC//4ponMDsKOMIldq3Q==
X-Received: by 2002:a1c:ed14:0:b0:3f5:ffe2:91c0 with SMTP id l20-20020a1ced14000000b003f5ffe291c0mr3840011wmh.0.1685522791768;
        Wed, 31 May 2023 01:46:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003f31d44f0cbsm23714702wmo.29.2023.05.31.01.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:46:31 -0700 (PDT)
Message-ID: <492558dc-1377-fc4b-126f-c358bb000ff7@redhat.com>
Date:   Wed, 31 May 2023 10:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com>
 <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-2-dhowells@redhat.com>
 <510965.1685522152@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
In-Reply-To: <510965.1685522152@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.23 10:35, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
>>> to it from the page tables and make unpin_user_page*() correspondingly
>>> ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
>>> zero page's refcount as we're only allowed ~2 million pins on it -
>>> something that userspace can conceivably trigger.
>>
>> 2 millions pins (FOLL_PIN, which increments the refcount by 1024) or 2 million
>> references ?
> 
> Definitely pins.  It's tricky because we've been using "pinned" to mean held
> by a refcount or held by a flag too.
> 

Yes, it would be clearer if we would be using "pinned" now only for 
FOLL_PIN and everything else is simply "taking a temporary reference on 
the page".

> 2 million pins on the zero page is in the realms of possibility.  It only
> takes 32768 64-page DIO writes.
> 
>>> @@ -3079,6 +3096,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>>>     *
>>>     * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>>>     * see Documentation/core-api/pin_user_pages.rst for further details.
>>> + *
>>> + * Note that if a zero_page is amongst the returned pages, it will not have
>>> + * pins in it and unpin_user_page() will not remove pins from it.
>>>     */
>>
>> "it will not have pins in it" sounds fairly weird to a non-native speaker.
> 
> Oh, I know.  The problem is that "pin" is now really ambiguous.  Can we change
> "FOLL_PIN" to "FOLL_NAIL"?  Or maybe "FOLL_SCREW" - your pages are screwed if
> you use DIO and fork at the same time.
> 

I'm hoping that "pinning" will be "FOLL_PIN" (intention to access page 
content) and everything else is simply "taking a temporary page reference".

>> "Note that the refcount of any zero_pages returned among the pinned pages will
>> not be incremented, and unpin_user_page() will similarly not decrement it."
> 
> That's not really right (although it happens to be true), because we're
> talking primarily about the pin counter, not the refcount - and they may be
> separate.

In any case (FOLL_PIN/FOLL_GET) you increment/decrement the refcount. If 
we have a separate pincount, we increment/decrement the refcount by 1 
when (un)pinning.

Sure, if we'd have a separate pincount we'd also not be modifying it.

-- 
Thanks,

David / dhildenb

