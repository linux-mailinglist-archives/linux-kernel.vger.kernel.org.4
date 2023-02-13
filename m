Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7678F69494A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBMO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjBMO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754931C33E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676300186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcbvgdOnqyzXVAQogo/oCkD+sYlM47nFoe7fwRrExSo=;
        b=hS+TfkJcbEl3SBRsqWNqXMDEG2+xrfESdtZWPzM6u59AiiHWDbni2gc4aauP0ybGPjFIPg
        CtdGX2LiA23PDqQ3NtlBb7NXh4AnkJX+ctU4Znkwjf2Rv81NAyy5S4n3ol9hlTItQidGDL
        13WlYKrLN9BEygn9ka8YZy2aZf6fhus=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-CCwyuu0pO8qHpC7TpjFU7A-1; Mon, 13 Feb 2023 09:56:25 -0500
X-MC-Unique: CCwyuu0pO8qHpC7TpjFU7A-1
Received: by mail-wr1-f70.google.com with SMTP id r11-20020a5d498b000000b002c5588d962fso607353wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcbvgdOnqyzXVAQogo/oCkD+sYlM47nFoe7fwRrExSo=;
        b=R9YxslkMkyIsaA5hgaJVoe0RfVDcx2o44orvhXylycwk6n3R+Qr/1QCtNoYCRIeLPI
         oTKZZd99c/rs4RTNVUludpGIUao9OjW5QpZLRibYH2K4tF1BzB56T4WYY/ZX2+EUT5XA
         pj18f7+fJCpEBDrdpleh06+KKuAsFvEOQrLY6/LIJsOtUq1j7loBJ7HQDFQQ4jJvD4Ok
         CQGwovdo1e5CT5RNNOHPIpoEPwHlK7OTvUZz62VnfWEn37Jk9ESNd5Cf+fU6zaR/Ktmy
         CvdW1X1iuI1bR/dfr797LwcWFPMznLYW2kdoUIYzsaYApwNonJ2fXjdfhJsRXEyGZAAd
         Swsg==
X-Gm-Message-State: AO0yUKVZeWf8MiUzLbpy+FecdLtZ0ojIO1LUEunRZ6OvzAn22ycC1XKC
        wwYRotPBYtIi8nOK5Ou3n8ibrg6mCH0TlbwwK+VXLWrm4dHeYzYsAR2C+Jx2WpYwTGxZgKFwKzg
        dYIL2ewLLDSAP/xOI7sFlN0YT
X-Received: by 2002:adf:e5ce:0:b0:2c5:4d97:4a23 with SMTP id a14-20020adfe5ce000000b002c54d974a23mr6683046wrn.70.1676300183675;
        Mon, 13 Feb 2023 06:56:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/wp7iAqKD66CPLnH5FMLYm4u2nsJT3GTHCfZvBlZXNJR8IoCTQJqlclnW3q98J4QCVN7UwtQ==
X-Received: by 2002:adf:e5ce:0:b0:2c5:4d97:4a23 with SMTP id a14-20020adfe5ce000000b002c54d974a23mr6683036wrn.70.1676300183412;
        Mon, 13 Feb 2023 06:56:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5409000000b002c558228b6dsm3365811wrv.12.2023.02.13.06.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:56:22 -0800 (PST)
Message-ID: <7693247c-a55d-a375-3621-1b07115a9d99@redhat.com>
Date:   Mon, 13 Feb 2023 15:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 RFC Zisslpcfi 11/20] mmu: maybe_mkwrite updated to
 manufacture shadow stack PTEs
Content-Language: en-US
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-12-debug@rivosinc.com>
 <2d6eefb8-c7c5-7d32-9a75-ae716f828cd9@redhat.com>
 <20230213143754.GC3943238@debug.ba.rivosinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213143754.GC3943238@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 15:37, Deepak Gupta wrote:
> On Mon, Feb 13, 2023 at 01:05:16PM +0100, David Hildenbrand wrote:
>> On 13.02.23 05:53, Deepak Gupta wrote:
>>> maybe_mkwrite creates PTEs with WRITE encodings for underlying arch if
>>> VM_WRITE is turned on in vma->vm_flags. Shadow stack memory is a write-
>>> able memory except it can only be written by certain specific
>>> instructions. This patch allows maybe_mkwrite to create shadow stack PTEs
>>> if vma is shadow stack VMA. Each arch can define which combination of VMA
>>> flags means a shadow stack.
>>>
>>> Additionally pte_mkshdwstk must be provided by arch specific PTE
>>> construction headers to create shadow stack PTEs. (in arch specific
>>> pgtable.h).
>>>
>>> This patch provides dummy/stub pte_mkshdwstk if CONFIG_USER_SHADOW_STACK
>>> is not selected.
>>>
>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>> ---
>>>   include/linux/mm.h      | 23 +++++++++++++++++++++--
>>>   include/linux/pgtable.h |  4 ++++
>>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 8f857163ac89..a7705bc49bfe 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1093,6 +1093,21 @@ static inline unsigned long thp_size(struct page *page)
>>>   void free_compound_page(struct page *page);
>>>   #ifdef CONFIG_MMU
>>> +
>>> +#ifdef CONFIG_USER_SHADOW_STACK
>>> +bool arch_is_shadow_stack_vma(struct vm_area_struct *vma);
>>> +#endif
>>> +
>>> +static inline bool
>>> +is_shadow_stack_vma(struct vm_area_struct *vma)
>>> +{
>>> +#ifdef CONFIG_USER_SHADOW_STACK
>>> +	return arch_is_shadow_stack_vma(vma);
>>> +#else
>>> +	return false;
>>> +#endif
>>> +}
>>> +
>>>   /*
>>>    * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
>>>    * servicing faults for write access.  In the normal case, do always want
>>> @@ -1101,8 +1116,12 @@ void free_compound_page(struct page *page);
>>>    */
>>>   static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>>   {
>>> -	if (likely(vma->vm_flags & VM_WRITE))
>>> -		pte = pte_mkwrite(pte);
>>> +	if (likely(vma->vm_flags & VM_WRITE)) {
>>> +		if (unlikely(is_shadow_stack_vma(vma)))
>>> +			pte = pte_mkshdwstk(pte);
>>> +		else
>>> +			pte = pte_mkwrite(pte);
>>> +	}
>>>   	return pte;
>>
>> Exactly what we are trying to avoid in the x86 approach right now.
>> Please see the x86 series on details, we shouldn't try reinventing the
>> wheel but finding a core-mm approach that fits multiple architectures.
>>
>> https://lkml.kernel.org/r/20230119212317.8324-1-rick.p.edgecombe@intel.com
> 
> Thanks David for comment here. I looked at x86 approach. This patch
> actually written in a way which is not re-inventing wheel and is following
> a core-mm approach that fits multiple architectures.
> 
> Change above checks `is_shadow_stack_vma` and if it returns true then only
> it manufactures shadow stack pte else it'll make a regular writeable mapping.
> 
> Now if we look at `is_shadow_stack_vma` implementation, it returns false if
> `CONFIG_USER_SHADOW_STACK` is not defined. If `CONFIG_USER_SHADOW_STACK is
> defined then it calls `arch_is_shadow_stack_vma` which should be implemented
> by arch specific code. This allows each architecture to define their own vma
> flag encodings for shadow stack (riscv chooses presence of only `VM_WRITE`
> which is analogous to choosen PTE encodings on riscv W=1,R=0,X=0)
> 
> Additionally pte_mkshdwstk will be nop if not implemented by architecture.
> 
> Let me know if this make sense. If I am missing something here, let me know.

See the discussion in that thread. The idea is to pass a VMA to 
pte_mkwrite() and let it handle how to actually set it writable.

-- 
Thanks,

David / dhildenb

