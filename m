Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21D70C596
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjEVS6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjEVS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:58:22 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF24CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:58:20 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id BCE6F40737DB;
        Mon, 22 May 2023 18:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BCE6F40737DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684781897;
        bh=WzoKgIqH0WCzNOBuKVkACwLfqKz1DAgtiebAInBsVlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JPrfK9vweTodV6roixMqV84LTvCOgOa3kuW5V4QnLCKqfITYm48IJwa2zALXq4hFe
         YCH5/jliAFbDKYLZ3GI5rhVqYeoJUSjJDGuhLf7BDuOuqRr/qYFtu/Uzt4Mm6EoG1B
         +5+WeBgwzirMkASK3eJwu72cJEgpIP2Cnnn/9qYU=
MIME-Version: 1.0
Date:   Mon, 22 May 2023 21:58:17 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     David Hildenbrand <david@redhat.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
In-Reply-To: <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 19:22, David Hildenbrand wrote:
> On 22.05.23 12:35, Alexey Izbyshev wrote:
>> On 2023-05-22 11:55, David Hildenbrand wrote:
>>> On 17.05.23 17:03, Florent Revest wrote:
>>>> Alexey pointed out that defining a prctl flag as an int is a footgun
>>>> because, under some circumstances, when used as a flag to prctl, it
>>>> can
>>>> be casted to long with garbage upper bits which would result in
>>>> unexpected behaviors.
>>>> 
>>>> This patch changes the constant to a UL to eliminate these
>>>> possibilities.
>>>> 
>>>> Signed-off-by: Florent Revest <revest@chromium.org>
>>>> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
>>>> ---
>>>>    include/uapi/linux/prctl.h       | 2 +-
>>>>    tools/include/uapi/linux/prctl.h | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>>> index f23d9a16507f..6e9af6cbc950 100644
>>>> --- a/include/uapi/linux/prctl.h
>>>> +++ b/include/uapi/linux/prctl.h
>>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>>      /* Memory deny write / execute */
>>>>    #define PR_SET_MDWE			65
>>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>>      #define PR_GET_MDWE			66
>>>>    diff --git a/tools/include/uapi/linux/prctl.h
>>>> b/tools/include/uapi/linux/prctl.h
>>>> index 759b3f53e53f..6e6563e97fef 100644
>>>> --- a/tools/include/uapi/linux/prctl.h
>>>> +++ b/tools/include/uapi/linux/prctl.h
>>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>>      /* Memory deny write / execute */
>>>>    #define PR_SET_MDWE			65
>>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>>      #define PR_GET_MDWE			66
>>>> 
>>> 
>>> Both are changing existing uapi, so you'll already have existing user
>>> space using the old values, that your kernel code has to deal with 
>>> no?
>> 
>> I'm the one who suggested this change, so I feel the need to clarify.
>> 
>> For any existing 64-bit user space code using the kernel and the uapi
>> headers before this patch and doing the wrong prctl(PR_SET_MDWE,
>> PR_MDWE_REFUSE_EXEC_GAIN) call instead of the correct 
>> prctl(PR_SET_MDWE,
>> (unsigned long)PR_MDWE_REFUSE_EXEC_GAIN), there are two possibilities
>> when prctl() implementation extracts the second argument via 
>> va_arg(op,
>> unsigned long):
>> 
>> * It gets lucky, and the upper 32 bits of the argument are zero. The
>> call does what is expected by the user.
>> 
>> * The upper 32 bits are non-zero junk. The flags argument is rejected 
>> by
>> the kernel, and the call fails with EINVAL (unexpectedly for the 
>> user).
>> 
>> This change is intended to affect only the second case, and only after
>> the program is recompiled with the new uapi headers. The currently
>> wrong, but naturally-looking prctl(PR_SET_MDWE,
>> PR_MDWE_REFUSE_EXEC_GAIN) call becomes correct.
>> 
>> The kernel ABI is unaffected by this change, since it has been defined
>> in terms of unsigned long from the start.
> 
> The thing I'm concerned about is the following: old user space (that
> would fail) on new kernel where we define some upper 32bit to actually
> have a meaning (where it would succeed with wrong semantics).
> 
> IOW, can we ever really "use" these upper 32bit, or should we instead
> only consume the lower 32bit in the kernel and effectively ignore the
> upper 32bit?
> 
I see, thanks. But I think this question is mostly independent from this 
patch. The patch removes a footgun, but it doesn't change the flags 
check in the kernel, and nothing stops the user from doing

int flags = PR_MDWE_REFUSE_EXEC_GAIN;
prctl(PR_SET_MDWE, flags);

So we have to decide whether to ignore the upper 32 bits or not even if 
this patch is not applied (actually *had to* when PR_SET_MDWE op was 
being added).

Possible arguments for ignoring them:
* Upper 32 bits can't be passed on 32-bit targets via the current 
prctl() interface, so a change that adds meaning to them would have to 
be both 64-bit-specific and unable to use another prctl() argument 
instead. That seems unlikely.

* It's not hard to accidentally pass int to prctl() even after this 
patch, so making technically wrong user code work as intended could be a 
good thing.

* A similar footgun exists for ILP32 ABIs (e.g. x32) on a lower level: 
while prctl(PR_SET_MDWE, 1) is fine there because long is 32-bit, the 
syscall interface is still 64-bit, so e.g. syscall(SYS_prctl, 
PR_SET_MDWE, -1) could, depending on syscall() implementation, 
sign-extend -1 to 64 bits and pass 64 set bits instead of 32 to the 
kernel.

Possible arguments for checking them:
* Code like "prctl(PR_SET_MDWE, 1)" is UB on 64-bit platforms. If the 
compiler notices that (e.g. if somebody ever manages to build a program 
and a libc together with LTO), it's allowed to make things much worse 
than just passing junk. Allowing the user to detect at least some of 
such calls now by checking for junk could be better.

* I have the impression that the kernel security community prefers 
strict argument validation.

* PR_SET_MDWE is a new op added in 6.3, so we don't have lots of legacy 
code that is known to pass junk in the upper 32 bits and must be kept 
working (i.e. failing) in the same way in a potential future kernel that 
assigns meaning to those bits.

My preference would be to keep checking the upper 32 bits. Florent, what 
do you think?

> I guess the feature is not that old, so having many existing user
> space applications is unlikely.
> 
> Which raises the question if we want to tag this here with a "Fixes"
> and eventually cc stable (hmm ...)?

Yes, IMO the faster we propagate this change, the better.

Thanks,
Alexey
