Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BF676AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjAVD3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAVD3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:29:07 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043942311A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:29:06 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30M3SHdk1791283
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 21 Jan 2023 19:28:18 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30M3SHdk1791283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674358098;
        bh=rz7xubI8gaetCfjQsm2qjXCOj30c+/Ra+OWJ0JikZ5M=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=eZo7IwA0VwRpSTRddad5fxKP31JBNds4VLQ1HFxxM6fTG8MxcxhJlcFv+87hpD6Q0
         p2llEUsBbvyyDPNzQRx9F311Fvunnc3iqBm9ZcXy113OpkCID/O/v4fEUFaHMRFqiU
         UApzOZ9BvrDxOxkUbveVvP8pXsIHScpiuLtjF9J3gkVKj9ZHXpeOR8YFY67JeRZI1h
         oV1XoAHDbZBSMzWGT5rtWSYRRzQHCmLZcblj8Ml/lS7HFdgcDl677rblfHuWCQFfOJ
         wPOeKCiGOmZuBB23MdE7XPDAIE0ZFtnAZCcxyDGCcwNA0PA0Ih/Qy7bkGvE+hy9YZp
         jZMfDyFKWUUsg==
Date:   Sat, 21 Jan 2023 19:28:15 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>, Brian Gerst <brgerst@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: the x86 sysret_rip test fails on the Intel FRED architecture
User-Agent: K-9 Mail for Android
In-Reply-To: <SA1PR11MB6734368CB5479E2D1C03C978A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <5703e698-a92a-2026-e5d4-3c6340578918@intel.com> <CAMzpN2iC9_ZfEmQA0469RQqoZ7NsNCCafy3FsZAt6O0gdB9Oig@mail.gmail.com> <SA1PR11MB6734368CB5479E2D1C03C978A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <C3617458-3629-440D-A914-6792DBA03943@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2023 7:01:53 PM PST, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrot=
e:
>> > >> If not intentional, it might be something that can still be fixed=
=2E
>> > >> If it is intentional and is going to be with us for a while we hav=
e
>> > >> a few options=2E  If userspace is _really_ depending on this
>> > >> behavior, we could just clobber r11 ourselves in the FRED entry
>> > >> path=2E  If not, we can remove the assertion in the selftest=2E
>> > > We can't clobber it in the FRED entry path, since it is common for
>> > > all events, but we could do it in the syscall dispatch=2E
>> > >
>> > > However, it doesn't seem to make sense to do so to me=2E The curren=
t
>> > > behavior is much more of an artifact than desired behavior=2E
>> > I guess the SDM statements really are for the kernel's benefit and no=
t
>> > for userspace=2E  Userspace _should_ be treating SYSCALL like a CALL =
and
>> > r11 like any old register that can be clobbered=2E  Right now, the
>> > kernel just happens to clobber it with RFLAGS=2E
>> >
>> > I do the the odds of anyone relying on this behavior are pretty small=
=2E
>> > Let's just zap the check from the selftest, document what we did in
>> > the FRED docs and changelog and move on=2E
>>=20
>> Keep the selftest check, but also accept preserved RCX/R11=2E  What rea=
lly matters is
>> that the kernel isn't leaking data=2E
>
>I feel it the same way, it looks to me that the check is to make sure
>R11 doesn't leak any kernel data because the Linux kernel deliberately
>overwrites R11 with the value of user level flags just before returning
>to user level=2E
>
>I wanted to zap the check, but as HPA said, this is an artifact to not le=
ak
>any kernel data=2E  I guess it doesn't make a difference if the kernel se=
ts
>R11 to 0=2E
>
>Maybe it's still reasonable to keep such a check for IDT=2E  However, it =
makes
>no sense for FRED systems, because all GP registers are saved/restored up=
on
>event delivery/return=2E
>
>Thanks!
>  Xin
>
>>=20
>> --
>> Brian Gerst
>

The big thing is that the system calls that return with sysret v iret on I=
DT systems need to be consistent, in order to not leak kernel state=2E
