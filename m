Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D56D0AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjC3QYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjC3QYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:24:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457ABBB3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:24:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so78728661edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680193452; x=1682785452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGpUIuNkSWwlblo4NAnZsLgXHjXX1OX/SqTfrwIswRg=;
        b=Vt1jJXWHVCXspZt4UBd0at0O6A0NFdKZNHpURG50seAAUVmBpgqXWJ56Y5P1PT3pWY
         Or+YQK6FskI7TrePqBwBz9kXW/lEpy51ig3chB/4dsgT9vzyOJe4Y4SQJcb69BsWIlef
         AYKfFVfzRKE1zkJvLVb7b+MJaz/HE9E2XXxyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193452; x=1682785452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGpUIuNkSWwlblo4NAnZsLgXHjXX1OX/SqTfrwIswRg=;
        b=q2vlMk4K3Rn8XSWRiqW5FfpmeV1q05+fzeOr+Xp3CxfC3w4Ur2SU0VgD2HgBd0bNE9
         LztlWcUxPZTYf5eeNmwmsZQ0KZZtoZ7itR2fj45hIIyCnpbNk1DF2UF/bWffBisxgrPV
         TtVwo/KvyqciyXkK3dX2ggqCjv5ctfWCAdJK1meWiaFySdxYKUAPiTPDAVSKameyapCP
         N/xh0vTRmpy535DpFuEEjyylTyFVwKiWSoKWkfK+ydfAYh95yHOmeukn5ge9M6wuObUd
         4AT/qP3mEChzil4lntJ3Vx3pzPxNg5SHFgIMUu/qUN8lo+mNKnrZVfd+GXMsOy7sQBs/
         JTkg==
X-Gm-Message-State: AAQBX9e+C0LQTOPJBxrAgoqrIQ0axMQ0QB2JNEXii5rimC71uzjXWr4p
        mmgXD3rw39YmtRAwDrwVTCmmsgcpoOVZ7Gz0IPowKiy8
X-Google-Smtp-Source: AKy350Y+i22kZCQaDYiGfclF84Xd7QmZXJgf3p2/i+xuQDU08rXmMexnV+Ny8HdpK+nH+no2RhETYA==
X-Received: by 2002:aa7:d54f:0:b0:502:3376:7872 with SMTP id u15-20020aa7d54f000000b0050233767872mr19956472edr.35.1680193452555;
        Thu, 30 Mar 2023 09:24:12 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id cy8-20020a0564021c8800b00502689a06b2sm85337edb.91.2023.03.30.09.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:24:11 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id ew6so78642092edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:24:11 -0700 (PDT)
X-Received: by 2002:a05:6402:4306:b0:4af:6e95:85e9 with SMTP id
 m6-20020a056402430600b004af6e9585e9mr4039473edc.4.1680193450898; Thu, 30 Mar
 2023 09:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230329053149.3976378-1-mcgrof@kernel.org> <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net> <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net> <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
In-Reply-To: <20230330115626.GA124812@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Mar 2023 09:23:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
Message-ID: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
To:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 4:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Sure thing; still completely untested...

Seems obvious enough.

Looking at the people who use a semaphore as a mutex, one core user stands =
out:

>  kernel/printk/printk.c                                        |    2 +-

.. and I'm not entirely sure why that uses a semaphore. It may be
*entirely* legacy, and should just be changed to be a mutex.

But it may also be that the 'console_sem' has some subtle reason why
it wants to be a semaphore, and why it then plays games with lockdep
(which doesn't support counting semaphores) and does things like

  #define down_console_sem() do { \
        down(&console_sem);\
        mutex_acquire(&console_lock_dep_map, 0, 0, _RET_IP_);\
  } while (0)

Anyway, I think your patch is obviously safe as-is, and I think it's
long overdue to make it clear that the only real reason to use
semaphores rather than mutexes is if you do need the counting thing.

Of course, there is the thing about lockdep, and also about how
semaphores these days have no architecture-specific parts, so if
anybody wants to play deep games with their locking, that may be a
reason for using them.

Although we also do have some other issues - I think down_trylock() is
ok in irq contexts, but mutex_trylock() is not. Maybe that's why
printk uses semaphores? I forget.

                Linus
