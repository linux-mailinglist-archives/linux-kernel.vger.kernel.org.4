Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E95704DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjEPMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjEPMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AECE1713
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684240838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upbxxvOzNSBT926IBK9ZbKutV3zDXORRb/Sm2DRZKY8=;
        b=XdVGe7jhgs9vnGhX/+1277ahTUkuAnRwpBWokOrx58IdtKA5g7/g3GlVRYwm4dx69hOHn8
        OayeowRvWM6eBwu1p4hteJxK6eMxh4/eNpWgDSOsLTz+tDax2IDQrzugEQUQHS6lxSjnN0
        XASLq+cgzjE/htrC7EfXuD9saj9vKHI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-GGqwD7c9M2Gl5n_1crFUUg-1; Tue, 16 May 2023 08:40:37 -0400
X-MC-Unique: GGqwD7c9M2Gl5n_1crFUUg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42ceb4a4fso29297965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240836; x=1686832836;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upbxxvOzNSBT926IBK9ZbKutV3zDXORRb/Sm2DRZKY8=;
        b=c2GgXhUeFJvqqSBeIXB4FiUfuCvVuASfeXEq3Z/GiSTnQvyAoFwqxxTFhjll66Hclx
         j58pFIRYwpMCzQ//FBumkdSchP0yzwGtP2R8oSz7qhuG+305tD1yHkoe6Phhx3y/e75S
         a3owTHDBT7jZjQYx9HIFbROs5SgU2CQIy/6yld2yKfSyTuay4vtPV4rnHFd951HK3m2f
         GR5yVuL1BLNAd35birKFiatR4Sa9/uKORPMDlR26hJXEMLY2XIE+1BPhGdOxy3Z0GXmY
         f3uznTb27bUnzsFRLOS6vXzaA7ehF7HhTRBf2nL/uk8ARx+SYleJurNWq65DCkVe1PXE
         yqHA==
X-Gm-Message-State: AC+VfDw22cAwwlklk4o1EWbRtPoy6MlUMmkLNwI0D8eTRzoji/40Wv0H
        U0IKR0UgLXCKMfZawSK5ZPeViUnzOx+voFNeI/t34CY8G690D3UFKMkg3pSvPeBMeQqlb3HTA3c
        x3pAXn6zhAt82i6cXOgtecumB
X-Received: by 2002:adf:e7ca:0:b0:306:4063:1aff with SMTP id e10-20020adfe7ca000000b0030640631affmr27980922wrn.30.1684240836285;
        Tue, 16 May 2023 05:40:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4AIRomaPkOHFiqyLi+kkY65j+brNGYH2HLoYKsCiqeVH2oIr9hQC43Db4GD6+O8ErBjUR0hA==
X-Received: by 2002:adf:e7ca:0:b0:306:4063:1aff with SMTP id e10-20020adfe7ca000000b0030640631affmr27980889wrn.30.1684240835926;
        Tue, 16 May 2023 05:40:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d5185000000b0030497b3224bsm2513457wrv.64.2023.05.16.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:40:35 -0700 (PDT)
Message-ID: <efd5fb89-4f60-bee1-c183-5a9f89209718@redhat.com>
Date:   Tue, 16 May 2023 14:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Content-Language: en-US
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
 <ZGLLSYuedMsViDQG@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZGLLSYuedMsViDQG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 02:16, Peter Collingbourne wrote:
> On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
>> On 13.05.23 01:57, Peter Collingbourne wrote:
>>> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
>>> the call to swap_free() before the call to set_pte_at(), which meant that
>>> the MTE tags could end up being freed before set_pte_at() had a chance
>>> to restore them. One other possibility was to hook arch_do_swap_page(),
>>> but this had a number of problems:
>>>
>>> - The call to the hook was also after swap_free().
>>>
>>> - The call to the hook was after the call to set_pte_at(), so there was a
>>>     racy window where uninitialized metadata may be exposed to userspace.
>>>     This likely also affects SPARC ADI, which implements this hook to
>>>     restore tags.
>>>
>>> - As a result of commit 1eba86c096e3 ("mm: change page type prior to
>>>     adding page table entry"), we were also passing the new PTE as the
>>>     oldpte argument, preventing the hook from knowing the swap index.
>>>
>>> Fix all of these problems by moving the arch_do_swap_page() call before
>>> the call to free_page(), and ensuring that we do not set orig_pte until
>>> after the call.
>>>
>>> Signed-off-by: Peter Collingbourne <pcc@google.com>
>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
>>> Cc: <stable@vger.kernel.org> # 6.1
>>> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
>>> Fixes: 1eba86c096e3 ("mm: change page type prior to adding page table entry")
>>
>> I'm confused. You say c145e0b47c77 changed something (which was after above
>> commits), indicate that it fixes two other commits, and indicate "6.1" as
>> stable which does not apply to any of these commits.
> 
> Sorry, the situation is indeed a bit confusing.
> 
> - In order to make the arch_do_swap_page() hook suitable for fixing the
>    bug introduced by c145e0b47c77, patch 1 addresses a number of issues,
>    including fixing bugs introduced by ca827d55ebaa and 1eba86c096e3,
>    but we haven't fixed the c145e0b47c77 bug yet, so there's no Fixes:
>    tag for it yet.
> 
> - Patch 2, relying on the fixes in patch 1, makes MTE install an
>    arch_do_swap_page() hook (indirectly, by making arch_swap_restore()
>    also hook arch_do_swap_page()), thereby fixing the c145e0b47c77 bug.
> 

Oh. That's indeed confusing. Maybe that should all be squashed to have 
one logical fix for the overall problem. It's especially confusing 
because this patch here fixes the other two issues touches code moved by 
c145e0b47c77.

> - 6.1 is the first stable version in which all 3 commits in my Fixes: tags
>    are present, so that is the version that I've indicated in my stable
>    tag for this series. In theory patch 1 could be applied to older kernel
>    versions, but it wouldn't fix any problems that we are facing with MTE
>    (because it only fixes problems relating to the arch_do_swap_page()
>    hook, which older kernel versions don't hook with MTE), and there are
>    some merge conflicts if we go back further anyway. If the SPARC folks
>    (the previous only user of this hook) want to fix these issues with ADI,
>    they can propose their own backport.

Sometimes, it's a good idea to not specify a stable version and rather 
let the Fixes: tags imply that.

-- 
Thanks,

David / dhildenb

