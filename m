Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859E73047C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbjFNQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbjFNQBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:01:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46CE2119
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686758491; x=1718294491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=2h/idbtEo15I0ifYftHepvrSWhA6QoEfwm35jZ8etOA=;
  b=lS5UosmRxyGujRUD4bF8Urf9e+240SYA4n1isUhSnGiKWrshj6ozTu3n
   6GRkiv3qtgdUIkGaHieALHHJ/mew2nmKjSl5LMzYSMOdrIQnQzD+vTsYi
   T+GT87L1S1GFVdhrhpacGQVeHvb+itqHUnvhopqSQPY5Lf6z7hOFp9a6S
   FDHNZli88kY9hLl9WRgzjh3n3/kG2FMI8eIDJOsOu9dglUJe9Qeti7/8K
   uZwy0buB0Y8HQcVtbXtikiQ9JRN7crLrMxjkliTWzZM/H9ZHM4MAT4hLN
   bMvjkmuJV4lXyscFAOxZxxPX1vq7k6zvqY2MQdkups5+I1rWgBXclp+mr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339005669"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="339005669"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782142034"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782142034"
Received: from ngarg3-mobl3.amr.corp.intel.com (HELO [10.212.191.43]) ([10.212.191.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:01:27 -0700
Content-Type: multipart/mixed; boundary="------------IqVKoRf2AFEuZikwKIfxDN60"
Message-ID: <e72e3246-1803-6a17-5b9c-30fb2dc078e3@intel.com>
Date:   Wed, 14 Jun 2023 09:01:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: x86: pgtable / kaslr initialisation (OOB) help
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230614132339.GS3635807@google.com>
 <20230614141654.GA1640123@hirez.programming.kicks-ass.net>
 <20230614143732.GW3635807@google.com>
 <0cefb67a-6fae-daa2-c871-ae35b96aac08@intel.com>
 <20230614150615.GX3635807@google.com> <20230614151003.GY3635807@google.com>
 <20230614152632.GZ3635807@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230614152632.GZ3635807@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------IqVKoRf2AFEuZikwKIfxDN60
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/23 08:26, Lee Jones wrote:
> On Wed, 14 Jun 2023, Lee Jones wrote:
> 
>> On Wed, 14 Jun 2023, Lee Jones wrote:
>>
>>> Thanks for chiming in Dave.  I hoped you would.
>>>
>>> On Wed, 14 Jun 2023, Dave Hansen wrote:
>>>
>>>> On 6/14/23 07:37, Lee Jones wrote:
>>>>> Still unsure how we (the kernel) can/should write to an area of memory
>>>>> that does not belong to it.  Should we allocate enough memory
>>>>> (2*PAGE_SIZE? rather than 8-Bytes) for trampoline_pgd_entry to consume
>>>>> in a more sane way?
>>>>
>>>> No.
>>>>
>>>> I think this:
>>>>
>>>>                 set_pgd(&trampoline_pgd_entry,
>>>>                         __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
>>>>
>>>> is bogus-ish.  set_pgd() wants to operate on a pgd_t inside a pgd
>>>> *PAGE*.  But it's just being pointed at a single  _entry_.  The address
>>>> of 'trampoline_pgd_entry' in your case  also just (unfortunately)
>>>> happens to pass the:
>>>>
>>>> 	__pti_set_user_pgtbl -> pgdp_maps_userspace()
>>>>
>>>> test.  I _think_ we want these to just be something like:
>>>>
>>>> 	trampoline_pgd_entry = __pgd(_KERNPG_TABLE |
>>>> 				     __pa(p4d_page_tramp);
>>>>
>>>> That'll keep us away from all of the set_pgd()-induced nastiness.
>>>
>>> Okay.  Is this what you're suggesting?
>>>
>>> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c                 v
>>> index d336bb0cb38b..803595c7dcc8 100644
>>> --- a/arch/x86/mm/kaslr.c
>>> +++ b/arch/x86/mm/kaslr.c
>>> @@ -176,7 +176,7 @@ void __meminit init_trampoline_kaslr(void)
>>>                 set_pgd(&trampoline_pgd_entry,
>>>                         __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
>>>         } else {
>>> -               set_pgd(&trampoline_pgd_entry,
>>> -                       __pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
>>> +               trampoline_pgd_entry =
>>> +                       __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp);
>>
>> Note the change of *.page_tramp here.
>>
>>   s/pud/p4d/
>>
>> I'm assuming that too was intentional?
> 
> Never mind.  I can see that p4d_page_tramp is local to the if() segment.
> 
> While we're at it, does the if() segment look correct to you:
> 
>   if (pgtable_l5_enabled()) {
>         p4d_page_tramp = alloc_low_page();
> 
>         p4d_tramp = p4d_page_tramp + p4d_index(paddr);
> 
>         set_p4d(p4d_tramp,
>                 __p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
> 
>         set_pgd(&trampoline_pgd_entry,
>                 __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
>   } else {
>         trampoline_pgd_entry =
>                 __pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
>   }
> 
>  - pud_page_tramp is being passed to set_p4d()
>  - p4d_page_tramp is being passed to set_pgd()
> 
> Should those be the other way around, or am I missing the point?

You're missing the point. :)

PGDs are always set up to point to the physical address of the thing at
one lower level than them.  A page is allocated for that level when
5-level paging is in play.  No page is needed when it is not in play.

The pattern is _almost_ always

	pgd = ... __pa(p4d);

In other words, point the PGD at the physical address of a p4d.  But
things get funky on systems without p4ds, thus the special casing here.

Does the (completely untested) attached patch fix your problem?
--------------IqVKoRf2AFEuZikwKIfxDN60
Content-Type: text/x-patch; charset=UTF-8; name="trampoline_pgd_entry.patch"
Content-Disposition: attachment; filename="trampoline_pgd_entry.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L21tL2thc2xyLmMgfCAgICA4ICsrKystLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtcHVOIGFy
Y2gveDg2L21tL2thc2xyLmN+dHJhbXBvbGluZV9wZ2RfZW50cnkgYXJjaC94ODYvbW0va2Fz
bHIuYwotLS0gYS9hcmNoL3g4Ni9tbS9rYXNsci5jfnRyYW1wb2xpbmVfcGdkX2VudHJ5CTIw
MjMtMDYtMTQgMDg6NTQ6MDguNjg1NTU0MDk0IC0wNzAwCisrKyBiL2FyY2gveDg2L21tL2th
c2xyLmMJMjAyMy0wNi0xNCAwODo1NTozNi4wNzcwODk3OTMgLTA3MDAKQEAgLTE3MiwxMCAr
MTcyLDEwIEBAIHZvaWQgX19tZW1pbml0IGluaXRfdHJhbXBvbGluZV9rYXNscih2b2kKIAkJ
c2V0X3A0ZChwNGRfdHJhbXAsCiAJCQlfX3A0ZChfS0VSTlBHX1RBQkxFIHwgX19wYShwdWRf
cGFnZV90cmFtcCkpKTsKIAotCQlzZXRfcGdkKCZ0cmFtcG9saW5lX3BnZF9lbnRyeSwKLQkJ
CV9fcGdkKF9LRVJOUEdfVEFCTEUgfCBfX3BhKHA0ZF9wYWdlX3RyYW1wKSkpOworCQl0cmFt
cG9saW5lX3BnZF9lbnRyeSA9CisJCQlfX3BnZChfS0VSTlBHX1RBQkxFIHwgX19wYShwNGRf
cGFnZV90cmFtcCkpOwogCX0gZWxzZSB7Ci0JCXNldF9wZ2QoJnRyYW1wb2xpbmVfcGdkX2Vu
dHJ5LAotCQkJX19wZ2QoX0tFUk5QR19UQUJMRSB8IF9fcGEocHVkX3BhZ2VfdHJhbXApKSk7
CisJCXRyYW1wb2xpbmVfcGdkX2VudHJ5ID0KKwkJICAgICAgIAlfX3BnZChfS0VSTlBHX1RB
QkxFIHwgX19wYShwdWRfcGFnZV90cmFtcCkpOwogCX0KIH0KXwo=

--------------IqVKoRf2AFEuZikwKIfxDN60--
