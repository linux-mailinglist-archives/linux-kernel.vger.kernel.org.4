Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623005E7A04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiIWLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiIWLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:53:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C285138F0D;
        Fri, 23 Sep 2022 04:53:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYrBP425Hz4wgr;
        Fri, 23 Sep 2022 21:53:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1663933981;
        bh=5zdv+RLQqAtc8v2pEpSSPDxmbj5GL+BOe3bxhxAoGfc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qETfDxGu9ZXwu/AumnaN7OPLzZMy3Bxe8dM6D4G+xnu7ltnDBA4AUdpjz5I5AC+f1
         /wa1yRlaR7KUJyny//UTSZqrMeLiJ+QUG6/YKiq0lNX1bOdb8OjgcuxFlHZvaiznk6
         EYGyh8YYZyuYs/ilfvNFNsMyCpVkUOWOjbAff88Hx3I0lKZPjX2Yjqs73vg+AK+Fa4
         oxi+0pKawM04MeLCMpzWgBCTWFg3/Gr+qSgsK2LQKfw9e5MGrzcxq9A3uBbzNNLKS5
         cUlHWkBaJ4KdAyPvSXG2WRLITbnHJzle4P8BJnBRMXgwO8iZ8LC0pesN1PxXQfaW44
         83DLl+D8ZhgeQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc5
In-Reply-To: <a26ed5e3-1b87-22c5-2761-141a0bdb55e6@gmx.de>
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <20220912091325.1780524-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
 <647e2197-8f89-f5a0-a60b-476aff2fd134@gmx.de>
 <d54e7e26-7797-bedb-142a-2101a4e497de@infradead.org>
 <812d649c-380b-8a7e-1584-891c7e643656@gmx.de>
 <a26ed5e3-1b87-22c5-2761-141a0bdb55e6@gmx.de>
Date:   Fri, 23 Sep 2022 21:52:57 +1000
Message-ID: <87r102z4rq.fsf@mpe.ellerman.id.au>
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

Helge Deller <deller@gmx.de> writes:
> On 9/20/22 23:07, Helge Deller wrote:
>> On 9/20/22 22:29, Randy Dunlap wrote:
>>>
>>>
>>> On 9/20/22 13:23, Helge Deller wrote:
>>>> On 9/12/22 11:22, Geert Uytterhoeven wrote:
>>>>> On Mon, 12 Sep 2022, Geert Uytterhoeven wrote:
>>>>>> JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
>>>>>> =C2=A0=C2=A0- build errors: +16/-1
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: .cfi_endproc without corresponding .cfi_startproc:=C2=A0 =
=3D> 32
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: bad or irreducible absolute expression:=C2=A0 =3D> 16
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: junk at end of line, first unrecognized character is `:':=
=C2=A0 =3D> 16
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: no such instruction: `be 0x100(%sr2,%r0)':=C2=A0 =3D> 29
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: no such instruction: `ldi 0,%r20':=C2=A0 =3D> 30
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: no such instruction: `ldw 0(%sp),%r31':=C2=A0 =3D> 26
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ble 0x100(%sr2,%r0)':=C2=A0 =3D> 46, 51
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ldi 0,%r25':=C2=A0 =3D> 44
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ldi 1,%r25':=C2=A0 =3D> 49
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ldi 173,%r20':=C2=A0 =3D> 45, 50
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.callinfo':=C2=A0 =3D> 40
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.entry':=C2=A0 =3D> 41
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.exit':=C2=A0 =3D> 54
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.proc':=C2=A0 =3D> 39
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.procend':=C2=A0 =3D> 55
>>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.stringz':=C2=A0 =3D> 76
>>>>>
>>>>> parisc-gcc8/generic-32bit_defconfig
>>>>>
>>>>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce8=
6de0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
>>>>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b=
280c85b76967a9106a13ca61c16179/ (all 135 configs)
>>>>
>>>> I see those errors on the kiss website, but I'm unable to reproduce th=
em.
>>>> Downloaded that .config, used same compiler (from https://mirrors.edge=
.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.5.0/)....
>>>> Not sure how to get this fixed.
>>>> If someone has an idea or can reproduce, please let me know.
>>>
>>> Hi,
>>> I can reproduce it using the (x86_64 hosted) crosstool gcc-12.1.0 from =
kernel.org that Arnd builds/provides.
>>> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>>
>> Ah....
>> Building with "make=C2=A0 ARCH=3Dparisc=C2=A0 CROSS_COMPILE=3D/some/path=
/nolibc/hppa-linux/bin/hppa-linux-"
>> uses this CROSS_COMPILE prefix for compiling the .c files, but not for t=
he .S files.
>> So, you will end up with the default hppa-linux-gcc installed on the sys=
tem, not the one provided
>> by CROSS_COMPILE.
>
> Ok, it seems CROSS_COMPILE doesn't work as one would expect (and as it di=
d in the past).
> I'm not sure if this can be fixed.
>
> Since kernel v5.18 the parisc kernel comes with a 32-bit and a 64-bit vDS=
O.
> On parisc we have two compilers:
> - hppa-linux-gnu-gcc for 32-bit, and
> - hppa64-linux-gnu-gcc for 64-bit code.
> There is no -m64 flag like on x86 which can be used to just use one compi=
ler for both targets.
> If you provide a CROSS_COMPILE command, you can only provide either a 32-=
 or 64-bit compiler,
> so e.g. you won't be able to build the 64-bit kernel and a 32-bit vDSO wi=
th the same compiler.
>
> Instead of using CROSS_COMPILE, please just install your compiler(s) and =
make sure that
> the compiler(s) can be found via the PATH environment variable.
> In arch/parisc/Makefile (line 42ff) various variants like hppa-linux-gnu-=
gcc or
> hppa1.1-unknown-linux-gnu-gcc will be searched.
>
> So, instead of
>   make ARCH=3Dparisc CROSS_COMPILE=3D/opt/cross/kisskb/korg/gcc-8.5.0-nol=
ibc/hppa-linux/bin/hppa-linux-
> please use for 32-bit:
>   PATH=3D/opt/cross/kisskb/korg/gcc-8.5.0-nolibc/hppa-linux/bin/:$PATH   =
  make ARCH=3Dparisc
> or for 64-bit:
>   PATH=3D/opt/cross/kisskb/korg/gcc-8.5.0-nolibc/hppa64-linux/bin/:$PATH =
  make ARCH=3Dparisc64

I actually did that change a while back, but hadn't pushed it to one of
the builders -_-

I've done that now, so we shouldn't see this error in future.

Sorry for the noise.

cheers
