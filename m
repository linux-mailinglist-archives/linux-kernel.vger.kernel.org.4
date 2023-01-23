Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7353C6786B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjAWTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjAWTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:46:29 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663927D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:46:26 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30NJhbwc2461392
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Jan 2023 11:43:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30NJhbwc2461392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674503019;
        bh=1v0hX6MpsNTaatf0/gyVCBlXHUMZEcZpskJcjuFVg3E=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=V3E4VQUHyzC+44x5Mwir4fxCuDLkQDKEsnxthYqg6FPd1mauNPYb2zbNjR2h9/Zd1
         AtssJY0ncPwQdzeuZzgbHEpModsQsbj/EJ9Sor3eiDMMTIbK7CA/Q/pntbB0yTo4i6
         7ptSlOZ33c6drjluIPLHuc0pLKGpnECWmFQTmP96/zG68Cg8mva/xj7U6HOtap9fsI
         xeqWZCwYI0IOBIWm14LlYR5itM73RzTvMYKSZBspfDpaSAdGN+hk94hrYdJoOcwzLM
         HKzkygbJuXjnrJbIty5LyXb9nSGa6ASPuS/6HPjw6T2K1/Yn9rFVjwbRLajWdT3OXh
         Qmni6VRd/JfsA==
Date:   Mon, 23 Jan 2023 11:43:35 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
User-Agent: K-9 Mail for Android
In-Reply-To: <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
Message-ID: <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2023 1:02:22 AM PST, Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg>=
 wrote:
>On 1/23/23 6:45 AM, H=2E Peter Anvin wrote:
>> static enum regs_ok check_regs_syscall(int syscall,
>>  =C2=A0=C2=A0=C2=A0=C2=A0unsigned long arg1, unsigned long arg2)
>> {
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0register unsigned long r11 asm("%r11");
>>  =C2=A0=C2=A0=C2=A0=C2=A0unsigned long rcx, rbx, tmp;
>
>tmp is unused=2E
>
>>  =C2=A0=C2=A0=C2=A0=C2=A0r11 =3D r11_sentinel;
>>  =C2=A0=C2=A0=C2=A0=C2=A0rcx =3D rcx_sentinel;
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0asm volatile("push %3; popf; "
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "lea 1f(%%rip),%2; "
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "syscall; "
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "1:"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : "+r" (r11), "+c" (rcx), "=3Db" (rbx)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : "g" (rflags_sentinel),
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "a" (syscall), "D" (arg1), "S" (arg2));
>
>BTW, I just realized this "push" is unsafe for userspace code if the
>compiler decides to inline this inside a leaf function that uses the
>redzone=2E
>
>Reason: Because this "push;" clobbers redzone=2E
>
>It doesn't always happen, but when that happens it can be confusing to
>debug=2E
>
>A simple workaround is: just compile it with "-mno-red-zone" flag=2E
>
>Alternative, without using that flag, maybe preserve the value like:
>
>    movq    -8(%rsp), %r12
>    pushq   %[rflags_sentinel]
>    popf
>    movq    %r12, -8(%rsp)
>    syscall
>
>with "r12" and "memory" added to the clobber list=2E
>
>What do you think?
>

Good spotting=2E %rax needs to be marked clobbered, too=2E
