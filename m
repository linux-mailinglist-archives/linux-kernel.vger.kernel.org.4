Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDD71F2F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjFATcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFATcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:32:13 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20A195;
        Thu,  1 Jun 2023 12:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 351JVGfm2328876
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 1 Jun 2023 12:31:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 351JVGfm2328876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023051001; t=1685647878;
        bh=GAEb809tzFU8RRL99qzs256NAvp/XGziwXMtqrDZ4bI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZoIAOes0f7syVdcxW7iePtggH8XH5U6HMk/dstA2GF4JwqHI7rXQWP9GVEsqzgXW7
         NVtzqn7WdAjk6et69elYqDM8RKQoeei4ATmbWQJkWlr+z+OJgg/5M2rrClbsm8p8yt
         yhX/ucg4bJXc1teThZ5EPAVlSsjnU79vuBzoQUfCp47EwCQidUiFvLVYPMkmnOd8En
         BQBwZHIrd5VE9P/L+fH/HwS4ftYz6P6Hg5+iBy0q/AmTSiF1CavnQU6DBqVYOrOyiU
         FIta8RB551Bjph+UoaxlDV/nmOJD+KFewp2rk32bCj80naLixrM00DUKc6lilJfEyn
         XpytuxVVMx4wA==
Date:   Thu, 01 Jun 2023 12:31:11 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Steven Noonan <steven@uplinklabs.net>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
User-Agent: K-9 Mail for Android
In-Reply-To: <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com> <87mt1jeax1.ffs@tglx> <87h6rrdoy0.ffs@tglx> <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
Message-ID: <9BF0BF2A-E1D5-476A-A241-3B3BBDAD2750@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 1, 2023 12:07:38 PM PDT, Steven Noonan <steven@uplinklabs=2Enet> wr=
ote:
>On Thursday, June 1st, 2023 at 11:20 AM, Thomas Gleixner <tglx@linutronix=
=2Ede> wrote:
>> Here is an example where it falls flat on its nose=2E
>>=20
>
>> One of the early Ryzen laptops had a broken BIOS which came up with
>> unsynchronized TSCs=2E I tried to fix that up, but couldn't get it to s=
ync
>> on all CPUs because for some stupid reason the TSC write got
>> arbritrarily delayed (assumably by SMI/SMM)=2E
>
>Hah, I remember that=2E That was actually my laptop=2E A Lenovo ThinkPad =
A485 with a Ryzen 2700U=2E I've seen the problem since then occasionally on=
 newer Ryzen laptops (and even desktops)=2E Without the awful "tsc=3Ddirect=
sync" patch I wrote, which I've been carrying for years now in my own kerne=
l builds, it just falls back to HPET=2E It's not pleasant, but at least it'=
s a stable clock=2E
>
>> After the vendor fixed the BIOS, I tried again and the problem
>> persisted=2E
>>=20
>
>> So on such a machine the 'fixup time' mechanism would simply render an
>> otherwise perfectly fine TSC unusable for timekeeping=2E
>>=20
>
>> We asked both Intel and AMD to add TSC_ADJUST probably 15 years
>> ago=2E Intel added it with some HSW variants (IIRC) and since SKL all C=
PUs
>> have it=2E I don't know why AMD thought it's not required=2E That could=
 have
>> spared a gazillion of bugzilla entries vs=2E the early Ryzen machines=
=2E
>>
>
>Agreed, TSC_ADJUST is the ultimate solution for any of these kinds of iss=
ues=2E But last I heard from AMD, it's still several years out in silicon, =
and there's plenty of hardware to maintain compatibility with=2E Ugh=2E
>
>A software solution would be preferable in the meantime, but I don't know=
 what options are left at this point=2E
>
>The trap-and-emulate via SIGSEGV approach proposed earlier in the thread =
is unfortunately not likely to be practical, assuming I implemented it prop=
erly=2E
>
>One issue is how much overhead it has=2E This is an instruction that norm=
ally executes in roughly 50 clock cycles (RDTSC) to 100 clock cycles (RDTSC=
P) on Zen 3=2E Based on a proof-of-concept I wrote, the overhead of trappin=
g and emulating with a signal handler is roughly 100x=2E On my Zen 3 system=
, it goes up to around 10000 clock cycles per trapped read of RDTSCP=2E Mos=
t Windows games that use this instruction directly are doing so under the a=
ssumption that the TSC is faster to read than any of the native Windows API=
 clock sources=2E If it's suddenly ~100x slower than even the slowest-to-re=
ad Windows clocksource, those games would likely become entirely unplayable=
, depending on how frequently they do TSC reads=2E (And many do so quite of=
ten!)
>
>Also, my proof-of-concept doesn't actually do the emulation part=2E It ju=
st traps the instruction and then executes that same instruction in the sig=
nal handler, putting the results in the right registers=2E So it's a pass-t=
hrough approach, which is about the best you can do performance wise=2E
>
>Another issue is that the implementation might be tricky=2E In the case o=
f Wine, you'd need to enable PR_TSC_SIGSEGV whenever entering the Windows e=
xecutable and PR_TSC_ENABLE whenever leaving it=2E If you don't, any of the=
 normally well-behaved clock sources implemented using the TSC (e=2Eg=2E CL=
OCK_MONOTONIC_RAW, etc) would also fault on the Wine side=2E Also, there's =
some Windows-specific trickery, in that the Windows registry exposes the TS=
C frequency in a couple of places, so those would need to be replaced with =
the frequency of the emulated clocksource=2E
>
>- Steven
It seems to me that this is one of several reasons that it might be desira=
ble to wrap the Windows executable in a KVM wrapper, exactly to be able to =
intercept non-system-call related system differences=2E

I realize this is not a small change=2E=2E=2E
