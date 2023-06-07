Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310BB726018
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjFGMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFGMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:53:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11161735
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:53:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686142422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJiQE9VDAnzwpOGaRO9ka3cmwowQMgWUxgmdirElyzs=;
        b=wyk5TgCnsEOOQ6RGV1FaXTIPOvX3AlV8oHHk72CY2bIVJbDWT7mM78HOCDijWGd3+qAmG7
        LfUJ4LIjAFcy06vnVB7QYCu11hlnrzbXu/68DYvCEwRK/iDPPVttS4pPdZuES5PvHTnkHd
        hiEktIgJs3teq8cPdJAHmCGprm9+lhnTrS3JbCA9hDR8mqbUJ8SpS0238tI+YfsbHSYmMe
        pIJNMDqSIByOSiDz94whdr53GE5M5MI+CKjrERUs5x28dFcULnsuQpArVDqJXEHfq3vJvA
        lHR5/x+LtcRQaaMzglsfiWccdhdkpVVMv9mbVv8ucjoQ6ArwD47oRjXv8hbFfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686142422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJiQE9VDAnzwpOGaRO9ka3cmwowQMgWUxgmdirElyzs=;
        b=eYUIvSbbC1fBbB2LQUkgBTjnv1t0Qi5an0XfawoR5kvLwR9FgOJ4n5D8Mr5RzpxkrgEsB0
        q8ZvcdskWZeoCCAA==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com>
Date:   Wed, 07 Jun 2023 14:53:41 +0200
Message-ID: <87fs73juwa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 15:19, Nikolay Borisov wrote:
> On 7.06.23 =D0=B3. 15:01 =D1=87., Thomas Gleixner wrote:
>>=20
>>> -	(elf_check_arch_ia32(x) ||					\
>>> -	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_64))
>>> +	(!ia32_disabled && (elf_check_arch_ia32(x) ||			\
>>> +	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_64)))
>>=20
>> If I'm reading this correctly then ia32_disabled also prevents binaries
>> with X32 ABI to be loaded.
>>=20
>> That might be intentional but I'm failing to find any explanation for
>> this in the changelog.
>>=20
>> X32_ABI !=3D IA32_EMULATION
>
> Right, however given the other changes (i.e disabling sysenter/int 0x80)=
=20
> can we really have a working X32 abi when ia32_disabled is true? Now I'm=
=20
> thinking can we really have IA32_EMULATION && X32_ABI && ia32_disabled,=20
> I guess the answer is no?

X32_ABI is completely _independent_ from IA32_EMULATION.

It just shares some of the required compat code, but it does not use
sysenter/int 0x80 at all. It uses the regular 64bit system call.

You can build a working kernel with X32_ABI=3Dy and IA32_EMULATION=3Dn.

So why would boottime disabling of IA32_EMULATION affect X32_ABI in any
way?

>>=20
>> This issues a SMP function call on all online CPUs to set these entries
>> to 0 on _every_ CPU hotplug operation.
>>=20
>> I'm sure there is a reason why these bits need to be cleared over and
>> over. It's just not obvious to me why clearing them _ONCE_ per boot is
>> not sufficient. It's neither clear to me why CPU0 must do that ($NCPUS -
>> 1) times, but for the last CPU it's enough to do it once.
>
> Actually clearing them once per-cpu is perfectly fine. Looking around=20
> the code i saw arch_smt_update() to be the only place where a=20
> on_each_cpu() call is being made hence I put the code there. Another=20
> aspect I was thinking of is what if a cpu gets onlined at a later stage=20
> and a 32bit process is scheduled on that cpu, if the gdt entry wasn't=20
> cleared on that CPU then it would be possible to run 32bit processes on=20
> it. I guess a better alternative is to use arch_initcall() ?

Why do you need an on_each_cpu() function call at all? Why would you
need an extra arch_initcall()?

The obvious place to clear this is when a CPU is initialized, no?

>> That aside, what's the justification for doing this in the first place
>> and why is this again inconsistent vs. CONFIG_IA32_EMULATION=3Dn?
>
> I'll put it under an ifdef CONFIG_IA32_EMULATION, unfortunately the=20
> traps.h header can't be included in elf.h without causing build breakage.

You are not answering my question at all and neither the elf nor the
traps header have anything to do with it. I'm happy to rephrase it:

  1) What is the justification for setting the 'present' bit of
     GDT_ENTRY_DEFAULT_USER32_CS to 0?

  2) Why is #1 inconsistent with CONFIG_IA32_EMULATION=3Dn?

Thanks,

        tglx



