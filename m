Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E365BCDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjACJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbjACJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:14:53 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF35EE01F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:14:52 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pCdNd-00075k-FP; Tue, 03 Jan 2023 10:14:45 +0100
Message-ID: <5a09a4eb-f12a-9d48-4e5a-4b60b09bbb8f@leemhuis.info>
Date:   Tue, 3 Jan 2023 10:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Linux 6.2-rc2
Content-Language: en-US, de-DE
To:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
 <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <20230103035704.GA1207672@roeck-us.net>
 <Y7OuWjxR4M9cdtlR@dev-arch.thelio-3990X>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y7OuWjxR4M9cdtlR@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672737292;5e063258;
X-HE-SMSGID: 1pCdNd-00075k-FP
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.23 05:26, Nathan Chancellor wrote:
> On Mon, Jan 02, 2023 at 07:57:04PM -0800, Guenter Roeck wrote:
>> On Mon, Jan 02, 2023 at 06:13:09PM -0800, Linus Torvalds wrote:
>>> On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> ... and reverting commit 99cb0d917ff indeed fixes the problem.
>>>
>>> Hmm. My gut feel is that this just exposes some bug in binutils.
>>>
>> May well be, but it would be an architecture specific bug. The problem
>> is not seen when building an x86 image with binutils 2.32. Of course it
>> might affect other architectures.
> 
> It is likely a generic binutils bug, as I have seen it with PowerPC and
> s390. I assume it comes down to how architectures have written their
> linker scripts. I did some initial investigation yesterday and reported
> my findings on Masahiro's patch thread:
> 
> https://lore.kernel.org/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
> 
> I have seen at least three separate threads now with this issue, perhaps
> it is just worth reverting the patch now and submitting a fixed version?
> 2.35.2 is Debian stable's binutils version so this will likely impact a
> lot of CIs.

If someone wants to go down that route, it might be wise to also revert
the two patches 99cb0d917ff mentions with Fixes: tags, as otherwise the
regression it was supposed to fix (which at least impacts ARM64 kernel
rpm builds on Fedora -- and thus maybe some CI systems, too) will come back.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>>> That said, maybe that commit should not have added its own /DISCARDS/
>>> thing, and instead just added that "*(.note.GNU-stack)" to the general
>>> /DISCARDS/ thing that is defined by the
>>>
>>>   #define DISCARDS  ..
>>>
>>> a little bit later, so that we only end up with one single DISCARD
>>> list. Something like this (broken patch on purpose):
>>>
>>>   --- a/include/asm-generic/vmlinux.lds.h
>>>   +++ b/include/asm-generic/vmlinux.lds.h
>>>   @@ -897,5 +897,4 @@
>>>     */
>>>    #define NOTES                                        \
>>>   -     /DISCARD/ : { *(.note.GNU-stack) }              \
>>>         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {       \
>>>                 BOUNDED_SECTION_BY(.note.*, _notes)     \
>>>   @@ -1016,4 +1015,5 @@
>>>    #define DISCARDS                                     \
>>>         /DISCARD/ : {                                   \
>>>   +     *(.note.GNU-stack)                              \
>>>         EXIT_DISCARDS                                   \
>>>         EXIT_CALL                                       \
>>>
>>
>> I don't know if and how it affects arm64 and riscv, but the above fixes
>> the problem for sh.
>>
>>> But maybe that DISCARDS macrop ends up being used too late?
>>>
>>
>> DISCARDS is the very first entry in SECTIONS. NOTES is part of RO_DATA
>> and comes much later.
>>
>>> It really shouldn't matter, but here we are, with a build problem with
>>> some random old binutils on an odd platform..
>>
>> The one we know of. I could try to compile all architectures with
>> binutils 2.32, but I don't really want to do that if I can avoid it.
>>
>> Guenter
