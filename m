Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC45BFE88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIUNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:00:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB248A7DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:00:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXdn0035Tz4xG9;
        Wed, 21 Sep 2022 23:00:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1663765221;
        bh=QT/Sl5AvXoUzaa7Mvmu4tMi+mbhfGfOR2s8x//+T2VY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hjA4SvFWM/5Cex+dNXi9ZS8vBM8YsfJ2esWTPctRWZuPxP8Zr1thsxjaxFiUVdJbm
         cYkKXj8QJq3eUhadLV8HDf3qMWwXdhtDyNX5yEPJj46HF7MuP5sZE9GQVUtIlJRJFY
         GAuTf0KYAfy1F09+xy3KD8PC+JMCyd6LSW5Opsbt2Ha7fkxRYPwqsj/KxSp7Rtt3w5
         CiwzFpaE3ybt+1ljMDmHxoDaU7Qgnb6nZWlVXCbNV8wwBwjEki6CwtCRlQ75+Rnmnh
         jISwtL+dfAdsZDPV7EIQe/JjoUdVrHXW93wgz+QCX4S7Oq662PaU/hP58nEUYjFy9/
         pgxXLkacus4vw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Samuel Holland <samuel@sholland.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Russell Currey <ruscur@russell.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Save AMR/IAMR when switching tasks
In-Reply-To: <9a433048-ab0d-6d57-7aa8-c9acbe7b7a99@csgroup.eu>
References: <20220916050515.48842-1-samuel@sholland.org>
 <89049105-64fc-8d5b-d090-2841064786d1@csgroup.eu>
 <87h713leu8.fsf@mpe.ellerman.id.au>
 <9a433048-ab0d-6d57-7aa8-c9acbe7b7a99@csgroup.eu>
Date:   Wed, 21 Sep 2022 23:00:16 +1000
Message-ID: <87a66s287z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 19/09/2022 =C3=A0 14:37, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Le 16/09/2022 =C3=A0 07:05, Samuel Holland a =C3=A9crit=C2=A0:
>>>> With CONFIG_PREEMPT=3Dy (involuntary preemption enabled), it is possib=
le
>>>> to switch away from a task inside copy_{from,to}_user. This left the C=
PU
>>>> with userspace access enabled until after the next IRQ or privilege
>>>> level switch, when AMR/IAMR got reset to AMR_KU[AE]P_BLOCKED. Then, wh=
en
>>>> switching back to the original task, the userspace access would fault:
>>>
>>> This is not supposed to happen. You never switch away from a task
>>> magically. Task switch will always happen in an interrupt, that means
>>> copy_{from,to}_user() get interrupted.
>>=20
>> Unfortunately this isn't true when CONFIG_PREEMPT=3Dy.
>
> Argh, yes, I wrote the above with the assumption that we properly follow=
=20
> the main principles that no complex fonction is to be used while KUAP is=
=20
> open ... Which is apparently not true here. x86 would have detected it=20
> with objtool, but we don't have it yet in powerpc.

Yes and yes :/

>> We can switch away without an interrupt via:
>>    __copy_tofrom_user()
>>      -> __copy_tofrom_user_power7()
>>         -> exit_vmx_usercopy()
>>            -> preempt_enable()
>>               -> __preempt_schedule()
>>                  -> preempt_schedule()
>>                     -> preempt_schedule_common()
>>                        -> __schedule()
>
>
> Should we use preempt_enable_no_resched() to avoid that ?

Good point :)

...
>>=20
>> Still I think it might be our best option for an easy fix.
>
> Wouldn't it be even easier and less abusive to use=20
> preemt_enable_no_resched() ? Or is there definitively a good reason to=20
> resched after a VMX copy while we don't with regular copies ?

I don't think it's important to reschedule there. I guess it means
another task that wants to preempt will have to wait a little longer,
but I doubt it's measurable.

One reason to do the KUAP lock is it also protects us from running
disable_kernel_altivec() with KUAP unlocked.

That in turn calls into msr_check_and_clear() and
__msr_check_and_clear(), none of which is a problem per-se, but we'd
need to make that all notrace to be 100% safe.

At the moment we're running that all with KUAP unlocked anyway, so using
preempt_enable_no_resched() would fix the actual bug and is much nicer
than my patch, so we should probably do that.

We can look at making disable_kernel_altivec() etc. notrace as a
follow-up.

cheers
