Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3C7273B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 02:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjFHAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 20:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFHAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 20:25:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6422128
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:25:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686183927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3IsuGe1cP1d+2QPn1Q6+xwy68kc7U8w805Dy6Ua/hE=;
        b=ZFClPd4tRCul9T8BUKeqcTsAsYe6/fKo9B2DJRr8Vr+oVOkU8l8+vvuV+FcCMYGaqH6dDS
        cT792DOscb9OwWx2yYYGeAFB7CtNDYKD/2JKw1zwXQ/2Z4kuoQ326uZfsHQhPdY559WT+1
        sDt01DoB0qorzrfZw+8Gg1pa8EWAD2SFISm+vtW1nREBCs6ChD/298GryMHj70+ZJhUzVq
        nlkHK/Q7P/yBdIWKje73ucfovMITzLyLAHEgfMxYYm7RzCnQCQ+Infhpq7K0CzMZQ5ztDZ
        sPvIAAiBlbaEvAz96x1sV3CoOd5r1bCduogvhJCWQyBqiy/cEsENp/AkgXV0FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686183927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3IsuGe1cP1d+2QPn1Q6+xwy68kc7U8w805Dy6Ua/hE=;
        b=J7cAZ4NAfozz0nk3T/RN+PyKAe/5G3ifwZncupfnP0ZePoCQ0pyZiVHvoiXvlmC61Ve3qd
        3EZwJRDDYDx3M+Bg==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com>
Date:   Thu, 08 Jun 2023 02:25:26 +0200
Message-ID: <871qimkdft.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08 2023 at 00:43, Andrew Cooper wrote:
> On 07/06/2023 10:52 pm, Thomas Gleixner wrote:
>> On Wed, Jun 07 2023 at 18:25, Andrew Cooper wrote:
>>> You also have to block Linux from taking any SYSRETL or SYSEXITL path
>>> out of the kernel, as these will load fixed 32bit mode attributes into
>>> %cs without reference to the GDT.
>> That's non-trivial as there is no way to disable 32bit SYSCALL on AMD
>> (Intel does not support 32bit syscall and you get #UD if CS.L !=3D 1). So
>> to be safe you'd need to make ignore_sysret() kill the process w/o
>> returning to user space.
>
> ignore_sysret() desperately needs renaming to entry_SYSCALL32_ignore()
> or similar.

No argument about that.

> And yes, wiring this into SIGSEGV/etc would be a sensible move.

The only option is to wire it into die_hard_crash_and_burn(). There is
no sane way to deliver a signal to the process which managed to run into
this. Appropriate info to parent or ptracer will still be delivered.

> The same applies to 32bit SYSENTER if configured. (Linux doesn't, but
> other OSes do.)

Why the heck are they doing that?

I really wish that we could disable syscall32 reliably on AMD and make
it raise #UD as it does on Intal.

>> Though the real question is:
>>
>>        What is the benefit of such a change?
>>
>> So far I haven't seen any argument for that. Maybe there is none :)
>
> Hardening.=C2=A0 The general purpose distros definitely won't care, but
> special purpose ones will.
>
> An x86 bytestream is decoded differently in different modes, and malware
> can hide in the differences.=C2=A0 Standard tooling can't cope with
> multi-mode binaries, and if it happens by accident you tend get very
> obscure crash to diagnose.

IOW, you are talking about defense in depth, right? I can buy that one.

> Furthermore, despite CET-SS explicitly trying to account for and protect
> against accidental mismatches, there are errata in some parts which let
> userspace forge legal return addresses on the shadow stack by dropping
> into 32bit mode because, there's a #GP check missing in a microflow.

Didn't we assume that there are no CPU bugs? :)

> For usecases where there ought not to be any 32bit code at all (and
> there absolutely are), it would be lovely if this could be enforced,
> rather than relying on blind hope that it doesn't happen.

I think it's rather clear what needs to be done here to achieve that,
but that's completely orthogonal to the intent of the patch series in
question which aims to make CONFIG_IA32_EMULATION a boot time decision.

Thanks,

        tglx
