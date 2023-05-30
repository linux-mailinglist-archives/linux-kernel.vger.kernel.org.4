Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC6716194
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjE3NWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjE3NWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:22:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA792;
        Tue, 30 May 2023 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685452938; x=1716988938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4aGVqSdvgTPuU35q1D5R0JGk/giyk93IXrt6KSMzrvU=;
  b=WX3qukUtyoSjiaHL/VBOZGDvMBtlichIyy6Dbu6mmnY31KaCE391a7cI
   biFY6HhA0euHONuaWOCpmvDuTUcK460YhFPnOnasLj86BSIDeDrcLDvWJ
   39QJ1kRxN/R+fQyGar4SafysPzzhqBgWT+uwy4w1tIu21ajIaHX+l5Zvo
   GTpHw32gdZaSMEKjnqMPZg0gtkfpu9fOx+MJVqhd18HteeL329+i51+uM
   cCUNkD/pgObw4gSwc8GkrcKOQVKacnPu/TUrGk7mdC2gGw4aL5vurSmfF
   N3s6kuIPcUIBbNoXUeb5J9h438V6uOGVnVNhqN7MUEQ93sI6bHGsATpPn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383166691"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383166691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 06:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="656853818"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="656853818"
Received: from ndesilva-mobl1.amr.corp.intel.com (HELO [10.209.101.99]) ([10.209.101.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 06:22:17 -0700
Message-ID: <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
Date:   Tue, 30 May 2023 06:22:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, decui@microsoft.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/30/23 5:57 AM, Tom Lendacky wrote:
> On 5/29/23 19:57, Kirill A. Shutemov wrote:
>> On Fri, May 26, 2023 at 03:10:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>
>>>
>>> On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
>>>> Touching privately mapped GPA that is not properly converted to private
>>>> with MapGPA and accepted leads to unrecoverable exit to VMM.
>>>>
>>>> load_unaligned_zeropad() can touch memory that is not owned by the
>>>> caller, but just happened to next after the owned memory.
>>>
>>> /s/to/to be ?
>>
>> Yep, my bad.
>>
>>>> This load_unaligned_zeropad() behaviour makes it important when kernel
>>>> asks VMM to convert a GPA from shared to private or back. Kernel must
>>>> never have a page mapped into direct mapping (and aliases) as private
>>>> when the GPA is already converted to shared or when GPA is not yet
>>>> converted to private.
>>>
>>> I am wondering whether this issue exist in the AMD code?
>>>
>>> IMO, you can add some info on the window in set_memory_encrypted()
>>> where this race exists.
>>
>> I don't think AMD affected by load_unaligned_zeropad() the same way as
>> Intel does. But I'm not sure.
>>
>> Tom, do you have any comments?
> 
> Right, shouldn't be an issue for SNP.

Thanks for confirming.

> 
> Thanks,
> Tom
> 
>>
>>>
>>>>
>>>> guest.enc_status_change_prepare() called before adjusting direct mapping
>>>> and therefore it is responsible for converting the memory to private.
>>>>
>>>> guest.enc_status_change_finish() called after adjusting direct mapping
>>>> and it converts the memory to shared.
>>>>
>>>> It is okay to have a shared mapping of memory that is not converted
>>>> properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
>>>> stepping on it.
>>>
>>>>

Rest looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   arch/x86/coco/tdx/tdx.c | 56 ++++++++++++++++++++++++++++++++++++++---
>>>>   1 file changed, 53 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>>>> index e146b599260f..59cc13e41aa6 100644
>>>> --- a/arch/x86/coco/tdx/tdx.c
>>>> +++ b/arch/x86/coco/tdx/tdx.c
>>>> @@ -840,6 +840,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>>>>       return true;
>>>>   }
>>>>   +static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
>>>> +                      bool enc)
>>>> +{
>>>> +    /*
>>>> +     * Only handle shared->private conversion here.
>>>> +     * See the comment in tdx_early_init().
>>>> +     */
>>>> +    if (enc)
>>>> +        return tdx_enc_status_changed(vaddr, numpages, enc);
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>>>> +                     bool enc)
>>>> +{
>>>> +    /*
>>>> +     * Only handle private->shared conversion here.
>>>> +     * See the comment in tdx_early_init().
>>>> +     */
>>>> +    if (!enc)
>>>> +        return tdx_enc_status_changed(vaddr, numpages, enc);
>>>> +    return true;
>>>> +}
>>>> +
>>>>   void __init tdx_early_init(void)
>>>>   {
>>>>       u64 cc_mask;
>>>> @@ -867,9 +891,35 @@ void __init tdx_early_init(void)
>>>>        */
>>>>       physical_mask &= cc_mask - 1;
>>>>   -    x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
>>>> -    x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
>>>
>>> I think you don't need to change the order here.
>>
>> I wanted to emphasise that the comment is for _prepare/_finish callbacks
>> and I hoped re-order would help with this.
>>
>>>> -    x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
>>>> +    /*
>>>> +     * Touching privately mapped GPA that is not properly converted to
>>>> +     * private with MapGPA and accepted leads to unrecoverable exit
>>>> +     * to VMM.
>>>> +     *
>>>> +     * load_unaligned_zeropad() can touch memory that is not owned by
>>>> +     * the caller, but just happened to next after the owned memory.
>>>> +     * This load_unaligned_zeropad() behaviour makes it important when
>>>> +     * kernel asks VMM to convert a GPA from shared to private or back.
>>>> +     * Kernel must never have a page mapped into direct mapping (and
>>>> +     * aliases) as private when the GPA is already converted to shared or
>>>> +     * when GPA is not yet converted to private.
>>>> +     *
>>>> +     * guest.enc_status_change_prepare() called before adjusting direct
>>>> +     * mapping and therefore it is responsible for converting the memory
>>>> +     * to private.
>>>> +     *
>>>> +     * guest.enc_status_change_finish() called after adjusting direct
>>>> +     * mapping and it converts the memory to shared.
>>>> +     *
>>>> +     * It is okay to have a shared mapping of memory that is not converted
>>>> +     * properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
>>>> +     * stepping on it.
>>>> +     */
>>>> +    x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
>>>> +    x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
>>>> +
>>>> +    x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
>>>> +    x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
>>>>         pr_info("Guest detected\n");
>>>>   }
>>>
>>> -- 
>>> Sathyanarayanan Kuppuswamy
>>> Linux Kernel Developer
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
