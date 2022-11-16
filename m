Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094A862B674
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKPJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiKPJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4F6240
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668590691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBg0vpR79ykrWg7W6yFVkquAa8QDFi53cO5reZCSm2w=;
        b=WsLUMYArQTmmG2/5U2O++z89P+bY3Wtkz3/KBQlRqjKcVKHwM9bhlgKAFsNpcdk3HpHB0w
        GcAeEyNZDy2NrZrEWqmkI55Cei2aVxxyQ+0J7RELSuhW2ExG4JXkvCbiNa2XMrQAVhHOdA
        nDFmN/A/jHe/dcL42/c8+KK18TKR6hU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-U4nOe68LMW2i8Xog-Z9oJg-1; Wed, 16 Nov 2022 04:24:50 -0500
X-MC-Unique: U4nOe68LMW2i8Xog-Z9oJg-1
Received: by mail-wr1-f70.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so2716861wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBg0vpR79ykrWg7W6yFVkquAa8QDFi53cO5reZCSm2w=;
        b=0BvXiaXVjPkCJAXS70st7qhl+GVKolKSwghzoKADLnO9X6NalnszCrUBaU6geqKNjo
         3o9FH/CGndFHRrUxu0F2dRdquY9+8Cz54ulaxQk0a/8vv7GpQ44jBG4nl6byflGibDSF
         NjfqDUGPSz73Bk8Ng/hgRD1R21e4cph4JqTI3DeVSbdmJ52sLL3c2zkIXECthrxQHSlf
         hMf+yf63wuzrtRDCqlFBv1NgenrmZu2Jw+DVQfPHKnKWcOuv/AtFsRqz9L6nGvJUZOn5
         SMWD116Cw8YuiHvbJ17o1kWCAUoW4F/6RXtvPsc2wu1Qijw1g5phqMK9wd+815oyQfye
         /mBQ==
X-Gm-Message-State: ANoB5pnmTuWV+G+e5mFI8ozFnD++90973KVK8VDeBjfVlQQak192HAPF
        +oYrhjCe+OPoxJ80vIrG5rli276fKitUer+3lvZ0iGiPHOwYmM8o4oCAT6KjO4eZOmIyn6IDxvK
        m9gv04Nm3yLxPCM54M7KgVEaX
X-Received: by 2002:a5d:6743:0:b0:22e:28fe:39d6 with SMTP id l3-20020a5d6743000000b0022e28fe39d6mr13359758wrw.701.1668590689126;
        Wed, 16 Nov 2022 01:24:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4VFuyxwMjEQ9LcEB4erUpRK2y3OS4R2z2ooCMN1U5iH5mRvOiSincwS1V5ESg00uTHpGDJcw==
X-Received: by 2002:a5d:6743:0:b0:22e:28fe:39d6 with SMTP id l3-20020a5d6743000000b0022e28fe39d6mr13359744wrw.701.1668590688833;
        Wed, 16 Nov 2022 01:24:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003cff309807esm1263398wmo.23.2022.11.16.01.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:24:48 -0800 (PST)
Message-ID: <ce30117b-c652-5598-480f-6e367258ab30@redhat.com>
Date:   Wed, 16 Nov 2022 10:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/4] mm: teach release_pages() to take an array of encoded
 page pointers too
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-2-torvalds@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221109203051.1835763-2-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.22 21:30, Linus Torvalds wrote:
> release_pages() already could take either an array of page pointers, or
> an array of folio pointers.  Expand it to also accept an array of
> encoded page pointers, which is what both the existing mlock() use and
> the upcoming mmu_gather use of encoded page pointers wants.
> 
> Note that release_pages() won't actually use, or react to, any extra
> encoded bits.  Instead, this is very much a case of "I have walked the
> array of encoded pages and done everything the extra bits tell me to do,
> now release it all".
> 
> Also, while the "either page or folio pointers" dual use was handled
> with a cast of the pointer in "release_folios()", this takes a slightly
> different approach and uses the "transparent union" attribute to
> describe the set of arguments to the function:
> 
>    https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html
> 
> which has been supported by gcc forever, but the kernel hasn't used
> before.
> 
> That allows us to avoid using various wrappers with casts, and just use
> the same function regardless of use.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

