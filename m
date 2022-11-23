Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550C6352ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiKWIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiKWIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4BFAEB7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669192807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSsK49BB0QehTaq7s72UHqC+yK7r2J42taJ8WZgTeaE=;
        b=YHt4PfNTfd4PKgUv2Pi8m1mWTJHgBB5NmXUk+zpKiaOnQipz6RWoGJ+D9et0YidXzAfndC
        B5JRf61ujq2uvvz5Mpycz0IPZyCTMJt1GSClVFMKztQehsoa9dsLLz56MbtgKtbV2wuLbe
        rE7j2C1cgFw34Pa1gIfXGixirRjfCzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-LOoetBJLPuG6EJlM1zCifQ-1; Wed, 23 Nov 2022 03:40:06 -0500
X-MC-Unique: LOoetBJLPuG6EJlM1zCifQ-1
Received: by mail-wm1-f69.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso9320389wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSsK49BB0QehTaq7s72UHqC+yK7r2J42taJ8WZgTeaE=;
        b=uvNSb+6mtbtmmklFoigZ8kCJA6Y669WcM9PXvwy5u8XY1mpTx8XM+x2wBhul6q13di
         b8JqKywZM1g+4WXjTdAbBCl/sHu/IMx52zMCQD6WcdA+5y9iuk0orZXp6MKqTsN93Iz6
         DaQGWani6xS9YPg1D/55qShJxH9w9R9kPczbYePGqYkrHV2374E19IvNB8BwHoycx/rn
         hZ64zjheWdMwJ0nDBcejawBSap5KtzCJZHhyhbhyhJFkCA206LzmyJR827x8O5ZKV1rw
         AlP1CMdGPBrxbFJddv0TFzxjPSqbszuSPkyofpjEPY8nVkdNW2LOMvR8oWu13Su6lZjO
         Fu9A==
X-Gm-Message-State: ANoB5pkTiyV4IIaRzyUWi6co0m4k6U6scoSZw0x8hsRWQ/c25d/8BsH1
        naoYdgsoKB4qm/aHIcb189aQ/OFx4qAnKdehXs14k2T70AIjm0BOM7ykp8VPS9nhfuxfomd1SSO
        6NSY4WVdJHcbAZ8cM3sViRBhH
X-Received: by 2002:a5d:6f0f:0:b0:236:5b81:1daa with SMTP id ay15-20020a5d6f0f000000b002365b811daamr7396603wrb.17.1669192805367;
        Wed, 23 Nov 2022 00:40:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QOnQvBzB6n112DRc9RH4+gTUwZYkUf68gnI2V7DPxPxw3tyuQ0+/0nTKyVjoqiuMFlpRKHQ==
X-Received: by 2002:a5d:6f0f:0:b0:236:5b81:1daa with SMTP id ay15-20020a5d6f0f000000b002365b811daamr7396576wrb.17.1669192805070;
        Wed, 23 Nov 2022 00:40:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c189400b003c6deb5c1edsm1379153wmp.45.2022.11.23.00.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:40:04 -0800 (PST)
Message-ID: <eeef7d42-4e89-eafc-ab0f-e65de3a2cccc@redhat.com>
Date:   Wed, 23 Nov 2022 09:40:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com> <Y2BIbyxT0Bh6bCUr@monkey>
 <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
 <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
 <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com> <Y30Js24EqCncvqO/@monkey>
 <Y30N/YCg9MOVnhLk@nvidia.com>
 <20221122150355.41805b9013855cf0433b6612@linux-foundation.org>
 <Y31fxXk/Ou3Zr6kS@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y31fxXk/Ou3Zr6kS@monkey>
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

On 23.11.22 00:48, Mike Kravetz wrote:
> On 11/22/22 15:03, Andrew Morton wrote:
>> On Tue, 22 Nov 2022 13:59:25 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>>>>
>>>>>      While that's certainly valid, it's not the common use case with
>>>>>      hugetlb pages.
>>>>
>>>> FWIW, I did check with our product teams and they do not knowingly make use
>>>> of private mappings without write.  Of course, that is only a small and
>>>> limited sample size.
>>>
>>> Yeah, if it is only this case I'm comfortable as well
>>>
>>
>> So.... I am to slap a cc:stable on this patch and we're all good?
> 
> I think we will also need a Fixes tag.  There are two options for this:
> 1) In this patch David rightly points out
>     "I assume this has been broken at least since 2014, when mm/gup.c came to
>      life. I failed to come up with a suitable Fixes tag quickly."
>     So, we could go with some old gup commit.
> 2) One of the benefits of this patch is silencing the warning introduced
>     by 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared mappings").
>     So, we could use this for the tag.  It is also more in line with David's
>     suggestion to "backport it into 6.0/6.1 to fix the warning".
> 
> My suggestion would be to use 1d8d14641fd9 for the fixes tag.  However,
> David may have a better suggestion/idea.

Right, in an ideal world we'd backport this patch here to the dawn of
time where hugetlb + gup came to life and FOLL_FORCE was not properly fenced
of for hugetlb.

However, such a patch is not really stable-worthy I guess. So I'm fine
with "fixing the warning introduced for finding such previously wrong
behavior" instead.

Fixes: 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared mappings")
Cc: <stable@vger.kernel.org>

-- 
Thanks,

David / dhildenb

