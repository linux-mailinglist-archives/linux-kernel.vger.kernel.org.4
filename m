Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6465AA94
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAAQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 11:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:29:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60A21BB;
        Sun,  1 Jan 2023 08:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75EEA60DB7;
        Sun,  1 Jan 2023 16:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A74C433EF;
        Sun,  1 Jan 2023 16:29:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lXxtsVFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672590555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P82qoz09g6VzXpV/T2mg1MOpRLffLswFTgY3zS1xjso=;
        b=lXxtsVFllNqwQbEZcMZQjRTaCA+tk/Na6qs8AUVZomkVSSpntlUu48OghmogWeP2xcMsFP
        3ka2VvWOJhRv0rt9v0mzu2dEFCwmOQlA4Lu2b4t7MncK9er3bt1oXwPaAjy3qxSn5/FgGJ
        vrvGvMo9705o4C4H6ojh5z5HYJ9LOVI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ef930320 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 1 Jan 2023 16:29:15 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v14 0/7] implement getrandom() in vDSO
Date:   Sun,  1 Jan 2023 17:29:03 +0100
Message-Id: <20230101162910.710293-1-Jason@zx2c4.com>
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

Changes v13->v14:
----------------
- Fix incorrect comments in chacha assembly, and augment comments in
  random.c

- Get chacha standalone selftest building again after recent upstream
  changes.

- Switch to using `.set` instead of `#define` in asm.

- Rebased on e4cf7c25bae5.

Changes v12->v13:
-----------------
- Use helpers in insn-eval.h instead of open coding the same thing via
  insn.h.

- Due to some enum constants in insn-eval.h clashing with enum constants
  in an unrelated header that happens to be included by a file this
  series needs insn-eval.h from, the first patch of this series now
  renames some enum constants. This is a standalone patch that should
  probably be applied regardless of the rest of this series.

- Rebase atop the latest random.git master branch, which is itself
  pretty similar to Linus' tree at the moment.

Changes v11->v12:
-----------------
- In order to avoid mlock()ing pages, and the related rlimit and fork
  inheritance issues there, Introduce VM_DROPPABLE to prevent swapping
  while meeting the cache-like requirements of vDSO getrandom().

  This has some tenticles in mm/ and arch/x86/ code, so I've marked the
  two patches for that as still RFC, while the rest of the series is not
  RFC.

- Mandate that opaque state blobs don't straddle page boundaries, so
  that VM_DROPPABLE can work on page-level granularity rather than
  allocation-level granularity.

- Add compiler barriers to vDSO getrandom() to prevent theoretical
  reordering potential.

- Initialize the trials loop counter in the chacha test.

Changes v10->v11:
-----------------
- Adhemerval's latest glibc patch currently lives here:
  https://github.com/zatrazz/glibc/commits/azanella/getrandom-vdso
  It's still in flux (he hasn't posted it to glibc-alpha yet), but that
  should still give some idea.

- Substantially increase documentation detail throughout.

- Numerous fixes to style and clarity.

- Add two kselftests - one for the chacha20 assembly implementation, which
  compares its output to that of libsodium, and one for the actual vDSO
  function and vgetrandom_alloc() syscall, which also has some built-in quick &
  dirty benchmarking functionality.

- Add reserved `unsigned long addr` argument to syscall, for future use.

- Enforce that `flags`, `addr`, and `*size_per_each` are all zero on input, so
  that they can actually be used in the future.

- Use VM_LOCKONFAULT|VM_NORESERVE so that memory isn't wasted until it's used.

- Set VM_DONTDUMP to prevent state from being written out to core dumps.

- Do mapping and flag setting all in one operation, so that it's not racy, and
  so that dropping the mm lock between operations isn't required.

- Due to the above, there's no longer any purpose in selecting
  VGETRANDOM_ALLOC_SYSCALL, so remove that.

- Don't update *num or *size_per_each until the mapping has succeeded.

- Introduce vdso_kernel_ulong type for representing the long type that
  the kernel uses, even when in 32-bit compat code on a 64-bit kernel.

- Don't use 'bool' type in the vDSO page, in case of compiler quirks resulting
  in a different interpretation of the type in different compilation contexts.

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

  void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
                         unsigned long addr, unsigned int flags);

This takes a hinted number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread. (The
`flags` and `addr` arguments, as well as the `*size_per_each` input
value, are reserved for the future and are forced to be zero for now.)

Libc is expected to allocate a chunk of these on first use, and then
dole them out to threads as they're created, allocating more when
needed. The returned address of the first state may be passed to
munmap(2) with a length of `num * size_per_each`, in order to deallocate
the memory.

We very intentionally do *not* leave state allocation up to the caller
of vgetrandom, but provide vgetrandom_alloc for that allocation. There
are too many weird things that can go wrong, and it's important that
vDSO does not provide too generic of a mechanism. It's not going to
store its state in just any old memory address. It'll do it only in ones
it allocates.

Right now this means it uses a new mm flag called VM_DROPPABLE, along
with VM_WIPEONFORK. In the future maybe there will be other interesting
page flags or anti-heartbleed measures, or other platform-specific
kernel-specific things that can be set from the syscall. Again, it's
important that the kernel has a say in how this works rather than
agreeing to operate on any old address; memory isn't neutral.

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
Cc: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>  

Jason A. Donenfeld (7):
  x86: lib: Separate instruction decoder MMIO type from MMIO trace
  mm: add VM_DROPPABLE for designating always lazily freeable mappings
  x86: mm: Skip faulting instruction for VM_DROPPABLE faults
  random: add vgetrandom_alloc() syscall
  arch: allocate vgetrandom_alloc() syscall number
  random: introduce generic vDSO getrandom() implementation
  x86: vdso: Wire up getrandom() vDSO implementation

 MAINTAINERS                                   |   2 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/coco/tdx/tdx.c                       |  26 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S       | 178 +++++++++++
 arch/x86/entry/vdso/vgetrandom.c              |  17 ++
 arch/x86/include/asm/insn-eval.h              |  18 +-
 arch/x86/include/asm/vdso/getrandom.h         |  55 ++++
 arch/x86/include/asm/vdso/vsyscall.h          |   2 +
 arch/x86/include/asm/vvar.h                   |  16 +
 arch/x86/kernel/sev.c                         |  18 +-
 arch/x86/lib/insn-eval.c                      |  20 +-
 arch/x86/mm/fault.c                           |  19 ++
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 drivers/char/random.c                         | 147 +++++++++
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |   8 +
 include/linux/mm_types.h                      |   5 +-
 include/linux/syscalls.h                      |   3 +
 include/trace/events/mmflags.h                |   7 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/vdso/datapage.h                       |  12 +
 include/vdso/getrandom.h                      |  44 +++
 include/vdso/types.h                          |  35 +++
 kernel/sys_ni.c                               |   3 +
 lib/vdso/Kconfig                              |   6 +
 lib/vdso/getrandom.c                          | 224 ++++++++++++++
 mm/Kconfig                                    |   3 +
 mm/memory.c                                   |   6 +
 mm/mempolicy.c                                |   3 +
 mm/mprotect.c                                 |   2 +-
 mm/rmap.c                                     |   5 +-
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 tools/testing/selftests/vDSO/.gitignore       |   2 +
 tools/testing/selftests/vDSO/Makefile         |  11 +
 .../testing/selftests/vDSO/vdso_test_chacha.c |  43 +++
 .../selftests/vDSO/vdso_test_getrandom.c      | 283 ++++++++++++++++++
 59 files changed, 1217 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 include/vdso/getrandom.h
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c

-- 
2.39.0

