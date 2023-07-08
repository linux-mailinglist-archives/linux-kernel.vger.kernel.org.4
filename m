Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415D474BDAA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGHNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:37:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F2EB;
        Sat,  8 Jul 2023 06:37:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qI87T-0008NX-R3; Sat, 08 Jul 2023 15:37:03 +0200
Message-ID: <278dc66d-7cc8-2735-5cd0-c64dc139b10c@leemhuis.info>
Date:   Sat, 8 Jul 2023 15:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/27] locking/atomic: make atomic*_{cmp,}xchg optional
Content-Language: en-US, de-DE
To:     Guenter Roeck <linux@roeck-us.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
 <20230605070124.3741859-5-mark.rutland@arm.com>
 <32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net>
 <a94334d8-0a9a-1cbc-ebfe-1825abfb8307@leemhuis.info>
 <36c1ef3d-603b-574a-ad9d-796964a1410c@roeck-us.net>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <36c1ef3d-603b-574a-ad9d-796964a1410c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688823427;445cf778;
X-HE-SMSGID: 1qI87T-0008NX-R3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.23 15:20, Guenter Roeck wrote:
> On 7/8/23 06:07, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 27.06.23 19:07, Guenter Roeck wrote:
>>> On Mon, Jun 05, 2023 at 08:01:01AM +0100, Mark Rutland wrote:
>>>> Most architectures define the atomic/atomic64 xchg and cmpxchg
>>>> operations in terms of arch_xchg and arch_cmpxchg respectfully.
>>>>
>>>> Add fallbacks for these cases and remove the trivial cases from arch
>>>> code. On some architectures the existing definitions are kept as these
>>>> are used to build other arch_atomic*() operations.
>>>>
>>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> [...]
>>>
>>> This patch results in:
>>>
>>> ERROR: modpost: "__xchg_called_with_bad_pointer"
>>> [lib/atomic64_test.ko] undefined!
>>>
>>> when trying to build sparc64:allmodconfig.
>>
>> Guenter, please correct me if I'm wrong:
>>
>> This is fixed by Arnd's patch "sparc: mark __arch_xchg() as
>> __always_inline", but that afaics sadly hasn't even reached -next yet.
>> https://lore.kernel.org/all/20230628094938.2318171-1-arnd@kernel.org/
>>
>> Hence adding it to the tracking now that the end of the merge window is
>> near:
>>
>> #regzbot ^introduced d12157efc8e083c7
>> #regzbot title locking/atomic: build error on sparc64:allmodconfig
>> #regzbot ignore-activity
> 
> Yes, this is correct.

Thx for confirming (and also for adding the other regression to the
tracking). Let me use this opportunity to tell regzbot about the patch
for this regression, which I forgot to do earlier (sorry!):

#regzbot monitor:
https://lore.kernel.org/all/20230628094938.2318171-1-arnd@kernel.org/

Also CCing Arnd, maybe the fix fell through the cracks on his side.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
