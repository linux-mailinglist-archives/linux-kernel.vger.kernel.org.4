Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8825B72AB21
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjFJL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJL0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:26:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F53598
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 04:26:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686396395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLCkp1IrUM9tCSkyx7odsw98tKetwnQWSrTKw64gL8M=;
        b=cS0pWFPubRHjtq48u1ypCkE36C4S3eA3c/+MV9gmWKPpqfsVp7Qs7mHfu5gsoIzsROsqZU
        EiO6eUt+XP0u5yPAZVdUoUQjTuCVdDWR0BB/B48jmU1cjTLO69OrbJaSB0EELoteoewp2l
        Gz+b9cMibuOiT/JwvUafcPH6/v06pEA2sDQ630jnCIQQlNKwqYqUj9dc3Vj17mxdliVln0
        PYL7YhUgLCp5oR0VAxn2JReSnm9iScj9/Aw5Xevde0SWTjZwjXbgw4h4Bw9NR367qFOwx1
        nVvfvmMVN2C6aEwT0xNLUpz5Nl7Td8amVePbrOLicQc2Uxs0jTi8SZZY5jhEAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686396395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hLCkp1IrUM9tCSkyx7odsw98tKetwnQWSrTKw64gL8M=;
        b=n5oE553BjNV0MYg+zef/r0LuJfAWExDxsLbgXBC3XgBA4gfF3Mc9nJlvkev9KVU7iYwf+K
        1s5iSjwUkixs47Aw==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Subject: Re: [PATCH v2 3/4] x86/entry: Disable IA32 syscall if ia32_disabled
 is true
In-Reply-To: <599dea2f-f158-fd67-2c62-d5372d1d18a0@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-4-nik.borisov@suse.com> <87edmkirtd.ffs@tglx>
 <599dea2f-f158-fd67-2c62-d5372d1d18a0@suse.com>
Date:   Sat, 10 Jun 2023 13:26:34 +0200
Message-ID: <871qijimmt.ffs@tglx>
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

On Fri, Jun 09 2023 at 19:03, Nikolay Borisov wrote:
> On 9.06.23 =D0=B3. 18:22 =D1=87., Thomas Gleixner wrote:
>>> +	if ((IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) ||
>>> +	    !IS_ENABLED(CONFIG_IA32_EMULATION)) {
>>=20
>> Aside of that this condition is convoluted and can be simplified to
>> exactly a simple and understandable
>>=20
>>          if (foo)
>>=20
>> which is actually the obvious solution to make it compile in all
>> configurations.
>
> I fail to see how this can be done the way you suggest given that=20
> ia32_disabled is visible iff IA32_EMULATION is selected, this means an=20
> #ifdef is mandatory so that ia32_disabled is checked when we know it=20
> will exist as a symbol, the same applies for the entry_SYSCALL_compat=20
> symbol which has to be used iff IA32_EMULATION is defined. I.e the=20
> ignore code should also be duplicated in the #ifdef IA32_EMULATION &&=20
> ia32_disabled and in the #else  condition.

That's wrong in every aspect. Neither the #ifdeffery nor the code
duplication is mandatory.

arch/x86/include/asm/XXXX.h

#ifdef CONFIG_IA32_EMULATION
extern bool __ia32_enabled;

static inline bool ia32_enabled(void)
{
        return __ia32_enabled;
}
#else
static inline bool ia32_enabled(void)
{
        return IS_ENABLED(CONFIG_X86_32);
}
#endif

        if (ia32_enabled()) {
           ...
        } else {
           ...
        }

Which avoids the #ifdeffery in the code _and_ the code duplication.

All it needs aside of the above is to make sure that the other two
things which the compiler complains about being undeclared in the
EMULATION=3Dn case are treated differently in the relevant header
file. It's not rocket science. See also below.

If you chose $XXXX.h carefully it simply works for everything including
asm/elf.h.

I surely wouldn't have suggested it if it wouldn't be feasible and
reasonably trivial. I wanted you to figure it out yourself instead of
serving you the solution on a silver tablet. There are tons of examples
in the code.

>>> @@ -226,6 +226,13 @@ void __init idt_setup_early_traps(void)
>>>   void __init idt_setup_traps(void)
>>>   {
>>>   	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true=
);
>>> +
>>> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) {
>>=20
>> Ditto.
>
> This actually doesn't fail, because if IA32_EMULATION is n that=20
> conditional expands to 'if (0 && ia32_disabled)' which is eliminated by=20
> the compiler.

Making uninformed claims does not make it more correct.

This _cannot_ compile because the dead code elimination pass is not even
reached due to ia32_disabled being undeclared.

        declaration !=3D definition
and
        #ifdef CONSTANT !=3D if (CONSTANT)

Compiler basics.

You could have spared yourself the embarrassment and the lecture by
compiling that file with IA32_EMULATION=3Dn or by carefully analysing the
compile fail of cpu/common.c. That code is not any different:

>>> +	if ((IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) ||
>>> +	    !IS_ENABLED(CONFIG_IA32_EMULATION)) {

and the compiler also complains rightfully about ia32_disabled being
undeclared _before_ complaining about entry_*_compat.

So:

// Declaration
extern bool foo;

       if (0 && foo)
          ....

compiles and links without ever defining 'foo'.

While:

#if 0
extern bool foo;
#endif

        if (0 && foo)
          ....

already fails to compile due to -Werror

See?

>>> +		gate_desc null_desc =3D {};
>>=20
>> Lacks a newline between declaration and code. It's documented to be
>> required, no?
>>=20
>>> +		write_idt_entry(idt_table, IA32_SYSCALL_VECTOR, &null_desc);
>>> +		clear_bit(IA32_SYSCALL_VECTOR, system_vectors);
>>> +	}
>>=20
>> That aside, I asked you to split IA32_SYSCALL_VECTOR out of def_idts[]
>> and handle it separately, no? If you disagree with me then reply to my
>> review first instead of ignoring me silently.
>
> I tried doing this but it's no go since def_its is defined statically.=20
> Since tha IA32_SYSCALL_VECTOR is the last one it can't simply be tacked=20
> at the end of this array in a separate place. Hence the only viable=20
> solution ( apart from making def_its a dynamically sized array) was to=20
> simply overwrite IA32_SYSCALL_VECTOR in idt_table before it's being=20
> loaded into the ldtr.

Obviously we have fundamentally different interpretations of the phrase
'split IA32_SYSCALL_VECTOR out of def_idts[] and handle it separately':

This splits it out:

 def_idts[] =3D {
 ...=20
-#if defined(CONFIG_IA32_EMULATION)
-	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
-#elif defined(CONFIG_X86_32)
-	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
-#endif
 };

+ia32_idt[] =3D {
+#if defined(CONFIG_IA32_EMULATION)
+	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
+#elif defined(CONFIG_X86_32)
+	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
+#endif
+};

This handles it separately:

	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);

+	if (ia32_enabled())
+		idt_setup_from_table(idt_table, ia32_idt,....);

Which makes it bloody obvious what this is about.

Are you still convinced that the only viable solution is clearing it
after the fact?

So please go and ensure that all config combinations work and that it
builds and works for 32bit too. The latter fails to build because of
including traps.h into an header for no reason.

There is absolutely no urgency to get this into the tree, so please take
your time and do not rush out the next half baken version of this,
unless you aim for the fast path to my ignore list.

Thanks,

        tglx
