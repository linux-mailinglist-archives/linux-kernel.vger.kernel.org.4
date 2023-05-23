Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F4970DAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjEWKxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjEWKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:53:14 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75F011A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:53:11 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7EFDB4076265;
        Tue, 23 May 2023 10:53:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7EFDB4076265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684839189;
        bh=RMMF/TIJahmFqopd2qxNaPFmrmsiIjxi/vD3Y9rzttM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rnA8PS7r5OC0HUVXFetZ0ldVcZbaRzcXsw1p9kwWVk9I7Ciwxx5x1VwVF+JkuoknT
         yXUn/KV0QjUeCqwAdJ29jEGulbUk+7SfcBLnYgX/+2QNbxR4FzAWXypByPcEpBmwcu
         T4MPsQInZc8Dne4aUf0AXoqzspzjRzuNSmGQhR5Q=
MIME-Version: 1.0
Date:   Tue, 23 May 2023 13:53:09 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     David Hildenbrand <david@redhat.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
In-Reply-To: <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7c572622c0d8e283fc880fe3f4ffac27@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-23 12:12, David Hildenbrand wrote:
> On 22.05.23 20:58, Alexey Izbyshev wrote:
>> On 2023-05-22 19:22, David Hildenbrand wrote:
>>> On 22.05.23 12:35, Alexey Izbyshev wrote:
>>>> On 2023-05-22 11:55, David Hildenbrand wrote:
>>>>> On 17.05.23 17:03, Florent Revest wrote:
>>>>>> Alexey pointed out that defining a prctl flag as an int is a 
>>>>>> footgun
>>>>>> because, under some circumstances, when used as a flag to prctl, 
>>>>>> it
>>>>>> can
>>>>>> be casted to long with garbage upper bits which would result in
>>>>>> unexpected behaviors.
>>>>>> 
>>>>>> This patch changes the constant to a UL to eliminate these
>>>>>> possibilities.
>>>>>> 
>>>>>> Signed-off-by: Florent Revest <revest@chromium.org>
>>>>>> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
>>>>>> ---
>>>>>>     include/uapi/linux/prctl.h       | 2 +-
>>>>>>     tools/include/uapi/linux/prctl.h | 2 +-
>>>>>>     2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>> 
>>>>>> diff --git a/include/uapi/linux/prctl.h 
>>>>>> b/include/uapi/linux/prctl.h
>>>>>> index f23d9a16507f..6e9af6cbc950 100644
>>>>>> --- a/include/uapi/linux/prctl.h
>>>>>> +++ b/include/uapi/linux/prctl.h
>>>>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>>>>       /* Memory deny write / execute */
>>>>>>     #define PR_SET_MDWE			65
>>>>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>>>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>>>>       #define PR_GET_MDWE			66
>>>>>>     diff --git a/tools/include/uapi/linux/prctl.h
>>>>>> b/tools/include/uapi/linux/prctl.h
>>>>>> index 759b3f53e53f..6e6563e97fef 100644
>>>>>> --- a/tools/include/uapi/linux/prctl.h
>>>>>> +++ b/tools/include/uapi/linux/prctl.h
>>>>>> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>>>>>>       /* Memory deny write / execute */
>>>>>>     #define PR_SET_MDWE			65
>>>>>> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
>>>>>> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>>>>>>       #define PR_GET_MDWE			66
>>>>>> 
>>>>> 
>>>>> Both are changing existing uapi, so you'll already have existing 
>>>>> user
>>>>> space using the old values, that your kernel code has to deal with
>>>>> no?
>>>> 
>>>> I'm the one who suggested this change, so I feel the need to 
>>>> clarify.
>>>> 
>>>> For any existing 64-bit user space code using the kernel and the 
>>>> uapi
>>>> headers before this patch and doing the wrong prctl(PR_SET_MDWE,
>>>> PR_MDWE_REFUSE_EXEC_GAIN) call instead of the correct
>>>> prctl(PR_SET_MDWE,
>>>> (unsigned long)PR_MDWE_REFUSE_EXEC_GAIN), there are two 
>>>> possibilities
>>>> when prctl() implementation extracts the second argument via
>>>> va_arg(op,
>>>> unsigned long):
>>>> 
>>>> * It gets lucky, and the upper 32 bits of the argument are zero. The
>>>> call does what is expected by the user.
>>>> 
>>>> * The upper 32 bits are non-zero junk. The flags argument is 
>>>> rejected
>>>> by
>>>> the kernel, and the call fails with EINVAL (unexpectedly for the
>>>> user).
>>>> 
>>>> This change is intended to affect only the second case, and only 
>>>> after
>>>> the program is recompiled with the new uapi headers. The currently
>>>> wrong, but naturally-looking prctl(PR_SET_MDWE,
>>>> PR_MDWE_REFUSE_EXEC_GAIN) call becomes correct.
>>>> 
>>>> The kernel ABI is unaffected by this change, since it has been 
>>>> defined
>>>> in terms of unsigned long from the start.
>>> 
>>> The thing I'm concerned about is the following: old user space (that
>>> would fail) on new kernel where we define some upper 32bit to 
>>> actually
>>> have a meaning (where it would succeed with wrong semantics).
>>> 
>>> IOW, can we ever really "use" these upper 32bit, or should we instead
>>> only consume the lower 32bit in the kernel and effectively ignore the
>>> upper 32bit?
>>> 
>> I see, thanks. But I think this question is mostly independent from 
>> this
>> patch. The patch removes a footgun, but it doesn't change the flags
>> check in the kernel, and nothing stops the user from doing
>> 
>> int flags = PR_MDWE_REFUSE_EXEC_GAIN;
>> prctl(PR_SET_MDWE, flags);
>> 
>> So we have to decide whether to ignore the upper 32 bits or not even 
>> if
>> this patch is not applied (actually *had to* when PR_SET_MDWE op was
>> being added).
> 
> Well, an alternative to this patch would be to say "well, for this
> prctl we ignore any upper 32bit. Then, this change would not be
> needed. Yes, I also don't like that :)
> 
> Bu unrelated, I looked at some other random prctl.
> 
> #define SUID_DUMP_USER           1
> 
> And in kernel/sys.c:
> 
> 	case PR_SET_DUMPABLE:
> 		if (arg2 != SUID_DUMP_DISABLE && arg2 != SUID_DUMP_USER)
> 	...
> 
> Wouldn't that also suffer from the same issue, or how is this 
> different?
> 
Yes, it is the same issue, so e.g. prctl(PR_SET_DUMPABLE, 
SUID_DUMP_DISABLE ) may wrongly fail with EINVAL on 64-bit targets.

> Also, how is passing "0"s to e.g., PR_GET_THP_DISABLE reliable? We
> need arg2 -> arg5 to be 0. But wouldn't the following also just pass a
> 0 "int" ?
> 
> prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0)
> 
Yes, this is not reliable on 64-bit targets too. The simplest fix is to 
use "0L", as done in MDWE self-tests (but many other tests get this 
wrong).

Florent also expressed surprise[1] that we don't see a lot of failures 
due to such issues, and I tried to provide some reasons. To elaborate on 
the x86-64 thing, for prctl(PR_SET_DUMPABLE, 0) the compiler will likely 
generate "xorl %esi, %esi" to pass zero, but this instruction will also 
clear the upper 32 bits of %rsi, so the problem is masked (and I believe 
CPU vendors are motivated to do such zeroing to reduce false 
dependencies). But this zeroing is not required by the ABI, so in a more 
complex situation junk might get through.

Real-world examples of very similar breakage in variadic functions 
involving NULL sentinels are mentioned in [2] (the musl bug report is 
[3]). In short, musl defined NULL as plain 0 for C++, so when people do 
e.g. execl("/bin/true", "true", NULL), junk might prevent detection of 
the sentinel in execl() impl. (Though if the sentinel is passed via 
stack because there are a lot of preceding arguments, the breakage 
becomes more apparent because auto-zeroing of registers doesn't come 
into play anymore.)

> 
> I'm easily confused by such (va_args) things, so sorry for the dummy 
> questions.

This stuff *is* confusing, and note that Linux man pages don't even tell 
that prctl() is actually declared as a variadic function (and for 
ptrace() this is mentioned only in the notes, but not in its signature).

Thanks,
Alexey

[1] 
https://lore.kernel.org/lkml/3a38319a3b241e578729ffa5484ad24b@ispras.ru
[2] https://ewontfix.com/11
[3] https://www.openwall.com/lists/musl/2013/01/09/1
