Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41165637DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiKXQ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKXQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:56:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D8173551;
        Thu, 24 Nov 2022 08:56:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85B02B82899;
        Thu, 24 Nov 2022 16:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8CAC433C1;
        Thu, 24 Nov 2022 16:55:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VAu77RbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669308957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WRtXZ3UlcBxa5WG59+yjiYgYUqvEGtH6M+uE5724EeI=;
        b=VAu77RbNkeEG3VMO4orq9HYaF4xxdwWBq2FYMf/no85rmsNP8ek620RZXx+zI3Ks8S1YxM
        K2S1t36nX0LxYeQdw7puc7xoG8PiOOu/F9SdEMbUrcnxJ35DLFttpim4nWhvCiCuV+xwUN
        j8tbTJ8FFh3zEbJTEMWzZVPRvzIA1Vw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eeb8bdae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 16:55:56 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v7 0/3] implement getrandom() in vDSO
Date:   Thu, 24 Nov 2022 17:55:33 +0100
Message-Id: <20221124165536.1631325-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v6->v7:
--------------
- VERY EXCITING! There is now a rudimentary glibc implementation for
  this from one of the glibc maintainers, Adhemerval Zanella (CC'd). A
  commit that works with with this latest v7 revision is here:

  https://github.com/bminor/glibc/commit/247ec6dd77ec2a047163fe3a1b60e57880464b39

- Pass an `unsigned int *` instead of an `unsigned long *` for the
  syscall, to avoid having to add a compat syscall.
- Use ordinary function framing in assembly, rather than kernel-specific
  framing.
- Don't hardcode the number '2', but derive it at compile time with the
  expression `sizeof(state->batch_key) / CHACHA_BLOCK_SIZE`, as well as
  adding a BUILD_BUG_ON() in case that doesn't divide cleanly.

Changes v5->v6:
--------------
- Fix various build errors for odd configurations.
- Do not leak any secrets onto the stack at all, to account for possibility of
  fork()ing in a multithreaded scenario, which would ruin forward secrecy.
  Instead provide a arch-specific implementation that doesn't need stack
  space.
- Prevent page alignment from overflowing variable, and clamp to acceptable
  limits.
- Read/write unaligned bytes using get/put_unaligned.
- Add extensive comments to vDSO function explaining subtle aspects.
- Account for fork() races when writing generation counter.

Changes v4->v5:
--------------
- Add example code to vDSO addition commit showing intended use and
  interaction with allocations.
- Reset buffer to beginning when retrying.
- Rely on generation counter never being zero for fork detection, rather than
  adding extra boolean.
- Make use of __ARCH_WANT_VGETRANDOM_ALLOC macro around new syscall so that
  it's condition by archs that actually choose to add this, and don't forget
  to bump __NR_syscalls.
- Separate __cvdso_getrandom() into __cvdso_getrandom() and
  __cvdso_getrandom_data() so that powerpc can make a more efficient call.

Changes v3->v4:
--------------
- Split up into small series rather than one big patch.
- Use proper ordering in generation counter reads.
- Make properly generic, not just a hairball with x86, by moving symbols into
  correct files.

Changes v2->v3:
--------------

Big changes:

Thomas' previous objection was two-fold: 1) vgetrandom
should really have the same function signature as getrandom, in
addition to all of the same behavior, and 2) having vgetrandom_alloc
be a vDSO function doesn't make sense, because it doesn't actually
need anything from the VDSO data page and it doesn't correspond to an
existing syscall.

After a discussion at Plumbers this last week, we devised the following
ways to fix these: 1) we make the opque state argument be the last
argument of vgetrandom, rather than the first one, since the real
syscall ignores the additional argument, and that way all the registers
are the same, and no behavior changes; and 2) we make vgetrandom_alloc a
syscall, rather than a vDSO function, which also gives it added
flexibility for the future, which is good.

Making those changes also reduced the size of this patch a bit.

Smaller changes:
- Properly add buffer offset position.
- Don't EXPORT_SYMBOL for vDSO code.
- Account for timens and vvar being in swapped pages.

--------------

Two statements:

  1) Userspace wants faster cryptographically secure random numbers of
     arbitrary size, big or small.

  2) Userspace is currently unable to safely roll its own RNG with the
     same security profile as getrandom().

Statement (1) has been debated for years, with arguments ranging from
"we need faster cryptographically secure card shuffling!" to "the only
things that actually need good randomness are keys, which are few and
far between" to "actually, TLS CBC nonces are frequent" and so on. I
don't intend to wade into that debate substantially, except to note that
recently glibc added arc4random(), whose goal is to return a
cryptographically secure uint32_t, and there are real user reports of it
being too slow. So here we are.

Statement (2) is more interesting. The kernel is the nexus of all
entropic inputs that influence the RNG. It is in the best position, and
probably the only position, to decide anything at all about the current
state of the RNG and of its entropy. One of the things it uniquely knows
about is when reseeding is necessary.

For example, when a virtual machine is forked, restored, or duplicated,
it's imparative that the RNG doesn't generate the same outputs. For this
reason, there's a small protocol between hypervisors and the kernel that
indicates this has happened, alongside some ID, which the RNG uses to
immediately reseed, so as not to return the same numbers. Were userspace
to expand a getrandom() seed from time T1 for the next hour, and at some
point T2 < hour, the virtual machine forked, userspace would continue to
provide the same numbers to two (or more) different virtual machines,
resulting in potential cryptographic catastrophe. Something similar
happens on resuming from hibernation (or even suspend), with various
compromise scenarios there in mind.

There's a more general reason why userspace rolling its own RNG from a
getrandom() seed is fraught. There's a lot of attention paid to this
particular Linuxism we have of the RNG being initialized and thus
non-blocking or uninitialized and thus blocking until it is initialized.
These are our Two Big States that many hold to be the holy
differentiating factor between safe and not safe, between
cryptographically secure and garbage. The fact is, however, that the
distinction between these two states is a hand-wavy wishy-washy inexact
approximation. Outside of a few exceptional cases (e.g. a HW RNG is
available), we actually don't really ever know with any rigor at all
when the RNG is safe and ready (nor when it's compromised). We do the
best we can to "estimate" it, but entropy estimation is fundamentally
impossible in the general case. So really, we're just doing guess work,
and hoping it's good and conservative enough. Let's then assume that
there's always some potential error involved in this differentiator.

In fact, under the surface, the RNG is engineered around a different
principal, and that is trying to *use* new entropic inputs regularly and
at the right specific moments in time. For example, close to boot time,
the RNG reseeds itself more often than later. At certain events, like VM
fork, the RNG reseeds itself immediately. The various heuristics for
when the RNG will use new entropy and how often is really a core aspect
of what the RNG has some potential to do decently enough (and something
that will probably continue to improve in the future from random.c's
present set of algorithms). So in your mind, put away the metal
attachment to the Two Big States, which represent an approximation with
a potential margin of error. Instead keep in mind that the RNG's primary
operating heuristic is how often and exactly when it's going to reseed.

So, if userspace takes a seed from getrandom() at point T1, and uses it
for the next hour (or N megabytes or some other meaningless metric),
during that time, potential errors in the Two Big States approximation
are amplified. During that time potential reseeds are being lost,
forgotten, not reflected in the output stream. That's not good.

The simplest statement you could make is that userspace RNGs that expand
a getrandom() seed at some point T1 are nearly always *worse*, in some
way, than just calling getrandom() every time a random number is
desired.

For those reasons, after some discussion on libc-alpha, glibc's
arc4random() now just calls getrandom() on each invocation. That's
trivially safe, and gives us latitude to then make the safe thing faster
without becoming unsafe at our leasure. Card shuffling isn't
particularly fast, however.

How do we rectify this? By putting a safe implementation of getrandom()
in the vDSO, which has access to whatever information a
particular iteration of random.c is using to make its decisions. I use
that careful language of "particular iteration of random.c", because the
set of things that a vDSO getrandom() implementation might need for making
decisions as good as the kernel's will likely change over time. This
isn't just a matter of exporting certain *data* to userspace. We're not
going to commit to a "data API" where the various heuristics used are
exposed, locking in how the kernel works for decades to come, and then
leave it to various userspaces to roll something on top and shoot
themselves in the foot and have all sorts of complexity disasters.
Rather, vDSO getrandom() is supposed to be the *same exact algorithm*
that runs in the kernel, except it's been hoisted into userspace as
much as possible. And so vDSO getrandom() and kernel getrandom() will
always mirror each other hermetically.

API-wise, the vDSO gains this function:

  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);

The return value and the first 3 arguments are the same as ordinary
getrandom(), while the last argument is a pointer to some state
allocated with vgetrandom_alloc(), explained below. Were all four
arguments passed to the getrandom syscall, nothing different would
happen, and the functions would have the exact same behavior.

Then, we introduce a new syscall:

  void *vgetrandom_alloc([inout] unsigned int *num, [out] unsigned int *size_per_each, unsigned int flags);

This takes the desired number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread. (The
`flags` argument is always zero for now.) We very intentionally do *not*
leave state allocation up to the caller of vgetrandom, but provide
vgetrandom_alloc for that allocation. There are too many weird things
that can go wrong, and it's important that vDSO does not provide too
generic of a mechanism. It's not going to store its state in just any
old memory address. It'll do it only in ones it allocates.

Right now this means it's a mlock'd page with WIPEONFORK set. In the
future maybe there will be other interesting page flags or
anti-heartbleed measures, or other platform-specific kernel-specific
things that can be set from the syscall. Again, it's important that the
kernel has a say in how this works rather than agreeing to operate on
any old address; memory isn't neutral.

The syscall currently accomplishes this with a call to vm_mmap() and
then a call to do_madvise(). It'd be nice to do this all at once, but
I'm not sure that a helper function exists for that now, and it seems a
bit premature to add one, at least for now.

The interesting meat of the implementation is in lib/vdso/getrandom.c,
as generic C code, and it aims to mainly follow random.c's buffered fast
key erasure logic. Before the RNG is initialized, it falls back to the
syscall. Right now it uses a simple generation counter to make its decisions
on reseeding (though this could be made more extensive over time).

The actual place that has the most work to do is in all of the other
files. Most of the vDSO shared page infrastructure is centered around
gettimeofday, and so the main structs are all in arrays for different
timestamp types, and attached to time namespaces, and so forth. I've
done the best I could to add onto this in an unintrusive way.

In my test results, performance is pretty stellar (around 15x for uint32_t
generation), and it seems to be working. There's an extended example in the
second commit of this series, showing how the syscall and the vDSO function
are meant to be used together.

Cc: linux-crypto@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>

Jason A. Donenfeld (3):
  random: add vgetrandom_alloc() syscall
  random: introduce generic vDSO getrandom() implementation
  x86: vdso: Wire up getrandom() vDSO implementation

 MAINTAINERS                             |   2 +
 arch/x86/Kconfig                        |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 arch/x86/entry/vdso/Makefile            |   3 +-
 arch/x86/entry/vdso/vdso.lds.S          |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S | 179 ++++++++++++++++++++++++
 arch/x86/entry/vdso/vgetrandom.c        |  18 +++
 arch/x86/include/asm/unistd.h           |   1 +
 arch/x86/include/asm/vdso/getrandom.h   |  49 +++++++
 arch/x86/include/asm/vdso/vsyscall.h    |   2 +
 arch/x86/include/asm/vvar.h             |  16 +++
 drivers/char/random.c                   |  68 +++++++++
 include/uapi/asm-generic/unistd.h       |   7 +-
 include/vdso/datapage.h                 |   6 +
 kernel/sys_ni.c                         |   3 +
 lib/vdso/Kconfig                        |   5 +
 lib/vdso/getrandom.c                    | 114 +++++++++++++++
 lib/vdso/getrandom.h                    |  23 +++
 scripts/checksyscalls.sh                |   4 +
 tools/include/uapi/asm-generic/unistd.h |   7 +-
 20 files changed, 509 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 lib/vdso/getrandom.h

-- 
2.38.1

