Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E40706308
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjEQIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEQIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E175FF9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoyE4KJMZkzKP/aXFBkcgtSqzW5vCFF351V1GgKfqTs=;
        b=K1pZIcFPbED6EDpwG2Wx+TZzAosf3CUEOD0cI7FdjjDNSwjy3ZgXwWvZFw72zpROwEqiSx
        j1Iml5RxmYlbAjzdroUSxiXjPkm01E38cgI5pWySx3PgKMxMcL/LF73RsU5wBMaN9lwk7b
        Gd899R4pkM1ca9MugHFnag4lCMPTYDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ru_K_doNN6GJ1nZYudWt9w-1; Wed, 17 May 2023 04:34:45 -0400
X-MC-Unique: ru_K_doNN6GJ1nZYudWt9w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f420ec766dso3523985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312484; x=1686904484;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoyE4KJMZkzKP/aXFBkcgtSqzW5vCFF351V1GgKfqTs=;
        b=BjYItg7b98v0tOc485gMl/J4m9JUAsryh86tXrFrheHu7TEX4X/QIwX8kqj6suPZ+c
         OKEsOq7V3y6R1RJjqBOru9elskEbs0+6KvGDZUYEFovw7CkDpA0t43vHXO+joca6Dqr6
         px4AzucwfxuxxXvg9C3iW+QYkkphjr985W+DbI/spTRZ1Qon0WeOAuHt9zrJcWNwOg+R
         nK05RuuNoLac87z/w48Rx4R3u/Ti1vHUpIRXVjfmKq2PHhF7uBdlNtbW9qFrndMA7PpG
         EdEBz1BAKC4iKEVh+/xbANHfwVKd2HEhiVJuQSFKX8tOtQtAwT73Kf1mYHh9MephSS3G
         XjbQ==
X-Gm-Message-State: AC+VfDyxw/wxaEesRYItERoDdwyu3eHb7aIY880SYSOY3LQkGRvaP7yM
        DujQvwNyynFFN1vpWPnIyeEzd1ijP1vAh13xoOXuAMSOKJmMTgbKa50KFZfpau2l26deRECz0Z8
        iQrfrHF5+rLA/QeImlqvH5clW
X-Received: by 2002:a05:600c:2307:b0:3f4:2cf3:a542 with SMTP id 7-20020a05600c230700b003f42cf3a542mr18563293wmo.6.1684312483861;
        Wed, 17 May 2023 01:34:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69xCz2yc3tWerUY2z+evrEEbLpsBdhPCID8fyE+1EMtIzuO7zBap/5z+L7vWNzh3MQYaHFXA==
X-Received: by 2002:a05:600c:2307:b0:3f4:2cf3:a542 with SMTP id 7-20020a05600c230700b003f42cf3a542mr18563263wmo.6.1684312483462;
        Wed, 17 May 2023 01:34:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b003f182cc55c4sm1505469wmk.12.2023.05.17.01.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:34:43 -0700 (PDT)
Message-ID: <a9312c59-215a-1213-459e-bf42af555f0c@redhat.com>
Date:   Wed, 17 May 2023 10:34:41 +0200
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
 <ZGLLSYuedMsViDQG@google.com> <ZGLr7CzUL0A+mCRp@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZGLr7CzUL0A+mCRp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 04:35, Peter Collingbourne wrote:
> On Mon, May 15, 2023 at 05:16:09PM -0700, Peter Collingbourne wrote:
>> On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
>>> On 13.05.23 01:57, Peter Collingbourne wrote:
>>>> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
>>>> the call to swap_free() before the call to set_pte_at(), which meant that
>>>> the MTE tags could end up being freed before set_pte_at() had a chance
>>>> to restore them. One other possibility was to hook arch_do_swap_page(),
>>>> but this had a number of problems:
>>>>
>>>> - The call to the hook was also after swap_free().
>>>>
>>>> - The call to the hook was after the call to set_pte_at(), so there was a
>>>>     racy window where uninitialized metadata may be exposed to userspace.
>>>>     This likely also affects SPARC ADI, which implements this hook to
>>>>     restore tags.
>>>>
>>>> - As a result of commit 1eba86c096e3 ("mm: change page type prior to
>>>>     adding page table entry"), we were also passing the new PTE as the
>>>>     oldpte argument, preventing the hook from knowing the swap index.
>>>>
>>>> Fix all of these problems by moving the arch_do_swap_page() call before
>>>> the call to free_page(), and ensuring that we do not set orig_pte until
>>>> after the call.
>>>>
>>>> Signed-off-by: Peter Collingbourne <pcc@google.com>
>>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>>> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61020c510678965
>>>> Cc: <stable@vger.kernel.org> # 6.1
>>>> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
>>>> Fixes: 1eba86c096e3 ("mm: change page type prior to adding page table entry")
>>>
>>> I'm confused. You say c145e0b47c77 changed something (which was after above
>>> commits), indicate that it fixes two other commits, and indicate "6.1" as
>>> stable which does not apply to any of these commits.
>>
>> Sorry, the situation is indeed a bit confusing.
>>
>> - In order to make the arch_do_swap_page() hook suitable for fixing the
>>    bug introduced by c145e0b47c77, patch 1 addresses a number of issues,
>>    including fixing bugs introduced by ca827d55ebaa and 1eba86c096e3,
>>    but we haven't fixed the c145e0b47c77 bug yet, so there's no Fixes:
>>    tag for it yet.
>>
>> - Patch 2, relying on the fixes in patch 1, makes MTE install an
>>    arch_do_swap_page() hook (indirectly, by making arch_swap_restore()
>>    also hook arch_do_swap_page()), thereby fixing the c145e0b47c77 bug.
>>
>> - 6.1 is the first stable version in which all 3 commits in my Fixes: tags
>>    are present, so that is the version that I've indicated in my stable
>>    tag for this series. In theory patch 1 could be applied to older kernel
>>    versions, but it wouldn't fix any problems that we are facing with MTE
>>    (because it only fixes problems relating to the arch_do_swap_page()
>>    hook, which older kernel versions don't hook with MTE), and there are
>>    some merge conflicts if we go back further anyway. If the SPARC folks
>>    (the previous only user of this hook) want to fix these issues with ADI,
>>    they can propose their own backport.
>>
>>>> @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>    	VM_BUG_ON(!folio_test_anon(folio) ||
>>>>    			(pte_write(pte) && !PageAnonExclusive(page)));
>>>>    	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>>>> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>>>>    	folio_unlock(folio);
>>>>    	if (folio != swapcache && swapcache) {
>>>
>>>
>>> You are moving the folio_free_swap() call after the folio_ref_count(folio)
>>> == 1 check, which means that such (previously) swapped pages that are
>>> exclusive cannot be detected as exclusive.
>>
>> Ack. I will fix this in v2.
> 
> I gave this some thought and concluded that the added complexity needed
> to make this hook suitable for arm64 without breaking sparc probably
> isn't worth it in the end, and as I explained in patch 2, sparc ought
> to be moving away from this hook anyway. So in v2 I replaced patches 1
> and 2 with a patch that adds a direct call to the arch_swap_restore()
> hook before the call to swap_free().

As a side note, I recall that sparc code might be a bit fragile and 
eventually broken already (arch_unmap_one()):

https://lkml.kernel.org/r/d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com

-- 
Thanks,

David / dhildenb

