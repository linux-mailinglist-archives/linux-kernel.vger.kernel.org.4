Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00702683837
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjAaVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjAaVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:02:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5010CA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:01:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id fi26so15703736edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jzS//Tvn+8u6WEDulB0XGRp+90ihmZL8y7hV6gzvNvE=;
        b=CcycIhOSaGqcMcNaJ6Z2MvhNm9iMbbTx3IKMsJElhPL8g/A+CxoUvRmYlNmtjfAvHp
         4S8nBHvhFE69NHdigXz2jYcBaljXu24BFuVwFcsmVI2DEWvIXfejzcOFNq9bNFIwSb9A
         VtELSUoC8Abmrr6tHF2bt6O1kwy8dif8B+9Sw/6fIHjbcvHct9WDFBtkgGQNFW7J81a3
         eAtmtcPhXp1yX9XrAQBC87llTC1k+ZTTThrQ2Q2RO7DFlEOa5+02v/LVIBIKI2NQ2gGw
         DcnYOpVu2fu+hF4x/X8st3CqYYqneEZo0ANlgGmuw2ffP3wacAcqYd+u4c15vhuusa28
         yRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzS//Tvn+8u6WEDulB0XGRp+90ihmZL8y7hV6gzvNvE=;
        b=W6XnjgOv4s0L9mw5XriLpaYbLCG9Di3VzEkSLBNvwyiG2t5sHygNL2nnNxItcI24ZM
         ys/Jxom1UdTE7QwmNzzKj/HIlJatYC3biVsEVXCp3UVEE73kroCKxCKsafK1h3A0RVbu
         kN7MMFVsmthkAXfpwL8HQXu+GjvNRy36K1RntD+WBdOB60TLfJjUFQ8txYyXp8mYeOHU
         XUU1SajM+hspJ6x7ty+cvbB0hcBhVYJPpeaQJbgOKgjdxmmm318AqdUQEs7Hs/rP/Eeo
         ctJN2yHZAfwGl0Qh/K84mm+YTQyg/ahFas0RQg3aJGM3UY0dHUp41gYIPBYRXYLD9BSW
         pfHw==
X-Gm-Message-State: AO0yUKXhzgEFfg6wt4tQ94yikUL2SwANp3tsRsLMpn7+PAWcHZdvVtoU
        LBwIO9fQIKYafXUHrAa6GVI=
X-Google-Smtp-Source: AK7set/6Ch/IS6VkXdI7ykel8LTt0101Bc6VBcRWIO9d2OA0S+ZeazMS1S98Xz5tUh9vCM9DE97eUg==
X-Received: by 2002:aa7:df9a:0:b0:4a2:1737:55a9 with SMTP id b26-20020aa7df9a000000b004a2173755a9mr19114131edy.9.1675198917199;
        Tue, 31 Jan 2023 13:01:57 -0800 (PST)
Received: from sakura.myxoz.lan (81-230-97-204-no2390.tbcn.telia.com. [81.230.97.204])
        by smtp.gmail.com with ESMTPSA id l3-20020aa7c3c3000000b004a22ed9030csm5335976edr.56.2023.01.31.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:01:56 -0800 (PST)
Message-ID: <3bccbead128d5bbc699cd092b79bf8d61e6cb373.camel@gmail.com>
Subject: Re: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Jan 2023 22:01:55 +0100
In-Reply-To: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 21:30 +0000, Maciej W. Rozycki wrote:
> For x86 kernel stack offset randomization uses the RDTSC instruction,
> which according to H. Peter Anvin is not a secure source of entropy:
>=20
> "RDTSC isn't a super fast instruction either, but what is *way* more
> significant is that this use of RDTSC is NOT safe: in certain power
> states
> it may very well be that stone number of lower bits of TSC contain no
> entropy at all."
>=20
> It also causes an invalid opcode exception with hardware that does
> not=20
> implement this instruction:
>=20
> process '/sbin/init' started with executable stack
> invalid opcode: 0000 [#1]
> CPU: 0 PID: 1 Comm: init Not tainted 6.1.0-rc4+ #1
> EIP: exit_to_user_mode_prepare+0x90/0xe1
> Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73
> 05 e8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f>
> 31 0f b6 c0 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
> EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
> ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
> DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
> CR0: 80050033 CR2: bfe8659b CR3: 012e0000 CR4: 00000000
> Call Trace:
> =C2=A0? rest_init+0x72/0x72
> =C2=A0syscall_exit_to_user_mode+0x15/0x27
> =C2=A0ret_from_fork+0x10/0x30
> EIP: 0xb7f74800
> Code: Unable to access opcode bytes at 0xb7f747d6.
> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfe864b0
> DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
> ---[ end trace 0000000000000000 ]---
> EIP: exit_to_user_mode_prepare+0x90/0xe1
> Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73
> 05 e8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f>
> 31 0f b6 c0 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
> EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
> ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
> DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
> CR0: 80050033 CR2: b7f747d6 CR3: 012e0000 CR4: 00000000
> Kernel panic - not syncing: Fatal exception
>=20
> Therefore switch to our generic entropy source and use
> `get_random_u8'=20
> instead, which according to Jason A. Donenfeld is supposed to be fast
> enough:
>=20
> "Generally it's very very fast, as most cases wind up being only a
> memcpy -- in this case, a single byte copy. So by and large it should
> be suitable. It's fast enough now that most networking things are
> able
> to use it. And lots of other places where you'd want really high
> performance. So I'd expect it's okay to use here too. And if it is
> too
> slow, we should figure out how to make it faster. But I don't suspect
> it'll be too slow."
>=20
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: fe950f602033 ("x86/entry: Enable random_kstack_offset
> support")
> Cc: stable@vger.kernel.org=C2=A0# v5.13+
> ---
> Changes from v2:
>=20
> - Use `get_random_u8' rather than `rdtsc', universally; update the
> heading=20
> =C2=A0 (was: "x86: Disable kernel stack offset randomization for !TSC")
> and the=20
> =C2=A0 description accordingly.
>=20
> - As a security concern mark for backporting.
>=20
> Changes from v1:
>=20
> - Disable randomization at run time rather than in configuration.
> ---
> =C2=A0arch/x86/include/asm/entry-common.h |=C2=A0=C2=A0=C2=A0 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> linux-x86-randomize-kstack-offset-random-u8.diff
> Index: linux-macro/arch/x86/include/asm/entry-common.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/arch/x86/include/asm/entry-common.h
> +++ linux-macro/arch/x86/include/asm/entry-common.h
> @@ -2,6 +2,7 @@
> =C2=A0#ifndef _ASM_X86_ENTRY_COMMON_H
> =C2=A0#define _ASM_X86_ENTRY_COMMON_H
> =C2=A0
> +#include <linux/random.h>
> =C2=A0#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/user-return-notifier.h>
> =C2=A0
> @@ -85,7 +86,7 @@ static inline void arch_exit_to_user_mod
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Therefore, final stack=
 offset entropy will be 5 (x86_64)
> or
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 6 (ia32) bits.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0choose_random_kstack_offset(rd=
tsc() & 0xFF);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0choose_random_kstack_offset(ge=
t_random_u8());
> =C2=A0}
> =C2=A0#define arch_exit_to_user_mode_prepare
> arch_exit_to_user_mode_prepare
> =C2=A0
Tested-by: Miko Larsson <mikoxyzzz@gmail.com>
--=20
~miko
