Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AA7429AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjF2PbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2PbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:31:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89FAA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:30:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57725e1c24bso7826197b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688052658; x=1690644658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL6wKBophCJT750RGEYyX1lE9eIiUgZcFU/NnUJTEDA=;
        b=r0WnIICqLcQpC2z4k1OXqjdIHwbyPvk1Z8ri5rmK+ckoNK18AT6VPUSbdQmfmsx18M
         wpL4jWqQfgb/a0s8JMpZaBrgwnhJIf1ZGhC2od40BCjr+QlmX2ql2nZl1ck/r7A8cgTa
         n0RD9fpWUbCghdSpcnZNAOfA8ihWS+0uQ7L4MUsNXxfZoEYZsiYCuttP18dSP3+DAvuQ
         Y0KT2h9YNtynUz89d0/QqugdvmBW+mUOFFNQLmfN9qfC1rZIqrqRPTUQIPAJEt1tnlQX
         FC34JywB7aEarHByxfMPXtMTg/OEGYqBC8nbWMkvV1YAG76K9xeVTkeqDCIyr7z2EoiU
         15Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052658; x=1690644658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL6wKBophCJT750RGEYyX1lE9eIiUgZcFU/NnUJTEDA=;
        b=JZAX5XAbhOnSuZNf9Zv00hq1ObszrbKsq229ISLMQq6uLsihQ36AURjxTbYXNmlDZC
         dBF/YoV0badc4sACeC7/jZzDT7J54R4xwQUM9Pz00D7N5vvCZUO1/fi5Th8uvMOxHc+9
         //AxcvMuQeNjLGTdAY2h1aX7yH4qAyJslDoiurmyczAWPG5kYy9klRo1g3YWIXZ0s+5f
         3+4WjBPjLxvKqBUOn7is4v2Z+HcIGHUTY5hoQoVhJDjXjujdE71bVYm99dr3YGnGo7QU
         iJgCpLa1UemSohl8T1ee9nHx9s1UdcrjLdmRHxmEFccmcwvqEK4KPIkZJ5x1ciANS/Oo
         pPpQ==
X-Gm-Message-State: ABy/qLYST5keU6y3co2EWltPg4Dl1HJR9OVs0BTILi/iMEK/FAxffkGY
        7xBG0zppMiQLh0XM1qYPWtOjTT5gUT+Ecx+kvJUZnw==
X-Google-Smtp-Source: APBJJlHpQCyFxGZ2wEWn3k5zfeZwCJEObRUSbe49PZI26MJdi9kBQNmWxonB8vDszBerZkC/zLjl3GPQlhEj+vvvXB0=
X-Received: by 2002:a25:f603:0:b0:c11:565:debb with SMTP id
 t3-20020a25f603000000b00c110565debbmr322761ybd.17.1688052657580; Thu, 29 Jun
 2023 08:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
In-Reply-To: <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Jun 2023 08:30:45 -0700
Message-ID: <CAJuCfpF7LweMwpvXavjJZhAciK7wK-bdLz2aFhOZGSHeK5tA9A@mail.gmail.com>
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling first
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 7:40=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> Hi,
>
> On 27. 02. 23, 18:36, Suren Baghdasaryan wrote:
> > Attempt VMA lock-based page fault handling first, and fall back to the
> > existing mmap_lock-based handling if that fails.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   arch/x86/Kconfig    |  1 +
> >   arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 37 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index a825bf031f49..df21fba77db1 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -27,6 +27,7 @@ config X86_64
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > +     select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_USE_CMPXCHG_LOCKREF
> >       select HAVE_ARCH_SOFT_DIRTY
> >       select MODULES_USE_ELF_RELA
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index a498ae1fbe66..e4399983c50c 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -19,6 +19,7 @@
> >   #include <linux/uaccess.h>          /* faulthandler_disabled()      *=
/
> >   #include <linux/efi.h>                      /* efi_crash_gracefully_o=
n_page_fault()*/
> >   #include <linux/mm_types.h>
> > +#include <linux/mm.h>                        /* find_and_lock_vma() */
> >
> >   #include <asm/cpufeature.h>         /* boot_cpu_has, ...            *=
/
> >   #include <asm/traps.h>                      /* dotraplinkage, ...    =
       */
> > @@ -1333,6 +1334,38 @@ void do_user_addr_fault(struct pt_regs *regs,
> >       }
> >   #endif
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     if (!(flags & FAULT_FLAG_USER))
> > +             goto lock_mmap;
> > +
> > +     vma =3D lock_vma_under_rcu(mm, address);
> > +     if (!vma)
> > +             goto lock_mmap;
> > +
> > +     if (unlikely(access_error(error_code, vma))) {
> > +             vma_end_read(vma);
> > +             goto lock_mmap;
> > +     }
> > +     fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> > +     vma_end_read(vma);
> > +
> > +     if (!(fault & VM_FAULT_RETRY)) {
> > +             count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> > +             goto done;
> > +     }
> > +     count_vm_vma_lock_event(VMA_LOCK_RETRY);
>
> This is apparently not strong enough as it causes go build failures like:
>
> [  409s] strconv
> [  409s] releasep: m=3D0x579e2000 m->p=3D0x5781c600 p->m=3D0x0 p->status=
=3D2
> [  409s] fatal error: releasep: invalid p state
> [  409s]
>
> [  325s] hash/adler32
> [  325s] hash/crc32
> [  325s] cmd/internal/codesign
> [  336s] fatal error: runtime: out of memory

Hi Jiri,
Thanks for reporting! I'm not familiar with go builds. Could you
please explain the error to me or point me to some documentation to
decipher that error?
Thanks,
Suren.

>
> There are many kinds of similar errors. It happens in 1-3 out of 20
> builds only.
>
> If I revert the commit on top of 6.4, they all dismiss. Any idea?
>
> The downstream report:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1212775
>
> > +
> > +     /* Quick path to respond to signals */
> > +     if (fault_signal_pending(fault, regs)) {
> > +             if (!user_mode(regs))
> > +                     kernelmode_fixup_or_oops(regs, error_code, addres=
s,
> > +                                              SIGBUS, BUS_ADRERR,
> > +                                              ARCH_DEFAULT_PKEY);
> > +             return;
> > +     }
> > +lock_mmap:
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >       /*
> >        * Kernel-mode access to the user address space should only occur
> >        * on well-defined single instructions listed in the exception
> > @@ -1433,6 +1466,9 @@ void do_user_addr_fault(struct pt_regs *regs,
> >       }
> >
> >       mmap_read_unlock(mm);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +done:
> > +#endif
> >       if (likely(!(fault & VM_FAULT_ERROR)))
> >               return;
> >
>
> thanks,
> --
> js
> suse labs
>
