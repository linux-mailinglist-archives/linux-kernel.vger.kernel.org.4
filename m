Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3DA67950B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjAXKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjAXKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:19:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4F2E0D3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyCqz+q1FOAw1TQY7+/YLob/l7GyndY1wuroRx7I9oY=;
        b=VUm+YzCPR0mESmCx0LTOQCGUHFtmHcoCbDp2lOhniyXT3dE9li3RhghkPyuTnv/cjvkhOQ
        axH9Sb8Joqy1nUiItjJ/mwN75XRDFhma2s/Dkr4F6B9BaX31q0+xHBo/VYmu4rDpHb7gXI
        vecYimSw3Sw3qQwGjlr+oGMRL3rFQPE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-a23sxNM2OiOOINvyQNA30Q-1; Tue, 24 Jan 2023 05:19:06 -0500
X-MC-Unique: a23sxNM2OiOOINvyQNA30Q-1
Received: by mail-wr1-f72.google.com with SMTP id by12-20020a056000098c00b002bfb325c0edso106952wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyCqz+q1FOAw1TQY7+/YLob/l7GyndY1wuroRx7I9oY=;
        b=f2mPcHePpmlLPisTHmNwqKFOJD+qOGanR29A44fPsIkdAtoYivVFyh2bur+tIdF/us
         TwegoxS8UtHITW7EcfOjsQ7R7cPZb2vDjv/x4UO3M6z8zXsQXAa1j59oDg9L/grJHNGU
         jmHxkiZggj/JRtufJbXyPnTi3NLIGaXBxjwjhRsLKrmPALNuTo+kQIB2zWhDRaSjqZZK
         xZKLBlhKzXwXp9gUzBtXfz7NKIEQ1W5gCt18JhoLkznVnbKiktmNBQwaYwpCuVXk15Ok
         znpD2HtsuH7wkb44a/rowgV2gakg+Il1Xnkw1gl23tyrLB8xxsjq1cIuxKrZQblAGYHB
         eETg==
X-Gm-Message-State: AFqh2ko4wPMtO9Yie9RWUqQ54QFW6zK1WcQ+Fa+b/Xq15yx3jR+sAZ/S
        +yLg2D+pLjsgnruvqCENWcy9d9+UGNv2Spv7HS4JvMAHM17OMs62h0jUz0mSN0rp96Y4Kfo3ld7
        +tteK+NhrKdkjU3Y/Agsj7aD6
X-Received: by 2002:a05:600c:5386:b0:3da:f670:a199 with SMTP id hg6-20020a05600c538600b003daf670a199mr27171187wmb.36.1674555544841;
        Tue, 24 Jan 2023 02:19:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtpI+7NIxjA7yuHHkcSvFk74BBjIJ5+hNyfA7Zktc92gQIn7UM3QCwxgY5Up5wD22djWNwTqQ==
X-Received: by 2002:a05:600c:5386:b0:3da:f670:a199 with SMTP id hg6-20020a05600c538600b003daf670a199mr27171162wmb.36.1674555544546;
        Tue, 24 Jan 2023 02:19:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id c3-20020a1c3503000000b003dc0b0e1e47sm2405844wma.48.2023.01.24.02.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:19:04 -0800 (PST)
Message-ID: <4cb68043-1c06-6589-b83e-74847a06f457@redhat.com>
Date:   Tue, 24 Jan 2023 11:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>, g@box.shutemov.name
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
 <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
 <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
 <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
 <5a7fdfa7-5b25-0ed4-2479-661d387b397b@redhat.com>
 <20230116134710.n4dgtrutt6rqif62@box.shutemov.name>
 <1b8696ec-e2be-7b7b-705c-e2dcabb2e8e5@redhat.com>
 <20230124005102.ow33h7tfmj5eqyr3@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230124005102.ow33h7tfmj5eqyr3@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.23 01:51, Kirill A. Shutemov wrote:
> On Mon, Jan 23, 2023 at 12:07:05PM +0100, David Hildenbrand wrote:
>>>> commit bedf03416913d88c796288f9dca109a53608c745
>>>> Author: Yang Shi <shy828301@gmail.com>
>>>> Date:   Wed Sep 7 11:01:44 2022 -0700
>>>>
>>>>       powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush
>>>>       The IPI broadcast is used to serialize against fast-GUP, but fast-GUP will
>>>>       move to use RCU instead of disabling local interrupts in fast-GUP.  Using
>>>>       an IPI is the old-styled way of serializing against fast-GUP although it
>>>>       still works as expected now.
>>>>       And fast-GUP now fixed the potential race with THP collapse by checking
>>>>       whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
>>>>       flush is not necessary anymore.  But it is still needed for hash TLB.
>>>
>>> Okay. But I think tlb_remove_table_sync_one() belongs inside
>>> pmdp_collapse_flush(). Collapsing pmd table into huge page without
>>> serialization is a bug. They should not be separate.
>>
>> Agreed. But I wonder if it should be moved into a generic
>> pmdp_collapse_flush(), that calls an arch specific __pmdp_collapse_flush().
> 
> Um? There's no __pmdp_collapse_flush().

Did I imply that there is already one? ;)

-- 
Thanks,

David / dhildenb

