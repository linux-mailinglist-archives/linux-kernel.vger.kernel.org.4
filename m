Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911A46986A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBOUym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjBOUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:54:25 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5E518F9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:51:23 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u27so23586631ljo.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1xwLEJ+fw/9N/ASuJnTYboHFfSKDE0O/Dh0SH0Huc0=;
        b=ScOEg8rjjnhfXTc8HzTjwIf/5Svf4WUaS/eVfYuAiyV79xZ5QuO7qRa/QZPCMburOl
         UA/W3lUovH361B9iTrZGNQWYhCUL4BGia3uuTXjTSc/aUxn5S+npDRtFNxdEZ2odlqYl
         0QPRiCE0HdCcsM/Kt3mcIVW4O+Aier/Ydkz5LF+7FEdlyiLaM4YWgM+1naOkRwJmQ9K9
         HGgcgEXrjQjwAX5Ni5kAnlyhmtMyve1kf19VVbWXsXQinOYToGb7Jt6awAT/IL/eNC/L
         RbehIWRfK5rBj47+t+JyZdLc3MuylcGkWCpI2k5OduEJZer4O9fITmaB+dM88n9gFHmv
         jdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1xwLEJ+fw/9N/ASuJnTYboHFfSKDE0O/Dh0SH0Huc0=;
        b=4sxoASX4y9r3b1stGgc8o8Zen4LqKym3t2WPX5aZG0p28OFgz8K/jv9Wmvaq+mZQh+
         LGOEegEsw7nnxHMTS5c1nzVt15QDNApxeHfwH26dJunxc9KGxZd+nlzrD5zrci+0W4x1
         oOgCInxJ/pfKK3ptzzok5tfO2oqxH9fbtdCDFDslaG6lljJJhIGjDWxfBC5gDVL3uXLo
         ZfB+KQsg3GOCFNbo1gUxI3x0Hkp2SDR3LX9wdd0Kq+xJZcVmrcZPci4gwmxYB6lJ3onq
         yYNeycWneesOE643J7hzwcIer3shbd1SbR2NNJ0Nlq4LHyVzc14CWbFIbCxQVXCxqa/D
         7cfg==
X-Gm-Message-State: AO0yUKVOpa7UuKOV12P201NrLw++CSufsy+sC3WBVo+lIwC3UJlkriQI
        57/JPdyUvDTZO4GjU7GmqwdOYaHhPpTiUyrnjU2VwA==
X-Google-Smtp-Source: AK7set8F/UMH9A7lGEk0qXa6/3bT96HKsy5w8O6HU1LTBdIZoqwEbHPlMfCCfKeaHFee61F5jvccOTFx45xERHJnVRc=
X-Received: by 2002:a05:651c:11d0:b0:290:4032:8824 with SMTP id
 z16-20020a05651c11d000b0029040328824mr1002816ljo.4.1676494211844; Wed, 15 Feb
 2023 12:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+wedUsNEfWsKU5I@spud>
In-Reply-To: <Y+wedUsNEfWsKU5I@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 15 Feb 2023 12:49:35 -0800
Message-ID: <CALs-HssScpGxAN+TBA8PtaVHwJvmudqmXUaSZDFBiu3k4Tb3nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 3:51 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Evan,
>
> Just as a preface, I'm reviewing this lot from a position of ignorance
> on what glibc wants so I'll refrain from commenting on call itself.
> I figure that since the commentary has kinda died on the sysfs front &
> Palmer seems to be still into the syscall stuff, that we're pushing on
> with this approach...

Yep, sounds good.

>
> On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
> > We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> > system call that quite does this, so let's just provide an arch-specific
> > one to probe for hardware capabilities.  This currently just provides
> > m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > the future.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> > ---
> >
> > Changes in v2:
> >  - Changed the interface to look more like poll(). Rather than supplying
> >    key_offset and getting back an array of values with numerically
> >    contiguous keys, have the user pre-fill the key members of the array,
> >    and the kernel will fill in the corresponding values. For any key it
> >    doesn't recognize, it will set the key of that element to -1. This
> >    allows usermode to quickly ask for exactly the elements it cares
> >    about, and not get bogged down in a back and forth about newer keys
> >    that older kernels might not recognize. In other words, the kernel
> >    can communicate that it doesn't recognize some of the keys while
> >    still providing the data for the keys it does know.
> >  - Added a shortcut to the cpuset parameters that if a size of 0 and
> >    NULL is provided for the CPU set, the kernel will use a cpu mask of
> >    all online CPUs. This is convenient because I suspect most callers
> >    will only want to act on a feature if it's supported on all CPUs, and
> >    it's a headache to dynamically allocate an array of all 1s, not to
> >    mention a waste to have the kernel loop over all of the offline bits.
> >
> >
> > ---
> >  Documentation/riscv/hwprobe.rst       |  37 +++++++
> >  Documentation/riscv/index.rst         |   1 +
> >  arch/riscv/include/asm/hwprobe.h      |  13 +++
> >  arch/riscv/include/asm/syscall.h      |   3 +
> >  arch/riscv/include/uapi/asm/hwprobe.h |  25 +++++
> >  arch/riscv/include/uapi/asm/unistd.h  |   8 ++
> >  arch/riscv/kernel/cpu.c               |   3 +-
> >  arch/riscv/kernel/sys_riscv.c         | 146 +++++++++++++++++++++++++-
> >  8 files changed, 234 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/riscv/hwprobe.rst
> >  create mode 100644 arch/riscv/include/asm/hwprobe.h
> >  create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
> >
> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> > new file mode 100644
> > index 000000000000..97771090e972
> > --- /dev/null
> > +++ b/Documentation/riscv/hwprobe.rst
> > @@ -0,0 +1,37 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +RISC-V Hardware Probing Interface
> > +---------------------------------
> > +
> > +The RISC-V hardware probing interface is based around a single syscall, which
> > +is defined in <asm/hwprobe.h>::
> > +
> > +    struct riscv_hwprobe {
> > +        __s64 key;
> > +        __u64 value;
> > +    };
> > +
> > +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_count,
> > +                           size_t cpu_count, cpu_set_t *cpus,
> > +                           unsigned long flags);
> > +
> > +The arguments are split into three groups: an array of key-value pairs, a CPU
> > +set, and some flags.  The key-value pairs are supplied with a count.  Userspace
> > +must prepopulate the key field for each element, and the kernel will fill in the
> > +value if the key is recognized.  If a key is unknown to the kernel, its key
> > +field will be cleared to -1, and its value set to 0.  The CPU set is defined by
> > +CPU_SET(3), the indicated features will be supported on all CPUs in the set.
> > +Usermode can supply NULL for cpus and 0 for cpu_count as a shortcut for all
> > +online CPUs. There are currently no flags, this value must be zero for future
> > +compatibility.
> > +
> > +On success 0 is returned, on failure a negative error code is returned.
> > +
> > +The following keys are defined:
> > +
> > +* :RISCV_HWPROBE_KEY_MVENDORID:: Contains the value of :mvendorid:, as per the
> > +  ISA specifications.
>
> "per the ISA specifications" sounds like dangerous wording to me! ;)

I can replace "per the ISA specifications" with "as defined by the
RISC-V privileged architecture specification" to try and make that
more crisp.

>
> > +* :RISCV_HWPROBE_KEY_MARCHID:: Contains the value of :marchid:, as per the ISA
> > +  specifications.
> > +* :RISCV_HWPROBE_KEY_MIMPLID:: Contains the value of :mimplid:, as per the ISA
> > +  specifications.
>
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > new file mode 100644
> > index 000000000000..591802047460
> > --- /dev/null
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright 2022 Rivos, Inc
> > + */
> > +
> > +#ifndef _UAPI_ASM_HWPROBE_H
> > +#define _UAPI_ASM_HWPROBE_H
> > +
> > +#include <linux/types.h>
> > +
> > +/*
> > + * Interface for probing hardware capabilities from userspace, see
> > + * Documentation/riscv/hwprobe.rst for more information.
> > + */
> > +struct riscv_hwprobe {
> > +     __s64 key;
> > +     __u64 value;
> > +};
> > +
> > +#define RISCV_HWPROBE_KEY_MVENDORID  0
> > +#define RISCV_HWPROBE_KEY_MARCHID    1
> > +#define RISCV_HWPROBE_KEY_MIMPID     2
> > +/* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
> Can't wait for that to get forgotten!

I know. I could add an if (pair->key > RISCV_HWPROBE_MAX_KEY) goto
unrecognized_key, with a label at the default switch case, which would
effectively be a runtime guard against it. I opted not to as it's
aesthetically harsh, but anyone can holler if they want it.

>
> > diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> > index 73d7cdd2ec49..37d47302322a 100644
> > --- a/arch/riscv/include/uapi/asm/unistd.h
> > +++ b/arch/riscv/include/uapi/asm/unistd.h
> > @@ -43,3 +43,11 @@
> >  #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> >  #endif
> >  __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> > +
> > +/*
> > + * Allows userspace to probe
>
> That comment looks chopped off midway through.

Whoops yes I

>
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > index 5d3f2fbeb33c..868a12384f5a 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -6,8 +6,11 @@
> >   */
> >
> >  #include <linux/syscalls.h>
> > -#include <asm/unistd.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/cpufeature.h>
> > +#include <asm/hwprobe.h>
> > +#include <asm/uaccess.h>
> > +#include <asm/unistd.h>
> >  #include <asm-generic/mman-common.h>
> >
> >  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> > @@ -69,3 +72,144 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
> >
> >       return 0;
> >  }
> > +
> > +/*
> > + * The hwprobe interface, for allowing userspace to probe to see which features
> > + * are supported by the hardware.  See Documentation/riscv/hwprobe.rst for more
> > + * details.
> > + */
> > +static int set_hwprobe(struct riscv_hwprobe __user *pair, u64 val)
> > +{
> > +     long ret;
> > +
> > +     ret = put_user(val, &pair->value);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static long hwprobe_mid(struct riscv_hwprobe __user *pair, size_t key,
>
> ngl, it took me far too long to figure out that "mid" was not some
> shortening of "middle". I don't have any suggestions though, other than
> using cpu_id to match your variable and I think it becomes clearer by the
> end of the series anyway when the access alignment stuff appears.

Agreed. I'll rename this to hwprobe_arch_id().

>
> > +                     cpumask_t *cpus)
> > +{
> > +     long cpu, id;
> > +     bool first, valid;
> > +
> > +     first = true;
> > +     valid = false;
>
> Just make that
> boot first = true, valid = false;
> no?
>
> > +     for_each_cpu(cpu, cpus) {
> > +             struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu);
> > +             long cpu_id;
> > +
> > +             switch (key) {
> > +             case RISCV_HWPROBE_KEY_MVENDORID:
> > +                     cpu_id = ci->mvendorid;
>
> Are you intentionally avoiding using riscv_cached_mfooid()?

This might have been done with the expectation that there would be
more members in that struct to query, so grabbing the pointer in a
higher scope made sense. It didn't evolve that way, so you're right I
should just use those functions.

>
> > +                     break;
> > +             case RISCV_HWPROBE_KEY_MIMPID:
> > +                     cpu_id = ci->mimpid;
> > +                     break;
> > +             case RISCV_HWPROBE_KEY_MARCHID:
> > +                     cpu_id = ci->marchid;
> > +                     break;
> > +             }
> > +
> > +             if (first) {
> > +                     id = cpu_id;
> > +                     valid = true;
>
> So, we only end up in this function if there are CPUs in the set.
> Does that mean we can assume validity by default and just define valid =
> true from the get go?

The valid bool was meant to remember if we had come across a value
that was different from the others. But it can be eliminated with a
different code flow. For the next spin I removed valid altogether and
just break out of the loop if we find a value that's different, since
we already know what the return value will be and don't need to keep
iterating.

>
> > +             }
> > +
> > +             if (id != cpu_id)
> > +                     valid = false;
> > +     }
> > +
> > +     /*
> > +      * put_user() returns 0 on success, so use 1 to indicate it wasn't
> > +      * called and we should skip having incremented the output.
> > +      */
> > +     if (!valid)
> > +             return 1;
>
> I'm not sure why you're returning 1 here. If the id is deemed to be
> invalid, why aren't we treating it as a "real" error.
> TL;DR I don't understand the comment explaining this.

You're right, this is a mistake, leftover from v1 when the return
value signified the number of entries populated. For v3 I changed the
return type of this function to void, and just stick -1 in value if
the requested key isn't consistent across the given cpu set. That way
the syscall can still populate and return all the other values you
requested while simultaneously indicating "I can't give you a single
answer for that cpuset" for these vendor/arch/impl id elements.

>
> > +
> > +     return set_hwprobe(pair, id);
> > +}
> > +
> > +static
> > +long do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_count,
>
> The files not wrapped at 80 anyway, so why not put this on the same line
> as `static`?

It actually mostly is wrapped at 80, except for another mistake I
made. But I can break up the line between the parameters which I think
is closer to what people are used to seeing.

>
> > +                   long cpu_count, unsigned long __user *cpus_user,
> > +                   unsigned long flags)
> > +{
> > +     size_t out;
> > +     s64 key;
> > +     long ret;
> > +     struct cpumask cpus;
> > +
> > +     /* Check the reserved flags. */
> > +     if (flags != 0)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * The only supported values must be the same on all CPUs. Allow
>
> "The only supported values" doesn't really make much sense. Is that
> intended to be read as meaning that we only report the features
> supported by all CPUs in the set?

Yeah let me change that to:
/*
* The interface supports taking in a CPU mask, and returns values that
* are consistent across that mask. Allow userspace to specify NULL and
* 0 as a shortcut to all online CPUs.
*/


>
> > +      * userspace to specify NULL and 0 as a shortcut to all online CPUs.
> > +      */
> > +     cpumask_clear(&cpus);
> > +     if ((cpu_count == 0) && (cpus_user == NULL)) {
>
> Is this not just `if (!cpu_count && !cpus_user)`?
>
> > +             cpumask_copy(&cpus, cpu_online_mask);
> > +     } else {
> > +             if (cpu_count > cpumask_size())
> > +                     cpu_count = cpumask_size();
>
> nit: newline here please, helps my poor auld eyes out on the days
> they're not doing too well!
>
> Cheers,
> Conor.
>
> > +             ret = copy_from_user(&cpus, cpus_user, cpu_count);
> > +             if (!ret)
> > +                     return -EFAULT;
> > +
> > +             /*
> > +              * Userspace must provide at least one online CPU, without that there's
> > +              * no way to define what is supported.
> > +              */
> > +             cpumask_and(&cpus, &cpus, cpu_online_mask);
> > +             if (cpumask_empty(&cpus))
> > +                     return -EINVAL;
> > +     }
> > +
> > +     for (out = 0; out < pair_count; out++, pairs++) {
> > +             long ret;
> > +
> > +             if (get_user(key, &pairs->key))
> > +                     return -EFAULT;
> > +
> > +             switch (key) {
> > +             case RISCV_HWPROBE_KEY_MVENDORID:
> > +             case RISCV_HWPROBE_KEY_MARCHID:
> > +             case RISCV_HWPROBE_KEY_MIMPID:
> > +                     ret = hwprobe_mid(pairs, key, &cpus);
> > +                     break;
> > +
> > +             /*
> > +              * For forward compatibility, unknown keys don't fail the whole
> > +              * call, but get their element key set to -1 and value set to 0
> > +              * indicating they're unrecognized.
> > +              */
> > +             default:
> > +                     ret = put_user(-1, &pairs->key);
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     ret = set_hwprobe(pairs, 0);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     break;
> > +             }
> > +
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +
> > +}
> > +
> > +SYSCALL_DEFINE5(riscv_hwprobe, uintptr_t, pairs, uintptr_t, pair_count,
> > +             uintptr_t, cpu_count, uintptr_t, cpus, uintptr_t, flags)
> > +{
> > +     return do_riscv_hwprobe((void __user *)pairs, pair_count, cpu_count,
> > +                             (void __user *)cpus, flags);
> > +}
> > --
> > 2.25.1
> >
