Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3065274416F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjF3Rkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjF3Rkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:40:43 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E1199B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:40:42 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-577412111f0so11856087b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688146841; x=1690738841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6+En68YkXQdDYAx0rEbBwu3QYNU0fe/9lrmYA+JJw4=;
        b=sVIUuw+Ct1U/Bf5d3gHquE2/2YmHeGw4eAOYMZurkPnz7Y24DlbEXN3fMLp3sYcN7w
         tgfucc0iVLFc34Ms3jMPxnvlW6Eb8x0Lf1MXUlGxByUUNx4WXYipQ9KgO/xl31B0JI4M
         IIP0u6Xs56Bs3e9lex0861S68WDmmB7+JcKO0UeBjpy21YwOaoSxBmNv6oUU/s1G8oYP
         6JLLYQk3SD5QEk4tvBwsEFcdcNFlJ01oX2frs9bkRH3gAdSUAVTk3kbjQfpKTAqXirns
         C+eZ0I5q0ioihoN8MMcXuY6tPy58xUEn55wZSRbsndeVUUbxVUJZrjADvROmQxbWTf9R
         HjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146841; x=1690738841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6+En68YkXQdDYAx0rEbBwu3QYNU0fe/9lrmYA+JJw4=;
        b=SfjebvJEGyXPZlm+BkLOnmKlzZlVfffxG72gX99ptZDWo1RYypMOABtNIdituaUAOv
         xQgVDa0IztDppVJG9NtR+3p4vwBh0f5r75DVmnZ3CM8p4c8nwzfqMLGH0sTl770T2Z2V
         BM8bdmjNOUYp3EIK4KElDAqvZTjcFed7kcgD1ML6QNqgiJmTIhV34p/2iZLUwDcvH1/+
         xRokL9MI/pdulU6jxJmD5TxhTXIV68MDND8RrCDP2z6H/Q2FOra8D88ldSQ+lJa61JRd
         OJqTMv/bfSe8vBpzUbtbSg3kk6JgOsXvEIsTScR3Li88+/2XQrkfUXUlEUULBxvwdJ9z
         Gxog==
X-Gm-Message-State: ABy/qLajaQR5RKPpD7vJqdZY7jjW5dzEbXRSzO0kSZSe5k9Kxsl+c0Cq
        1ngqcbR3ZE8kx5QfVhyTqn7zHJdZhQU7KlGFgd7bpA==
X-Google-Smtp-Source: APBJJlFXdH9cwo9RRxx4x9iMDrvd6rqmTF9tbASyk8UnyE1yPQ9tRQvTIFcSV/qhYHv9yQckIwxngQeKPyprmMPCXOc=
X-Received: by 2002:a0d:d54d:0:b0:577:2f3f:dd20 with SMTP id
 x74-20020a0dd54d000000b005772f3fdd20mr3237043ywd.34.1688146841016; Fri, 30
 Jun 2023 10:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org> <CAJuCfpF7LweMwpvXavjJZhAciK7wK-bdLz2aFhOZGSHeK5tA9A@mail.gmail.com>
 <9a8d788c-b8ba-1b8a-fd79-0e25b1b60bed@kernel.org> <f7ad7a42-13c8-a486-d0b7-01d5acf01e13@kernel.org>
 <f8864bb0-3d76-20d5-8a25-aab9726354f2@kernel.org>
In-Reply-To: <f8864bb0-3d76-20d5-8a25-aab9726354f2@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 30 Jun 2023 10:40:29 -0700
Message-ID: <CAJuCfpGLozRzxE9KZehgW1dAYpNxe4b+nnjH+ppbeAuFtRNGBQ@mail.gmail.com>
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

On Fri, Jun 30, 2023 at 1:43=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 30. 06. 23, 10:28, Jiri Slaby wrote:
> >  > 2348
> > clone3({flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREA=
D|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, chil=
d_tid=3D0x7fcaa5882990, parent_tid=3D0x7fcaa5882990, exit_signal=3D0, stack=
=3D0x7fcaa5082000, stack_size=3D0x7ffe00, tls=3D0x7fcaa58826c0} =3D> {paren=
t_tid=3D[2351]}, 88) =3D 2351
> >  > 2350  <... clone3 resumed> =3D> {parent_tid=3D[2372]}, 88) =3D 2372
> >  > 2351  <... clone3 resumed> =3D> {parent_tid=3D[2354]}, 88) =3D 2354
> >  > 2351  <... clone3 resumed> =3D> {parent_tid=3D[2357]}, 88) =3D 2357
> >  > 2354  <... clone3 resumed> =3D> {parent_tid=3D[2355]}, 88) =3D 2355
> >  > 2355  <... clone3 resumed> =3D> {parent_tid=3D[2370]}, 88) =3D 2370
> >  > 2370  mmap(NULL, 262144, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> >  > 2370  <... mmap resumed>)               =3D 0x7fca68249000
> >  > 2372  <... clone3 resumed> =3D> {parent_tid=3D[2384]}, 88) =3D 2384
> >  > 2384  <... clone3 resumed> =3D> {parent_tid=3D[2388]}, 88) =3D 2388
> >  > 2388  <... clone3 resumed> =3D> {parent_tid=3D[2392]}, 88) =3D 2392
> >  > 2392  <... clone3 resumed> =3D> {parent_tid=3D[2395]}, 88) =3D 2395
> >  > 2395  write(2, "runtime: marked free object in s"..., 36 <unfinished
> > ...>
> >
> > I.e. IIUC, all are threads (CLONE_VM) and thread 2370 mapped ANON
> > 0x7fca68249000 - 0x7fca6827ffff and go in thread 2395 thinks for some
> > reason 0x7fca6824bec8 in that region is "bad".

Thanks for the analysis Jiri.
Is it possible from these logs to identify whether 2370 finished the
mmap operation before 2395 tried to access 0x7fca6824bec8? That access
has to happen only after mmap finishes mapping the region.

>
> As I was noticed, this might be as well be a fail of the go's
> inter-thread communication (or alike) too. It might now be only more
> exposed with vma-based locks as we can do more parallelism now.

Yes, with multithreaded processes like these where threads are mapping
and accessing memory areas, per-VMA locks should allow for greater
parallelism. So, if there is a race like the one I asked above, it
might become more pronounced with per-VMA locks.

I'll double check the code, but from Kernel's POV mmap would take the
mmap_lock for write then will lock the VMA lock for write. That should
prevent any page fault handlers from accessing this VMA in parallel
until writers release the locks. Page fault path would try to find the
VMA without any lock and then will try to read-lock that VMA. If it
fails it will fall back to mmap_lock. So, if the writer started first
and obtained the VMA lock, the reader will fall back to mmap_lock and
will block until the writer releases the mmap_lock. If the reader got
VMA read lock first then the writer will block while obtaining the
VMA's write lock. However for your scenario, the reader (page fault)
might be getting here before the writer (mmap) and upon not finding
the VMA it is looking for, it will fail.
Please let me know if you can verify this scenario.
Thanks,
Suren.

>
> There are older hard to reproduce bugs in go with similar symptoms (we
> see this error sometimes now too):
> https://github.com/golang/go/issues/15246
>
> Or this 2016 bug is a red herring. Hard to tell...
>
> >> thanks,
> --
> js
> suse labs
>
