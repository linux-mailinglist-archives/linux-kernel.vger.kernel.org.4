Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56F6F70E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjEDRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEDRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:30:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0C5255
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683221451; x=1714757451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P9d9fn0W34nQYN6RZChK10mEkK/8tTOdFxKTSoEjNWE=;
  b=XLrJKJqMTWowjoxvW0piJmLo6Bv/1//6Ha7ihWhHXOt+6ugk4q9i4Kcs
   4C9VS0p7JsTjL78Bs63QepcaxR/gHmZUmyVS4h7bl/zatgYP9huiPpiDy
   0zovqbpeWpqYdPNR7pnHgBnfp9p2IrTg+J8CNzkMUpX00R8cEEHHfUQih
   ufG5MXz9Zsec6Zn3f4iirmwlRlouPhqquzPQOdK1E5sYp/WdmwvqfBPaw
   MacXMa4G9lk0QdpPP7Xe4LOxHuPw+Dc2d1gKAYmTRfmEEa21sL9JdIP98
   UM2FoZidCPbnJtoV4FVQNEZfTTJPF3PbJVWr6ei+g5arCatpJjEc61A4e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="352026711"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="352026711"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 10:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="871423667"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="871423667"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.22.139]) ([10.213.22.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 10:28:29 -0700
Message-ID: <73dbeef4-cc39-4f09-5050-724c5b8dbd8c@intel.com>
Date:   Thu, 4 May 2023 19:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [GIT PULL] locking changes for v6.4
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <Y/NmzouehvMWTPVZ@gmail.com> <ZErTyKxjGQvF6EqP@gmail.com>
 <CAHk-=wiDTLgf8LhigR4XKnjgkuhsoS-pXZckXU79J-EXiOj7Vw@mail.gmail.com>
 <ZEy9kUpwx/N3JEA/@gmail.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ZEy9kUpwx/N3JEA/@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for late response.
Just two cents to constructively defend myself.

On 29.04.2023 08:47, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Thu, Apr 27, 2023 at 12:58 PM Ingo Molnar <mingo@kernel.org> wrote:
>>>   - Add non-atomic __xchg() variant, use it in a couple of places
>> Guys, this is insane, and completely unacceptable.
>>
>> I pulled this, but I'm going to unpull it, because the code is
>> actively wrong and ugly.
>>
>> It not only randomly decides to re-use a name that has existing users
>> that now need to be fixed up.
> meh - you are 100% right, I'm not sure what we were thinking there ... [
> actually, I know what we were thinking, but it's a bit complicated - see
> the various non-perfect nomenclature options further below. ]
>
> So the first line of our thinking was that "__" also often & additionally
> means 'lighter weight version of a similar API signature, beware, here be
> dragons, use at your own risk', and more of the focus of these particular
> changes was on identifying hand-coded xchg-ish pieces of code, such as in:
>
>     26ace5d28d36 ("arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr")
>
> ... but while that background of '__' is somewhat valid logic that we use
> quite often in various kernel facilities, it doesn't really excuse the
> sloppy decision to slap __ in front of an existing API without trying
> harder, *especially* that a better name with fetch_and_zero() already
> existed :-/
>
>> It then *also* decides to start "preferring" this absolutely
>> disgusting new name over a much more legible one in the i915 driver,
>> which had this same functionality except it used a prettier name:
>>
>>     fetch_and_zero()

My 1st approach was to follow C++ library and I have proposed 'exchange' 
[1][2].
Later I have also showed/suggested Rust's approach [3][4]:
- 'replace' for __xchg,
- 'take' for fetch_and_zero

Anyway it ended as is.

[1]: https://lore.kernel.org/lkml/Y5OFSvaYbv4XCxhE@smile.fi.intel.com/T/
[2]: https://en.cppreference.com/w/cpp/header/utility
[3]: https://doc.rust-lang.org/std/mem/index.html
[4]: 
https://lore.kernel.org/lkml/20230118153529.57695-1-andrzej.hajda@intel.com/

>>
>> But what then takes the cake for me is that this horribly ugly feature
>> then didn't even get that right, and only randomly converted *some* of
>> the users, with most of them remaining:
>>
>>    git grep fetch_and_zero drivers/gpu/drm/i915/ | wc
>>       58     187    5534
>>    git grep -w __xchg drivers/gpu/drm/i915/ | wc
>>       22     109    1899
>>
>> and it looks like the only "logic" to this is that the converted ones
>> were in the "gt/" subdirectory. What a random choice, but happily it
>> caused a trivial conflict, and as a result I noticed how bad things
>> were.

The logic was just to focus on introduction of the helper, providing few 
(not all) examples of usage and finish i915 conversion later, when the 
helper will be accepted.
Conversion should be split anyway - as i915 uses different repo for 
i915/gt, sorry for not clearly stating this.

Regards
Andrzej

>>
>> Anyway, I really find this all offensively ugly and pointless. I'm not
>> going to pull some "fixed" version of this. This needs to go away and
>> never come back.
> Yeah. So I've rebased locking/core to take out these changes - a simple
> revert is too ugly and the history has no value here really.
>
> Will re-send the rest of locking/core.
>
>> What was so magically great about the name "__xchg" that it needed to be
>> taken over by this function? And why was that legibly named version of it
>> replaced so randomly?
> Yeah.
>
> So fetch_and_zero() has a bit of a nomenclature & ambiguity problem as
> well: there's already an atomic_fetch_*() API family, and it's easy to
> think that fetch_and_zero() is atomic too - a bit like how xchg() is atomic
> without mentioning 'atomic'.
>
> Adding to the confusion is that there's already atomic APIs that don't use
> atomic_t:
>
>    xchg()
>    cmpxchg()
>    try_cmpxchg()
>
> ... and by *that* implicit nomenclature logic, dropping the atomic_ from a
> atomic_fetch_and_zero() API means: 'atomic API, not using atomic_t'. Which
> fetch_and_zero() clearly isnt ...
>
> So by all that logic and somewhat idiosynchratic API history, the new
> facility should probably not be fetch_and_zero(), but something like
> nonatomic_fetch_and_zero(), but that's quite a mouthful for something so
> simple - and the API family connection to xchg() is lost as well, which is
> a bit sad...
>
> In all that context the least bad approach sounded to add a __ to denote
> __xchg() is 'something special and also lighter weight' (which it is).
>
> I *think* the bigger danger in locking nomenclature is to falsely imply
> atomicity - in that sense I'm not sure fetch_and_zero() is ideal - but I
> can certainly live with it b/c the perfect name keeps eluding me.
>
>> The *whole* point of two underscores is to say "don't use this - it's
>> an internal implementation". That's the historical meaning, and it's
>> the meaning we have in the kernel too. Two underscores means "this is
>> special and doesn't do everything required" (it might need locking
>> around it, for example).
> Yeah. I do think we might want to keep one related change though:
>
>    e27cff3d2d43 ("arch: rename all internal names __xchg to __arch_xchg")
>
> ... not because we want to use the __xchg namespace, but because an _arch
> prefix makes it even *less* likely to be used by non-infrastructure code.
>
>> So then making a new interface with two underscores and thinking "we
>> should now make random drivers use this" is fundamentally bogus.
>>
>> Look, just grep for "__xchg" in the main tree (ie the one *without* this
>> change). It all makes sense. It's all clearly an internal helper - as
>> marked by that double underscore - and it's not used by any driver or
>> filesystem code.
>>
>> Exactly like K&R and God intended.
> Yeah. We'll try this new facility again in v6.5, but with a better name.
> Sorry about that!
>
> Thanks,
>
> 	Ingo

