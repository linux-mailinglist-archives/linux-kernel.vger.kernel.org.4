Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F464DAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLOLtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLOLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:49:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8B15837
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:49:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D1A61DA3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2580DC433EF;
        Thu, 15 Dec 2022 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671104939;
        bh=wbeItei8XNJdtvERQarnHc0sfIIAd4rFKjZzbMdgUdU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X15lztr5OmHJzle07spiVk/pJmspvk8QSf4IpZtcPy5tiZ2wfg62HswLSKAAs9H8R
         b2liUzh//ycbVhN2gZojO8nvzrPRbAMxXHV22rc6WAlImO3QvnBVLD9hC+eBJjv7pI
         zznooJpS62GU1nlaHi9LZTBH67kOlVxzT4q/Mf3nltrwF7TJODapIrjoylrffBWQh5
         FClV7UIlsEGptV2jmFK4LSgT4QT2xrquIKLpnHUUT8LA+D5iN4+avfB0BWqriLyzaj
         nC4EQNYwS5gbaKfQAPoejx6OfrRobJlGlUcR/TJtBPaVDwJK+QH8pXEGkq/MjkHq3h
         ST2PWkfhZ/rgg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Darius Rad <darius@bluespec.com>,
        Vineet Gupta <vineetg@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        libc-alpha@sourceware.org, christoph.muellner@vrull.eu,
        Aaron Durbin <adurbin@rivosinc.com>, linux@rivosinc.com
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
In-Reply-To: <Y5qByfCtpV0uNID3@bruce.bluespec.com>
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
 <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
 <Y5qByfCtpV0uNID3@bruce.bluespec.com>
Date:   Thu, 15 Dec 2022 12:48:56 +0100
Message-ID: <877cysx4yf.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darius Rad <darius@bluespec.com> writes:

> On Wed, Dec 14, 2022 at 12:07:03PM -0800, Vineet Gupta wrote:
>> On 12/13/22 08:43, Darius Rad wrote:
>> > On Fri, Dec 09, 2022 at 11:42:19AM -0800, Vineet Gupta wrote:
>> > > But keeping the V unit disabled by default and using prctl as a gate=
keeper
>> > > to enable it feels unnecessary and tedious.
>> > > Here's my reasoning below (I'm collating comments from prior msgs as=
 well).
>> > Please reference the previous discussion [1] which has covered topics =
that
>> > have not been discussed recently.
>> >=20
>> > [1] https://lists.infradead.org/pipermail/linux-riscv/2021-September/t=
hread.html#8361
>>=20
>> I sure read thru that thread, and many more :-) to get context.
>> The highlight is we should something because AVX/AMX do so (or failed to=
 do
>> so).
>> But on the flip side ARM SVE is not disabling this by default.
>> Your other concerns seems to be potential power implications for leaving=
 it
>> on and sharing of V unit across harts (see more on that below)
>> Maybe leaving it on all the time will be motivation for hw designers to =
be
>> more considerate of the idle power draw.
>>=20
>
> That is not quite the same take away I had from the AMX discussion.  I
> would also disagree that ARM SVE is not disabling things by default,
> although the behavior is somewhat different.
>
> The significant point that I see from that discussion, which also applies
> to SVE, and also applies to RISC-V vector, is that the extension is
> necessarily dependant upon a functional unit that is reasonably large with
> respect to the size of the processor and has a significant amount of
> additional architectural state.  The argument there is that AMX/SVE/RVV is
> a significant system resource and should be treated as such: by having the
> kernel track usage of it and by having a process specifically request
> access to it.
>
> For any of AMX/SVE/RVV, use of the extension operates as follows:
>
>   1. A process requests access to the extension,
>
>   2. The kernel allocates memory for the additional state for this proces=
s,
>
>   3. The kernel enables the extension for the process, and finally
>
>   4. The process is able to use the instructions.
>
> I don't recall the exact details, but my understanding is that AMX is goi=
ng
> to use an x86 specific mechanism and require and explict request from user
> space to request access to AMX.

Yes, it uses arch_prctl, and on top of that a "lazy trigger" (AFAIK) as
SVE (first use enable via trap).

> For SVE, it is in fact disabled by default in the kernel.  When a thread
> executes the first SVE instruction, it will cause an exception, the kernel
> will allocate memory for SVE state and enable TIF_SVE.  Further use of SVE
> instructions will proceed without exceptions.  Although SVE is disabled by
> default, it is enabled automatically.  Since this is done automatically
> during an exception handler, there is no opportunity for memory allocation
> errors to be reported, as there are in the AMX case.

Glibc has an SVE optimized memcpy, right? Doesn't that mean that pretty
much all processes on an SVE capable system will enable SVE (lazily)? If
so, that's close to "enabled by default" (unless SVE is disabled system
wide).

> For RVV, I do not recall ever seeing Linux patches that automatically ena=
ble
> vector.  I have seen it enabled unconditionally, or with a manual enable
> (i.e., prctl).
>
> It is possible to write a program that does not ever use AMX, and when th=
at
> program is run, the process will not incur the power or memory overhead of
> AMX.  It is also possible to do that with SVE.  This is simply not possib=
le
> if RISC-V will, by default for every process, enable and allocate state
> memory for vector.
>
> So my thought would be what is the motivation for being even less flexible
> than SVE, if you feel that the AMX mechanism is too onerous?

AMX is a bit different from SVE and V; SVE/V is/would be used by glibc
for memcpy and such, where I doubt that AMX would be used there. Then
again, there's AVX512 which many argue that "turned on by default" was a
mistake (ABI breakage/power consumption).

>> >=20
>> > > 2. People want the prctl gatekeeping for ability to gracefully handl=
e memory
>> > > allocation failure for the extra V-state within kernel. But that is =
only
>> > > additional 4K (for typical 128 wide V regs) per task.
>> > But vector state scales up to as much as 256k.  Are you suggesting that
>> > there is no possibility that future systems would support more than
>> > VLEN=3D128?
>>=20
>> I mentioned "typical". And below also said that memory allocation concer=
ns
>> are moot, since fork/execve failures due to failing to allocate would ta=
ke
>> care of those anyways.
>>=20
>
> But again, what if one were using such an admittedly atypical system?  Why
> should such a user be compelled to take a memory hit for every process,
> even if they specifically go out of their way to avoid using vector
> instructions?

For the sake of discussion; Nobody is arguing against not having knobs
to turn V on/off per-process/per-system, right? The discussion is about
on/off, and broader what a "typical" RV system looks like. If most
systems that fold in the A profile has V, it might make sense not
requiring users to explicitly enable it, and vice-versa.

Using RVA23 as a ball-gazing aid, [1] states that it might mandate V. If
so, assuming that "most system will be designed for V usage" is not
crazy.

Now moving on! The thread is leaning towards "disabled by default" ("AMX
way"), let's try to move the discussion forward!

The Linux kernel itself would benefit from using V
(hashing/crypto). What kind of policy would determine if the kernel is
allowed to use V? Default off, with an explicit enable kernel knob
(cmdline/sysctl/sysfs/...)?

There will likely be V support in glibc (str*/mem*). For systems that
prefer having V "always-on", the UX of requiring all binaries to
explicitly call prctl() is not great (as Andrew pointed out in earlier
posts). A V knob based on some system policy in crt0? :-P


Bj=C3=B6rn

[1] https://lists.riscv.org/g/tech-profiles/message/48
