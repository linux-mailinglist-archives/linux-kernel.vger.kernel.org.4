Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A0631AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKUIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKUIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7123387
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669017948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fkuVnnKfnYdazWQA0wQdSIDRDvDUTp9+DxYQu2B22U=;
        b=U9zqECG1xbkZUhVQdXzBTvjNOoe1NKcRFALjzwEREbQcHL6SwG0mlynNdPKmr2osLtfpKJ
        C/IjGjEQIvqY9Yfxn165IbI0lQ6VjWatUsUq6TttUKUekjKKyeAxQQ3EecHT34fJMCdI5d
        bSqPjpXfJM0aX/Hrlil94QDQ8HfeMZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-kRASXcIfPT6oKgcn_aC_Yw-1; Mon, 21 Nov 2022 03:05:46 -0500
X-MC-Unique: kRASXcIfPT6oKgcn_aC_Yw-1
Received: by mail-wm1-f72.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so2767477wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fkuVnnKfnYdazWQA0wQdSIDRDvDUTp9+DxYQu2B22U=;
        b=7F8grnE2TmyTPedQZWyFEE4BbJoI9ug0yeJMVo2b+fIgu+QZF3x+REj6ODVBYloyg9
         UDFkIg6LMOz8dVGlTNzKrJ2MANiSBycAS/Z6PLW84dqBffzgZXHyPX2ouRnfGIa2GeRQ
         TAIRKn3Ur7tnhpy+/bwozdZ1QgCHPfYn24cOREh86OW5LkH/NkmQ8Ns29VYZucJJWdLK
         ZCuRK2FKBBKW3V38RszPFEPhAB6/YkYAN2kgzrtenXmUrOX87b/AKofM2mhzfjliGUoa
         9bhB/ZNBq8JQvD6Ke3P1k/h6/B/u4WzoneBoME9PC7gaaSLV7/fC0NlJJpSLqU6BMHWg
         UKFA==
X-Gm-Message-State: ANoB5pmjB3voV9x3MhSX+XKM06f/eTO4DSJSBPnVcv9MPzGqNWjn5gdz
        vx1EJNimiMFTxjULUr4hdrkNq2ZR26YgK9iP5RPjWZn2mcffa6EyIHYzRdAd1+8y1/hRgni7F4i
        xZpHzbXEWs3vqE3W6zw+xW+sa
X-Received: by 2002:a5d:4404:0:b0:236:657e:757e with SMTP id z4-20020a5d4404000000b00236657e757emr2407088wrq.350.1669017945459;
        Mon, 21 Nov 2022 00:05:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5T7MYZ1Z7Tgz3Lc6SCcOpsIQYMy0SCl85W6ZxjqCOEXMJCtZCTWw6mvGWUD1VqWChgbiyWGw==
X-Received: by 2002:a5d:4404:0:b0:236:657e:757e with SMTP id z4-20020a5d4404000000b00236657e757emr2407080wrq.350.1669017945195;
        Mon, 21 Nov 2022 00:05:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:dc00:2571:c3c2:c6ea:84ef? (p200300cbc702dc002571c3c2c6ea84ef.dip0.t-ipconnect.de. [2003:cb:c702:dc00:2571:c3c2:c6ea:84ef])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm19113223wmg.46.2022.11.21.00.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:05:44 -0800 (PST)
Message-ID: <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
Date:   Mon, 21 Nov 2022 09:05:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com> <Y2BIbyxT0Bh6bCUr@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y2BIbyxT0Bh6bCUr@monkey>
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

On 31.10.22 23:13, Mike Kravetz wrote:
> On 10/31/22 13:14, Jason Gunthorpe wrote:
>> On Mon, Oct 31, 2022 at 04:25:24PM +0100, David Hildenbrand wrote:
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>
>>> I assume this has been broken at least since 2014, when mm/gup.c came to
>>> life. I failed to come up with a suitable Fixes tag quickly.
>>
>> I'm worried this would break RDMA over hugetlbfs maps - which is a
>> real thing people do.
> 
> Yes, it is a real thing.  Unfortunately, I do not know exactly how it is used.
> 
>>
>> MikeK do you have test cases?
> 
> Sorry, I do not have any test cases.
> 
> I can ask one of our product groups about their usage.  But, that would
> certainly not be a comprehensive view.

With

https://lkml.kernel.org/r/20221116102659.70287-1-david@redhat.com

on it's way, the RDMA concern should be gone, hopefully.

@Andrew, can you queue this one? Thanks.

-- 
Thanks,

David / dhildenb

