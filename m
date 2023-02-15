Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24CF6979FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjBOKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjBOKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:36:35 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B146C40F2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:36:33 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSF9J-0005s3-Ku; Wed, 15 Feb 2023 11:36:29 +0100
Message-ID: <b829633e-ccc4-7a54-1cad-f29254de1251@leemhuis.info>
Date:   Wed, 15 Feb 2023 11:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
Content-Language: en-US, de-DE
To:     Chris Clayton <chris2553@googlemail.com>,
        Dave Airlie <airlied@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, bskeggs@redhat.com,
        Lyude Paul <lyude@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <3ab28896-70e9-6f90-5b97-e5397b06e715@googlemail.com>
 <a163dd7b-c5d1-a07b-a816-7a2dfd3edfd4@leemhuis.info>
 <ab1b0f73-6b4e-8602-2999-b7bec25d92db@googlemail.com>
 <CACAvsv4sOtPjCVnEcKd2RCUqYWxSn5XKyksbS-Bds2qCqyusVw@mail.gmail.com>
 <1cdb84ac-f7a8-66ba-98fc-3db302b49a5a@googlemail.com>
 <dab6eb81-db3f-8fa1-84ad-9b40e209514b@googlemail.com>
 <CACAvsv5iYdF3P8AbyrbYo3zGmYRYhxDWn7WbAR5V9qHpbgBXRA@mail.gmail.com>
 <1632a9ef-2954-c8f0-cdc9-03157c9d8547@googlemail.com>
 <5abbee70-cc84-1528-c3d8-9befd9edd611@googlemail.com>
 <5cf46df8-0fa2-e9f5-aa8e-7f7f703d96dd@googlemail.com>
 <f72fe15b-db1d-56dd-aaf6-3cba68a8bf0a@leemhuis.info>
 <CACO55tvR4ydDOXt=9nbR3n2aFLKrj8zeuGRR_xpezVQBBLrjqg@mail.gmail.com>
 <a6188878-f84c-0fcc-9509-b9d7ab797f4c@leemhuis.info>
 <d031f0a5-8d5e-af51-6db6-11844de3eeba@googlemail.com>
 <CAPM=9tz+wksJTvMi_4Ef7XWezfH0ReN2se189s8Q=obJjHC+Fw@mail.gmail.com>
 <4e786e22-f17a-da76-5129-8fef0c7c825a@googlemail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4e786e22-f17a-da76-5129-8fef0c7c825a@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676457393;5a3fea7a;
X-HE-SMSGID: 1pSF9J-0005s3-Ku
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 10:14, Chris Clayton wrote:
> On 13/02/2023 02:57, Dave Airlie wrote:
>> On Sun, 12 Feb 2023 at 00:43, Chris Clayton <chris2553@googlemail.com> wrote:
>>>
>>>
>>>
>>> On 10/02/2023 19:33, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 10.02.23 20:01, Karol Herbst wrote:
>>>>> On Fri, Feb 10, 2023 at 7:35 PM Linux regression tracking (Thorsten
>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>
>>>>>> On 08.02.23 09:48, Chris Clayton wrote:
>>>>>>>
>>>>>>> I'm assuming  that we are not going to see a fix for this regression before 6.2 is released.
>>>>>>
>>>>>> Yeah, looks like it. That's unfortunate, but happens. But there is still
>>>>>> time to fix it and there is one thing I wonder:
>>>>>>
>>>>>> Did any of the nouveau developers look at the netconsole captures Chris
>>>>>> posted more than a week ago to check if they somehow help to track down
>>>>>> the root of this problem?
>>>>>
>>>>> I did now and I can't spot anything. I think at this point it would
>>>>> make sense to dump the active tasks/threads via sqsrq keys to see if
>>>>> any is in a weird state preventing the machine from shutting down.
>>>>
>>>> Many thx for looking into it!
>>>
>>> Yes, thanks Karol.
>>>
>>> Attached is the output from dmesg when this block of code:
>>>
>>>         /bin/mount /dev/sda7 /mnt/sda7
>>>         /bin/mountpoint /proc || /bin/mount /proc
>>>         /bin/dmesg -w > /mnt/sda7/sysrq.dmesg.log &
>>>         /bin/echo t > /proc/sysrq-trigger
>>>         /bin/sleep 1
>>>         /bin/sync
>>>         /bin/sleep 1
>>>         kill $(pidof dmesg)
>>>         /bin/umount /mnt/sda7
>>>
>>> is executed immediately before /sbin/reboot is called as the final step of rebooting my system.
>>>
>>> I hope this is what you were looking for, but if not, please let me know what you need
> 
> Thanks Dave. [...]
FWIW, in case anyone strands here in the archives: the msg was
truncated. The full post can be found in a new thread:

https://lore.kernel.org/lkml/e0b80506-b3cf-315b-4327-1b988d86031e@googlemail.com/

Sadly it seems the info "With runpm=0, both reboot and poweroff work on
my laptop." didn't bring us much further to a solution. :-/ I don't
really like it, but for regression tracking I'm now putting this on the
back-burner, as a fix is not in sight.

#regzbot monitor:
https://lore.kernel.org/lkml/e0b80506-b3cf-315b-4327-1b988d86031e@googlemail.com/
#regzbot backburner: hard to debug and apparently rare
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
